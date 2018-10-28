<?php 
header("Content-type: text/html; charset=utf-8");
//header('Access-Control-Allow-Origin:*');
require_once "jssdk.php";
require_once("config.php");
$jssdk = new JSSDK(APPID, APPSECRET);

//

if(isset($_POST['createBtn'])){
	
	$signPackage = $jssdk->GetSignPackage($_POST['createBtn']);
	$accessToken = $jssdk->getAccessToken();
	/*$btndb =  '{
				 "button":[
				 {	
					  "type":"view",
					  "name":"小舅养车",
					  "url":"http://www.jubenxiong.com/appgame/sellcar/main/index.html"
				  }]
			 }';*/
			 
			 
			 /*"button":[
				 {	
					  "type":"view",
					  "name":"消消高手",
					  "url":"http://www.jubenxiong.com/wxapi/GetUserInfo/dropindex.php?type=xxl"
				  }]*/
			 
			 /**
			 {
            "name": "扫码", 
            "sub_button": [
                {
                    "type": "scancode_waitmsg", 
                    "name": "扫码带提示", 
                    "key": "rselfmenu_0_0", 
                    "sub_button": [ ]
                }, 
                {
                    "type": "scancode_push", 
                    "name": "扫码推事件", 
                    "key": "rselfmenu_0_1", 
                    "sub_button": [ ]
                }
            ]
        }, 
			 */
			 
	$btndb =  '{
				 "button": [
					{
						"name": "网站系统", 
						"sub_button": [
							{
								"type": "view", 
								"name": "汽车保养", 
								"url":"http://www.jubenxiong.com/appgame/sellcar/main/index.html"
							}, 
							{
								"type": "view", 
								"name": "美容商城", 
								"url":"http://www.jubenxiong.com/wxapi/GetUserInfo/dropindex.php?type=amlzlogin"
							}
						]
					}, 
					{
						"name": "H5互动", 
						"sub_button": [
							{
								"type": "view", 
								"name": "颜资", 
								"url":"http://www.jubenxiong.com/wxapi/GetUserInfo/dropindex.php?type=beautiful"
							}, 
							{
								"type": "view", 
								"name": "消消乐", 
								"url":"http://www.jubenxiong.com/wxapi/GetUserInfo/dropindex.php?type=xxl"
							},
							{
								"type": "view", 
								"name": "圣诞活动", 
								"url":"http://www.jubenxiong.com/wxapi/GetUserInfo/dropindex.php?type=pingtu"
							}
						]
					}]
			 }';
	
	$url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=".$accessToken;
	$result = https_request($url, $btndb);
	//var_dump($result);
	

	
	
	echo $result;
}
else if(isset($_POST['BackMsg'])){
	$signPackage = $jssdk->GetSignPackage($_POST['BackMsg']);
	$accessToken = $jssdk->getAccessToken();
	$BackMsgdb =  '{ 
	  "is_add_friend_reply_open": 1, 
	  "is_autoreply_open": 1, 
	  "add_friend_autoreply_info": { 
		  "type": "text", 
		  "content": "谢谢关注巨本熊,希望你每天都过的开开心心"
		}
	}';
	
	$url = "https://api.weixin.qq.com/cgi-bin/get_current_autoreply_info?access_token=".$accessToken;
	$result = https_request($url, $BackMsgdb);
	echo $result;
}


	function https_request($url,$data = null){
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
		if (!empty($data)){
			curl_setopt($curl, CURLOPT_POST, 1);
			curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
		}
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
		$output = curl_exec($curl);
		curl_close($curl);
		return $output;
	}
?>