<?php
	header('Access-Control-Allow-Origin:*');
	require("../tool/config.php");
	require("../tool/PDO.class.php");
	require("../tool/util.php");
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
			$selectSql = "SELECT xl_buylist.*,icon,message,xl_goods.price,xl_goods.id FROM xl_buylist,xl_goods where xl_buylist.userid = ? and xl_buylist.goodsid = xl_goods.id and xl_goods.type<=1 order by buydate desc limit ?,?";
		}
		else{
			$selectSql = "SELECT xl_buylist.*,icon,message,xl_goods.price,xl_goods.id FROM xl_buylist,xl_goods where xl_buylist.userid = ? and xl_buylist.goodsid = xl_goods.id and xl_goods.type=$goodstype order by buydate desc limit ?,?";
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
			ErrorSend('cpid fail');
			return;
		}
		if(!isset($_POST['userid'])){
			ErrorSend('userid fail');
			return;
		}
		if(!isset($_POST['bossuserid'])){
			ErrorSend('selluserid fail');
			return;
		}
		if(!isset($_POST['buyid'])){
			ErrorSend('buyid fail');
			return;
		}
		
		$uuid = $_POST['cuid'];
		$userid = $_POST['userid'];
		$BossUserid = $_POST['bossuserid'];
		$buyid = $_POST['buyid'];
		if(!is_numeric($uuid)){
			ErrorSend('uuid is number');
			return;
		}
		if(!is_numeric($userid)){
			ErrorSend('userid is number');
			return;
		}
		if(!is_numeric($BossUserid)){
			ErrorSend('userid is number');
			return;
		}
		
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("SELECT * from xl_couponlist where cpid = ?",array($uuid));
		if(count($result)<=0){
			$db->Closeconnection();
			echo '201';
			return;
		}
		
		
		$goodsid = $result[0]['goodsid'];
		//echo 'gid='.$goodsid;
		$goodsRes = $db->query("select commissionboss,commissionsalesman,price,type,commagent,giveIntegral from xl_goods where id = ?",array($goodsid));
		if(count($goodsRes)<=0){
			//商品不存在
			$db->Closeconnection();
			echo '207';
			return;
		}
		
		$starttm = intval($result[0]['datefrom']);
		$endtm = intval($result[0]['dateto']);
		$curtime = time();
		if($curtime<$starttm || $curtime>$endtm){
			$db->Closeconnection();
			echo '206';
			return;
		}
		
		$roleresult = $db->query("SELECT role from xl_userinfo where userid = ? ",array($BossUserid));
		if(count($roleresult)<=0){
			$db->Closeconnection();
			echo '203';
			return;
		}
		if($roleresult[0]['role'] != Boss){
			$db->Closeconnection();
			echo '202';
			return;
		}
		
		$userroleresult = $db->query("SELECT role from xl_userinfo where userid = ? ",array($userid));
		if(count($userroleresult)<=0){
			//角色不存在
			$db->Closeconnection();
			echo '208';
			return;
		}
		if($userroleresult[0]['role'] != User){
			//角色错误
			$db->Closeconnection();
			echo '209';
			return;
		}
		//查看他是否和其他人绑定了关系
		$clientHave = $db->query("select * from xl_clientslist where clientid = ?",array($userid));
		if(count($clientHave)>0 && $clientHave[0]['belongto']!=$BossUserid){
			echo '205';
			return;
		}
		
		
		$data = $result[0];		
		$cpuuid = $result[0]['cpuuid'];
		
		$couponresult = $db->query("select * from xl_coupon where id = ?",array($cpuuid));	
		if(count($couponresult)<=0){
			$db->Closeconnection();
			echo '204';
			return;
		}
		
		$buyresult = $db->query("select * from xl_buylist where buyid = ?",array($buyid));
		//交易订单不存在
		if(count($buyresult)<=0){
			$db->Closeconnection();
			echo '300';
			return;
		}
		
		//订单状态不对
		if($buyresult[0]['orderstate']>=EndUse){
			$db->Closeconnection();
			echo '301';
			return;
		}
		
		//转赠状态不能使用
		if($buyresult[0]['givestate']==Give){
			$db->Closeconnection();
			echo '302';
			return;
		}
		
		//订单userid和交易订单userid不同
		$buyUserid = $buyresult[0]['userid'];
		if($buyUserid != $userid){
			$db->Closeconnection();
			echo '300';
			return;
		}
		
		$row1 = $db->query("insert into xl_consumelist(coupon,cptype,username,consumedate,notes,userid,goodsid,buyid,bossid) values (?,?,?,?,?,?,?,?,?)",array($data['cpuuid'],$data['cptype'],$data['belongto'],time(),'',$userid,$goodsid,$buyid,$BossUserid));		
		if($row1>0){
			$row2 = $db->query("delete from xl_couponlist where cpid = ?",array($uuid));
			
			//不同的券做不同的操作
			$ctype = $couponresult[0]['type'];
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
			
			$client = $db->query("select * from xl_clientslist where belongto = ? and clientid = ?",array($BossUserid,$userid));
			$agentlist = $db->query("select * from xl_clientslist where clientid = ?",array($BossUserid));			
			//代理商编号
			$agentid = 0;
			if(count($agentlist)>0){
				$agentid = $agentlist[0]['agentid'];
			}
			
			if(count($client)<=0){
				//说明没有确定关系
				$db->query("insert into xl_clientslist(clientid,belongto,conndate,agentid)values(?,?,?,?)",array($userid,$BossUserid,time(),$agentid));
				
				//存储代理商用户信息
				$agentuserlist = $db->query("select id from xl_agentuser where userid = ?",array($userid));
				if(count($agentuserlist)<=0){
					$db->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array($agentid,$userid,time()));
				}
			}
			
			
			//$userinoutResult = $db->query("select * from xl_inoutcomelist where usera = ? and userb = ? and goodsid = ?",array($BossUserid,$userid,$goodsid));
			//查看是否在这个商户这里使用过这个商品
			//$userinoutResult = $db->query("select * from xl_goodsuse where bossid = ? and userid = ? and goodsid = ?",array($BossUserid,$userid,$goodsid));		
			$userinoutResult = $db->query("select * from xl_goodsuse where bossid = ? and userid = ? and buyid = ?",array($BossUserid,$userid,$buyid));
			if(count($userinoutResult)<=0){		
				
				//业务员编号
				$sellUid = 0;
				//美导编号
				$helpSellId = 0;
				
				$salescommission = 0;
				$hsalescommission = 0;
				
				//上面的业务员和美导
				$SellerRes = $db->query("select belongto,clientid,role,username,salescommission
				 from xl_clientslist,xl_userinfo where userid = belongto and clientid =?",array($BossUserid));
				
				$sellerNum = count($SellerRes);
				
				if($sellerNum>0){
					
					for($i=0;$i<$sellerNum;$i++){
						if($SellerRes[$i]["role"] == SAlESMAN){
							$sellUid = $SellerRes[$i]["belongto"];
							$salescommission = $SellerRes[$i]["salescommission"];
						}
						else if($SellerRes[$i]["role"] == HelpSAlESMAN){
							$helpSellId = $SellerRes[$i]["belongto"];
							$hsalescommission = $SellerRes[$i]["salescommission"];
						}
					}				
				}
				
				$adduse = $db->query("insert into xl_goodsuse(bossid,userid,goodsid,usetime,buyid)values(?,?,?,?,?)",array($BossUserid,$userid,$goodsid,time(),$buyid));
				$lastid = $db->lastInsertId();
				//修改分成关系				
				if($adduse>0){
					$price = $goodsRes[0]['price'];
					$bossMoney = floatval($goodsRes[0]['commissionboss'] * $price);
					
					$agentMoney = floatval($goodsRes[0]['commagent'] * $price);
					$HelpSellMoney = floatval($agentMoney*floatval($hsalescommission));
					$sellMoney = floatval($agentMoney*floatval($salescommission));
					
					$agentMoney = $agentMoney - $HelpSellMoney - $sellMoney;
					if($agentMoney<0){
						$agentMoney = 0;
					}
					
					$giveIntegral = $goodsRes[0]['giveIntegral'];
					
					$db->query("update xl_userinfo set source = source + ? where userid = ?",array($giveIntegral,$userid));
					
					if($sellUid>0){
						//添加业务收支明细
//						$addnum = $db->query("insert into xl_inoutcomelist(usera,userb,userc,sum,opdate,notes,goodsid)values(?,?,?,?,?,?,?)",array($sellUid,$BossUserid,$userid,$sellMoney,time(),'',$goodsid));
						$addnum = $db->query("insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)values(?,?,?,?,?,?)",array(UseTypeMoney,$lastid,$sellUid,$sellMoney,time(),SAlESMAN));
						
						if($addnum>0){
							$db->query("update xl_userinfo set accounts = accounts + ? where userid = ?",array($sellMoney,$sellUid));
						}
					}
					
					if($helpSellId>0){
						//添加美导收支明细
						$addnum = $db->query("insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)values(?,?,?,?,?,?)",array(UseTypeMoney,$lastid,$helpSellId,$HelpSellMoney,time(),HelpSAlESMAN));
						
						if($addnum>0){
							$db->query("update xl_userinfo set accounts = accounts + ? where userid = ?",array($HelpSellMoney,$helpSellId));
						}
					}
					
					if($agentid>0){
						//添加代理商明细
						$addnum = $db->query("insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)values(?,?,?,?,?,?)",array(UseTypeMoney,$lastid,$agentid,$agentMoney,time(),Agent));
						
						if($addnum>0){
							$db->query("update xl_userinfo set accounts = accounts + ? where userid = ?",array($agentMoney,$agentid));
						}
					}
					
					//老板娘自己的
					$addnum = $db->query("insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)values(?,?,?,?,?,?)",array(UseTypeMoney,$lastid,$BossUserid,$bossMoney,time(),Boss));
					$db->query("update xl_userinfo set accounts = accounts + ? where userid = ?",array($bossMoney,$BossUserid));	
//					$db->query("insert into xl_inoutcomelist(usera,userb,userc,sum,opdate,notes,goodsid)values(?,?,?,?,?,?,?)",array($BossUserid,$userid,0,$bossMoney,time(),'',$goodsid));
					
					//用户信息
					$addnum = $db->query("insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)values(?,?,?,?,?,?)",array(UseTypeSource,$lastid,$userid,$giveIntegral,time(),User));				
				}
			}
			
			
			$db->Closeconnection();
			echo '200';
			
			$redis_ocean = new Redis();
		    $redis_ocean->connect(RedISHost, RedISPORT);			
			$resUseKey = 'use:userid:'.$userid.':'.$uuid;		
			$redis_ocean->setex($resUseKey, 30, 'ttl come');
			
			return;
		}
		echo '210';
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
		
		$useGroup = $db->query("select * from xl_goodsusemsg where userid = ? order by opdate desc LIMIT ?,?",array($userid,$startPage,$endPage));
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
				if(floatval($_POST['money']) <= 100){
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
			return;
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
			ErrorSend('clientid not');
			return;
		}
		if(!isset($_POST['salesmanid'])){
			ErrorSend('salesmanid');
			return;
		}
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
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($_POST['clientid']));
		if($result[0]['role'] != 1){
			$DB->CloseConnection();
			echo '105';
			return;
		}
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($_POST['salesmanid']));
		if($result[0]['role'] != 3){
			$DB->CloseConnection();
			echo '106';
			return;
		}
		
		$nresult = $DB->query("SELECT listid from xl_clientslist where clientid=? ",array($_POST['clientid']));
		if(count($nresult)>0){
			$DB->CloseConnection();
			echo '108';
		}
		
		$result = $DB->query("SELECT listid from xl_clientslist where clientid=? and belongto=?",array($_POST['clientid'],$_POST['salesmanid']));
		if(count($result)>0){
			$DB->CloseConnection();
			echo '107';
			return;
		}
		$DB->CloseConnection();
		echo '200';
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