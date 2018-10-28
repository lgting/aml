<?php
	
	namespace Module;	
	header('Access-Control-Allow-Origin:*');
	
	class UserModule{
    	
    	//显示代理商线下列表
    	public function showAgentList($postDb){
    		if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
			
			if(!isset($postDb['roletp'])){
				ErrorSend('roletp fail');
				return;
			}
			
			if(!isset($postDb['page'])){
				ErrorSend('page fail');
				return;
			}
			
			$aid = $postDb['aid'];
			$roletp = $postDb['roletp'];
			$page = $postDb['page'];
			
			$startPage = $page*10;
			$endPage = 10;
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $db->query("select userid,xl_clientslist.conndate,headimgurl,role,username,phone,salescommission from xl_clientslist,xl_userinfo where userid = clientid and belongto =? and role = ? order by conndate limit ?,?",array($aid,$roletp,$startPage,$endPage));
			
			$resultMsg = array('error'=>'ok');	
			$resultMsg['arr'] = $result;
			echo json_encode($resultMsg);
			$db->Closeconnection();
    	}
    	
		//更改提成
		public function updateCommission($postDb){
			if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
			
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['scom'])){
				ErrorSend('scom fail');
				return;
			}

			$aid = $postDb['aid'];
			$uid = $postDb['uid'];
			$scom = $postDb['scom'];
			
			if(!is_numeric($scom)){
				ErrorSend('scom isfloat');
				return;
			}
			
			if($scom>0.5){
				ErrorSend('-103');
				return;
			}
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$auserresult = $db->query("select userid,role from xl_userinfo where userid=?",array($aid));
			//代理商不存在
			if(count($auserresult)<=0){
				ErrorSend('-100');
				$db->CloseConnection();
				return;
			}
			
			$arole = $auserresult[0]['role'];
			//代理商id角色不是代理商
			if($arole != Agent){
				ErrorSend('-101');
				$db->CloseConnection();
				return;
			}
			
			$userresult = $db->query("select userid,role from xl_userinfo where userid=?",array($uid));
			//用户不存在
			if(count($auserresult)<=0){
				ErrorSend('-102');
				$db->CloseConnection();
				return;
			}
			
			$db->query("update xl_userinfo set salescommission =? where userid=?",array($scom,$uid));
			
			ErrorSend('ok');
			$db->CloseConnection();
		}
		
    	//代理商查找下面对应的美导或者业务按照手机号码
    	//按照手机号码查找用户信息
    	public function FindUserByPhone($postDb){
    		if(!isset($postDb['phone'])){
				ErrorSend('phone fail');
				return;
			}
			
			if(!isset($postDb['role'])){
				ErrorSend('role fail');
				return;
			}
			
			$phone = $postDb['phone'];
			$role = $postDb['role'];
			
			if($phone == "" || $phone == null){
				ErrorSend('-100');
				return;
			}
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $db->query("select userid,role,username,phone,headimgurl from xl_userinfo where phone=?",array($phone));
			
			//没有这个用户
			if(count($result)<=0){
				ErrorSend('-101');
				$db->CloseConnection();
				return;
			}
			
			//用户角色不对
			$resultrole = $result[0]["role"];
			if($role >0 && $resultrole != $role){
				ErrorSend('-102');
				$db->CloseConnection();
				return;
			}
			
			
			
			$userid = $result[0]["userid"];
			$upresult = $db->query("select xl_clientslist.conndate,clientid,belongto,headimgurl,role,username,phone
		 from xl_clientslist,xl_userinfo where userid = belongto and clientid =? and role <>5",array($userid));
			
			$userNum = count($upresult);
			$uparr = array();
			for($i = 0;$i<$userNum;$i++){
				array_push($uparr,
				array('belongto'=>$upresult[$i]['belongto'],
				'belongtoname'=>$upresult[$i]['username'],
				'role'=>$upresult[$i]['role'],));
			}
			
			
			$result[0]['uplist'] = $uparr;

			$resultMsg = array('error'=>'ok');	
			$resultMsg['arr'] = $result;
			echo json_encode($resultMsg);
			$db->Closeconnection();
    	}
		
		//代理商查找下面对应的美导或者业务按照手机号码
    	public function AgentFindUserByPhone($postDb){
    		if(!isset($postDb['phone'])){
				ErrorSend('phone fail');
				return;
			}
			
			if(!isset($postDb['role'])){
				ErrorSend('role fail');
				return;
			}
			
			if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
			
			$phone = $postDb['phone'];
			$role = $postDb['role'];
			$aid = $postDb['aid'];
			
			if($phone == "" || $phone == null){
				ErrorSend('-100');
				return;
			}
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $db->query("select userid,role,username,phone,headimgurl,salescommission from xl_userinfo where phone=?",array($phone));
			//没有找到该用户
			if(count($result)<=0){
				ErrorSend('-101');
				$db->CloseConnection();
				return;
			}
			
			//用户角色不对
			$userRole = $result[0]["role"];
			
			if($role >0 && $userRole != $role){
				ErrorSend('-102');
				$db->CloseConnection();
				return;
			}
			
			$userid = $result[0]["userid"];
			
			
			//role = 0 查找所有  
			$back = [];
			if($role == 0){
				$upresult = $db->query("select clientid,belongto,role,username,phone,salescommission
			 from xl_clientslist,xl_userinfo where userid = belongto and clientid =? and agentid =? and role <>5",array($userid,$aid));
				
				$userNum = count($upresult);
				for($i = 0;$i<$userNum;$i++){
					array_push($back,
					array('belongto'=>$upresult[$i]['belongto'],
					'belongtoname'=>$upresult[$i]['username'],
					'role'=>$upresult[$i]['role'],
					'salescommission'=>$upresult[$i]['salescommission']));
				}
				
				$result[0]['uplist'] = $back;
				$resultMsg = array('error'=>'ok');	
				$resultMsg['arr'] = $result;
				echo json_encode($resultMsg);
				$db->Closeconnection();
				return;
			}
			else{
				
				$agentresult = $db->query("select * from xl_agentuser where userid = ? and aid=?",array($userid,$aid));
				if(count($agentresult)<=0){
					ErrorSend('-101');
					$db->CloseConnection();
					return;
				}
				
				$upresult = $db->query("select clientid,belongto,role,username,phone,salescommission
			 from xl_clientslist,xl_userinfo where userid = belongto and clientid =? and agentid =? and role <>5",array($userid,$aid));
				
				$userNum = count($upresult);
				for($i = 0;$i<$userNum;$i++){
					array_push($back,
					array('belongto'=>$upresult[$i]['belongto'],
					'belongtoname'=>$upresult[$i]['username'],
					'role'=>$upresult[$i]['role'],
					'salescommission'=>$upresult[$i]['salescommission']));
				}
				
			}
			
			$result[0]['uplist'] = $back;
			$resultMsg = array('error'=>'ok');	
			$resultMsg['arr'] = $result;
			echo json_encode($resultMsg);
			$db->Closeconnection();
    	}
    	
		
		//判断用户是否在对应的代理商下面
		//$userid 用户编号
		//$aid 代理商用户编号
		/*public function AgentUser($userid,$aid,$db){
				$bossResult = $db->query("select xl_clientslist.conndate,clientid,belongto,headimgurl,role,username,phone
		 from xl_clientslist,xl_userinfo where userid = belongto and clientid =?",array($userid));
		 		
				$bossResultNum = count($bossResult);
		 		if($bossResultNum<=0){
					return null;
		 		}
				
				$salesResult = $db->query("select * from xl_clientslist where clientid = ".$bossResult[0]['belongto']);
				$salesResultNum = count($salesResult);
				if($salesResultNum<=0){
					return null;
		 		}
		 		
		 		$useridArr = array();
		 		for($i=0;$i<$salesResultNum;$i++){
		 			array_push($useridArr,$salesResult[$i]["belongto"]);
		 		}
				
				$useridArrStr = implode(',', $useridArr);
				$useridArrStr = "(".$useridArrStr.")";
				$agentResult = $db->query("select * from xl_clientslist where clientid in ".$useridArrStr);
				$agentResultNum = count($agentResult);
				
				$aobjs = null;
				for($i=0;$i<$agentResultNum;$i++){
		 			if($agentResult[$i]["belongto"] == $aid){
		 				$aobjs = $agentResult[$i];
		 				break;
		 			}
		 		}
		 		
		 		if($aobjs == null){
					return null;
		 		}
				
				$uparr = array();
				for($i = 0;$i<$bossResultNum;$i++){
					array_push($uparr,
					array('belongto'=>$bossResult[$i]['belongto'],
					'belongtoname'=>$bossResult[$i]['username'],
					'role'=>$bossResult[$i]['role']));
				}
				
				return $uparr;
		}*/
		
		
    	
    	//查找代理商下面所有商户信息
    	public function AgengAllBoss($postDb){
    		
    		if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
    		
    		if(!isset($postDb['page'])){
				ErrorSend('page fail');
				return;
			}
    		
    		$aid = $postDb['aid'];
    		$page = $postDb['page'];
    		$startPage = $page*10;
			$endPage = 10;
			
    		
    		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
    		//1.拿到所有商户						
			$result = $db->query("SELECT xl_agentuser.userid,username,phone,headimgurl,conndate,role FROM xl_agentuser,xl_userinfo WHERE 
			 xl_userinfo.userid = xl_agentuser.userid and xl_userinfo.role=2 and aid = ?
			ORDER BY conndate DESC limit ?,?",array($aid,$startPage,$endPage));
			
			if(count($result)>0){
				$useridArr = array();
				foreach($result as $key=>$values){
					array_push($useridArr,$values['userid']);
					$result[$key]['uplist'] = array();
				}
				$useridArrStr = '('.implode(',', $useridArr).')';
				
				//2.拿到商户和美导
				$aresult = $db->query("select clientid,role,belongto,username,phone,salescommission
				 from xl_clientslist,xl_userinfo where clientid in $useridArrStr and belongto = userid and agentid = $aid and role <>5");
				 
				foreach($result as $key=>$values){
					$ruserid = $values['userid'];
					foreach($aresult as $akey=>$avalues){
						if($ruserid == $avalues['clientid']){
							
							array_push($result[$key]['uplist'],array('belongto'=>$avalues['belongto'],
								'belongtoname'=>$avalues['username'],
								'role'=>$avalues['role'],
								'salescommission'=>$avalues['salescommission']));
						}
					}	
				}
				
			}
			
			$resultMsg = array('error'=>'ok');	
			$resultMsg['arr'] = $result;
			echo json_encode($resultMsg);
			
			$db->Closeconnection();
    	}
    	
    	//商户和美导或者业务员绑定关系
    	public function BossToHelpManConn($postDb){
    		
			if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
			
			if(!isset($postDb['bid'])){
				ErrorSend('bid fail');
				return;
			}
			
			if(!isset($postDb['hid'])){
				ErrorSend('hid fail');
				return;
			}
			
			if(!isset($postDb['role'])){
				ErrorSend('rrole fail');
				return;
			}
			
			$aid = $postDb['aid'];
			$bid = $postDb['bid'];
			$hid = $postDb['hid'];
			$role = $postDb['role'];
			
			if($role != HelpSAlESMAN && $role != SAlESMAN){
				//不能绑定业务员和美导以外的角色
				ErrorSend('-103');
				return;
			}
			
			//查看商户是否是商户
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
    		$bresult = $db->query("SELECT username,role FROM xl_userinfo where userid=?",array($bid));
			if(count($bresult)<=0 || $bresult[0]['role'] != Boss){
				ErrorSend('-100');
				$db->Closeconnection();
				return;
			}
			
			//查看美导是否是美导 业务是否是业务
			$hresult = $db->query("SELECT username,role FROM xl_userinfo where userid=?",array($hid));
			if(count($hresult)<=0 || $hresult[0]['role'] != $role){
				ErrorSend('-101');
				$db->Closeconnection();
				return;
			}
			
			//查看商户是否绑定的美导
			//$alls = $db->query("SELECT username,role,conndate FROM xl_clientslist,xl_userinfo WHERE belongto in( select belongto from xl_clientslist where clientid = ?) 
			//	and xl_userinfo.userid = xl_clientslist.belongto and agentid = ?",array($bid,$aid));
			
			$alls = $db->query("select userid,username,role FROM xl_clientslist,xl_userinfo WHERE  xl_userinfo.userid = xl_clientslist.belongto and clientid = ? and agentid= ?",array($bid,$aid));
			
    		
    		$allNum = count($alls);
    		
    		for($i=0;$i<$allNum;$i++){
    			if($alls[$i]["role"]==$role){
    				ErrorSend('-102');
    				$db->Closeconnection();
					return;
    			}
    		}
			
			$agentlist = $db->query("select * from xl_clientslist where clientid = ?",array($hid));
			$agentid = 0;
			if(count($agentlist)>0){
				$agentid = $agentlist[0]['agentid'];
			}
			
			//代理商信息错误
			if($agentid != $aid){
				ErrorSend('-104');
				$db->Closeconnection();
				return;
			}
			
			//说明没有确定关系
			$addCount = $db->query("insert into xl_clientslist(clientid,belongto,conndate,agentid)values(?,?,?,?)",array($bid,$hid,time(),$agentid));
			
			//存储代理商用户信息
			$agentuserlist = $db->query("select id from xl_agentuser where userid = ? and aid =?",array($bid,$agentid));
			if(count($agentuserlist)<=0){
				$db->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array($agentid,$bid,time()));
			}
			
    		
			if($addCount>0){
    			ErrorSend("ok");	
    		}
    		else{
    			ErrorSend("fail");
    		}
    		
    		$db->Closeconnection();
    	}
		
		
		//商户和美导或者业务员取消绑定关系
    	public function BossToExitConn($postDb){
			
			//代理商编号
			if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
			
			//业务员或者美导编号
			if(!isset($postDb['sid'])){
				ErrorSend('sid fail');
				return;
			}
			
			//商户编号
			if(!isset($postDb['bid'])){
				ErrorSend('bid fail');
				return;
			}
			
			$aid = $postDb['aid'];
			$sid = $postDb['sid'];
			$bid = $postDb['bid'];
			
			//查看商户是否是商户
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
    		$bresult = $db->query("SELECT username,role FROM xl_userinfo where userid=?",array($bid));
			if(count($bresult)<=0 || $bresult[0]['role'] != Boss){
				ErrorSend('-100');
				$db->Closeconnection();
				return;
			}
			
			//查看美导是否是美导 业务是否是业务
			$sresult = $db->query("SELECT username,role FROM xl_userinfo where userid=?",array($sid));
			if(count($sresult)<=0){
				ErrorSend('-101');
				$db->Closeconnection();
				return;
			}
			
			$srole = $sresult[0]['role'];
			if($srole != HelpSAlESMAN && $srole != SAlESMAN){
				//业务员或者美导角色错误
				ErrorSend('-102');
				$db->Closeconnection();
				return;
			}
			
			
			//上面的业务员和美导
			$SellerRes = $db->query("select belongto,agentid,clientid,role
			 from xl_clientslist,xl_userinfo where userid = belongto and clientid =? and agentid = ?",array($bid,$aid));
			
			$sellerNum = count($SellerRes);
			
			if($sellerNum<=0){
				//商户没有绑定美导或者业务员
				ErrorSend('-103');
				$db->Closeconnection();
				return;
			}
			
			$agentid = $SellerRes[0]['agentid'];
			//echo 'agentid='.$agentid.'...='.$sellerNum;
			if($agentid!=$aid){
				//代理商信息不对
				ErrorSend('-104');
				$db->Closeconnection();
				return;
			}
			
			$sellUid = 0;
			$helpSellId = 0;
			
			for($i=0;$i<$sellerNum;$i++){
				if($SellerRes[$i]["role"] == SAlESMAN){
					$sellUid = $SellerRes[$i]["belongto"];
				}
				else if($SellerRes[$i]["role"] == HelpSAlESMAN){
					$helpSellId = $SellerRes[$i]["belongto"];
				}
			}				

			
			if($srole == HelpSAlESMAN && $sid == $helpSellId && $helpSellId>0){
				 $db->query("delete from xl_clientslist where belongto = ? and clientid=?",array($sid,$bid));
				 ErrorSend('ok');
				 $db->Closeconnection();
				 return;
			}
			
			if($srole == SAlESMAN && $sid == $sellUid && $sellUid>0){
				$db->query("delete from xl_clientslist where belongto = ? and clientid=?",array($sid,$bid));
				ErrorSend('ok');
				$db->Closeconnection();
				return;
			}
			
			//修改错误
			ErrorSend('-103');
			$db->Closeconnection();
		}
    	
		//取消业务或者美导角色
		public function ExitSaleOrHelp($postDb){
			
			//代理商编号
			if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
			
			//业务员或者美导编号
			if(!isset($postDb['sid'])){
				ErrorSend('sid fail');
				return;
			}
			
			$sid = $postDb['sid'];
			$aid = $postDb['aid'];
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
    		$sresult = $db->query("SELECT * FROM xl_clientslist where belongto=?",array($sid));
			//还有没有取消关系的商户
			if(count($sresult)>0){
				ErrorSend('-100');
				$db->Closeconnection();
				return;
			}
			
			//业务员或者美导数据不存在
			$uresult = $db->query("SELECT role FROM xl_userinfo where userid=?",array($sid));
			if(count($uresult)<=0){
				ErrorSend('-101');
				$db->Closeconnection();
				return;
			}
			
			$urole = $uresult[0]['role'];
			//被取消的角色不是业务员也不是美导
			if($urole != HelpSAlESMAN && $urole !=SAlESMAN){
				ErrorSend('-102');
				$db->Closeconnection();
				return;
			}
			
			$aresult = $db->query("SELECT * FROM xl_clientslist where clientid=?",array($sid));
			//代理商信息不存在
			if(count($aresult)<=0){
				ErrorSend('-103');
				$db->Closeconnection();
				return;
			}
			
			//代理商角色错误
			$agentid = $aresult[0]['belongto'];
			if($agentid!=$aid){
				ErrorSend('-104');
				$db->Closeconnection();
				return;
			}
			
			$db->query("delete from xl_clientslist where belongto=?",array($sid));
			$db->query("delete from xl_clientslist where clientid=?",array($sid));
			$db->query("delete from xl_agentuser where userid=? and aid = ?",array($sid,$aid));
			$db->query("update xl_userinfo set role = 1,salescommission=0 where userid=?",array($sid));
			
			ErrorSend('ok');
			$db->Closeconnection();
		}
    	
    	//代理商绑定业务
    	public function AgentCreateSellOrHelpSell($postDb){
    		if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
			
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['role'])){
				ErrorSend('role fail');
				return;
			}
			
			$aid = $postDb["aid"];
			$uid = $postDb["uid"];
			$roles = $postDb["role"];
			
			if(!is_numeric($aid)){
				ErrorSend('aid is number');
				return;
			}
			
			if(!is_numeric($uid)){
				ErrorSend('uid is number');
				return;
			}
			
			if(!is_numeric($roles)){
				ErrorSend('roles is number');
				return;
			}
			
			//查看代理商是否是代理商
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
    		$aresult = $db->query("SELECT username,role FROM xl_userinfo where userid=?",array($aid));
			if(count($aresult)<=0 || $aresult[0]['role'] != Agent){
				ErrorSend('-100');
				$db->Closeconnection();
				return;
			}
			
			//查看用户是否是用户
			$uresult = $db->query("SELECT username,role FROM xl_userinfo where userid=?",array($uid));
			if(count($uresult)<=0 || $uresult[0]['role'] != User){
				ErrorSend('-101');
				$db->Closeconnection();
				return;
			}
			
			//用户和其他人绑定的关系
			$clientresult  = $db->query("select * from xl_clientslist where clientid=?",array($uid));
			if(count($clientresult)>0){
				ErrorSend('-102');
				$db->Closeconnection();
				return;
			}
			
			
    		$addCount = $db->query("insert into xl_clientslist(clientid,belongto,conndate,agentid)values(?,?,?,?)",array($uid,$aid,time(),$aid));
    		if($addCount>0){
    			$db->query("update xl_userinfo set role = ?,salescommission=0 where userid=?",array($roles,$uid));
				
				//存储代理商用户信息
				$agentuserlist = $db->query("select id from xl_agentuser where userid = ? and aid = ?",array($uid,$aid));
				if(count($agentuserlist)<=0){
					$db->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array($aid,$uid,time()));
				}
				
    			ErrorSend("ok");	
    		}
    		else{
    			ErrorSend("fail");
    		}
    		
			$db->Closeconnection();
    	}
		
		
		public function UserInfoHeart($postDb){
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			$uid = $postDb['uid'];
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
    		$aresult = $db->query("SELECT role,accounts,source from xl_userinfo where userid=?",array($uid));
			$uresult = $db->query("select count(listid) from xl_clientslist,xl_userinfo where userid = clientid and role<>3 and role<>4 and belongto = ?",array($uid));
			
			$clientNum = 0;
			if(count($uresult)>0){
				$clientNum = $uresult[0]['count(listid)'];
			}
			
			if(count($aresult)>0){
				echo json_encode(array('role'=>$aresult[0]['role'],'accounts'=>$aresult[0]['accounts'],'source'=>$aresult[0]['source'],'clientNum'=>$clientNum));
			}
		}
		
		public function testAddMsg(){
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			
			$aresult = $db->query("select belongto from xl_clientslist where belongto<>21 group by belongto ORDER BY belongto desc");
			
    		//$aresult = $db->query("select clientid from xl_clientslist group by clientid ORDER BY clientid desc");
			foreach($aresult as $key=>$values){
				$uid = $values['belongto'];
				
				
				
				$agentuserlist = $db->query("select id from xl_agentuser where userid = ?",array($uid));
				if(count($agentuserlist)<=0){
					$db->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array(21,$uid,time()+rand(1,1000)));
				}
			}
		}
		
		function GetUserInfoClient(){
			if(!isset($_POST['openid'])){
				ErrorSend('not openid');
				exit();
			}
			
			$openid = $_POST['openid'];
			if(strlen($openid)>100){
				ErrorSend('openid to long');
				exit();
			}
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("SELECT * FROM xl_userinfo where openid = ?",array($openid));
			if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['userid'] == 0){
				ErrorSend('not userid');
				$DB->CloseConnection();
				exit();
			}
			
			$userid = $result[0]['userid'];
			
			$resultArr = array('userid'=>$userid,
				'username'=>$result[0]['username'],
				'phone'=>$result[0]['phone'],
				'role'=>$result[0]['role'],
				'accounts'=>$result[0]['accounts'],
				'openid'=>$result[0]['openid'],
				'headimgurl'=>$result[0]['headimgurl'],
				'sex'=>$result[0]['sex'],
				'source'=>$result[0]['source']
			);
			
			$couponResult = $DB->query("SELECT giftnum,expnum,goodsid from xl_buylist where userid = ".$userid);
			$giftnum = 0;
			$expnum = 0;
			if($couponResult == null || count($couponResult)<=0 || count($couponResult[0])<=0){
				$giftnum = 0;
				$expnum = 0;
			}
			else{
				$cNum = count($couponResult);
				for($i = 0;$i<$cNum;$i++){
					$giftnum+=$couponResult[$i]['giftnum'];
					$expnum+=$couponResult[$i]['expnum'];
				}			
			}
			
			$resultArr['clientNum'] = 0;
			if($result[0]['role']!=User){
				$RoleRes = $DB->query("select count(listid) from xl_clientslist,xl_userinfo where userid = clientid and role<>3 and role<>4 and belongto = ".$userid);
				$resultArr['clientNum'] = $RoleRes[0]['count(listid)'];
			}
			
			
			$resultArr['buyarr'] = $couponResult;
			$resultArr['giftnum'] = $giftnum;
			$resultArr['expnum'] = $expnum;
			$resultArr['error'] = 'ok';
			$DB->CloseConnection();
			
			$json_objback = json_encode($resultArr,JSON_UNESCAPED_UNICODE);
			echo $json_objback;
		}
		
		//推荐人列表
		function extension_fun(){
			if(!isset($_POST['userid'])){
				ErrorSend('not userid');
				exit();
			}
			
			
			$userid = $_POST['userid'];
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("select xl_extension.*,username,headimgurl,phone,conndate from xl_extension,xl_userinfo where xl_extension.extid = xl_userinfo.userid and xl_extension.userid = ?",array($userid));
			$resultArr['error'] ='ok';
			$resultArr['arr'] =$result;
			
			$json_objback = json_encode($resultArr);
			echo $json_objback;
		}
		
		function userBindBoss($postDb){
				
			if(!isset($_POST['userid'])){
				ReturnMsg(-1,'用户信息错误');
			}
			
			if(!isset($_POST['bossid'])){
				ReturnMsg(-1,'商户信息错误');
			}
			
			$userid = $_POST['userid'];
			$bossid = $_POST['bossid'];
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$userinfo = $DB->query("select userid,role from xl_userinfo where userid = ?",array($userid));
			if(count($userinfo)<=0){
				ReturnMsg(-1,'用户信息错误.');
			}
			
			$bossinfo = $DB->query("select userid,role from xl_userinfo where userid = ?",array($bossid));
			if(count($bossinfo)<=0){
				ReturnMsg(-1,'商户信息错误.');
			}
			
			$userrole = $userinfo[0]['role'];
			$bossinfo = $bossinfo[0]['role'];
			
			if($userrole!=User && $userrole!=Beauties){
				ReturnMsg(-1,'用户角色错误.');
			}
			
			if($bossinfo!=Boss){
				ReturnMsg(-1,'商户角色错误.');
			}
			
			$uplist = $DB->query("select * from xl_clientslist where clientid = ?",[$userid]);
			if(count($uplist)>0){
				ReturnMsg(-2,'您已经绑定过商户了');
			}
			
			$client = $DB->query("select * from xl_clientslist where belongto = ? and clientid = ?",array($bossid,$userid));
			if(count($client)>0){
				ReturnMsg(-2,'您和该商家已经建立关系了');
			}
				
				
			$bossAgent = $DB->query("select id,aid from xl_agentuser where userid = ?",array($bossid));
			$saveAgentid = 0;
			if(count($bossAgent)>0){
				$saveAgentid = $bossAgent[0]['aid'];
			}
			
			$curtime = time();
			$DB->query("insert into xl_clientslist(clientid,belongto,conndate,agentid)values(?,?,?,?)",
			[$userid,$bossid,$curtime,$saveAgentid]);
			
			//存储代理商用户信息
			$agentuserlist = $DB->query("select id from xl_agentuser where userid = ? and aid = ?",array($userid,$saveAgentid));
			if(count($agentuserlist)<=0 && $saveAgentid>0){			
				$DB->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",
				[$saveAgentid,$userid,$curtime]);
			}
			
			ReturnMsg('ok','绑定成功');
			$DB->CloseConnection();
		}
		
	}
	
?>