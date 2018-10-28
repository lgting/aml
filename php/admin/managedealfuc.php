<?php
	header('Access-Control-Allow-Origin:*');
	require("../tool/config.php");
	require("../tool/util.php");
	require_once("include.php");
	use Module\AdminPower;
	use Module\DB;
	
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
		else if($fuc=="selectwithdraw"){
			selectwithdraw_handle();
		}
		else if($fuc=="selectdrawrecord"){
			selectdrawrecord_handle();
		}
		
	}
	
	function withdraw_handle(){
		if(!isset($_POST['offset'])){
			ErrorSend('offset fail');
			exit();
		}
		$offset = $_POST['offset'];
		withdraw_fun($offset);
	}
	
	function withdraw_fun($offset){
		$len = 20;
		$startindex = intval($offset) * $len;
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT xl_userinfo.userid,xl_userinfo.username,role,
		bankname,banknum,bankaccount,drawid,drawdate,sum,status FROM xl_withdrawlist,xl_userinfo,xl_bankinfos WHERE xl_withdrawlist.username=xl_userinfo.userid and xl_userinfo.userid=xl_bankinfos.username ORDER BY drawdate DESC LIMIT ?,?",array($startindex,$len));
		echo json_encode($result);
		$db->CloseConnection();
	}
	
	//查询提现列表
	function selectwithdraw_handle(){
		if(!isset($_POST['select'])){
			ErrorSend('select fail');
			exit();
		}
		
		$selectmsg = $_POST['select'];
		
		if($selectmsg == null || $selectmsg == ""){
			withdraw_fun(0);
			return;
		}
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT xl_userinfo.userid,xl_userinfo.username,role,
		bankname,banknum,bankaccount,drawid,drawdate,sum,status FROM xl_withdrawlist,xl_userinfo,xl_bankinfos
		WHERE xl_withdrawlist.username=xl_userinfo.userid and xl_userinfo.userid=xl_bankinfos.username
		and (xl_userinfo.username like ? or phone like ?) ORDER BY drawdate DESC LIMIT 0,100",array('%'.$selectmsg.'%','%'.$selectmsg.'%'));
		
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
		
		$apower = new AdminPower();
		$isOk = $apower->isUserPowerToClient(__FUNCTION__,$_POST);
		if(!$isOk){
			return;
		}
		
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
		drawrecord_fun($_POST['offset']);
	}
	
	function drawrecord_fun($offset){
		$len = 20;
		$startindex = intval($offset) * $len;
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT xl_userinfo.userid,xl_userinfo.username,role,
		bankname,banknum,bankaccount,drawdate,finishdate,sum FROM xl_drawrecord,xl_userinfo,xl_bankinfos WHERE xl_drawrecord.username=xl_userinfo.userid and xl_userinfo.userid=xl_bankinfos.username ORDER BY finishdate DESC LIMIT ?,?",array($startindex,$len));
		echo json_encode($result);
		$db->CloseConnection();
	}
	
	//查询记录
	function selectdrawrecord_handle(){
		$selectmsg = $_POST['select'];
		
		if($selectmsg == null || $selectmsg == ""){
			drawrecord_fun(0);
			return;
		}
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT xl_userinfo.userid,xl_userinfo.username,role,
		bankname,banknum,bankaccount,drawdate,finishdate,sum FROM xl_drawrecord,xl_userinfo,
		xl_bankinfos WHERE xl_drawrecord.username=xl_userinfo.userid and 
		xl_userinfo.userid=xl_bankinfos.username and (xl_userinfo.username like ? or phone like ?) 
		ORDER BY finishdate DESC LIMIT 0,100",array('%'.$selectmsg.'%','%'.$selectmsg.'%'));
		echo json_encode($result);
		$db->CloseConnection();
	}
?>