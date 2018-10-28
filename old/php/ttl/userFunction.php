<?php
header('Access-Control-Allow-Origin:*');
require("../tool/PDO.class.php");
require("../tool/config.php");
require("../tool/util.php");
if(isset($_POST['type'])){
	$gettype = $_POST['type'];
	switch($gettype){
		case 'userinfo':
			GetUserInfoClient();
			break;
		case 'extuser':
			//用户下线列表
			extension_fun();
			break;
		case 'GetUserInfotwo':
			GetUserInfotwo();
			break;
	}
}

function GetUserInfoClient(){
	if(!isset($_POST['openid'])){
		ErrorSend('not openid');
		exit();
	}
	
	$openid = $_POST['openid'];
	if(strlen($openid)>100){
		ErrorSend('openid to long');
		exit();
	}
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $DB->query("SELECT * FROM xl_userinfo where openid = ?",array($openid));
	if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['userid'] == 0){
		ErrorSend('not userid');
		$DB->CloseConnection();
		exit();
	}
	
	$userid = $result[0]['userid'];
	
	$resultArr = array('userid'=>$userid,
		'username'=>$result[0]['username'],
		'phone'=>$result[0]['phone'],
		'role'=>$result[0]['role'],
		'accounts'=>$result[0]['accounts'],
		'openid'=>$result[0]['openid'],
		'headimgurl'=>$result[0]['headimgurl'],
		'sex'=>$result[0]['sex'],
		'source'=>$result[0]['source']
	);
	
	$couponResult = $DB->query("SELECT giftnum,expnum,goodsid from xl_buylist where userid = ".$userid);
	$giftnum = 0;
	$expnum = 0;
	if($couponResult == null || count($couponResult)<=0 || count($couponResult[0])<=0){
		$giftnum = 0;
		$expnum = 0;
	}
	else{
		$cNum = count($couponResult);
		for($i = 0;$i<$cNum;$i++){
			$giftnum+=$couponResult[$i]['giftnum'];
			$expnum+=$couponResult[$i]['expnum'];
		}			
	}
	
	$resultArr['clientNum'] = 0;
	if($result[0]['role']!=User){
		$RoleRes = $DB->query("select count(listid) from xl_clientslist,xl_userinfo where userid = clientid and role<>3 and role<>4 and belongto = ".$userid);
		$resultArr['clientNum'] = $RoleRes[0]['count(listid)'];
	}
	
	
	$resultArr['buyarr'] = $couponResult;
	$resultArr['giftnum'] = $giftnum;
	$resultArr['expnum'] = $expnum;
	$resultArr['error'] = 'ok';
	$DB->CloseConnection();
	
	$json_objback = json_encode($resultArr,JSON_UNESCAPED_UNICODE);
	echo $json_objback;
	//echo $result[0]['username'];
}


function extension_fun(){
	if(!isset($_POST['userid'])){
		ErrorSend('not userid');
		exit();
	}
	
	
	$userid = $_POST['userid'];
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $DB->query("select xl_extension.*,username,headimgurl,phone,conndate from xl_extension,xl_userinfo where xl_extension.extid = xl_userinfo.userid and xl_extension.userid = ?",array($userid));
	$resultArr['error'] ='ok';
	$resultArr['arr'] =$result;
	
	$json_objback = json_encode($resultArr);
	echo $json_objback;
	
}


function GetUserInfotwo(){
	if(!isset($_POST['openid'])){
		ErrorSend('not openid');
		exit();
	}
	
	$openid = $_POST['openid'];
	if(strlen($openid)>100){
		ErrorSend('openid to long');
		exit();
	}
	
	$DB = new Db(DBHOST, "xl_shop", DBUSER, DBPASS);
	$result = $DB->query("SELECT * FROM xl_userinfo where openid = ?",array($openid));
	if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['userid'] == 0){
		ErrorSend('not userid');
		$DB->CloseConnection();
		exit();
	}
	
	$userid = $result[0]['userid'];
	
	echo $result[0]['username'];
	
	$resultArr = array('userid'=>$userid,
		'username'=>$result[0]['username'],
		'phone'=>$result[0]['phone'],
		'role'=>$result[0]['role'],
		'accounts'=>$result[0]['accounts'],
		'openid'=>$result[0]['openid'],
		'headimgurl'=>$result[0]['headimgurl'],
		'sex'=>$result[0]['sex'],
		'source'=>$result[0]['source']
	);
	
	$couponResult = $DB->query("SELECT giftnum,expnum,goodsid from xl_buylist where userid = ".$userid);
	$giftnum = 0;
	$expnum = 0;
	if($couponResult == null || count($couponResult)<=0 || count($couponResult[0])<=0){
		$giftnum = 0;
		$expnum = 0;
	}
	else{
		$cNum = count($couponResult);
		for($i = 0;$i<$cNum;$i++){
			$giftnum+=$couponResult[$i]['giftnum'];
			$expnum+=$couponResult[$i]['expnum'];
		}			
	}
	
	$resultArr['clientNum'] = 0;
	if($result[0]['role']!=User){
		$RoleRes = $DB->query("select count(listid) from xl_clientslist where belongto = ".$userid);
		$resultArr['clientNum'] = $RoleRes[0]['count(listid)'];
	}
	
	$resultArr['buyarr'] = $couponResult;
	$resultArr['giftnum'] = $giftnum;
	$resultArr['expnum'] = $expnum;
	$resultArr['error'] = 'ok';
	$DB->CloseConnection();
	
	$json_objback = json_encode($resultArr,JSON_UNESCAPED_UNICODE);
	echo $json_objback;
	//echo $result[0]['username'];
}

?>