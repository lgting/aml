<?php
header('Access-Control-Allow-Origin:*');
require_once("../../php/tool/config.php");
$appid = APPID;
$snsapitp = "snsapi_userinfo";
//snsapi_base snsapi_userinfo

if(isset($_GET['type'])){
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
	//echo 'cururl'.$cururl;
	$redirect_uri = urlencode ($redirect_uri.'&selfurl='.$cururl);
	$url ="https://open.weixin.qq.com/connect/oauth2/authorize?appid=$appid&redirect_uri=$redirect_uri&response_type=code&scope=$snsapitp&state=1#wechat_redirect";
	header("Location:".$url);
}


//echo $url;
?>