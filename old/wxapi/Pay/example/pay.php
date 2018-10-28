<?php
	ini_set('date.timezone','Asia/Shanghai');
	require_once "PayGetParam.php";
	require_once("../../../php/tool/PDO.class.php");
	require_once("../../../php/tool/config.php");
	require_once("../../../php/tool/util.php");

	if(isset($_POST['type'])){
		$otype = $_POST['type'];
		if($otype == 'GoodsPayParam'){
			GetPayReadyParam();
		}
		else if($otype == 'DepositPayParam'){
			DepositReadyParam();
		}
		else if($otype == 'isCanPay'){
			isCanPay();
		}
	}
	
	//是否能够购买
	function isCanPay(){		
		if(!isset($_POST['goodsid'])){
			ErrorSend('gid not');
			exit();
		}
		
		
		if(!isset($_POST['code'])){
			ErrorSend('code not');
			exit();
		}
		
		if(!isset($_POST['userid'])){
			ErrorSend('userid not');
			exit();
		}
		
		
		$userid = $_POST['userid'];
		$goodsid = $_POST['goodsid'];
		if(!is_numeric($goodsid)){
			ErrorSend('gid error');
			exit();
		}
		
		if(!is_numeric($userid)){
			ErrorSend('userid error');
			exit();
		}
		
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("SELECT * from xl_goods where id=?",array($goodsid));
		if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['id'] == 0){
			ErrorSend('not gid');
			exit();
		}
		
		$roleresult = $DB->query("SELECT * from xl_userinfo where userid=?",array($userid));
		if($roleresult == null || count($roleresult)<=0 || count($roleresult[0])<=0){
			ErrorSend('not user');
			exit();
		}
		
		$price = $result[0]['price']*100;
		$goodstype = $result[0]['buyType'];
		$role = $result[0]['role'];
		$phone = $roleresult[0]['phone'];
		
		if($phone == null || $phone == ''){
			ErrorSend('-100'); 
			exit();
		}
		
		if($role != User || $role != Boss){
			ErrorSend('-101'); 
			exit();
		}
		
		$result = $DB->query("SELECT * from xl_buylist where userid=? and goodsid = ?",array($userid,$goodsid));
		if(count($result)>0 && $goodstype == 1 && $role!=Boss){
			ErrorSend('-102');
			exit();
		}
		
		ErrorSend('ok');
	}
	
	//购买商品参数获取
	function GetPayReadyParam(){
		
		if(!isset($_POST['goodsid'])){
			ErrorSend('gid not');
			exit();
		}
		
		
		if(!isset($_POST['code'])){
			ErrorSend('code not');
			exit();
		}
		
		if(!isset($_POST['userid'])){
			ErrorSend('userid not');
			exit();
		}
		
		if(!isset($_POST['num'])){
			ErrorSend('num not');
			exit();
		}
		
		
		$userid = $_POST['userid'];
		$goodsid = $_POST['goodsid'];
		$num = $_POST['num'];
		
		if(!is_numeric($goodsid)){
			ErrorSend('gid error');
			exit();
		}
		
		if(!is_numeric($userid)){
			ErrorSend('userid error');
			exit();
		}
		
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("SELECT * from xl_goods where id=?",array($goodsid));
		if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['id'] == 0){
			ErrorSend('not gid');
			exit();
		}
		
		$roleresult = $DB->query("SELECT * from xl_userinfo where userid=?",array($userid));
		if($roleresult == null || count($roleresult)<=0 || count($roleresult[0])<=0){
			ErrorSend('not user');
			exit();
		}
		
		$price = $result[0]['price']*100 *$num;
		$goodstype = $result[0]['buyType'];
		$gname = $result[0]['gname'];
		$phone = $roleresult[0]['phone'];
		$role = $roleresult[0]['role'];
		
		if($phone == null || $phone == ''){
			ErrorSend('请先绑定电话号码'); 
			exit();
		}
		
		$result = $DB->query("SELECT * from xl_buylist where userid=? and goodsid = ?",array($userid,$goodsid));
		if(count($result)>0 && $goodstype == 1 && $role!=Boss){
			ErrorSend('商品只能够购买一次');
			exit();
		}
		
		
		$attach = 'GoodsPayParam'.';'.$userid.';'.$gname.';'.$price.';'.$goodsid.';'.$num;
		$codes = $_POST['code'];
		$tourl = ROOTURL.'wxapi/Pay/example/notifyGoods.php';
		
		$payArr = array('gname'=>$gname,
		'attach'=>$attach,
		'price'=>$price,
		'code'=>$codes,
		'tourl'=>$tourl);
		
		$getparam = new PayGetParam();		
		$getparam->PayParam($payArr);
		
		$DB->CloseConnection();
	}
	
	function DepositReadyParam(){
		if(!isset($_POST['clientid'])){
			ErrorSend('clientid not');
			exit();
		}
		if(!isset($_POST['salesmanid'])){
			ErrorSend('salesmanid');
			exit();
		}
		if(!isset($_POST['code'])){
			ErrorSend('code not');
			exit();
		}
		$dptype= $_POST['dptype'];
		if(!is_numeric($dptype)){
			ErrorSend('dptype error');
			exit();
		}
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($_POST['clientid']));
		if($result[0]['role'] != 1){
			$DB->CloseConnection();
			echo json_encode(array("status" => "105"));
			exit();
		}
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($_POST['salesmanid']));
		if($result[0]['role'] != 3){
			$DB->CloseConnection();
			echo json_encode(array("status" => "106"));
			exit();
		}
		$result = $DB->query("SELECT listid from xl_clientslist where clientid=? and belongto=?",array($_POST['clientid'],$_POST['salesmanid']));
		if(count($result)>0){
			$DB->CloseConnection();
			echo json_encode(array("status" => "107"));
		}
		
		$nresult = $DB->query("SELECT listid from xl_clientslist where clientid=? ",array($_POST['clientid']));
		if(count($nresult)>0){
			$DB->CloseConnection();
			echo json_encode(array("status" => "109"));
		}
		
		$result = $DB->query("SELECT * from xl_deposit where dptype=?",array($dptype));
		if($result == null || count($result)<=0){
			$DB->CloseConnection();
			echo json_encode(array("status" => "108"));
			exit();
		}
		$price = $result[0]['dpsum']*100;
		$dpname = $result[0]['dpname'];
		$clientid = $_POST['clientid'];
		$salesmanid = $_POST['salesmanid'];
		$attach = 'DepositPayParam'.';'.$clientid.';'.$salesmanid.';'.$dpname.';'.$price.';'.$dptype;
		$codes = $_POST['code'];
		$tourl = ROOTURL.'wxapi/Pay/example/notifyGoods.php';
		
		$payArr = array('gname'=>$dpname,
		'attach'=>$attach,
		'price'=>$price,
		'code'=>$codes,
		'tourl'=>$tourl);
		
		//echo json_encode($payArr);
		$DB->CloseConnection();
		
		$getparam = new PayGetParam();		
		$getparam->PayParam($payArr);
	}
?>