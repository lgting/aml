<?php
ini_set('date.timezone','Asia/Shanghai');
error_reporting(E_ERROR);

require_once "../lib/WxPay.Api.php";
require_once '../lib/WxPay.Notify.php';
require_once 'log.php';
require_once("../../../tool/PDO.class.php");
require_once("../../../tool/config.php");
require_once("../../../tool/util.php");

//初始化日志
$logHandler= new CLogFileHandler("../logs/".date('Y-m-d').'.log');
$log = Log::Init($logHandler, 15);

class PayNotifyCallBack extends WxPayNotify
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
		Log::DEBUG("call back...:" . json_encode($data));
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
		
		
		
		
		return true;
	}
	
	function nmd(){
		Log::DEBUG("im nmd");
	}
	
	//购买商品返回方法
	function GoodsPayBack($data,$attach){
		//Log::DEBUG("im enter");
			
		$transaction_id = $data['transaction_id'];
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("select * from xl_buylist where serialnum = ?",array($transaction_id));
		
		//Log::DEBUG("start add call data:".$data['transaction_id']);
		
		$price = intval($attach[3]);
		$goodsid = intval($attach[4]);
		$userid = intval($attach[1]);
		if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['buyid'] == 0){
			//没有这个订单重新添加
			
			//Log::DEBUG("im enter2");
			
			//给玩家添加礼品券
			$couponList = $DB->query("select * from xl_coupontogoods where goodsid = ?",array($goodsid));
			$giftArr = array('1'=>0,'2'=>0);
			if($couponList != null && count($couponList)>0){
				
				$arrlen = count($couponList);
				$couponMsg;
				for($i = 0;$i<$arrlen;$i++){
					if(count($couponList[$i])>0){
						$cid = $couponList[$i]['couponid'];
						$couponMsg = $DB->query("select * from xl_coupon where id = ".$cid);
						
						if($couponMsg == null || count($couponMsg)<=0 || count($couponMsg[0])<=0 || $couponMsg[0]['id'] == 0){
							continue;
						}
						
						$giftArr[$couponMsg[0]['type']]+=$couponList[$i]['nums'];
						$datefrom = time() + $couponMsg[0]['starttime'];
						$dateto = $datefrom + $couponMsg[0]['endtime'];
						
						
						$sqlStr = $cid.",".$userid.",".$datefrom.",".$dateto;
//							echo "insert into xl_couponlist(cpuuid,belongto,datefrom,dateto) value(".$sqlStr.")";
						//添加到客户列表
						$DB->query("insert into xl_couponlist(cpuuid,belongto,datefrom,dateto) value(".$sqlStr.")");
					}
				}
				
			}
			
			//添加购买列表
			$giftnum = $giftArr['1'];
			$expnum = $giftArr['2'];
			
			$result = $DB->query("insert into xl_buylist(serialnum,setsname,buydate,giftnum,expnum,bindinfo,notes,userid,price)values(?,?,?,?,?,?,?,?,?)",
			array($transaction_id,$attach[2],time(),$giftnum,$expnum,0,'buy',$userid,$price));
			
			Log::DEBUG("add".$transaction_id);
		}
	}
}

Log::DEBUG("begin notify");
$notify = new PayNotifyCallBack();
$notify->Handle(false);
