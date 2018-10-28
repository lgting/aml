<?php
header('Access-Control-Allow-Origin:*');
require ("../tool/config.php");
require ("../tool/util.php");
require_once('ImageHander.php');
require_once("include.php");
use Module\AdminPower;
use Module\DB;

if (isset($_POST['type'])) {
	$gettype = $_POST['type'];
	
	if(!IsAuthority()){
		exit();
	}
	
	switch($gettype) {
		case 'couponlist' :
			couponlist();
			break;
		case 'addcoupon' :
			addcoupon();
			break;
		case 'deletecoupon' :
			deletecoupon();
			break;
		case 'editcoupon':
			editcoupon();
			break;
		case 'bindcoupon':
			bindcoupon();
			break;
		case 'bindcouponlist':
			bindcouponlist();
			break;
		case 'selectcoupon':
			selectCouPon();
			break;
	}
}

//显示礼品券
function couponlist() {

	if (!isset($_POST['page'])) {
		ErrorSend('not page');
		exit();
	}

	$pages = $_POST['page'];
	if (!is_numeric($pages)) {
		ErrorSend(' page number ');
		exit();
	}

	if ($pages < 0) {
		ErrorSend(' page > 0 ');
		exit();
	}

	$endPage = 10;
	$startPage = $pages * $endPage;
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);

	$userresult = $DB -> query("select * from xl_coupon limit ?,?", array($startPage, $endPage));
	$CountResult = $DB -> query("select count(id) from xl_coupon");
	$pageMax = $CountResult[0]['count(id)'];

	$backresult['error'] = 'ok';
	$backresult['arr'] = $userresult;
	$backresult['pageMax'] = $pageMax;
	$json_objback = json_encode($backresult);
	echo $json_objback;
	$DB -> Closeconnection();

}

//添加优惠券
function addcoupon() {
	/*
	 * cname:this.form.cname,
	 msg:this.form.message,
	 ctype:this.form.type,
	 icon:this.form.base64Str,
	 type:'addcoupon',
	 starttime:this.form.showstarttime,
	 endtime:this.form.showendtime
	 * */
	$apower = new AdminPower();
	$isOk = $apower->isUserPowerToClient(__FUNCTION__,$_POST);
	if(!$isOk){
		return;
	}
	
	if (!isset($_POST['cname'])) {
		ErrorSend('not cname');
		exit();
	}

	if (!isset($_POST['msg'])) {
		ErrorSend('not msg');
		exit();
	}

	if (!isset($_POST['icon'])) {
		ErrorSend('not icon');
		exit();
	}

	if (!isset($_POST['starttime'])) {
		ErrorSend('not starttime');
		exit();
	}
	
	if(!isset($_POST['endtime'])){
		ErrorSend('not endtime');
		exit();
	}
	
	if(!isset($_POST['ctype'])){
		ErrorSend('not ctype');
		exit();
	}
	
	$cname = $_POST['cname'];
	$msg = $_POST['msg'];
	$icon = $_POST['icon'];
	$starttime = $_POST['starttime'];
	$endtime = $_POST['endtime'];
	$ctype = $_POST['ctype'];
	
	if($cname == null || $cname == ''){
		ErrorSend('用户名不能够为空.');
		exit();
	}
	
	if (!is_numeric($ctype)) {
		ErrorSend('ctype number');
		exit();
	}
	if (!is_numeric($starttime)) {
		ErrorSend('starttime number');
		exit();
	}
	if (!is_numeric($endtime)) {
		ErrorSend('endtime number');
		exit();
	}
	
	$iconurl = '';
	if($icon!='' && $icon!=null){
		//$imagePath = SaveImage($icon,"../../img/coupon/");	
		//$iconurl = 'img/coupon/'.$imagePath['1'];
		$iconurl = SaveImage($icon,CouponDBTop,CouponUrl)[2];
	}
	
	$starttime = $starttime*24*60*60;
	$endtime = $endtime*24*60*60;
	
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);

	$userresult = $DB -> query("insert into xl_coupon(cname,message,iconurl,type,starttime,endtime,addtime)values(?,?,?,?,?,?,?)", 
	array($cname, $msg,$iconurl,$ctype,$starttime,$endtime,time()));
	$DB -> Closeconnection();
	ErrorSend('ok');
}

function deletecoupon(){
	
	$apower = new AdminPower();
	$isOk = $apower->isUserPowerToClient(__FUNCTION__,$_POST);
	if(!$isOk){
		return;
	}
	
	if (!isset($_POST['cid'])) {
		ErrorSend('not cid');
		exit();
	}
	
	$cid = $_POST['cid'];
	
	if (!is_numeric($cid)) {
		ErrorSend('cid number');
		exit();
	}
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $DB -> query("select * from xl_coupontogoods where couponid = ?",array($cid));
	if(count($result)>0){
		ErrorSend('-101');
		$DB -> Closeconnection();
		exit();
	}
	
	$result = $DB -> query("delete from xl_coupon where id = ?",array($cid));
	ErrorSend('ok');
}

