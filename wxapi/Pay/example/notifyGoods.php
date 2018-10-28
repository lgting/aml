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
		
		//$attach = explode(";",$attach);
		
		$transaction_id = $data['transaction_id'];
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("select buyid from xl_buylist where serialnum = ?",array($transaction_id));
		
		$orderid = $attach[1];
		$ordrenum = count($result);
		
		if($ordrenum>0){
			$DB->CloseConnection();
			return false;
		}
		
		
		$orderList = $DB->query("select * from xl_buylist where orderid = ?",[$orderid]);
		$ordrenum = count($orderList);
		if($ordrenum<=0){
			$DB->CloseConnection();
			return false;
		}
		
		$goodsid = $orderList[0]['goodsid'];
		$tid = $orderList[0]['tid'];
		$userid = $orderList[0]['userid'];
		$bossid = $orderList[0]['bossid'];
		$beautiesid = $orderList[0]['beautiesid'];
		$sqlArr = [];
		
		$goodsres = $DB->query("select gname,commissionboss,commissionsalesman,price,type,commagent,giveIntegral,agentid,extsource,commissionhelp,
		 commissionbeauties,divideintotp from xl_goods where id=$goodsid");
		if(count($goodsres)<=0){
			$DB->CloseConnection();
			return false;
		}
		
		$agentid = $goodsres[0]['agentid'];
		
		array_push($sqlArr,"update xl_goods set buynum = buynum+$ordrenum where id=$goodsid");
		$curtime = time();
		//给商品加券
		$couponList = $DB->query("select * from xl_coupontogoods where goodsid = ?",array($goodsid));
		foreach($orderList as $key=>$value){
				
			$lastbuyid = $value['buyid'];
			$giftArr = array('1'=>0,'2'=>0);
			if(count($couponList)>0){
				
				$arrlen = count($couponList);
				$couponMsg;
				for($i = 0;$i<$arrlen;$i++){
					if(count($couponList[$i])>0){
						$cid = $couponList[$i]['couponid'];
						$cnums = $couponList[$i]['nums'];
						$couponMsg = $DB->query("select * from xl_coupon where id = ".$cid);
						
						if(count($couponMsg)<=0){
							continue;
						}
						
						$giftArr[$couponMsg[0]['type']]= $giftArr[$couponMsg[0]['type']] + $cnums;
						$datefrom = time() + $couponMsg[0]['starttime'];
						$dateto = $datefrom + $couponMsg[0]['endtime'];
						
						
						$sqlStr = $cid.",".$userid.",".$datefrom.",".$dateto.",".$goodsid.",".$lastbuyid;
						//添加券
						for($k = 0;$k<$cnums;$k++){
							array_push($sqlArr,"insert into xl_couponlist(cpuuid,belongto,datefrom,dateto,goodsid,buyid) value(".$sqlStr.")");
						}
					}
				}				
			}
			
			//添加购买列表
			$giftnum = $giftArr['1'];
			$expnum = $giftArr['2'];			
			array_push($sqlArr,"update xl_buylist set giftnum=$giftnum, expnum = $expnum where buyid = $lastbuyid");
			
			//如果商品绑定代理商。记录下来			
			
			if($agentid>0){				
				array_push($sqlArr,"insert into xl_buy_agent_goods(agentid,buyerid,buytime,buyid)values($agentid,$userid,$curtime,$lastbuyid)");
			}
		}
		
		
		
		//推荐人积分
		if($tid>0 && $tid != $userid){
			$tidlist = $DB->query("select userid from xl_extension where userid=? and extid=?",array($tid,$userid));
			if(count($tidlist)<=0){
				array_push($sqlArr,"insert into xl_extension(userid,extid,goodsid,conndate)values($tid,$userid,$goodsid,$curtime)");
				
			}
			
			$extsource = $goodsres[0]['extsource']*$ordrenum;
			array_push($sqlArr,"update xl_userinfo set source = source+$extsource where userid = $tid");
		}
		array_push($sqlArr,"update xl_buylist set serialnum = $transaction_id,paystate=1 where orderid = $orderid");
		
		
		//上级分钱
		$sellUid = 0;
		$helpSellId = 0;
		//用户积分
		$giveIntegral = $goodsres[0]['giveIntegral']*$ordrenum;
		//老板分成
		//$price = $goodsres[0]['price'] *10000 * $ordrenum;
		$price = $goodsres[0]['price'] * $ordrenum;
		$divideintotp = $goodsres[0]['divideintotp'];
		$sellMoney = $HelpSellMoney = 0;
		if($divideintotp ==  PercentDivideinto){
			//商户分成
			$bossMoney = floatval($goodsres[0]['commissionboss'] * $price);	
			//美体师分成
			$beautiesMoney = $bossMoney * $goodsres[0]['commissionbeauties'];
					
			//代理商分成
			$agentMoney = floatval($goodsres[0]['commagent'] * $price);			
			$sellMoney = $agentMoney * $goodsres[0]['commissionsalesman'];
			$HelpSellMoney = $agentMoney * $goodsres[0]['commissionhelp'];
		}
		else{
			//商户分成
			$bossMoney = $goodsres[0]['commissionboss']*$ordrenum;	
			//美体师分成
			$beautiesMoney = $goodsres[0]['commissionbeauties']*$ordrenum;
			
			//代理商分成
			$agentMoney = $goodsres[0]['commagent']*$ordrenum;
			$sellMoney = $goodsres[0]['commissionsalesman']*$ordrenum;
			$HelpSellMoney = $goodsres[0]['commissionhelp']*$ordrenum;			
		}
		
		if($beautiesid>0){
			//商户减去 美体师分成剩下的钱
			$bossMoney = $bossMoney - $beautiesMoney;
		}
		
		
		$goodsname = $goodsres[0]['gname'];
		$DB->query("insert into xl_goodsuse(bossid,userid,goodsid,usetime,buyid,gname,orderid)values(?,?,?,?,?,?,?)",
		array($bossid,$userid,$goodsid,time(),$lastbuyid,$goodsname,$orderid));
		$lastuseid = $DB->lastInsertId();
		
		
		$usetSource = UseTypeSource;
		$usermoney = UseTypeMoney;
		$bosst = Boss;
		$usert = User;
		//老板的
		if($bossMoney>0){
			array_push($sqlArr,"update xl_userinfo set accounts = accounts + $bossMoney where userid = $bossid");
			
			//老板分钱记录
			array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
			values($usermoney,$lastuseid,$bossid,$bossMoney,$curtime,$bosst)");	
		}
		
		//用户分积分记录
		if($giveIntegral>0){			
			array_push($sqlArr,"update xl_userinfo set source = source + $giveIntegral where userid = $userid");			
			array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
			values($usetSource,$lastuseid,$userid,$giveIntegral,$curtime,$usert)");	
		}
		
		//美体师的
		if($beautiesMoney>0 && $beautiesid>0){	
			$Beautiest = Beauties;		
			array_push($sqlArr,"update xl_userinfo set accounts = accounts + $beautiesMoney where userid = $beautiesid");
			//美体师分钱记录
			array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
			values($usermoney,$lastuseid,$beautiesid,$beautiesMoney,$curtime,$Beautiest)");
		}
		
		//代理商线下的
		if($agentid > 0){
					
			$SellerRes = $DB->query("select belongto,clientid,role,username,salescommission
				 from xl_clientslist,xl_userinfo where userid = belongto and clientid =? and agentid = ?",array($bossid,$agentid));
				 
			$sellerNum = count($SellerRes);	
			$sellUid = 0;
			$helpSellId = 0;
			if($sellerNum>0){
				
				for($i=0;$i<$sellerNum;$i++){
					if($SellerRes[$i]["role"] == SAlESMAN){
						$sellUid = $SellerRes[$i]["belongto"];
					}
					else if($SellerRes[$i]["role"] == HelpSAlESMAN){
						$helpSellId = $SellerRes[$i]["belongto"];
					}
				}				
			}
			
			//业务分成
			if($sellUid<=0){
				$sellMoney = 0;
			}
			//美导分成
			if($helpSellId<=0){
				$HelpSellMoney = 0;
			}
			
			//代理商减去 业务和美导的分成剩下的钱
			$agentMoney = $agentMoney-($sellMoney + $HelpSellMoney);
			
			//代理商收入
			$agentt = Agent;
			array_push($sqlArr,"update xl_userinfo set accounts = accounts + $agentMoney where userid = $agentid");
				array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
				values($usermoney,$lastuseid,$agentid,$agentMoney,$curtime,$agentt)");
			
			if($sellUid>0 && $sellMoney>0){
				//添加业务收支明细				
				$salet = SAlESMAN;
				array_push($sqlArr,"update xl_userinfo set accounts = accounts + $sellMoney where userid = $sellUid");
				array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
				values($usermoney,$lastuseid,$sellUid,$sellMoney,$curtime,$salet)");
			}
			
			if($helpSellId>0 && $HelpSellMoney>0){
				//添加美导收支明细
				$halet = HelpSAlESMAN;
				array_push($sqlArr,"update xl_userinfo set accounts = accounts + $HelpSellMoney where userid = $helpSellId");
				array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
				values($usermoney,$lastuseid,$helpSellId,$HelpSellMoney,$curtime,$halet)");
			}			
		}
		
		
		try {  
		  $DB->startTransaction();
		  
		  $sqlnum = count($sqlArr);
		  for($i=0;$i<$sqlnum;$i++){
		  	$DB->query($sqlArr[$i]);
		  }
		  
		  $DB->commitTransaction();
		  
		} catch (Exception $e) {
		  $DB->rollbackTransaction();
		  Log::DEBUG("Failed".$e->getMessage());		
		}
		
		Log::DEBUG("addgoods".$transaction_id);		
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
				
				$resultclist = $DB->query("select listid from xl_clientslist where clientid=? and belongto=?",array($clientid,$salesid));
				if(count($resultclist)<=0){					
					//绑定代理商关系
					$row = $DB->query("insert into xl_clientslist(clientid,belongto,conndate,agentid) values(?,?,?,?)",array($clientid,$agentid,$dptime,$agentid));
					//绑定业务员关系
					$DB->query("insert into xl_clientslist(clientid,belongto,conndate,agentid) values(?,?,?,?)",array($clientid,$salesid,$dptime,$agentid));
					//存储代理商用户信息
					$agentuserlist = $DB->query("select id from xl_agentuser where userid = ? and aid=?",array($clientid,$agentid));
					if(count($agentuserlist)<=0){
						$DB->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array($agentid,$clientid,time()));
					}
					
					//更改角色
					$row = $DB->query("update xl_userinfo set role=2 where userid=?",array($clientid));
					
					//添加店铺信息
					$storeres = $DB->query("select * from xl_store where bossid = ?",[$clientid]);
					if(count($storeres)<=0){
						$DB->query("insert into xl_store(bossid,storekey,storename) values($clientid,$clientid,'')");
						$laststoreid = $DB->lastInsertId();
					}
					else{
						$laststoreid = $storeres[0]['id'];
					}
					
					$storekey = '0'.rand(1000, 9999).($laststoreid*3).rand(1, 99);
					$DB->query("update xl_store set storekey = ? where id = ?",[$storekey,$laststoreid]);
					
				}
				
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
