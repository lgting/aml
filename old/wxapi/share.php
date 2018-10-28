<?php
header('Access-Control-Allow-Origin:*');
header("Content-type: text/html; charset=utf-8");
require_once("../php/tool/config.php");
//header('Access-Control-Allow-Origin:*');
if(isset($_POST['urls'])){
	require_once "jssdk.php";
	$jssdk = new JSSDK(APPID, APPSECRET);
	$signPackage = $jssdk->GetSignPackage($_POST['urls']);
	$accessToken = $jssdk->getAccessToken();
	//$signPackage['token'] = $accessToken;
	echo json_encode($signPackage);
}
?>