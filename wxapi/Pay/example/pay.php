<?php
	//header('Access-Control-Allow-Origin:*');
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
		
		
		if(!isset($_POST['userid'])){
			ErrorSend('userid not');
			exit();
		}
		
		
		$userid = $_POST['userid'];
		$beautiesid = 0;
		if(isset($_POST['beautiesid'])){
			$beautiesid = $_POST['beautiesid'];
		}
		
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
		$role = $roleresult[0]['role'];
		$phone = $roleresult[0]['phone'];
		
		if($phone == null || $phone == ''){
			ErrorSend('-100'); 
			exit();
		}
		
//		echo 'role='.$role.'User='.User;
		
		if($role != User && $role != Boss){
			ErrorSend('-101'); 
			exit();
		}
		
		$result = $DB->query("SELECT * from xl_buylist where userid=? and goodsid = ?",array($userid,$goodsid));
		if(count($result)>0 && $goodstype == 1 && $role!=Boss){
			ErrorSend('-102');
			exit();
		}
		
		
		$client = $DB->query("select belongto,clientid,role,username,salescommission,userid
				 from xl_clientslist,xl_userinfo where userid = belongto and clientid =?",[$userid]);
		
		$bossid = 0;
		foreach($client as $key=>$value){
			if($value['role'] == Boss){
				$bossid = $value['userid'];
			}
		}
		
		if($bossid<=0){
			ReturnMsg('-1','客户还没有绑定商户哦');
		}
		
		
		if($beautiesid<=0){
			ReturnMsg('-1','请选择一个美体师');
		}
		
//		echo '$bossid='.$bossid.'$beautiesid='.$beautiesid;
		
		$beautiesRes = $DB->query("select * from xl_store_beauties where bossid =? and beautiesid = ?",[$bossid,$beautiesid]);
		
		if(count($beautiesRes)<=0){
			ReturnMsg('-1','该美体师没有和该商户绑定');
		}
		
		GetPayReadyParam();
//		ErrorSend('ok');
	}
	
	//购买商品参数获取
	function GetPayReadyParam(){

		if(!isset($_POST['goodsid'])){
			ReturnMsg('-1','商品参数错误');
		}
		
		if(!isset($_POST['userid'])){
			ReturnMsg('-1','用户参数错误');
		}
		
		if(!isset($_POST['num'])){
			ReturnMsg('-1','数量参数错误');
		}
		
		
		//exit('im in this2'); 
		
		$beautiesid = 0;
		$userid = $_POST['userid'];
		$goodsid = $_POST['goodsid'];
		$num = $_POST['num'];
		$extid = 0;
		
		if(isset($_POST['extid'])){
			$extid = $_POST['extid'];
		}
		
		if(isset($_POST['beautiesid'])){
			$beautiesid = $_POST['beautiesid'];
		}
		
		if(!is_numeric($goodsid)){
			ReturnMsg('-1','商品参数错误.');
		}
		
		if(!is_numeric($userid)){
			ReturnMsg('-1','用户参数错误.');
		}
		
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("SELECT * from xl_goods where id=?",array($goodsid));
		if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['id'] == 0){
			ReturnMsg('-1','商品参数错误..');
		}
		
		$coupongoods = $DB->query("select * from xl_coupontogoods where goodsid = ?",[$goodsid]);
		if(count($coupongoods)<=0){
			ReturnMsg('-1','该商品没有绑定优惠券');
		}
		
		$roleresult = $DB->query("SELECT * from xl_userinfo where userid=?",array($userid));
		if($roleresult == null || count($roleresult)<=0 || count($roleresult[0])<=0){
			ReturnMsg('-1','用户参数错误..');
		}
		
		
		
		$price = $result[0]['price']*100 *$num;
		$goodsprice = $result[0]['price']*100;
		$goodstype = $result[0]['buyType'];
		$gname = $result[0]['gname'];
		$phone = $roleresult[0]['phone'];
		$role = $roleresult[0]['role'];
		$wxopenid = $roleresult[0]['wxopenid'];
		
		if($phone == null || $phone == ''){
			ReturnMsg('-100','请先绑定电话号码');
		}
		
		$result = $DB->query("select * from xl_buylist where userid=? and goodsid = ?",array($userid,$goodsid));
		if(count($result)>0 && $goodstype == 1 && $role!=Boss){
			ReturnMsg('-2','商品只能够购买一次');
		}
		
		if($role != User && $role != Boss && $role != Beauties){
			ReturnMsg('-1','只有用户,商户,美体师才可以购买哦');
		}
		
		if($role == Boss){
			$bossid = $userid;
		}
		else{
			$client = $DB->query("select belongto,clientid,role,username,salescommission,userid
				 from xl_clientslist,xl_userinfo where userid = belongto and clientid =?",[$userid]);
		
			$bossid = 0;
			foreach($client as $key=>$value){
				if($value['role'] == Boss){
					$bossid = $value['userid'];
				}
			}
		}
		
		if($bossid<=0){
			ReturnMsg('-1','客户还没有绑定商户哦');
		}
		
//		if($beautiesid<=0){
//			ReturnMsg('-1','请选择一个美体师');
//		}
		
		if($beautiesid>0){
			$beautiesRes = $DB->query("select * from xl_store_beauties where bossid =? and beautiesid = ?",[$bossid,$beautiesid]);	
			if(count($beautiesRes)<=0){
				ReturnMsg('-1','该美体师没有和该商户绑定');
			}
		}
		
		$orderid = time().$userid;
		//在此处下订单（tid 存在订单表）
		$attach = 'GoodsPayParam'.';'.$orderid;
		$tourl = ROOTURL.'wxapi/Pay/example/notifyGoods.php';
		
		$payArr = array('gname'=>$gname,
		'attach'=>$attach,
		'price'=>$price,
		'openid'=>$wxopenid,
		'tourl'=>$tourl);
		
		for($i = 0;$i<$num;$i++){
			$DB->query("insert into xl_buylist(serialnum,setsname,buydate,giftnum,expnum,bindinfo,notes,userid,price,goodsid,beautiesid,paystate,orderid,tid,bossid) 
			values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
			['',$gname,time(),0,0,'','',$userid,$goodsprice,$goodsid,$beautiesid,0,$orderid,$extid,$bossid]);
		}
		
		$DB->CloseConnection();
		
		//测试注释		
		$getparam = new PayGetParam();		
		$getparam->PayParam($payArr);
		
//		GoodsPayBack(['transaction_id'=>time()],$attach);
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

		$dptype= $_POST['dptype'];
		if(!is_numeric($dptype)){
			ErrorSend('dptype error');
			exit();
		}
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$salesmanid = $_POST['salesmanid'];
		$clientid = $_POST['clientid'];
		
		//判断是否商户或者用户
		$result = $DB->query("SELECT role,wxopenid from xl_userinfo where userid=?",array($clientid));
		$userRole = $result[0]['role'];
		$wxopenid = $result[0]['wxopenid'];
		if($result[0]['role'] > Boss){
			$DB->CloseConnection();
			echo json_encode(array("status" => "105"));
			exit();
		}
		
		//判断业务角色的正确性
		$result = $DB->query("SELECT role from xl_userinfo where userid=?",array($_POST['salesmanid']));
		if($result[0]['role'] != 3){
			$DB->CloseConnection();
			echo json_encode(array("status" => "106"));
			exit();
		}
		
		//该业务是否已经和这个用户或者商户绑定过
		$result = $DB->query("SELECT listid from xl_clientslist where clientid=? and belongto=?",array($_POST['clientid'],$salesmanid));
		if(count($result)>0){
			$DB->CloseConnection();
			echo json_encode(array("status" => "107"));
			exit();
		}
		
		//业务员上面没有代理商
		$agentlist = $DB->query("select * from xl_clientslist where clientid = ?",array($salesmanid));
		if(count($agentlist)<=0){
			$DB->CloseConnection();
			echo json_encode(array("status" => "110"));
			exit();
		}
		
		//获得代理商编号
		$agentid = $agentlist[0]['agentid'];
		//用户已经和这个代理商绑定了关系
		$aresult = $DB->query("select id from xl_agentuser where userid = ? and aid=?",array($clientid,$agentid));
		if(count($aresult)>0){
			$DB->CloseConnection();
			echo json_encode(array("status" => "111"));
			exit();
		}
		
		//如果是用户的时候和别人绑定了关系不可以继续
		$nresult = $DB->query("SELECT listid from xl_clientslist where clientid=? ",array($_POST['clientid']));
		if(count($nresult)>0 && $userRole == User){
			$DB->CloseConnection();
			echo json_encode(array("status" => "109"));
			exit();
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

		$tourl = ROOTURL.'wxapi/Pay/example/notifyGoods.php';
		
		$payArr = array('gname'=>$dpname,
		'attach'=>$attach,
		'price'=>$price,
		'openid'=>$wxopenid,
		'tourl'=>$tourl);
		
		//echo json_encode($payArr);
		$DB->CloseConnection();
		
		//header("Location:http://www.amyshirley.com/amlqs/login.html?errormsg=".json_encode($payArr));
		//exit(json_encode($payArr));
		
		$getparam = new PayGetParam();		
		$getparam->PayParam($payArr);
	}
	
	
	
	
	
	
	
	
	
	
	//购买商品返回方法
	function GoodsPayBack($data,$attach){
//		Log::DEBUG("im enter");
		
//		exit('pay back');
		
		$attach = explode(";",$attach);
		
		$transaction_id = $data['transaction_id'];
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("select buyid from xl_buylist where serialnum = ?",array($transaction_id));
		
//		Log::DEBUG("start add call data:".$data['transaction_id']);
		
		
		$orderid = $attach[1];
		$ordrenum = count($result);
		
		if($ordrenum>0){
			$DB->CloseConnection();
			return;
		}
		
		
		$orderList = $DB->query("select * from xl_buylist where orderid = ?",[$orderid]);
		$ordrenum = count($orderList);
		if($ordrenum<=0){
			$DB->CloseConnection();
			return;
		}
		
		$goodsid = $orderList[0]['goodsid'];
		$tid = $orderList[0]['tid'];
		$userid = $orderList[0]['userid'];
		$bossid = $orderList[0]['bossid'];
		$beautiesid = $orderList[0]['beautiesid'];
		$sqlArr = [];
		
		$goodsres = $DB->query("select gname,commissionboss,commissionsalesman,price,type,commagent,giveIntegral,agentid,extsource,commissionhelp,
		 commissionbeauties from xl_goods where id=$goodsid");
		if(count($goodsres)<=0){
			$DB->CloseConnection();
			return;
		}
		
		$agentid = $goodsres[0]['agentid'];
		
		array_push($sqlArr,"update xl_goods set buynum = buynum+$ordrenum where id=$goodsid");
		$curtime = time();
		//给商品加券
		$couponList = $DB->query("select * from xl_coupontogoods where goodsid = ?",array($goodsid));
		foreach($orderList as $key=>$value){
				
			$lastbuyid = $value['buyid'];
			$giftArr = array('1'=>0,'2'=>0);
			if(count($couponList)>0){
				
				$arrlen = count($couponList);
				$couponMsg;
				for($i = 0;$i<$arrlen;$i++){
					if(count($couponList[$i])>0){
						$cid = $couponList[$i]['couponid'];
						$couponMsg = $DB->query("select * from xl_coupon where id = ".$cid);
						
						if(count($couponMsg)<=0){
							continue;
						}
						
						$giftArr[$couponMsg[0]['type']]= $giftArr[$couponMsg[0]['type']] + $couponList[$i]['nums'];
						$datefrom = time() + $couponMsg[0]['starttime'];
						$dateto = $datefrom + $couponMsg[0]['endtime'];
						
						
						$sqlStr = $cid.",".$userid.",".$datefrom.",".$dateto.",".$goodsid.",".$lastbuyid;
						//添加券
						array_push($sqlArr,"insert into xl_couponlist(cpuuid,belongto,datefrom,dateto,goodsid,buyid) value(".$sqlStr.")");
					}
				}				
			}
			
			//添加购买列表
			$giftnum = $giftArr['1'];
			$expnum = $giftArr['2'];			
			array_push($sqlArr,"update xl_buylist set giftnum=$giftnum, expnum = $expnum where buyid = $lastbuyid");
			
			//如果商品绑定代理商。记录下来			
			
			if($agentid>0){				
				array_push($sqlArr,"insert into xl_buy_agent_goods(agentid,buyerid,buytime,buyid)values($agentid,$userid,$curtime,$lastbuyid)");
			}
		}
		
		
		
		//推荐人积分
		if($tid>0 && $tid != $userid){
			$tidlist = $DB->query("select userid from xl_extension where userid=? and extid=?",array($tid,$userid));
			if(count($tidlist)<=0){
				array_push($sqlArr,"insert into xl_extension(userid,extid,goodsid,conndate)values($tid,$userid,$goodsid,$curtime)");
				
			}
			
			$extsource = $goodsres[0]['extsource']*$ordrenum;
			array_push($sqlArr,"update xl_userinfo set source = source+$extsource where userid = $tid");
		}
		array_push($sqlArr,"update xl_buylist set serialnum = $transaction_id,paystate=1 where orderid = $orderid");
		
		
		
		//老板娘和商户绑定关系
//		$client = $DB->query("select * from xl_clientslist where belongto = ? and clientid = ?",array($bossid,$userid));	
//		if(count($client)<=0){
//			//说明没有确定关系		
//			$bossAgent = $DB->query("select id,aid from xl_agentuser where userid = ?",array($bossid));
//			$saveAgentid = $agentid;
//			if(count($bossAgent)>0){
//				$saveAgentid = $bossAgent[0]['aid'];
//			}
//			
//			array_push($sqlArr,"insert into xl_clientslist(clientid,belongto,conndate,agentid)values($userid,$bossid,$curtime,$saveAgentid)");
//			
//			//存储代理商用户信息
//			$agentuserlist = $DB->query("select id from xl_agentuser where userid = ? and aid = ?",array($userid,$saveAgentid));
//			if(count($agentuserlist)<=0 && $saveAgentid>0){			
//				array_push($sqlArr,"insert into xl_agentuser(aid,userid,conndate) values($saveAgentid,$userid,$curtime)");
//			}
//		}
		
		
		//上级分钱
		$sellUid = 0;
		$helpSellId = 0;
		//用户积分
		$giveIntegral = $goodsres[0]['giveIntegral']*$ordrenum;
		//老板分成
		$price = $goodsres[0]['price'] * $ordrenum;
		$bossMoney = floatval($goodsres[0]['commissionboss'] * $price);	
		//美体师分成
		$beautiesMoney = $bossMoney * $goodsres[0]['commissionbeauties'];
		//商户减去 美体师分成剩下的钱
		$bossMoney = $bossMoney - $beautiesMoney;
		
		
		//代理商分成
		$agentMoney = floatval($goodsres[0]['commagent'] * $price);
		$sellMoney = $HelpSellMoney = 0;
		
		
		$goodsname = $goodsres[0]['gname'];
		$DB->query("insert into xl_goodsuse(bossid,userid,goodsid,usetime,buyid,gname,orderid)values(?,?,?,?,?,?,?)",
		array($bossid,$userid,$goodsid,time(),$lastbuyid,$goodsname,$orderid));
		$lastuseid = $DB->lastInsertId();
		
		
		$usetSource = UseTypeSource;
		$usermoney = UseTypeMoney;
		$bosst = Boss;
		$usert = User;
		//老板的
		if($bossMoney>0){
			array_push($sqlArr,"update xl_userinfo set accounts = accounts + $bossMoney where userid = $bossid");
			
			//老板分钱记录
			array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
			values($usermoney,$lastuseid,$bossid,$bossMoney,$curtime,$bosst)");	
		}
		
		//用户分积分记录
		if($giveIntegral>0){			
			array_push($sqlArr,"update xl_userinfo set source = source + $giveIntegral where userid = $userid");			
			array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
			values($usetSource,$lastuseid,$userid,$giveIntegral,$curtime,$usert)");	
		}
		
		//美体师的
		if($beautiesMoney>0 && $beautiesid>0){	
			$Beautiest = Beauties;		
			array_push($sqlArr,"update xl_userinfo set accounts = accounts + $beautiesMoney where userid = $beautiesid");
			//美体师分钱记录
			array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
			values($usermoney,$lastuseid,$beautiesid,$beautiesMoney,$curtime,$Beautiest)");
		}
		
		//代理商线下的
		if($agentid > 0){
					
			$SellerRes = $DB->query("select belongto,clientid,role,username,salescommission
				 from xl_clientslist,xl_userinfo where userid = belongto and clientid =? and agentid = ?",array($bossid,$agentid));
				 
			$sellerNum = count($SellerRes);
				
			if($sellerNum>0){
				
				for($i=0;$i<$sellerNum;$i++){
					if($SellerRes[$i]["role"] == SAlESMAN){
						$sellUid = $SellerRes[$i]["belongto"];
					}
					else if($SellerRes[$i]["role"] == HelpSAlESMAN){
						$helpSellId = $SellerRes[$i]["belongto"];
					}
				}				
			}
			
			//业务分成
			if($sellUid>0){
				$sellMoney = $agentMoney * $goodsres[0]['commissionsalesman'];
			}
			//美导分成
			if($helpSellId>0){
				$HelpSellMoney = $agentMoney * $goodsres[0]['commissionhelp'];
			}
			
			//代理商减去 业务和美导的分成剩下的钱
			$agentMoney = $agentMoney-($sellMoney + $HelpSellMoney);
			
			//代理商收入
			$agentt = Agent;
			array_push($sqlArr,"update xl_userinfo set accounts = accounts + $agentMoney where userid = $agentid");
				array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
				values($usermoney,$lastuseid,$agentid,$agentMoney,$curtime,$agentt)");
			
			if($sellUid>0 && $sellMoney>0){
				//添加业务收支明细				
				$salet = SAlESMAN;
				array_push($sqlArr,"update xl_userinfo set accounts = accounts + $sellMoney where userid = $sellUid");
				array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
				values($usermoney,$lastuseid,$sellUid,$sellMoney,$curtime,$salet)");
			}
			
			if($helpSellId>0 && $HelpSellMoney>0){
				//添加美导收支明细
				$halet = HelpSAlESMAN;
				array_push($sqlArr,"update xl_userinfo set accounts = accounts + $HelpSellMoney where userid = $helpSellId");
				array_push($sqlArr,"insert into xl_goodsusemsg(usetype,useid,userid,nums,opdate,userrole)
				values($usermoney,$lastuseid,$helpSellId,$HelpSellMoney,$curtime,$halet)");
			}			
		}
		
//		exit(' im ok '.$lastuseid);
		
		try {  
		  $DB->startTransaction();
		  
		  $sqlnum = count($sqlArr);
		  for($i=0;$i<$sqlnum;$i++){
		  	//echo 'i='.$sqlArr[$i];
		  	$DB->query($sqlArr[$i]);
		  }
		  
		  $DB->commitTransaction();
		  
		} catch (Exception $e) {
		  $DB->rollbackTransaction();
		  echo "Failed: " . $e->getMessage();
//		  Log::DEBUG("Failed".$e->getMessage());		
		}
		
//		Log::DEBUG("addgoods".$transaction_id);		

//		echo 'im  su'; 
//		echo '$bossid='.$bossid.'$beautiesid='.$beautiesid.'$sellUid='.$sellUid.'$helpSellId='.$helpSellId.'$agentid='.$agentid;
		
		$DB->CloseConnection();
		
		ReturnMsg('ok','支付成功');
	}
	
	
	
	
	
	
	
?>