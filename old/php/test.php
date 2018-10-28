<?php
header('Access-Control-Allow-Origin:*');
require_once("../../tool/config.php");
require_once("../../tool/PDO.class.php");
require_once("../../tool/util.php");

//$DB = new Db(DBHOST, "xl_shop", DBUSER, DBPASS);
//$result = $DB->query("update xl_userinfo set username=? where openid=?",array($userabc,'olXx5wd4-x6BhfMoqkK_Fsb10tyY'));
//var_dump($result);

//$tmpStr = preg_replace("#(\\\ue[0-9a-f]{3})#ie","addslashes('\\1')",json_encode('nickname'.$userinfo['nickname']));

//echo json_encode('nickname'.$userinfo['nickname'],JSON_UNESCAPED_UNICODE);
//echo 'selectname='.$DB->query("select * from emojitable where id = 1")[0]['username'];
//$DB->query("select * from xl_userinfo where openid =?",array('olXx5wd4-x6BhfMoqkK_Fsb10tyY'))[0]['username'];
//echo json_encode($DB->query("select * from xl_userinfo where openid =?",array('olXx5wd4-x6BhfMoqkK_Fsb10tyY')),JSON_UNESCAPED_UNICODE);

if(isset($_POST['type'])){
	$gettype = $_POST['type'];
	switch($gettype){
		case 'GetUserInfotwo':
			GetUserInfotwo();
			break;
	}
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
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $DB->query("SELECT * FROM xl_userinfo where openid = ?",array($openid));
	if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['userid'] == 0){
		ErrorSend('not userid');
		$DB->CloseConnection();
		exit();
	}
	
	$userid = $result[0]['userid'];
	
	//echo $result[0]['username'];
	
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