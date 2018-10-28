<?php
	header('Access-Control-Allow-Origin:*');
	require("../tool/config.php");
	require("../tool/PDO.class.php");
	require("../tool/util.php");
	
	
	if(isset($_POST['fuc'])){
		
		CheckToken();
		
		if($_POST['fuc'] == "buylist"){
			// 套餐购买记录
			//拆
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
			return;
		}
		
		if(!isset($_POST['goodstype'])){
			ErrorSend('goodstype fail');
			return;
		}
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = [];
		$str = "";
		if(!isset($_POST['page'])){
			ErrorSend('page fail');
			return;
		}
				
		$page = $_POST['page'];	
		$goodstype = $_POST['goodstype'];
		$userid = $_POST['user'];
		
		$startPage = $page*10;
		$endPage = 10;
		
		$selectSql = '';
		if($goodstype == 1){
			$selectSql = "SELECT xl_buylist.*,icon,message,xl_goods.price,xl_goods.id FROM xl_buylist,xl_goods 
			where xl_buylist.userid = ? and xl_buylist.goodsid = xl_goods.id and xl_goods.type<20 
			and xl_goods.type<>2 and paystate = 1 order by buydate desc limit ?,?";
		}
		else{
			$selectSql = "SELECT xl_buylist.*,icon,message,xl_goods.price,xl_goods.id FROM xl_buylist,xl_goods 
			where xl_buylist.userid = ? and xl_buylist.goodsid = xl_goods.id and xl_goods.type=$goodstype 
			and paystate = 1 order by buydate desc limit ?,?";
		}
		
		$result = $db->query($selectSql,array($userid,$startPage,$endPage));
		
		
		if(count($result)>0){
			$giveidArr = array();
			foreach ($result as $key => $value) {
				if($value['giveuid']>0){
					array_push($giveidArr,$value['giveuid']);
				}
				$result[$key]['username'] = "";
				$result[$key]['phone'] ="";
				
				$buydate = $value['buydate'];
				$daydate= floor((time()-$buydate)/86400);
				
				$result[$key]['iscanreturn'] = true;
				if($daydate>7){
					$result[$key]['iscanreturn'] = false;
				}
			}
			
			$giveidArrNum = count($giveidArr);
			
			if($giveidArrNum>0){
				$giveidArrNumStr = implode(',', $giveidArr);
				$giveidArrNumStr = '('.$giveidArrNumStr.')';
				$userResult = $db->query("select username,phone,userid from xl_userinfo where userid in ".$giveidArrNumStr);
				
				$giveidArr = array();
				foreach ($userResult as $key => $value) {
					$giveidArr[$value['userid']] = array('username'=>$value['username'],'phone'=>$value['phone']);						
				}
				
				foreach ($result as $key => $value) {
					$giveuid = $value['giveuid'];
					
					
					if(isset($giveidArr[$giveuid])){
						$result[$key]['username'] = $giveidArr[$giveuid]['username'];
						$result[$key]['phone'] = $giveidArr[$giveuid]['phone'];
					}
				}
			}
		}
		
		$str = json_encode($result);
		$db->Closeconnection();
		echo $str;
	}
	
	function usecoupon_handle(){
		if(!isset($_POST['cuid'])){
			ReturnMsg('-1','优惠券信息错误');
		}
		if(!isset($_POST['userid'])){
			ReturnMsg('-1','用户信息错误');
		}
		if(!isset($_POST['bossuserid'])){
			ReturnMsg('-1','商户户信息错误');
		}
		if(!isset($_POST['buyid'])){
			ReturnMsg('-1','订单信息错误');
		}
		
		
		$uuid = $_POST['cuid'];
		$userid = $_POST['userid'];
		$BossUserid = $_POST['bossuserid'];
		$buyid = $_POST['buyid'];
		$beautiesid = 0;
		
		if(isset($_POST['beautiesid'])){
			$beautiesid = $_POST['beautiesid'];
		}
		
		if(!is_numeric($uuid)){
			ReturnMsg('-1','优惠券信息错误.');
		}
		if(!is_numeric($userid)){
			ReturnMsg('-1','用户信息错误.');
		}
		if(!is_numeric($BossUserid)){
			ReturnMsg('-1','商户信息错误.');
		}
		if(!is_numeric($beautiesid)){
			ReturnMsg('-1','美体师信息错误.');
		}
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT * from xl_couponlist where cpid = ?",array($uuid));
		if(count($result)<=0){
			$db->Closeconnection();
			ReturnMsg('201','优惠券不存在');
		}
		
		
		$goodsid = $result[0]['goodsid'];
		$goodsRes = $db->query("select gname,commissionboss,commissionsalesman,price,type,commagent,giveIntegral,agentid from xl_goods where id = ?",array($goodsid));
		if(count($goodsRes)<=0){
			//商品不存在
			$db->Closeconnection();
			ReturnMsg('207','商品不存在');
		}
		
		$starttm = intval($result[0]['datefrom']);
		$endtm = intval($result[0]['dateto']);
		$curtime = time();
		if($curtime<$starttm || $curtime>$endtm){
			$db->Closeconnection();
			ReturnMsg('206','优惠券超过使用期.');
		}
		
		$roleresult = $db->query("SELECT role from xl_userinfo where userid = ? ",array($BossUserid));
		if(count($roleresult)<=0 || $roleresult[0]['role'] != Boss){
			$db->Closeconnection();
			ReturnMsg('203','商户信息不存在');
		}
		
		$userroleresult = $db->query("SELECT role from xl_userinfo where userid = ? ",array($userid));
		if(count($userroleresult)<=0 || !isCanUse($userroleresult[0]['role'])){
			//角色不存在
			$db->Closeconnection();
			ReturnMsg('208','用户信息不存在');
		}
		
		
		$data = $result[0];		
		$cpuuid = $result[0]['cpuuid'];
		
		$couponresult = $db->query("select * from xl_coupon where id = ?",array($cpuuid));	
		if(count($couponresult)<=0){
			$db->Closeconnection();
			ReturnMsg('204','没有找到对应优惠券.');
		}
		
		$buyresult = $db->query("select * from xl_buylist where buyid = ?",array($buyid));
		//交易订单不存在
		if(count($buyresult)<=0){
			$db->Closeconnection();
			ReturnMsg('300','订单信息不存在.');
		}
		
		//订单状态不对
		if($buyresult[0]['orderstate']>=EndUse){
			$db->Closeconnection();
			ReturnMsg('301','订单已经过期.');
		}
		
		//订单未支付
		if($buyresult[0]['paystate']==0){
			ReturnMsg('-1','订单未支付');
		}
		
		//转赠状态不能使用
		if($buyresult[0]['givestate']==Give){
			$db->Closeconnection();
			ReturnMsg('302','已转赠商品不能使用');
		}
		
		//订单userid和交易订单userid不同
		$buyUserid = $buyresult[0]['userid'];
		if($buyUserid != $userid){
			$db->Closeconnection();
			ReturnMsg('300','订单信息错误');
		}
		
		//不同的券做不同的操作
		$ctype = $couponresult[0]['type'];
		
		$client = $db->query("select * from xl_clientslist where belongto = ? and clientid = ?",array($BossUserid,$userid));		
		if(count($client)<=0){
			$db->Closeconnection();
			ReturnMsg('-1','您没有和这个商家绑定关系!');
		}
		
		if($beautiesid>0){		
			$bclient = $db->query("select * from xl_store_beauties where bossid = ? and beautiesid = ?",[$BossUserid,$beautiesid]);
			if(count($bclient)<=0){
				$db->Closeconnection();
				ReturnMsg('-1','美体师还没有和当前商家绑定关系!');
			}
		}
		
		$row1 = $db->query("insert into xl_consumelist(coupon,cptype,username,consumedate,notes,userid,goodsid,buyid,bossid) values (?,?,?,?,?,?,?,?,?)",array($data['cpuuid'],$data['cptype'],$data['belongto'],time(),'',$userid,$goodsid,$buyid,$BossUserid));		
		if($row1>0){
			$row2 = $db->query("delete from xl_couponlist where cpid = ?",array($uuid));
			
			
			
			//查看红包
			$redpacket = $couponresult[0]['redpacket'];
			if($ctype == '1'){
				$db->query("update xl_buylist set giftnum = giftnum-1,orderstate = 1 where buyid = ?",array($buyid));
			}
			else if($ctype == '2'){
				$db->query("update xl_buylist set expnum = expnum-1,orderstate = 1 where buyid = ?",array($buyid));
			}
			
			//更改订单状态
			$couponlistResult = $db->query("select cpid from xl_couponlist where buyid = ?",array($buyid));
			if(count($couponlistResult)<=0){
				$db->query("update xl_buylist set orderstate = 2 where buyid = ?",array($buyid));
			}
			
			//发送红包
			if($redpacket>0 && $beautiesid>0){
				$beautiesinfo = $db->query("select * from xl_userinfo where userid = $beautiesid");
				
				if(count($beautiesinfo)>0){
					$db->query("update xl_userinfo set accounts = accounts + $redpacket where userid = $beautiesid");
					
					$db->query("insert into xl_goodsuse(bossid,userid,goodsid,usetime,buyid,gname,orderid)values(?,?,?,?,?,?,?)",
					[$BossUserid,$beautiesid,$goodsid,time(),$buyid,$goodsRes[0]['gname'],$buyresult[0]['orderid']]);
					
					$lastuseid = $db->lastInsertId();
					
					$db->query("insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
						values(?,?,?,?,?,?)",[UseRedPack,$lastuseid,$beautiesid,$redpacket,time(),Beauties]);
				}
			}
			
			$redis_ocean = new Redis();
		    $redis_ocean->connect(RedISHost, RedISPORT);			
			$resUseKey = 'use:userid:'.$userid.':'.$uuid;		
			$redis_ocean->setex($resUseKey, 30, 'ttl come');	
			
			$db->Closeconnection();		
			ReturnMsg('ok','使用成功!');
		}

		ReturnMsg('210','订单信息错误!');
	}
	
	function clientlist_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			return;
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);//
		$result = $db->query("SELECT clientid,username,phone,headimgurl,conndate FROM xl_clientslist,xl_userinfo WHERE belongto = ? and xl_userinfo.userid = xl_clientslist.clientid and xl_userinfo.userid <> ? ORDER BY conndate DESC",array($_POST['user'],$_POST['user']));//user 参数
		$str = json_encode($result);
		$db->Closeconnection();
		echo $str;
	}
	
	function moneynotes_handle(){
		if(!isset($_POST['user'])){
			echo json_encode(array());
			return;
		}
		
		if(!isset($_POST['page'])){
			echo json_encode(array());
			return;
		}
		
		$page = $_POST['page'];
		$userid = $_POST['user'];
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT role from xl_userinfo where userid = ?",array($userid));
		if(count($result)<=0){
			$db->Closeconnection();
			echo json_encode(array());
			return;
		}
		
		$startPage = $page*10;
		$endPage = 10;
		
		$useGroup = $db->query("select * from xl_goodsusemsg where userid = ? and usetype<>1 order by opdate desc LIMIT ?,?",array($userid,$startPage,$endPage));
		if(count($useGroup)<=0){
			$db->Closeconnection();
			echo json_encode(array());
			return;
		}
		
		//use 存储编号
		$useGroupArr = array();
		$useGroupNum = count($useGroup);
		for($i=0;$i<$useGroupNum;$i++){
			if($useGroup[$i]["usetype"] == UseTypeWithdraw)
				continue;
			array_push($useGroupArr,$useGroup[$i]["useid"]);
		}
		
		$useAddArr = array();
		if(count($useGroupArr)>0){
			
			$useGroupStr = implode(',',$useGroupArr);	
			
			$useGroupStr = "(".$useGroupStr.")";		
			
			$useArr = $db->query("select * from xl_goodsuse where ids in $useGroupStr");
			
			if(count($useArr)<=0){
				$db->Closeconnection();
				echo json_encode(array());
				return;
			}
			
			//用户编号存储数组
			$uarr = array();
			$ulens  = count($useArr);
			for($i=0;$i<$ulens;$i++){
				
				$bossid = $useArr[$i]["bossid"];
				$userid = $useArr[$i]["userid"];
				
				if(!in_array($bossid,$uarr)){
					array_push($uarr,$bossid);
				}
				
				if(!in_array($userid,$uarr)){
					array_push($uarr,$userid);
				}			
			}
			
			$userstr = implode(",",$uarr);
			$userstr = "(".$userstr.")";
			$userarr = $db->query("select userid,username from xl_userinfo where userid in $userstr");
			
			//存储用户名字
			$userNameCount = count($userarr);
			$userNameArr = array();
			for($i=0;$i<$userNameCount;$i++){
				$userNameArr[$userarr[$i]['userid']] = $userarr[$i]['username'];
			}
			
			for($i=0;$i<$ulens;$i++){				
				$bossid = $useArr[$i]["bossid"];
				$userid = $useArr[$i]["userid"];
				$useid = $useArr[$i]["ids"];			
				$useAddArr[$useid] = array("bossname"=>$userNameArr[$bossid],"username"=>$userNameArr[$userid]);
			}
		}
		
		for($i=0;$i<$useGroupNum;$i++){			
			$useGroup[$i]["bossname"] = "";
			$useGroup[$i]["username"] = "";			
			$useids = $useGroup[$i]["useid"];
			
			if(isset($useAddArr[$useids])){
				$useGroup[$i]["bossname"] = $useAddArr[$useids]['bossname'];
				$useGroup[$i]["username"] = $useAddArr[$useids]['username'];				
			}			
		}
		
		echo json_encode($useGroup);
		$db->Closeconnection();
	}
	
	function withdraw_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			return;
		}
		else{
			if(!is_numeric($_POST['user'])){
				ErrorSend('user not a number');
				return;
			}
		}
		if(!isset($_POST['money'])){
			ErrorSend('money fail');
			return;
		}
		else{
			if(!is_numeric($_POST['money'])){
				echo json_encode(array("status" => "105"));
				return;
			}
			else{
				if(floatval($_POST['money']) < 100){
					echo json_encode(array("status" => "105","msg"=>100));
					return;
				}
			}
		}
		if(!isset($_POST['pwd'])){
			ErrorSend('pwd fail');
			return;
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
//				$row = $db->query("insert into xl_inoutcomelist(usera,sum,opdate) values (?,?,?)",array($data['user'],$moneyval,$time));
				$row = $db->query("insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate)values(?,?,?,?,?)",array(UseTypeWithdraw,0,$data['user'],$moneyval,time()));
					
				$status = '200';
			}
		}		
		$db->Closeconnection();
		echo json_encode(array("status" => $status));
	}
	
	function deposit_handle(){
		
	}
	
	function editinfo_handle(){

		
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			exit();
		}
		
		$sqlstr = "update xl_userinfo set ";		
		if(isset($_POST['username'])){
			$sqlstr .= "username='".$_POST['username']."',";
		}
		
		if(isset($_POST['phone'])){
			$sqlstr .= ' phone='.$_POST['phone'].',';
		}
		
		if(isset($_POST['extrapwd'])){
			$sqlstr .= ' extrapwd='.$_POST['extrapwd'].',';
		}
		
		$len = strlen($sqlstr);
		if($len<=1){
			ErrorSend('param fail');
			exit();
		}
		
		$sqlstr = substr($sqlstr,0,$len-1);
		
		$sqlstr .= " where userid = ".$_POST['user'];	

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
			return;
		}
		if(!isset($_POST['bankname'])){
			ErrorSend('bankname fail');
			return;
		}
		if(!isset($_POST['bankno'])){
			ErrorSend('bankno fail');
			return;
		}
		if(!isset($_POST['accountname'])){
			ErrorSend('accountname fail');
			return;
		}
		if(!isset($_POST['bankcode'])){
			ErrorSend('bankcode fail');
			return;
		}
		if(!isset($_POST['expwd'])){
			ErrorSend('expwd fail');
			return;
		}
		
		
		
		if(strlen($_POST['expwd'])>10){
			ErrorSend('expwd tolong');
			return;
		}
		
		$expwds = md5($_POST['expwd']);
		
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
		$row2 = $db->query("update xl_userinfo set extrapwd=? where userid=?",array($expwds,$_POST['user']));
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
			return;
		}
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("select * from xl_bankinfos where username=?",array($_POST['user']));
		$db->Closeconnection();
		if(count($result)>0){
			echo json_encode($result);
		}
		else{
			echo json_encode([]);
		}
	}
	
	function checkbank_handle(){
		if(!isset($_POST['user'])){
			ErrorSend('user fail');
			return;
		}
		if(!isset($_POST['pwd'])){
			ErrorSend('pwd fail');
			return;
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
			return;
		}
		
		$hand = $_POST['hand'];
		$redis_ocean = new Redis();
    	$redis_ocean->connect(RedISHost, RedISPORT);
		if($redis_ocean->exists($hand)){
			echo '200';
			$redis_ocean->delete($hand);
			return;
		}
		echo '201';
	}
	
	function deposit_canpay_handle(){
		if(!isset($_POST['clientid'])){
			ReturnMsg('-1','用户信息错误');
		}
		if(!isset($_POST['salesmanid'])){
			ReturnMsg('-1','业务信息错误');
		}
		if(!isset($_POST['dptype'])){
			ReturnMsg('-1','购买类型信息错误');
		}
		
		$dptype= $_POST['dptype'];
		if(!is_numeric($dptype)){
			ReturnMsg('-1','购买类型信息错误.');
		}
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$salesmanid = $_POST['salesmanid'];
		$clientid = $_POST['clientid'];
		
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($clientid));
		if($result[0]['role'] > Boss){			
			$DB->CloseConnection();
			ReturnMsg('105','用户信息错误.');
		}
		$userRole = $result[0]['role'];
		
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($salesmanid));
		if($result[0]['role'] != 3){
			$DB->CloseConnection();
			ReturnMsg('106','商户信息错误.');
		}
		
		
		$result = $DB->query("SELECT listid from xl_clientslist where clientid=? and belongto=?",array($_POST['clientid'],$_POST['salesmanid']));
		if(count($result)>0){
			$DB->CloseConnection();
			ReturnMsg('107','您已经和改业务员建立了关系.');
		}
		
		
		//如果是用户的时候和别人绑定了关系不可以继续
		$nresult = $DB->query("SELECT listid from xl_clientslist where clientid=? ",array($clientid));
		if(count($nresult)>0 && $userRole == User){
			$DB->CloseConnection();
			ReturnMsg('108','您已经和其他的商户建立了关系.');
		}
		
		//业务员上面没有代理商
		$agentlist = $DB->query("select * from xl_clientslist where clientid = ?",array($salesmanid));
		if(count($agentlist)<=0){
			$DB->CloseConnection();
			ReturnMsg('110','该业务员还没有绑定代理商.');
		}
		
		//获得代理商编号
		$agentid = $agentlist[0]['agentid'];
		//用户已经和这个代理商绑定了关系
		$aresult = $DB->query("select id from xl_agentuser where userid = ? and aid=?",array($clientid,$agentid));
		if(count($aresult)>0){
			$DB->CloseConnection();
			ReturnMsg('110','您已经和其他代理商建立了关系.');
		}
		
		$DB->CloseConnection();
		ReturnMsg('ok','');
	}
	
	function sets_price_handle(){
		if(!isset($_POST['dptype'])){
			ErrorSend('dptype');
			return;
		}
		else{
			$dptype= $_POST['dptype'];
			if(!is_numeric($dptype)){
				ErrorSend('dptype error');
				return;
			}
		}
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("SELECT dpsum from xl_deposit where dptype=?",array($_POST['dptype']));
		$DB->CloseConnection();
		echo $result[0]['dpsum'];
	}
?>