function editcoupon(){
	
	$apower = new AdminPower();
	$isOk = $apower->isUserPowerToClient(__FUNCTION__,$_POST);
	if(!$isOk){
		return;
	}
	
	if (!isset($_POST['cname'])) {
		ErrorSend('not cname');
		exit();
	}

	if (!isset($_POST['msg'])) {
		ErrorSend('not msg');
		exit();
	}

	if (!isset($_POST['icon'])) {
		ErrorSend('not icon');
		exit();
	}

	if (!isset($_POST['starttime'])) {
		ErrorSend('not starttime');
		exit();
	}
	
	if(!isset($_POST['endtime'])){
		ErrorSend('not endtime');
		exit();
	}
	
	if(!isset($_POST['ctype'])){
		ErrorSend('not ctype');
		exit();
	}
	
	if(!isset($_POST['cid'])){
		ErrorSend('not cid');
		exit();
	}
	
	$cname = $_POST['cname'];
	$msg = $_POST['msg'];
	$icon = $_POST['icon'];
	$starttime = $_POST['starttime'];
	$endtime = $_POST['endtime'];
	$ctype = $_POST['ctype'];
	$cid = $_POST['cid'];
	
	if($cname == null || $cname == ''){
		ErrorSend('用户名不能够为空.');
		exit();
	}
	
	if (!is_numeric($ctype)) {
		ErrorSend('ctype number');
		exit();
	}
	if (!is_numeric($starttime)) {
		ErrorSend('starttime number');
		exit();
	}
	if (!is_numeric($endtime)) {
		ErrorSend('endtime number');
		exit();
	}
	
	$iconurl = '';
	if($icon!='' && $icon!=null){
		
		$baseimgArr = explode(',',$icon);
		
		if(count($baseimgArr)>1){
			//$imagePath = SaveImage($icon,CouponDBTop,CouponUrl)[2];	
			//$iconurl = 'img/coupon/'.$imagePath['1'];
			$iconurl = SaveImage($icon,CouponDBTop,CouponUrl)[2];	
			//echo '$iconurl'.$iconurl;
		}
		else{
			$iconurl = $icon;
		}
		
		
	}
	
	$starttime = $starttime*24*60*60;
	$endtime = $endtime*24*60*60;
	
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);

	$userresult = $DB -> query("update xl_coupon set cname=?,message=?,iconurl=?,type=?,starttime=?,endtime=? where id=?", 
	array($cname, $msg,$iconurl,$ctype,$starttime,$endtime,$cid));
	$DB -> Closeconnection();
	ErrorSend('ok');
}

//绑定商品的列表
function bindcouponlist(){

	if (!isset($_POST['goodsid'])) {
		ErrorSend('not goodsid');
		exit();
	}

	$goodsid = $_POST['goodsid'];
	if (!is_numeric($goodsid)) {
		ErrorSend(' goodsid number ');
		exit();
	}

	if ($goodsid < 0) {
		ErrorSend(' goodsid > 0 ');
		exit();
	}


	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);	
	$userresult = $DB -> query("select * from xl_coupon,xl_coupontogoods where goodsid = ? and couponid = xl_coupon.id", array($goodsid));
	$backresult['error'] = 'ok';
	$backresult['arr'] = $userresult;
	$json_objback = json_encode($backresult);
	echo $json_objback;
	$DB -> Closeconnection();
}

//绑定优惠券
function bindcoupon(){
	
	$apower = new AdminPower();
	$isOk = $apower->isUserPowerToClient(__FUNCTION__,$_POST);
	if(!$isOk){
		return;
	}
	
	if (!isset($_POST['bindArr'])){
		ErrorSend('not bindArr');
		return;
	}
	
	if (!isset($_POST['goodsid'])){
		ErrorSend('not goodsid');
		return;
	}
	
	$goodsid = $_POST['goodsid'];
	if(!is_numeric($goodsid)){
		ErrorSend('goodsid is number');
		return;
	}
	
	$bindArr = explode(',',$_POST['bindArr']);
	$bindArrLen = count($bindArr);
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);	
	$allresult = $DB -> query("select * from xl_coupontogoods where goodsid=?",array($goodsid));
	$allnum = count($allresult);
	
	for($i=0;$i<$bindArrLen;$i++){
		$bindid = $bindArr[$i];
		$result = $DB -> query("select * from xl_coupontogoods where couponid =? and goodsid=?",array($bindid,$goodsid));
		if(count($result)>0){
			continue;
		}		
		$DB -> query("insert into xl_coupontogoods (goodsid,couponid,nums)values(?,?,?)",array($goodsid,$bindid,1));
	}
	
	for($i=0;$i<$allnum;$i++){		
		$couponid = intval($allresult[$i]['couponid']);	
		$bindid = 0;
		$isHave = false;
		$deleteid = intval($allresult[$i]['id']);	
		for($j=0;$j<$bindArrLen;$j++){
			$bindid = intval($bindArr[$j]);		
			if($bindid==$couponid){
				$isHave =  true;
				break;
			}
		}
		
		if(!$isHave){
			$DB -> query("delete from xl_coupontogoods where id=?",array($deleteid));
		}
	}
	
	ErrorSend('ok');
	$DB -> Closeconnection();
}

function selectCouPon(){
	if (!isset($_POST['cname'])){
		ErrorSend('not cname');
		exit();
	}
	
	$cname = $_POST['cname'];
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);	
	$allresult = $DB -> query("select * from xl_coupon where cname like ? limit 0,100",array("%".$cname."%"));
	
	$backresult['error'] = 'ok';
	$backresult['arr'] = $allresult;
	$backresult['pageMax'] = 1;
	$json_objback = json_encode($backresult);
	echo $json_objback;
	$DB -> Closeconnection();
		
}

?>