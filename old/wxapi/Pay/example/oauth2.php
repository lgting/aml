<?php
require_once "../lib/WxPay.Config.php";
header('Access-Control-Allow-Origin:*');
//require_once 'log.php';
//$logHandler= new CLogFileHandler("../logs/".date('Y-m-d').'.log');
//$log = Log::Init($logHandler, 15);
//Log::DEBUG('abcdef');

/*if(isset($_GET['code']))
{
	$url = 'http://www.jubenxiong.com/?code='.$_GET['code'];
	Log::DEBUG('kaka'.$url);
	exit();
}*/

if(!isset($_GET['tourl']))
{
	exit();
}
$tourl = $_GET['tourl'];
//$tourl = 'http://www.jubenxiong.com/wxapi/Pay/example/oauth2.php';
//获取openid
$url = CreateOauthUrlForCode($tourl);
Header("Location: $url");


function CreateOauthUrlForCode($redirectUrl)
{
	$urlObj["appid"] = WxPayConfig::APPID;
	$urlObj["redirect_uri"] = "$redirectUrl";
	$urlObj["response_type"] = "code";
	$urlObj["scope"] = "snsapi_base";
	$urlObj["state"] = "STATE"."#wechat_redirect";
	$bizString = ToUrlParams($urlObj);
	return "https://open.weixin.qq.com/connect/oauth2/authorize?".$bizString;
}

function ToUrlParams($urlObj)
{
	$buff = "";
	foreach ($urlObj as $k => $v)
	{
		if($k != "sign"){
			$buff .= $k . "=" . $v . "&";
		}
	}
	
	$buff = trim($buff, "&");
	return $buff;
}

function httpGet($url) {
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_TIMEOUT, 500);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
	curl_setopt($curl, CURLOPT_URL, $url);

	$res = curl_exec($curl);
	curl_close($curl);

	return $res;
}

?>

