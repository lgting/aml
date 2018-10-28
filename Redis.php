<?php
require_once("../tool/config.php");
require_once("../tool/util.php");
require_once("../tool/config.php");
require_once("../tool/PDO.class.php");
	$redis_ocean = new Redis();
    $redis_ocean->connect(RedISHost, RedISPORT);
	
	if($redis_ocean->exists('userid')){
		echo $redis_ocean->get('userid');
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		//查询这个微信号是否以前登陆过
		$result = $DB->query("SELECT id,gname,message,price,type,icon from xl_goods where isshow = 1 limit 0, 5");
		
		//$conn = getConnect();
		//$sql = "SELECT * FROM xl_userinfo where userid = 1";//"select count(*) from vote where openid=$Openid and inserttime>$lastime";
		//$res = $conn->query($sql);
		
		exit();
	}
	
	$redis_ocean->setex('userid', 10, 'ttl abc come');
	
?>