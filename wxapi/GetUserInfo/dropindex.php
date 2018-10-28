<?php
header('Access-Control-Allow-Origin:*');
require_once("../../php/tool/config.php");
$appid = APPID;
$snsapitp = "snsapi_base";
//snsapi_base snsapi_userinfo

if(isset($_GET['type'])){
	/*$types = $_GET['type'];
	$url = ROOTURL.'login.html?';
	if(isset($_GET['userid'])){	
		$url .= 'userid='.$_GET['userid'];

		if(isset($_GET['detailsid'])){
			$detailsid = $_GET['detailsid'];
			$url .= '&detailsid='.$detailsid;
		}
	}
	
	header("Location:".$url);*/
	
	$types = $_GET['type'];
	$redirect_uri = ROOTURL.'wxapi/GetUserInfo/getUserInfo.php?type='.$types;//getUserInfo.php //amllogin2
	if(isset($_GET['userid'])){		
		//暧昧雪梨
		if(isset($_GET['detailsid'])){
			$detailsid = $_GET['detailsid'];
			$redirect_uri = ROOTURL.'wxapi/GetUserInfo/getUserInfo.php?type='.$types.'&userid='.$_GET['userid'].'&detailsid='.$detailsid;
		}
		else{
			$redirect_uri = ROOTURL.'wxapi/GetUserInfo/getUserInfo.php?type='.$types.'&userid='.$_GET['userid'];
		}
		
	}
	$cururl = 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
	$redirect_uri = urlencode ($redirect_uri.'&selfurl='.$cururl);
	$url ="https://open.weixin.qq.com/connect/oauth2/authorize?appid=$appid&redirect_uri=$redirect_uri&response_type=code&scope=$snsapitp&state=1#wechat_redirect";
	header("Location:".$url);
	
}

?>