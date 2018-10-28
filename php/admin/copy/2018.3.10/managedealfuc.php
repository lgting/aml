<?php
	header('Access-Control-Allow-Origin:*');
	require("../tool/PDO.class.php");
	require("../tool/config.php");
	require("../tool/util.php");
	
	if(!IsAuthority()){
		exit();
	}
	
	if(isset($_POST['fuc'])){
		$fuc = $_POST['fuc'];
		if($fuc=="withdraw"){
			withdraw_handle();
		}
		else if($fuc=="totalcount"){
			totalcount_handle();
		}
		else if($fuc=="dealdraw"){
			deal_withdraw_handle();
		}
		else if($fuc=="drawrecord"){
			drawrecord_handle();
		}
	}
	
	function withdraw_handle(){
		if(!isset($_POST['offset'])){
			ErrorSend('offset fail');
			exit();
		}
		$len = 20;
		$startindex = intval($_POST['offset']) * $len;
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT xl_userinfo.userid,xl_userinfo.username,role,
		bankname,banknum,bankaccount,drawid,drawdate,sum,status FROM xl_withdrawlist,xl_userinfo,xl_bankinfos WHERE xl_withdrawlist.username=xl_userinfo.userid and xl_userinfo.userid=xl_bankinfos.username ORDER BY drawdate DESC LIMIT ?,?",array($startindex,$len));
		echo json_encode($result);
		$db->CloseConnection();
	}
	
	function totalcount_handle(){
		if(!isset($_POST['type'])){
			ErrorSend('type fail');
			exit();
		}
		$sqlstr = "SELECT count(*) from xl_withdrawlist";
		if(intval($_POST['type'])==1){
			$sqlstr = "SELECT count(*) from xl_withdrawlist";
		}
		else{
			$sqlstr = "SELECT count(*) from xl_drawrecord";
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query($sqlstr);
		echo $result[0]["count(*)"];
		$db->CloseConnection();
	}
	
	function deal_withdraw_handle(){
		if(!isset($_POST['drawid'])){
			ErrorSend('drawid fail');
			exit();
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("select * from xl_withdrawlist where drawid=?",array($_POST['drawid']));
		$row = $db->query("insert into xl_drawrecord(username,drawdate,finishdate,sum) values(?,?,?,?)",array($result[0]['username'],$result[0]['drawdate'],time(),$result[0]['sum']));
		$db->query("delete from xl_withdrawlist where drawid=?",array($_POST['drawid']));
		echo "200";
		$db->CloseConnection();
	}
	
	function drawrecord_handle(){
		if(!isset($_POST['offset'])){
			ErrorSend('offset fail');
			exit();
		}
		$len = 20;
		$startindex = intval($_POST['offset']) * $len;
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT xl_userinfo.userid,xl_userinfo.username,role,
		bankname,banknum,bankaccount,drawdate,finishdate,sum FROM xl_drawrecord,xl_userinfo,xl_bankinfos WHERE xl_drawrecord.username=xl_userinfo.userid and xl_userinfo.userid=xl_bankinfos.username ORDER BY finishdate DESC LIMIT ?,?",array($startindex,$len));
		echo json_encode($result);
		$db->CloseConnection();
	}
?>