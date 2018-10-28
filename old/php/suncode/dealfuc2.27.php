<?php
	header('Access-Control-Allow-Origin:*');
	require("../tool/config.php");
	require("../tool/PDO.class.php");
	
	if(isset($_POST['fuc'])){
		if($_POST['fuc'] == "buylist"){
			// 套餐购买记录
			buylist_handle();
		}
		else if($_POST['fuc'] == "usecoupon"){
			// 使用礼品券 体验券
			usecoupon_handle();
		}
		else if($_POST['fuc'] == "clientlist"){
			// 获取客户列表
			clientlist_handle();
		}
		else if($_POST['fuc'] == "moneynotes"){
			// 获取收支明细
			moneynotes_handle();
		}
		else if($_POST['fuc'] == "withdraw"){
			// 提现操作
			withdraw_handle();
		}
		else if($_POST['fuc'] == "deposit"){
			// 押金操作
			deposit_handle();
		}
		else if($_POST['fuc'] == "editinfo"){
			// 修改用户信息
			editinfo_handle();
		}
		else if($_POST['fuc'] == "bank"){
			// 添加银行账户
			bank_handle();
		}
		else if($_POST['fuc'] == "checkbankpwd"){
			// 添加银行账户
			checkbank_handle();
		}
		else if($_POST['fuc'] == "banklist"){
			// 银行账户
			banklist_handle();
		}
		else if($_POST['fuc'] == "usecouponstate"){
			// 获得扫码使用状态
			couponstate_handle();
		}
		else if($_POST['fuc'] == "deposit_canpay"){
			// 获得扫码使用状态
			deposit_canpay_handle();
		}
		else if($_POST['fuc'] == "sets_price"){
			// 获得扫码使用状态
			sets_price_handle();
		}
		else{
			echo 'error';
		}
	}
	
	function buylist_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			exit();
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = [];
		$str = "";
		if(isset($_POST['extra_need'])){
			if($_POST['extra_need'] == '1'){
				$result = $db->query("SELECT buyid,serialnum,setsname,buydate,giftnum,expnum,icon,xl_goods.price,xl_goods.id FROM xl_buylist,xl_goods where xl_buylist.userid = ? and (giftnum <> 0 or expnum <> 0) and xl_buylist.goodsid = xl_goods.id",array($_POST['user']));//user参数
			}
			else if($_POST['extra_need'] == '2'){
				$result = $db->query("SELECT buyid,serialnum,setsname,buydate,giftnum,expnum,icon,xl_goods.price,xl_goods.id FROM xl_buylist,xl_goods where xl_buylist.userid = ? and xl_buylist.goodsid = xl_goods.id and xl_goods.type = 0",array($_POST['user']));//user参数
			}
			else{
				$result = $db->query("SELECT buyid,serialnum,setsname,buydate,giftnum,expnum,icon,xl_goods.price,xl_goods.id FROM xl_buylist,xl_goods where xl_buylist.userid = ? and xl_buylist.goodsid = xl_goods.id",array($_POST['user']));//user参数
			}
		}
		else{
			$result = $db->query("SELECT buyid,serialnum,setsname,buydate,giftnum,expnum,icon,xl_goods.price,xl_goods.id FROM xl_buylist,xl_goods where xl_buylist.userid = ? and xl_buylist.goodsid = xl_goods.id",array($_POST['user']));//user参数
		}
		$str = json_encode($result);
		$db->Closeconnection();
		echo $str;
	}
	
	function usecoupon_handle(){
		if(!isset($_POST['cuid'])){
			ErrorSend('cpid fail');
			exit();
		}
		if(!isset($_POST['userid'])){
			ErrorSend('userid fail');
			exit();
		}
		if(!isset($_POST['bossuserid'])){
			ErrorSend('selluserid fail');
			exit();
		}
		
		$uuid = $_POST['cuid'];
		$userid = $_POST['userid'];
		$BossUserid = $_POST['bossuserid'];
		if(!is_numeric($uuid)){
			ErrorSend('uuid is number');
			exit();
		}
		if(!is_numeric($userid)){
			ErrorSend('userid is number');
			exit();
		}
		if(!is_numeric($BossUserid)){
			ErrorSend('userid is number');
			exit();
		}
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT * from xl_couponlist where cpid = ?",array($uuid));
		if(count($result)<=0){
			$db->Closeconnection();
			echo '201';
			exit();
		}
		
		$starttm = intval($result[0]['datefrom']);
		$endtm = intval($result[0]['dateto']);
		$curtime = time();
		if($curtime<$starttm || $curtime>$endtm){
			$db->Closeconnection();
			echo '206';
			exit();
		}
		
		$roleresult = $db->query("SELECT role from xl_userinfo where userid = ? ",array($BossUserid));
		if(count($roleresult)<=0){
			$db->Closeconnection();
			echo '203';
			exit();
		}
		if($roleresult[0]['role'] != Boss){
			$db->Closeconnection();
			echo '202';
			exit();
		}
		//查看他是否和其他人绑定了关系
		$clientHave = $db->query("select * from xl_clientslist where clientid = ?",array($userid));
		if(count($clientHave)>0 && $clientHave[0]['belongto']!=$BossUserid){
			echo '205';
			exit();
		}
		
		
		$data = $result[0];
		$goodsid = $result[0]['goodsid'];
		$cpuuid = $result[0]['cpuuid'];
		$row1 = $db->query("insert into xl_consumelist(coupon,cptype,username,consumedate,notes,userid,goodsid) values (?,?,?,?,?,?,?)",array($data['cpuuid'],$data['cptype'],$data['belongto'],time(),'',$userid,$goodsid));
		
		if($row1>0){
			$row2 = $db->query("delete from xl_couponlist where cpid = ?",array($uuid));
		
		
			//修改券的数量
			$couponresult = $db->query("select * from xl_coupon where id = ?",array($cpuuid));	
			if(count($couponresult)<=0){
				$db->Closeconnection();
				echo '204';
				exit();
			}
			
			//不同的券做不同的操作
			$ctype = $couponresult[0]['type'];
			if($ctype == '1'){
				$db->query("update xl_buylist set giftnum = giftnum-1 where userid = ? and goodsid = ?",array($userid,$goodsid));
			}
			else if($ctype == '2'){
				$db->query("update xl_buylist set expnum = expnum-1 where userid = ? and goodsid = ?",array($userid,$goodsid));
			}
			
			
			$client = $db->query("select * from xl_clientslist where belongto = ? and clientid = ?",array($BossUserid,$userid));
			if(count($client)<=0){
				//说明没有确定关系
				$db->query("insert into xl_clientslist(clientid,belongto,conndate)values(?,?,?)",array($userid,$BossUserid,time()));
			}
			
			
			$userinoutResult = $db->query("select * from xl_inoutcomelist where usera = ? and userb = ? and goodsid = ?",array($BossUserid,$userid,$goodsid));
			$goodsRes = $db->query("select commissionboss,commissionsalesman,price,type from xl_goods where id = ?",array($goodsid));
			if(count($userinoutResult)<=0 && count($goodsRes)>0){	
			//if(count($goodsRes)>0){
				//修改分成关系				
				if(count($goodsRes)>0){
					$price = $goodsRes[0]['price'];
					$bossMoney = floatval($goodsRes[0]['commissionboss'] * $price);
					$sellMoney = floatval($goodsRes[0]['commissionsalesman'] * $price);
					
					//给她上面的业务员
					$SellerRes = $db->query("select * from xl_clientslist where clientid = ?",array($BossUserid));
					if(count($SellerRes)>0){
						$sellUid = $SellerRes[0]['belongto'];
						//添加收支明细
						$db->query("insert into xl_inoutcomelist(usera,userb,userc,sum,opdate,notes,goodsid)values(?,?,?,?,?,?,?)",array($sellUid,$BossUserid,$userid,$sellMoney,time(),'',$goodsid));
						$db->query("update xl_userinfo set accounts = accounts + ? where userid = ?",array($sellMoney,$sellUid));
					}
					
					//老板娘自己的
					$db->query("insert into xl_inoutcomelist(usera,userb,userc,sum,opdate,notes,goodsid)values(?,?,?,?,?,?,?)",array($BossUserid,$userid,0,$bossMoney,time(),'',$goodsid));
					$db->query("update xl_userinfo set accounts = accounts + ? where userid = ?",array($bossMoney,$BossUserid));
				}
			}
			
			
			$db->Closeconnection();
			echo '200';
			
			$redis_ocean = new Redis();
		    $redis_ocean->connect(RedISHost, RedISPORT);			
			$resUseKey = 'use:userid:'.$userid.':'.$uuid;		
			$redis_ocean->setex($resUseKey, 30, 'ttl come');
			
			exit();
		}
		echo '210';
	}
	
	function clientlist_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			exit();
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);//
		$result = $db->query("SELECT clientid,username,phone,headimgurl,conndate FROM xl_clientslist,xl_userinfo WHERE belongto = ? and xl_userinfo.userid = xl_clientslist.clientid and xl_userinfo.userid <> ? ORDER BY conndate DESC",array($_POST['user'],$_POST['user']));//user 参数
		$str = json_encode($result);
		$db->Closeconnection();
		echo $str;
	}
	
	function moneynotes_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			exit();
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT role from xl_userinfo where userid = ?",array($_POST['user']));
		if(count($result)<=0){
			$db->Closeconnection();
			echo json_encode(array());
			return;
		}
		if($result[0]['role']==2){
			$result = $db->query("SELECT usera,userb,sum,opdate FROM xl_inoutcomelist where usera = ? ORDER BY opdate DESC",array($_POST['user']));
			$new_data = array();
			for ($i= 0;$i< count($result); $i++){
				$res_dataArr = $result[$i];
				$name_a = $db->query("SELECT username FROM xl_userinfo where userid = ?",array($res_dataArr["usera"]));
				$res_dataArr["name_a"] = $name_a[0]['username'];
				
				$name_b = $db->query("SELECT username FROM xl_userinfo where userid = ?",array($res_dataArr["userb"]));
				if(count($name_b)>0){
					$res_dataArr["name_b"] = $name_b[0]['username'];
				}
				array_push($new_data,$res_dataArr);
			}			
			$db->Closeconnection();
			echo json_encode($new_data);
		}
		else if($result[0]['role']==3){
			$result = $db->query("SELECT usera,userb,userc,sum,opdate FROM xl_inoutcomelist where usera = ? ORDER BY opdate DESC",array($_POST['user']));
			$new_data = array();
			for ($i= 0;$i< count($result); $i++){
				$res_dataArr = $result[$i];
				$name_a = $db->query("SELECT username FROM xl_userinfo where userid = ?",array($res_dataArr["usera"]));
				$res_dataArr["name_a"] = $name_a[0]['username'];
				$name_b = $db->query("SELECT username FROM xl_userinfo where userid = ?",array($res_dataArr["userb"]));
				if(count($name_b)>0){
					$res_dataArr["name_b"] = $name_b[0]['username'];
				}
				$name_c = $db->query("SELECT username FROM xl_userinfo where userid = ?",array($res_dataArr["userc"]));
				if(count($name_c)>0){
					$res_dataArr["name_c"] = $name_c[0]['username'];
				}
				array_push($new_data,$res_dataArr);
			}			
			$db->Closeconnection();
			echo json_encode($new_data);
		}
		else{
			$db->Closeconnection();
			echo json_encode(array());
		}
	}
	
	function withdraw_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			exit();
		}
		else{
			if(!is_numeric($_POST['user'])){
				ErrorSend('user not a number');
				exit();
			}
		}
		if(!isset($_POST['money'])){
			ErrorSend('money fail');
			exit();
		}
		else{
			if(!is_numeric($_POST['money'])){
				echo json_encode(array("status" => "105"));
				exit();
			}
			else{
				if(floatval($_POST['money']) <= 0){
					echo json_encode(array("status" => "105"));
					exit();
				}
			}
		}
		if(!isset($_POST['pwd'])){
			ErrorSend('pwd fail');
			exit();
		}
		$data = $_POST;// pwd:提现密码   money:金额  user:申请人
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT phone FROM xl_userinfo where userid = ?",array($data['user']));
		if($result==null||count($result)<=0){
			echo json_encode(array("status" => "106"));
			$db->Closeconnection();
			return;
		}
		else{
			if($result[0]["phone"]==""||$result[0]["phone"]=="NULL"||$result[0]["phone"]=="null"||$result[0]["phone"]==NULL||$result[0]["phone"]==null){
				echo json_encode(array("status" => "107"));
				$db->Closeconnection();
				return;
			}
		}
		$result = $db->query("SELECT bankid FROM xl_bankinfos where username = ?",array($data['user']));
		if(count($result)<=0){
			echo json_encode(array("status" => "108"));
			$db->Closeconnection();
			return;
		}
		$result = $db->query("SELECT accounts,extrapwd FROM xl_userinfo where userid = ?",array($data['user']));//user 参数
		$status = '209';
		if($data['pwd']!=$result[0]['extrapwd']){
			$status = '208';
		}
		else{
			if($result[0]['accounts'] < floatval($data['money'])){
				$status = '110';
			}
			else{
				$time = time();
				$sum = $result[0]['accounts']-floatval($data['money']);
				$row = $db->query("insert into xl_withdrawlist(username,drawdate,sum) values(?,?,?)",array($data['user'],$time,$data['money']));
				$row = $db->query("update xl_userinfo set accounts=? where userid=?",array($sum,$data['user']));
				$moneyval = (-1)*floatval($data['money']);
				$row = $db->query("insert into xl_inoutcomelist(usera,sum,opdate) values (?,?,?)",array($data['user'],$moneyval,$time));
				$status = '200';
			}
		}		
		$db->Closeconnection();
		echo json_encode(array("status" => $status));
	}
	
	function deposit_handle(){
		
	}
	
	function editinfo_handle(){
		$data = $_POST['data'];//chname phone extrapwd notes user
		$sqlstr = "update xl_userinfo ";
		foreach($data as $key => $value){
			if($key == "user"){
				continue;
			}
			$tmp = "set ";
			$tmp .= $key;
			$tmp .= "='";
			$tmp .= $value;
			$tmp .= "',";
			$sqlstr .= $tmp;
		}
		$len = strlen($sqlstr);
		$sqlstr = substr($sqlstr,0,$len-1);
		$sqlstr .= " where userid = ";
		$sqlstr .= $data["user"];
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$row = $db->query($sqlstr);
		if($row>0){
			$db->Closeconnection();
			echo json_encode(array('status'=>'200'));
			return;
		}
		$db->Closeconnection();
		echo json_encode(array('status'=>'210'));
	}
	
	function bank_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			exit();
		}
		if(!isset($_POST['bankname'])){
			ErrorSend('bankname fail');
			exit();
		}
		if(!isset($_POST['bankno'])){
			ErrorSend('bankno fail');
			exit();
		}
		if(!isset($_POST['accountname'])){
			ErrorSend('accountname fail');
			exit();
		}
		if(!isset($_POST['bankcode'])){
			ErrorSend('bankcode fail');
			exit();
		}
		if(!isset($_POST['expwd'])){
			ErrorSend('expwd fail');
			exit();
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("select bankid from xl_bankinfos where username=?",array($_POST['user']));
		$status = '109';
		if(count($result)>0){
			$row1 = $db->query("update xl_bankinfos set bankname=?,code=?,banknum=?,bankaccount=? where username=?",array($_POST['bankname'],$_POST['bankcode'],$_POST['bankno'],$_POST['accountname'],$_POST['user']));
			if($row1>0){
				$status = '200';
			}
			else{
				$status = '201';
			}
		}
		else{
			$row = $db->query("insert into xl_bankinfos(username,bankname,code,banknum,bankaccount) values(?,?,?,?,?)",array($_POST['user'],$_POST['bankname'],$_POST['bankcode'],$_POST['bankno'],$_POST['accountname']));
			if($row>0){
				$status = '200';
			}
			else{
				$status = '202';
			}
		}
		$status2 = '109';
		$row2 = $db->query("update xl_userinfo set extrapwd=? where userid=?",array($_POST['expwd'],$_POST['user']));
		if($row2>0){
			$status2 = '200';
		}
		else{
			$status2 = '203';
		}
		$db->Closeconnection();
		echo json_encode(array("stat1"=>$status,"stat2"=>$status2));
	}
	
	function banklist_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			exit();
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("select * from xl_bankinfos where username=?",array($_POST['user']));
		$db->Closeconnection();
		if(count($result)>0){
			echo json_encode($result);
		}
		else{
			echo '';
		}
	}
	
	function checkbank_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			exit();
		}
		if(!isset($_POST['pwd'])){
			ErrorSend('pwd fail');
			exit();
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("select extrapwd from xl_userinfo where userid=?",array($_POST['user']));
		$db->Closeconnection();
		if($result[0]['extrapwd'] == $_POST['pwd']){
			echo '200';
		}
		else{
			echo '101';
		}
	}
	
	//获得使用状态
	function couponstate_handle(){
		if(!isset($_POST['hand'])){
			ErrorSend('hand');
			exit();
		}
		
		$hand = $_POST['hand'];
		$redis_ocean = new Redis();
    	$redis_ocean->connect(RedISHost, RedISPORT);
		if($redis_ocean->exists($hand)){
			echo '200';
			$redis_ocean->delete($hand);
			exit();
		}
		echo '201';
	}
	
	function deposit_canpay_handle(){
		if(!isset($_POST['clientid'])){
			ErrorSend('clientid not');
			exit();
		}
		if(!isset($_POST['salesmanid'])){
			ErrorSend('salesmanid');
			exit();
		}
		if(!isset($_POST['dptype'])){
			ErrorSend('dptype');
			exit();
		}
		else{
			$dptype= $_POST['dptype'];
			if(!is_numeric($dptype)){
				ErrorSend('dptype error');
				exit();
			}
		}
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($_POST['clientid']));
		if($result[0]['role'] != 1){
			$DB->CloseConnection();
			echo '105';
			exit();
		}
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($_POST['salesmanid']));
		if($result[0]['role'] != 3){
			$DB->CloseConnection();
			echo '106';
			exit();
		}
		$result = $DB->query("SELECT listid from xl_clientslist where clientid=? and belongto=?",array($_POST['clientid'],$_POST['salesmanid']));
		if(count($result)>0){
			$DB->CloseConnection();
			echo '107';
			exit();
		}
		$DB->CloseConnection();
		echo '200';
	}
	
	function sets_price_handle(){
		if(!isset($_POST['dptype'])){
			ErrorSend('dptype');
			exit();
		}
		else{
			$dptype= $_POST['dptype'];
			if(!is_numeric($dptype)){
				ErrorSend('dptype error');
				exit();
			}
		}
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("SELECT dpsum from xl_deposit where dptype=?",array($_POST['dptype']));
		$DB->CloseConnection();
		echo $result[0]['dpsum'];
	}
?>