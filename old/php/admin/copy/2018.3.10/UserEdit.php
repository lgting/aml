<?php
header('Access-Control-Allow-Origin:*');
require("../tool/PDO.class.php");
require("../tool/config.php");
require("../tool/util.php");
if(isset($_POST['type'])){
	$gettype = $_POST['type'];
	switch($gettype){
		case 'editAdmin':
			EditAdmin();
			break;
		case 'userlist':
			getUserList();
			break;
		case 'select':
			selectUser();
			break;
		case 'sellerlist':
			sellerList();
			break;
		case 'offlinelist':
			offlinelist();
			break;
		case 'login':
			login();
			break;
		case 'transferUser':
			transferUser();
			break;
	}
}

	function EditAdmin(){
		if(!IsAuthority())
			return;
		
		if(!isset($_POST['userid'])){
			ErrorSend('not userid');
			exit();
		}
		else if(!isset($_POST['adminid'])){
			ErrorSend('not adminid');
			exit();
		}
		else if(!isset($_POST['role'])){
			ErrorSend('not role');
			exit();
		}
		else if(!isset($_POST['issystem'])){
			ErrorSend('not issystem');
			exit();
		}
		
		
		
		
		$userid = $_POST['userid'];
		$adminid = $_POST['adminid'];
		$role = $_POST['role'];
		$issystem = $_POST['issystem'];
		
		if(!is_numeric($userid)){
			ErrorSend('userid is number');
			exit();
		}
		else if(!is_numeric($adminid)){
			ErrorSend('adminid is number');
			exit();
		}
		else if(!is_numeric($role)){
			ErrorSend('role is number');
			exit();
		}
		
//		if($role !=SAlESMAN){
//			ErrorSend('-100');
//			exit();
//		}
		
		//用户绑定了商户。如果升级成其他角色咋处理
		//
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$userresult = $DB->query("select * from xl_clientslist where belongto = ?",array($userid));
		if(count($userresult)>0){
			ErrorSend('-101');
			$DB->Closeconnection();
			exit();
		}

		
		/*$result = $DB->query("select role from xl_userinfo where userid = ?",array($adminid));
		if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['role'] == 0){
			ErrorSend('no body');
			exit();
		}
		
		if($result[0]['role']!=Admin){
			ErrorSend('no weight');
			exit();
		}*/		
		if($issystem=="true"){
			$issystem = 1;
		}
		else{
			$issystem = 0;
		}
		
		$DB->query("update xl_userinfo set role = ?,issystem=? where userid=?",array($role,$issystem,$userid));
		$logs = '设置管理员-'.$userid.'-'.GetUserRole($role);
		$DB->query("insert into xl_uselog (useid,usemsg,usetm)values(?,?,?)",array($adminid,$logs,time()));
		$DB->Closeconnection();	
		ErrorSend('ok');
		
	}
	
	//获得用户列表
	function getUserList(){
		if(!IsAuthority())
			return;
		
		if(!isset($_POST['page'])){
			ErrorSend('not page');
			exit();
		}
		
		if(!isset($_POST['roletype'])){
			ErrorSend('not roletype');
			exit();
		}
		
		getUserList_hander($_POST['page'],$_POST['roletype']);
	}
	
	function getUserList_hander($pages,$roles){
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$endPage = 10;
		$startPage = $pages*$endPage;
		
		if($roles == 0){
			$result = $DB->query("select * from xl_userinfo limit ?,?",array($startPage,$endPage));
			$maxResult = $DB->query("select count(userid) from xl_userinfo");
		
		}
		else{
			$result = $DB->query("select * from xl_userinfo where role = ? limit ?,?",array($roles,$startPage,$endPage));
			$maxResult = $DB->query("select count(userid) from xl_userinfo where role = ?",array($roles));
		
		}
		
		
		$backresult = array();
		$backresult['error']='ok';
		$backresult['arr'] = $result;
		$backresult['pageMax'] = $maxResult[0]['count(userid)'];
		$DB->Closeconnection();
		$json_objback = json_encode($backresult,JSON_UNESCAPED_UNICODE);
		echo $json_objback;
	}
	
	function selectUser(){
		if(!isset($_POST['msg'])){
			ErrorSend('not msg');
			exit();
		}
		
		if(!isset($_POST['roletype'])){
			ErrorSend('not roletype');
			exit();
		}
		
		$curRole = $_POST['roletype'];
		
		$selectMsg = $_POST['msg'];
		if($selectMsg=='' || $selectMsg == null)
		{
			getUserList_hander(0,$curRole);
			exit();
		}
		
		$backresult = array();
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		if($curRole == 0){
			$result = $DB->query("select * from xl_userinfo where userid = ?",array($selectMsg));
		}
		else{
			$result = $DB->query("select * from xl_userinfo where userid = ? and role = ?",array($selectMsg,$curRole));
		}
		
		GetRoleArr($result,$DB);
		
		if($curRole == 0){
			$result = $DB->query("select * from xl_userinfo where username like '%".$selectMsg."%'");
		}
		else{
			$result = $DB->query("select * from xl_userinfo where username like '%".$selectMsg."%' and role = ?",array($curRole));
		}
		
		GetRoleArr($result,$DB);
		
		
		if($curRole == 0){
			$result = $DB->query("select * from xl_userinfo where phone like '%".$selectMsg."%'");
		}
		else{
			$result = $DB->query("select * from xl_userinfo where phone like '%".$selectMsg."%' and role = ?",array($curRole));
		}
		GetRoleArr($result,$DB);
		
		
		$DB->Closeconnection();
		ErrorSend('not find'.$_POST['msg']);
		exit();
	}
	
	function offlinelist(){
		if(!IsAuthority())
			return;
		
		if(!isset($_POST['userid'])){
			ErrorSend('not userid');
			exit();
		}
		
		if(!isset($_POST['page'])){
			ErrorSend('not page');
			exit();
		}
		
		$pages = $_POST['page'];
		$endPage = 10;
		$startPage = $pages*$endPage;
		
		$userid = $_POST['userid'];
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$result = $DB->query("select xl_clientslist.*,username,phone,role,accounts,sex,userid from xl_clientslist,xl_userinfo where belongto = ? and clientid = userid limit ?,?",array($userid,$startPage,$endPage));
		$Countresult = $DB->query("select count(listid) from xl_clientslist where belongto = ?",array($userid));
		
		$backresult['error']='ok';
		$backresult['arr'] = $result;
		$backresult['pageMax'] = $Countresult[0]['count(listid)'];
		$json_objback = json_encode($backresult);
		echo $json_objback;
		$DB->Closeconnection();
	}
	
	function login(){
		if(!isset($_POST['uname'])){
			ErrorSend('not uname');
			exit();
		}
		
		if(!isset($_POST['pwd'])){
			ErrorSend('not pwd');
			exit();
		}
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$result = $DB->query("select * from adminUser where username = ? and userpwd = ?",array($_POST['uname'],$_POST['pwd']));
		if(count($result)>0){
			
			$UseKey = time().rand(100,10000).$result[0]['id'];
			$backresult = array();
			$backresult['error']='ok';
			$backresult['key'] = $UseKey;
			echo json_encode($backresult);
			$DB->Closeconnection();
			
			$redis_ocean = new Redis();
		    $redis_ocean->connect(RedISHost, RedISPORT);			
			$redis_ocean->setex($UseKey, 60*60*2, $UseKey);
			
			exit();
		}
		
		ErrorSend('-101');
	}
	
	//通过角色获得数据
	function GetRoleArr($result,$DB){
		if(count($result)>0){
			$backresult['error']='ok';
			$backresult['arr'] = $result;
			$backresult['pageMax'] = count($result);
			$json_objback = json_encode($backresult);
			echo $json_objback;
			$DB->Closeconnection();
			exit();
		}
	}
	
	function GetUserRole($role){
		switch($role){
			case User:
				return '客户';
			break;
			case Boss:
				return '商户';
			break;
			case SAlESMAN:
				return '业务员';
			break;
			case HelpSAlESMAN:
				return '美导';
			break;
			case Agent:
				return '代理商';
			break;
		}
		return '';
	}
	
	function transferUser(){
		
		if(!IsAuthority())
			return;
		
		if(!isset($_POST['uid'])){
			ErrorSend('not uid');
			exit();
		}
		
		if(!isset($_POST['tuid'])){
			ErrorSend('not tuid');
			exit();
		}
		
		//用户编号
		$uid = $_POST['uid'];
		//转移给用户编号
		$tuid = $_POST['tuid'];
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$uresult = $DB->query("select role,issystem from xl_userinfo where userid=?",array($uid));
		$turesult = $DB->query("select role,issystem from xl_userinfo where userid=?",array($tuid));
		
		$urole = $uresult[0]['role'];
		$turole = $turesult[0]['role'];
		
		$tuissystem = $turesult[0]['issystem'];
		
		
		
		if($urole<=1 || $turole<=1){
			//用户直接不可以转换
			ErrorSend('-100');
			return;
		}
		
		if($urole != $turole){
			//用户类型不对称
			ErrorSend('-101');
			return;
		}
		
		if($tuissystem != 1){
			//转移方不是系统用户
			ErrorSend('-102');
			return;
		}
		

		
		$unum = $DB->query("update xl_clientslist set belongto = ? where belongto = ?",array($tuid,$uid));
		ErrorSend('ok');

//		if($unum > 0){
//			ErrorSend('ok');
//			return;
//		}
//		else{
//			//转移失败
//			ErrorSend('-103');
//			return;
//		}
	}
	
	
?>