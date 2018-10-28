<?php
header('Access-Control-Allow-Origin:*');
require_once "WxTransfers.Config.php";
require_once "WxTransfers.Api.php";
require_once("../../../php/tool/PDO.class.php");
require_once("../../../php/tool/config.php");
require_once("../../../php/tool/util.php");




if(isset($_POST['type'])){
	$msgtypes = $_POST['type'];
	if($msgtypes == 'tomoney'){
		WxToMoney();
	}
	else if($msgtypes == 'withdraw'){
		withdraw_handle();
	}
}

function WxToMoney(){
	if(!IsAuthority()){
		exit();
	}

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
	
	//echo 'drawid='.$drawid.'data='.$drawdate;
	
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
	
	$openid = $userresult[0]['wxopenid'];
	$username = $userresult[0]['username'];
	$curmoney = $result[0]['sum'];
	$getmoney = $curmoney*100 - ceil(floatval($curmoney*100*0.01));;
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


function withdraw_handle(){
	
	CheckToken();
	
	if(!isset($_POST['user'])){
		ErrorStatus('user fail');
		return;
	}
	else{
		if(!is_numeric($_POST['user'])){
			ErrorStatus('user not a number');
			return;
		}
	}
	
	if(!isset($_POST['money'])){
		ErrorStatus('money fail');
		return;
	}
	else{
		if(!is_numeric($_POST['money'])){
			echo json_encode(array("status" => "105"));
			return;
		}
		else{
			if(floatval($_POST['money']) <= 0.3){
				echo json_encode(array("status" => "提现金额必须大于0.3元","msg"=>1));
				return;
			}
		}
	}
	
	if(!isset($_POST['pwd'])){
		ErrorStatus('pwd fail');
		return;
	}
	
	
	$data = $_POST;// pwd:提现密码   money:金额  user:申请人
	$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$userresult = $db->query("select accounts,extrapwd,wxopenid,username,phone from xl_userinfo where userid = ?",array($data['user']));
	if($userresult==null||count($userresult)<=0){
		echo json_encode(array("status" => "106"));
		$db->Closeconnection();
		return;
	}
	else{
		if($userresult[0]["phone"]==""||$userresult[0]["phone"]=="NULL"||$userresult[0]["phone"]=="null"||$userresult[0]["phone"]==NULL||$userresult[0]["phone"]==null){
			echo json_encode(array("status" => "107"));
			$db->Closeconnection();
			return;
		}
	}
	$result = $db->query("SELECT bankid FROM xl_bankinfos where username = ?",array($data['user']));
	if(count($result)<=0){
		echo json_encode(array("status" => "108"));
		$db->Closeconnection();
		return;
	}
	
	$status = '209';
	if($data['pwd']!=$userresult[0]['extrapwd']){
		$status = '208';
	}
	else{
		if($userresult[0]['accounts'] < floatval($data['money'])){
			$status = '110';
		}
		else{
			
			$time = time();
			$sum = $userresult[0]['accounts']-floatval($data['money']);
			$row = $db->query("insert into xl_withdrawlist(username,drawdate,sum) values(?,?,?)",array($data['user'],$time,$data['money']));
			$drawid = $db->lastInsertId();
			$row = $db->query("update xl_userinfo set accounts=? where userid=?",array($sum,$data['user']));
			$moneyval = (-1)*floatval($data['money']);
			$row = $db->query("insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate)values(?,?,?,?,?)",array(UseTypeWithdraw,0,$data['user'],$moneyval,time()));
				
			
			$openid = $userresult[0]['wxopenid'];
			$username = $userresult[0]['username'];
			
			$curmoney = $data['money'];
			$getmoney = $curmoney*100 - ceil(floatval($curmoney*100*0.01));
			// - ceil(floatval($curmoney*100*0.01));
			$testdemo = new WxTransfersDemo();
			$userid = $data['user'];
			
			$tdata=array(
				'openid'=>$openid,//openid
				'check_name'=>'NO_CHECK',//是否验证真实姓名参数
				're_user_name'=>$username,//姓名
				'amount'=>$getmoney,//最小1元 也就是100
				'desc'=>ComPanyName."提现通知"//描述
			);
			
			$drawstate = $testdemo->index($tdata);

			if($drawstate == "SUCCESS"){
				$row = $db->query("insert into xl_drawrecord(username,drawdate,finishdate,sum) values(?,?,?,?)",array($userid,time(),time(),$data['money']));
				$db->query("delete from xl_withdrawlist where drawid=?",array($drawid));		
				$status = '200';
			}
			else if($drawstate == 'NOTENOUGH'){
				//余额不足。请稍等后台审核
				$status = '210';
			}
			else{
				$errorid = $drawstate;
				$status = $errorid;
			}		
		}
	}		
	$db->Closeconnection();
	echo json_encode(array("status" => $status));
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