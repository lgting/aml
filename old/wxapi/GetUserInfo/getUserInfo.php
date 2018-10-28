<?php
header('Access-Control-Allow-Origin:*');
require_once("../../php/tool/config.php");
require_once("../../php/tool/PDO.class.php");
require_once("../../php/tool/util.php");
require_once 'log.php';

$logHandler= new CLogFileHandler("./logs/".date('Y-m-d').'.log');
$log = Log::Init($logHandler, 15);

$appid = APPID;
$secret = APPSECRET;  
//echo 'appid='.$appid.'....secret='.$secret;
$code = $_GET["code"];

 

//第一步:取全局access_token
//$url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$appid&secret=$secret";
//$token = getJson($url);
 

//第二步:取得openid
$oauth2Url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=$appid&secret=$secret&code=$code&grant_type=authorization_code";
$oauth2 = getJson($oauth2Url);

Log::DEBUG("query:=".$_GET["selfurl"]);

if(!isset($oauth2["refresh_token"])){
	Log::DEBUG("query:" . json_encode($oauth2).'...urls='.$_GET["selfurl"]);
	header("Location:".$_GET["selfurl"]);
	exit();
}

//header("Location:http://www.jubenxiong.com/aml/wxapi/GetUserInfo/dropindex.php?type=amlzlogin");
//return;

//第三刷新access_token
$refresh_token = $oauth2["refresh_token"];
//            "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=APPID&grant_type=refresh_token&refresh_token=REFRESH_TOKEN "
$refauthurl = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=$appid&grant_type=refresh_token&refresh_token=$refresh_token";
//echo 'rurls'.$refauthurl;
$refoauth2 = getJson($refauthurl);
/*var_dump($refoauth2);
echo '.....<br>';*/

if(!isset($refoauth2["access_token"])){
	var_dump($refoauth2);
	echo '.........<br>';
}

//第四步:根据全局access_token和openid查询用户信息
$access_token = $refoauth2["access_token"];  //$refoauth2['access_token'];//
$openid = $refoauth2['openid'];  
$userurl = "https://api.weixin.qq.com/sns/userinfo?access_token=$access_token&openid=$openid&lang=zh_CN";
$get_user_info_url = $userurl;//"https://api.weixin.qq.com/cgi-bin/user/info?access_token=$access_token&openid=$openid&lang=zh_CN";
$userinfo = getJson($get_user_info_url);


if(isset($_GET['type'])){
	$usertype = $_GET['type'];
	//$backJson = json_encode($userinfo,JSON_UNESCAPED_UNICODE);
	if($usertype == 'amlzlogin'){
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		//查询这个微信号是否以前登陆过
		$openid = $userinfo['openid'];
		$headimgurl = $userinfo['headimgurl'];
		$rnames = filterEmoji($userinfo['nickname']);
		if($rnames==null || $rnames == ''){
			$rnames = $openid;
		}
		
		//$userinfo['nickname'];//
		$result = $DB->query("SELECT count(*) FROM xl_userinfo where openid = ?",array($openid));
		if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['count(*)'] == 0){			
			$DB->query("insert into xl_userinfo(username,role,accounts,openid,headimgurl,regTime,sex)VALUES(?,?,?,?,?,?,?)",array($rnames,User,0,$openid,$headimgurl,time(),$userinfo['sex']));
		}
		else{
			$DB->query("update xl_userinfo set headimgurl ='?',username=? where openid=?",array($headimgurl,$rnames,$openid));
		}
		
		
		$url =  ROOTURL.'login.html?openid='.$openid;
		if(isset($_GET['userid'])){
			
			$tuserid = $_GET['userid'];
			if(is_numeric($tuserid) && $tuserid>0){
				$DB->query("update xl_userinfo set tid =? where openid=?",array($tuserid,$openid));
			}
			
			if(isset($_GET['detailsid'])){
				$detailsid = $_GET['detailsid'];
				$url = ROOTURL.'login.html?openid='.$openid.'&detailsid='.$detailsid;
			}
		}
		else{
			$DB->query("update xl_userinfo set tid =? where openid=?",array(0,$openid));
		}
		//'http://www.jubenxiong.com/wxapi/index.html?json='.$backJson;
		header("Location:".$url);
	}
	else{
		//$url = 'http://www.jubenxiong.com/wxapi/index.html?a=bb';
		//header("Location:".$url);
		var_dump($userinfo);
		
	}
}



function getJson($url){

    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, $url);

    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE); 

    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE); 

    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    $output = curl_exec($ch);

    curl_close($ch);

    return json_decode($output, true);

}
?>