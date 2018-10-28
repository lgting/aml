<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8">
    <title>HTML5 GetUserMedia Demo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
	<script src="http://www.jubenxiong.com/php_face_sdk/facechecking/js/sharejs.js"></script>
	<script src="../php_face_sdk/facechecking/js/jquery-2.0.2.min.js"></script>
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<body>
	<?php require 'share.php';?>
    <input type="button" title="selectimages" value="selectimages" onclick="selectImage()" /><br/>

    <script type="text/javascript">	
		GetUrlData();		
    </script>
</body>
</html>


<?php
	//$localId = (isset($_POST['localId'])) ? $_POST['localId'] :"null";
	//echo "hc="+$localId+"dd";
	require_once "jssdk.php";
	require_once "config.php";
	if(isset($_GET['localId'])){
		$localId = $_GET['localId'];
		$jssdk = new JSSDK(APPID, APPSECRET);
		$atk = $jssdk->getAccessToken();
		//根据微信JS接口上传了图片,会返回上面写的images.serverId（即media_id），填在下面即可  
		$str = "https://api.weixin.qq.com/cgi-bin/media/get?access_token=$atk&media_id=$localId";
		//$str = "https://qyapi.weixin.qq.com/cgi-bin/media/get?access_token=$atk&media_id=$localId";  
		
		echo 'oooow'.$atk.'-----'.$str.'||||';
		
		return;
		
		//获取微信“获取临时素材”接口返回来的内容（即刚上传的图片）  
		$a = file_get_contents($str);  
		//__DIR__指向当前执行的PHP脚本所在的目录  
		//echo 'weixin'.$a;//__DIR__;  
		
		//以读写方式打开一个文件，若没有，则自动创建  
		$resource = fopen("image"."/1.jpg" , 'w+');  
		//将图片内容写入上述新建的文件  
		fwrite($resource, $a);  
		//关闭资源  
		fclose($resource);  
		
	}
?>
