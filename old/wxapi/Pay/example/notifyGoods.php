<?php
ini_set('date.timezone','Asia/Shanghai');
error_reporting(E_ERROR);

require_once "../lib/WxPay.Api.php";
require_once '../lib/WxPay.Notify.php';
require_once 'log.php';
require_once("../../../php/tool/PDO.class.php");
require_once("../../../php/tool/config.php");
require_once("../../../php/tool/util.php");

//初始化日志
$logHandler= new CLogFileHandler("../logs/".date('Y-m-d').'.log');
$log = Log::Init($logHandler, 15);

class PayNotifyGoodsCallBack extends WxPayNotify
{
	//查询订单
	public function Queryorder($transaction_id)
	{
		$input = new WxPayOrderQuery();
		$input->SetTransaction_id($transaction_id);
		$result = WxPayApi::orderQuery($input);
		Log::DEBUG("query:" . json_encode($result));
		if(array_key_exists("return_code", $result)
			&& array_key_exists("result_code", $result)
			&& $result["return_code"] == "SUCCESS"
			&& $result["result_code"] == "SUCCESS")
		{
			return true;
		}
		return false;
	}
	
	//重写回调处理函数
	public function NotifyProcess($data, &$msg)
	{
		Log::DEBUG("call back...---:" . json_encode($data));
		$notfiyOutput = array();
		
		if(!array_key_exists("transaction_id", $data)){
			$msg = "输入参数不正确";
			return false;
		}
		//查询订单，判断订单真实性
		if(!$this->Queryorder($data["transaction_id"])){
			$msg = "订单查询失败";
			return false;
		}
		
		//Log::DEBUG("attachccc".$data['attach']);
		
		$attach = explode(";",$data['attach']);
		$type = $attach[0];
		//Log::DEBUG("attach...".$type.'...dtt='.$data['attach']);
		
		if($type=='GoodsPayParam'){
			$this->GoodsPayBack($data,$attach);
		}
		else if($type == 'DepositPayParam'){
			$this->DepositPayBack($data,$attach);
		}
		
		return true;
	}
	
	
	//购买商品返回方法
	function GoodsPayBack($data,$attach){
		Log::DEBUG("im enter");
			
		$transaction_id = $data['transaction_id'];
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("select * from xl_buylist where serialnum = ?",array($transaction_id));
		
		Log::DEBUG("start add call data:".$data['transaction_id']);
		
		$price = intval($attach[3]);
		$goodsid = intval($attach[4]);
		$num = intval($attach[5]);
		$userid = intval($attach[1]);
		
		if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['buyid'] == 0){
			//没有这个订单重新添加
			
			//Log::DEBUG("im enter2");
			$DB->query("update xl_goods set buynum = buynum+$num where id=$goodsid");
			$couponList = $DB->query("select * from xl_coupontogoods where goodsid = ?",array($goodsid));
			
			for($j = 0;$j<$num;$j++){
				$DB->query("insert into xl_buylist(serialnum,setsname,buydate,giftnum,expnum,bindinfo,notes,userid,price,goodsid)values(?,?,?,?,?,?,?,?,?,?)",
				array($transaction_id,$attach[2],time(),0,0,0,'buy',$userid,$price,$goodsid));
				
				$lastbuyid = $DB->lastInsertId();
				
				//给玩家添加礼品券			
				$giftArr = array('1'=>0,'2'=>0);
				if(count($couponList)>0){
					
					$arrlen = count($couponList);
					$couponMsg;
					for($i = 0;$i<$arrlen;$i++){
						if(count($couponList[$i])>0){
							$cid = $couponList[$i]['couponid'];
							$couponMsg = $DB->query("select * from xl_coupon where id = ".$cid);
							
							if(count($couponMsg)<=0){
								continue;
							}
							
							$giftArr[$couponMsg[0]['type']]+=$couponList[$i]['nums'];
							$datefrom = time() + $couponMsg[0]['starttime'];
							$dateto = $datefrom + $couponMsg[0]['endtime'];
							
							
							$sqlStr = $cid.",".$userid.",".$datefrom.",".$dateto.",".$goodsid.",".$lastbuyid;
	//							echo "insert into xl_couponlist(cpuuid,belongto,datefrom,dateto) value(".$sqlStr.")";
							//添加到客户列表
							$DB->query("insert into xl_couponlist(cpuuid,belongto,datefrom,dateto,goodsid,buyid) value(".$sqlStr.")");
						}
					}
					
				}
				
				//添加购买列表
				$giftnum = $giftArr['1'];
				$expnum = $giftArr['2'];			
				$DB->query("update xl_buylist set giftnum=?, expnum = ? where buyid = ?",array($giftnum,$expnum,$lastbuyid));
			}
			
			$userresult = $DB->query("select tid from xl_userinfo where userid = ?",array($userid));
			if(count($userresult)>0){
				$tid = $userresult[0]['tid'];
				if($tid>0 && $tid != $userid){
					$tidlist = $DB->query("select userid from xl_extension where userid=? and extid=?",array($tid,$userid));
					if(count($tidlist)<=0){
						$DB->query("insert into xl_extension(userid,extid,goodsid,conndate)values(?,?,?,?)",array($tid,$userid,$goodsid,time()));
					}
					
					$goodsArr = $DB->query("select extsource from xl_goods where id=?",array($goodsid));
					
					if(count($goodsArr)>0){
						$extsource = $goodsArr[0]['extsource'];
						$DB->query("update xl_userinfo set source = source+? where userid = ?",array($extsource,$tid));
					}
				}
			}
			
			Log::DEBUG("addgoods".$transaction_id);
		}
		$DB->CloseConnection();
	}
	
	function DepositPayBack($data,$attach){
		Log::DEBUG("add_depositlist");
		$transaction_id = $data['transaction_id'];
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("select * from xl_depositlist where tactionid = ?",array($transaction_id));
		if($result == null || count($result) ==0){
			Log::DEBUG("insert".$attach[1].'..'.$attach[2]);
			$clientid = $attach[1];
			$salesid = $attach[2];
			$dpname = $attach[3];
			$price = $attach[4];
			$dptype = $attach[5];
			$dptime = time();
			Log::DEBUG("insert1".$dpname.','.$clientid.','.$salesid.','.$price.','.$dptime.','.$dptype.','.$transaction_id);
			$row = $DB->query("insert into xl_depositlist(dpname,username,salesman,sum,depositdate,dptype,tactionid) values(?,?,?,?,?,?,?)",
			array($dpname,$clientid,$salesid,$price,$dptime,$dptype,$transaction_id));
			Log::DEBUG("insert2".$row);
			
			$agentlist = $DB->query("select * from xl_clientslist where clientid = ?",array($salesid));
			$agentid = 0;
			if(count($agentlist)>0){
				$agentid = $agentlist[0]['agentid'];
				
			//绑定代理商关系
			$row = $DB->query("insert into xl_clientslist(clientid,belongto,conndate,agentid) values(?,?,?,?)",array($clientid,$agentid,$dptime,$agentid));
			//绑定业务员关系
			$DB->query("insert into xl_clientslist(clientid,belongto,conndate,agentid) values(?,?,?,?)",array($clientid,$salesid,$dptime,$agentid));
			//存储代理商用户信息
			$agentuserlist = $DB->query("select id from xl_agentuser where userid = ?",array($clientid));
			if(count($agentuserlist)<=0){
				$DB->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array($agentid,$clientid,time()));
			}
			
			//更改角色
			$row = $DB->query("update xl_userinfo set role=2 where userid=?",array($clientid));
			}
			
			
		}
		
		$redis_ocean = new Redis();
		$redis_ocean->connect(RedISHost, RedISPORT);			
		$resUseKey = 'use:deposit:'.$salesid;		
		$redis_ocean->setex($resUseKey, 30, 'deposit succes');

		$DB->CloseConnection();
	}
}

Log::DEBUG("begin goods notify");
$notify = new PayNotifyGoodsCallBack();
$notify->Handle(false);
