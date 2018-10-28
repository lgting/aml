<?php
	
	$conn;
	date_default_timezone_set("Asia/Shanghai");
	function writeJson($result){
		//header("Content-type:text/json;charset=utf-8");
		header("Content-type: text/html; charset=utf-8");
		//header("Content-Type:application/json;charset=UTF-8");
		echo json_encode($result,JSON_UNESCAPED_UNICODE);
	}

	function alphaID($in, $to_num = false, $pad_up = false, $passKey = "ehidbo"){
	    $index = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	    if ($passKey !== null) {
	        for ($n = 0; $n<strlen($index); $n++) {
	            $i[] = substr( $index,$n ,1);
	        }
	        $passhash = hash('sha256',$passKey);
	        $passhash = (strlen($passhash) < strlen($index))
	            ? hash('sha512',$passKey)
	            : $passhash;
	        for ($n=0; $n < strlen($index); $n++) {
	            $p[] =  substr($passhash, $n ,1);
	        }
	        
	        array_multisort($p,  SORT_DESC, $i);
	        $index = implode($i);
	    }
	    $base  = strlen($index);
	    if ($to_num) {
	        // Digital number  <<--  alphabet letter code
	        $in  = strrev($in);
	        $out = 0;
	        $len = strlen($in) - 1;
	        for ($t = 0; $t <= $len; $t++) {
	            $bcpow = bcpow($base, $len - $t);
	            $out   = $out + strpos($index, substr($in, $t, 1)) * $bcpow;
	        }
	        if (is_numeric($pad_up)) {
	            $pad_up--;
	            if ($pad_up > 0) {
	                $out -= pow($base, $pad_up);
	            }
	        }
	        $out = sprintf('%F', $out);
	        $out = substr($out, 0, strpos($out, '.'));
	    } else { 
	        // Digital number  -->>  alphabet letter code
	        if (is_numeric($pad_up)) {
	            $pad_up--;
	            if ($pad_up > 0) {
	                $in += pow($base, $pad_up);
	            }
	        }
	        $out = "";
	        for ($t = floor(log($in, $base)); $t >= 0; $t--) {
	            $bcp = bcpow($base, $t);
	            $a   = floor($in / $bcp) % $base;
	            $out = $out . substr($index, $a, 1);
	            $in  = $in - ($a * $bcp);
	        }
	        $out = strrev($out); // reverse
	    }
	    return $out;
	}

	function getConnect(){
		global $conn;
		if(!$conn){

			$conn = new mysqli(DBHOST, DBUSER, DBPASS, DATABASE);	
			if(!$conn){
				die("cann't connnect mysqldb");
			}
		}
		return $conn;
	}

	function mysql_insert($table, $inserts) {
		global $conn;
		foreach($inserts as $key => $val){
			$keys[] = $key;
			if(is_string($val)){
				$val = '"'.$conn->real_escape_string($val).'"';
			}
			$values[] = $val;
		}
	    return $conn->query('INSERT INTO `'.$table.'` (`'.implode('`,`', $keys).'`) VALUES ('.implode(',', $values).')');
	}
	
	
	function getCurrentPath(){
		$info = pathinfo(parse_url($_SERVER['REQUEST_URI'],PHP_URL_PATH));
		return $info['dirname']."/";
	}

	function showImage($im){
		header("Content-type: image/png");
		imagepng($im);
		imagedestroy($im);
	}

	function getIp() {
	    $ipaddress = '';
	    if (isset($_SERVER['HTTP_CLIENT_IP'])) {
	        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
	    }
	    else if(isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
	        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
	    }
	    else if(isset($_SERVER['HTTP_X_FORWARDED'])) {
	        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
	    }
	    else if(isset($_SERVER['HTTP_FORWARDED_FOR'])) {
	        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
	    }
	    else if(isset($_SERVER['HTTP_FORWARDED'])) {
	        $ipaddress = $_SERVER['HTTP_FORWARDED'];
	    }
	    else if(isset($_SERVER['REMOTE_ADDR'])) {
	        $ipaddress = $_SERVER['REMOTE_ADDR'];
	    }
	    else {
	        $ipaddress = 'UNKNOWN';
	    }
	    return $ipaddress;
	}
	
	//发送错误码
	function ErrorSend($errorid){
		$json_arrback = array("error"=>$errorid);
		$json_objback = json_encode($json_arrback);
		echo $json_objback;
	}
	
	function ReturnMsg($errorid,$msg,$arr=[]){
		$json_arrback = ["error"=>$errorid,'msg'=>$msg,'arr'=>$arr];
		$json_objback = json_encode($json_arrback);
		exit($json_objback);
	}
	
	function ErrorStatus($errorid){
		$json_arrback = array("status"=>$errorid);
		$json_objback = json_encode($json_arrback);
		echo $json_objback;
	}
	
	function IsAuthority(){
		if(!isset($_POST['amlkey'])){
			ErrorSend('-1001');
			exit();
		}

		$userkey = $_POST['amlkey'];
		$redis_ocean = new Redis();
    	$redis_ocean->connect(RedISHost, RedISPORT);
		if(!$redis_ocean->exists($userkey)){
			ErrorSend(-1001);
			exit();
		}
		return true;	
	}
	
	function getUserInfo($userkey){
		$redis_ocean = new Redis();
    	$redis_ocean->connect(RedISHost, RedISPORT);
		if(!$redis_ocean->exists($userkey)){
			ErrorSend(-1001);
			return null;
		}	
		return array('userid'=>$redis_ocean->get($userkey),'role'=>$redis_ocean->get($userkey.'role'));
	}
	
		//去掉名字上的图片字符
	function removeEmoji($text) {
		// Match Emoticons
		$regexEmoticons = '/[\x{1F600}-\x{1F64F}]/u';
		$clean_text = preg_replace($regexEmoticons, '', $text);

		// Match Miscellaneous Symbols and Pictographs
		$regexSymbols = '/[\x{1F300}-\x{1F5FF}]/u';
		$clean_text = preg_replace($regexSymbols, '', $clean_text);

		// Match Transport And Map Symbols
		$regexTransport = '/[\x{1F680}-\x{1F6FF}]/u';
		$clean_text = preg_replace($regexTransport, '', $clean_text);

		// Match Miscellaneous Symbols
		$regexMisc = '/[\x{2600}-\x{26FF}]/u';
		$clean_text = preg_replace($regexMisc, '', $clean_text);

		// Match Dingbats
		$regexDingbats = '/[\x{2700}-\x{27BF}]/u';
		$clean_text = preg_replace($regexDingbats, '', $clean_text);

		return $clean_text;
	}
	
	function filterEmoji($str)
	{
		 $str = preg_replace_callback(
		   '/./u',
		   function (array $match) {
			return strlen($match[0]) >= 4 ? '' : $match[0];
		   },
		   $str);
		 
		  return $str;
	 }
	 
	 function create_unique() {  
		$data = $_SERVER['HTTP_USER_AGENT'] . $_SERVER['REMOTE_ADDR']  
		.time() . rand();  
		return sha1($data);
	} 
	 
	 //检验token 
	 function CheckToken(){
		 
		  if(!isset($_POST['openid']) || !isset($_POST['token'])){
			 ErrorSend('-1000');
			 exit();
		 }
		 
		 
		 $token = $_POST['token'];
		 $openid = $_POST['openid'];
		 
		 $db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		 $result = $db->query("SELECT loginkey from xl_userinfo where openid = ?",array($openid));
		 if(count($result)>0){
			 $keys = $result[0]['loginkey'];
			 $rtoken = md5($openid.$keys);
			 if($rtoken != $token){
				 //token 失效
				 ErrorSend('-1002');
				 $db->Closeconnection();
				 exit();
			 }
		 }
		 else{
			 ErrorSend('-1001');
			 $db->Closeconnection();
			 exit();
		 }
		 
		 
		 
		/* $redis_ocean = new Redis();
		 $redis_ocean->pconnect(RedISHost, RedISPORT);
		 if(!$redis_ocean->exists($openid)){
			 //没有登陆
			 ErrorSend('-1001');
			 //header('HTTP/1.1 881 Not Login');
			 exit();
		 }
		 $keys = $redis_ocean->get($openid);
		 $rtoken = md5($openid.$keys);
		 //echo '$rtoken='.$rtoken;
		 if($rtoken != $token){
			 //token 失效
			 ErrorSend('-1002');
			 //header('HTTP/1.1 882 Token Fail');
			 exit();
		 }*/
		 
	 }
	
	 //是否能够使用券
	 function isCanUse($roles){
	 	if($roles == User || $roles==Beauties){
	 		return true;
	 	}
		return false;
	 }
?>