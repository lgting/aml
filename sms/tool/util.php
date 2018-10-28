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
?>