<?php
	
	namespace Module;	
	header('Access-Control-Allow-Origin:*');
	
	class UserModule{
		//用户扫码代理商申请成为业务员的操作
    	public function ApplySellman($postDb){
    		//   		
    		if(!isset($postDb['aid'])){
				ErrorSend('aid fail');
				return;
			}
			
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['atp'])){
				ErrorSend('atp fail');
				return;
			}
			
			$aid = $postDb["aid"];
			$uid = $postDb["uid"];
			$atp = $postDb["atp"];
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			//查看当前角色
			$uroleResult = $db->query("select role from xl_userinfo where userid = ?",array($uid));
			
			$aroleResult = $db->query("select role from xl_userinfo where userid = ?",array($aid));
			
			if(count($uroleResult)<=0 || count($aroleResult)<=0){
				ErrorSend('user not find');
				return;
			}
			
			$urole = $uroleResult[0]["role"];
			$arole = $aroleResult[0]["role"];
			
			//检查两个角色的正确性
			if($urole != User){
				ErrorSend('user role isuser');
				$db->Closeconnection();
				return;
			}
			
			if($arole != Agent){
				ErrorSend('user role isAgent');
				$db->Closeconnection();
				return;
			}
			
			//查看是否申请了。
			$applyList = $db->query("select * from xl_applylist where applyuid=? and applytouid=?",array($uid,$aid));
			if(count($applyList)>0){
				//已经申请过这个代理商
				ErrorSend('-100');
				$db->Closeconnection();
				return;
			}
			
			$db->query("insert into xl_applylist(applyuid,applytouid,applytime,applytype)values(?,?,?,?)",array($uid,$aid,time(),$atp));
    		ErrorSend('ok');
    		$db->Closeconnection();
    	}
    	
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
			$result = $db->query("select userid,xl_clientslist.conndate,headimgurl,role,username,phone from xl_clientslist,xl_userinfo where userid = clientid and belongto =? and role = ? order by conndate limit ?,?",array($aid,$roletp,$startPage,$endPage));
			
			$resultMsg = array('error'=>'ok');	
			$resultMsg['arr'] = $result;
			echo json_encode($resultMsg);
			$db->Closeconnection();
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
		 from xl_clientslist,xl_userinfo where userid = belongto and clientid =?",array($userid));
			
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
			$result = $db->query("select userid,role,username,phone,headimgurl from xl_userinfo where phone=?",array($phone));
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
			$back = null;
			
			
			if($role == 0){
				$upresult = $db->query("select xl_clientslist.conndate,clientid,belongto,headimgurl,role,username,phone
			 from xl_clientslist,xl_userinfo where userid = belongto and clientid =?",array($userid));
				
				$userNum = count($upresult);
				$back = array();
				for($i = 0;$i<$userNum;$i++){
					array_push($back,
					array('belongto'=>$upresult[$i]['belongto'],
					'belongtoname'=>$upresult[$i]['username'],
					'role'=>$upresult[$i]['role'],));
				}
				
				$result[0]['uplist'] = $back;
				$resultMsg = array('error'=>'ok');	
				$resultMsg['arr'] = $result;
				echo json_encode($resultMsg);
				$db->Closeconnection();
				return;
			}
			else{
				if($userRole == User){
					$back = $this->AgentUser($userid,$aid,$db);
				}
				else if($userRole == Boss){
					$back = $this->AgentBoss($userid,$aid,$db);
				}
				else if($userRole == SAlESMAN){
					$back = $this->AgentSales($userid,$aid,$db);
				}
				else if($userRole == HelpSAlESMAN){
					$back = $this->AgentSales($userid,$aid,$db);
				}
			}
			
			if($back == null){
				ErrorSend('-102');
				$db->CloseConnection();
				return;
			}

			$result[0]['uplist'] = $back;
			$resultMsg = array('error'=>'ok');	
			$resultMsg['arr'] = $result;
			echo json_encode($resultMsg);
			$db->Closeconnection();
    	}
    	
		
		//判断用法是否在对应的代理商下面
		//$userid 用户编号
		//$aid 代理商用户编号
		public function AgentUser($userid,$aid,$db){
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
		}
		
		public function AgentBoss($userid,$aid,$db){
			
			$salesResult = $db->query("select xl_clientslist.conndate,clientid,belongto,headimgurl,role,username,phone
		 from xl_clientslist,xl_userinfo where userid = belongto and clientid =?",array($userid));
		 		
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
				for($i = 0;$i<$salesResultNum;$i++){
					array_push($uparr,
					array('belongto'=>$salesResult[$i]['belongto'],
					'belongtoname'=>$salesResult[$i]['username'],
					'role'=>$salesResult[$i]['role']));
				}
				
				return $uparr;
		}
		
		
		public function AgentSales($userid,$aid,$db){
			
			$upresult = $db->query("select xl_clientslist.conndate,clientid,belongto,headimgurl,role,username,phone
 			from xl_clientslist,xl_userinfo where userid = belongto and clientid =?",array($userid));
			
			$upNum = count($upresult);
			
			//当前代理商下没有该用户
			if($upNum<=0){
				return null;
			}
			
			$upobjs = null;			
			for($i=0;$i<$upNum;$i++){
				if($upresult[$i]['belongto'] == $aid){
					$upobjs = $upresult[$i];
					break;
				}
			}
			
			//当前代理商下没有该用户
			if($upobjs == null){
				return null;
			}
			
			$uparr = array();
			for($i = 0;$i<$upNum;$i++){
				array_push($uparr,
				array('belongto'=>$upresult[$i]['belongto'],
				'belongtoname'=>$upresult[$i]['username'],
				'role'=>$upresult[$i]['role']));
			}
			return $uparr;			
		}
		
    	
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
			$result = $db->query("SELECT userid,clientid,username,phone,headimgurl,conndate,belongto,role FROM xl_clientslist,xl_userinfo WHERE 
			belongto in( select clientid from xl_clientslist where belongto = ?) 
			and xl_userinfo.userid = xl_clientslist.clientid and xl_userinfo.role=2 
			ORDER BY conndate DESC limit ?,?",array($aid,$startPage,$endPage));
			
			//2.拿到所有代理商下面的美导
			$aresult = $db->query("select xl_clientslist.conndate,clientid,headimgurl,role,username,phone
			 from xl_clientslist,xl_userinfo where userid = clientid and belongto =? and role = ?",array($aid,4));
			 
			
			
			$rcount = count($result);
			$acount = count($aresult);
			
			$rbelongto = 0;
			$abelongto = 0;
			$oldids = 0;
			
			$deleteArr = array();
			
			$similarityArr = array();
			
			for($i=0;$i<$rcount;$i++){
				$rbelongto = $result[$i]["belongto"];
				
				if($oldids != $result[$i]["clientid"]){
					$oldids = $result[$i]["clientid"];	
				}
				else{
					array_push($similarityArr,$oldids);
				}
				
				$result[$i]["belongtoname"] = "";
				for($j=0;$j<$acount;$j++){
					$abelongto = $aresult[$j]["clientid"];
					if($rbelongto == $abelongto){
						$result[$i]["belongtoname"] = $aresult[$j]["username"];
						break;
					}
				}
			}
			
			//echo '..$rclientid.='.count($similarityArr);
			if(count($similarityArr)>0){
				
				//3.拿到所有代理商下面的业务(如果有重复的商家提出业务这条记录)
				$sresult = $db->query("select xl_clientslist.conndate,clientid,headimgurl,role,username,phone
				from xl_clientslist,xl_userinfo where userid = clientid and belongto =? and role = ?",array($aid,3));
				
				$scount = count($sresult);
				
				for($i=0;$i<$rcount;$i++){
					$rbelongto = $result[$i]["belongto"];
					$rclientid = $result[$i]["clientid"];
					/*echo '..$rclientid='.$rclientid;
					if(!in_array($rclientid,$similarityArr)){
						continue;
					}*/
					
					for($j=0;$j<$scount;$j++){
					//$sbelongto = $sresult[$j]["clientid"];
					//	if($rbelongto == $sbelongto){
					$sbclientid = $sresult[$j]["clientid"];
					
						if($sbclientid == $rclientid){
							
							unset($result[$i]);
							$i--;
							$rcount--;
							break;
						}					
					}				
				}
			}
			
			
			
			$resultMsg = array('error'=>'ok');	
			$resultMsg['arr'] = $result;
			echo json_encode($resultMsg);
			
			$db->Closeconnection();
    	}
    	
    	//商户和美导绑定关系
    	public function BossToHelpManConn($postDb){
    		if(!isset($postDb['bid'])){
				ErrorSend('bid fail');
				return;
			}
			
			if(!isset($postDb['hid'])){
				ErrorSend('hid fail');
				return;
			}
			
			$bid = $postDb['bid'];
			$hid = $postDb['hid'];
			
			//查看商户是否是商户
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
    		$bresult = $db->query("SELECT username,role FROM xl_userinfo where userid=?",array($bid));
			if(count($bresult)<=0 || $bresult[0]['role'] != Boss){
				ErrorSend('-100');
				$db->Closeconnection();
				return;
			}
			
			//查看美导是否是美导
			$hresult = $db->query("SELECT username,role FROM xl_userinfo where userid=?",array($hid));
			if(count($hresult)<=0 || $hresult[0]['role'] != HelpSAlESMAN){
				ErrorSend('-101');
				$db->Closeconnection();
				return;
			}
			
			//查看商户是否绑定的美导
			$alls = $db->query("SELECT username,role,conndate FROM xl_clientslist,xl_userinfo WHERE belongto in( select belongto from xl_clientslist where clientid = ?) 
				and xl_userinfo.userid = xl_clientslist.belongto",array($bid));
    		
    		$allNum = count($alls);
    		
    		for($i=0;$i<$allNum;$i++){
    			if($alls[$i]["role"]==HelpSAlESMAN){
    				ErrorSend('-102');
    				$db->Closeconnection();
					return;
    			}
    		}
			
			$agentlist = $DB->query("select * from xl_clientslist where clientid = ?",array($hid));
			$agentid = 0;
			if(count($agentlist)>0){
				$agentid = $agentlist[0]['agentid'];
			}
			
			//说明没有确定关系
			$addCount = $db->query("insert into xl_clientslist(clientid,belongto,conndate,agentid)values(?,?,?,?)",array($bid,$hid,time(),$agentid));
			
			//存储代理商用户信息
			$agentuserlist = $DB->query("select id from xl_agentuser where userid = ?",array($bid));
			if(count($agentuserlist)<=0){
				$DB->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array($agentid,$bid,time()));
			}
			
    		
			if($addCount>0){
    			ErrorSend("ok");	
    		}
    		else{
    			ErrorSend("fail");
    		}
    		
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
    			$db->query("update xl_userinfo set role = ? where userid=?",array($roles,$uid));
				
				//存储代理商用户信息
				$agentuserlist = $DB->query("select id from xl_agentuser where userid = ?",array($uid));
				if(count($agentuserlist)<=0){
					$DB->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array($aid,$uid,time()));
				}
				
    			ErrorSend("ok");	
    		}
    		else{
    			ErrorSend("fail");
    		}
    		
			$db->Closeconnection();
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
	}
	
	
	
	
	
	
	
	
	
	
	
?>