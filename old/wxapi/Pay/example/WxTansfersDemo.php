<?php
header('Access-Control-Allow-Origin:*');
require_once "WxTransfers.Config.php";
require_once "WxTransfers.Api.php";
require_once("../../../php/tool/PDO.class.php");
require_once("../../../php/tool/config.php");
require_once("../../../php/tool/util.php");


if(!IsAuthority()){
	exit();
}

if(isset($_POST['type'])){
	$msgtypes = $_POST['type'];
	if($msgtypes == 'tomoney'){
		WxToMoney();
	}
}

function WxToMoney(){	
	if(!isset($_POST['drawid'])){
		ErrorSend('openid fail');
		exit();
	}
	if(!isset($_POST['drawdate'])){
		ErrorSend('drawdate fail');
		exit();
	}
	
	
	$drawid = $_POST['drawid'];
	$drawdate = $_POST['drawdate'];
	
	$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $db->query("select * from xl_withdrawlist where drawid=? and drawdate=?",array($drawid,$drawdate));
	
	if(count($result)<=0){
		ErrorSend('not data');
		$db->CloseConnection();
		return;
	}
	
	$userresult = $db->query("select * from xl_userinfo where userid=?",array($result[0]['username']));
	if(count($userresult)<=0){
		ErrorSend('not user data');
		$db->CloseConnection();
		return;
	}
	
	$openid = $userresult[0]['openid'];
	$username = $userresult[0]['username'];
	$getmoney = $result[0]['sum']*100;
	$testdemo = new WxTransfersDemo();
	
	$data=array(
		'openid'=>$openid,//openid
		'check_name'=>'NO_CHECK',//是否验证真实姓名参数
		're_user_name'=>$username,//姓名
		'amount'=>$getmoney,//最小1元 也就是100
		'desc'=>ComPanyName."提现通知"//描述
	);
	
	$drawstate = $testdemo->index($data);

	if($drawstate == "SUCCESS"){
		$row = $db->query("insert into xl_drawrecord(username,drawdate,finishdate,sum) values(?,?,?,?)",array($result[0]['username'],$result[0]['drawdate'],time(),$result[0]['sum']));
		$db->query("delete from xl_withdrawlist where drawid=?",array($drawid));		
		ErrorSend('200');
	}
	else if($drawstate == 'NOTENOUGH'){
		$errorid = 'failno';
		ErrorSend($errorid);
	}
	else{
		$errorid = $drawstate;
		ErrorSend($errorid);
	}
	$db->CloseConnection();
	
	//echo json_encode(array("error"=>$errorid));
	
	//ErrorSend($errorid);
}

class WxTransfersDemo{
	
	public function index($data){
		
		$path = WxTransfersConfig::getRealPath(); // 证书文件路径
		$config['wxappid'] = WxTransfersConfig::APPID;
		$config['mch_id'] = WxTransfersConfig::MCHID;
		$config['key'] = WxTransfersConfig::KEY;
		$config['PARTNERKEY'] = WxTransfersConfig::KEY;
		$config['api_cert'] = $path . WxTransfersConfig::SSLCERT_PATH;
		$config['api_key'] = $path . WxTransfersConfig::SSLKEY_PATH;
		$config['rootca'] = $path . WxTransfersConfig::SSLROOTCA;
		
		$wxtran=new WxTransfers($config);
		
		$wxtran->setLogFile('c:\transfers.log');//日志地址
		
		$data['spbill_create_ip']=$wxtran->getServerIp();//服务器IP地址
		
		$backState = $wxtran->transfers($data);
		
		if($backState == true){
			return "SUCCESS";
		}
		else{
			return $wxtran->error;
		}
	}	
}