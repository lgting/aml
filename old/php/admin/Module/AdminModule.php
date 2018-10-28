<?php
	namespace Module;	
	header('Access-Control-Allow-Origin:*');
	use Redis;
	
	class AdminModule{
		
		//显示权利方法
		public function ShowAdminPower_fun(){
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$resultGroup = $DB->query("SELECT * from xl_adminpowergroup");
			$result = $DB->query("SELECT * from xl_adminpower");	
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['garr']=$resultGroup;
			$backArr['arr']=$result;
			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$DB->Closeconnection();
			
		}
		
		//查找用户对应的权限
		public function ShowAdminUserPower_fun($postDb){
			
			$userinfo = getUserInfo($postDb['amlkey']);
			if($postDb == null){
				ErrorSend(-1001);
				return null;
			}
			$role = $userinfo['role'];
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("SELECT * from xl_adminrolepower where role = ?",array($role));	
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']=$result;
			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$DB->Closeconnection();
			
		}
		
		//修改权限
		public function EditAdminUserPower_fun($postDb){
			
			$apower = new AdminPower();
			$isOk = $apower->isUserPowerToClient(__FUNCTION__,$postDb);
			if(!$isOk){
				return;
			}
			
			if(!isset($postDb['power'])){
				ErrorSend('power fail');
				return;
			}
			
			if(!isset($postDb['role'])){
				ErrorSend('role fail');
				return;
			}
			
			$cRole = $postDb['role'];
			$powerStr = $postDb['power'];			
			
			$userinfo = getUserInfo($postDb['amlkey']);
			if($postDb == null){
				ErrorSend(-1001);
				return null;
			}
			
			$role = $userinfo['role'];
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("update xl_adminrole set powerid = ? where id = ?",array($powerStr,$cRole));				
			$rarr = $DB->query("select * from xl_adminrole");
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']= $rarr;
			$json_objback = json_encode($backArr);
			echo $json_objback;
			
			$DB->Closeconnection();			
		}
		
		//查找所有管理员权限
		public function showAdminList_fun(){
			
			$Db = new DB(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $Db->query("SELECT * from adminuser");	
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']=$result;
			
			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$Db->Closeconnection();
		}
		
		//编辑管理员角色
		public function EditAdminRole_fun($postDb){
			
			$apower = new AdminPower();
			$isOk = $apower->isUserPowerToClient(__FUNCTION__,$postDb);
			if(!$isOk){
				return;
			}
			
			if(!isset($postDb['userid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['role'])){
				ErrorSend('role fail');
				return;
			}

			$uid = $postDb['userid'];
			$rid = $postDb['role'];
			
			$Db = new DB(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $Db->query("update adminuser set role = ? where id = ?",array($rid,$uid));	
			
			ErrorSend('ok');
			
			$Db->Closeconnection();	
		}
		
		//添加管理员
		public function AddAdmin_fun($postDb){
			$apower = new AdminPower();
			$isOk = $apower->isUserPowerToClient(__FUNCTION__,$postDb);
			if(!$isOk){
				return;
			}
			
			if(!isset($postDb['username'])){
				ErrorSend('username fail');
				return;
			}
			
			if(!isset($postDb['pwd'])){
				ErrorSend('pwd fail');
				return;
			}
			
			if(!isset($postDb['role'])){
				ErrorSend('role fail');
				return;
			}
			
			$username = $postDb['username'];
			$pwd = $postDb['pwd'];
			$role = $postDb['role'];
			
			$username = trim($username,"");
			$pwd = trim($pwd,"");
			
			if($username == null || $username == null){
				ErrorSend('-100');
				return;
			}
			
			if($pwd == null || $pwd == null){
				ErrorSend('-101');
				return;
			}
			
			$pwd = md5($pwd);
			
			$Db = new DB(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $Db->query("insert into adminuser(username,userpwd,role,createTime) values(?,?,?,?)",array($username,$pwd,$role,time()));
			
			if($result>0){
				ErrorSend('ok');
			}
			else{
				ErrorSend('update fail');
			}
			
			$Db->Closeconnection();
			
		}
		
		//添加管理员角色
		public function addAdminRole_fun($postDb){
			$apower = new AdminPower();
			$isOk = $apower->isUserPowerToClient(__FUNCTION__,$postDb);
			if(!$isOk){
				return;
			}
			
			if(!isset($postDb['rolename'])){
				ErrorSend('rolename fail');
				return;
			}

			$rolename = $postDb['rolename'];
			$rolename = trim($rolename,"");
			//用户名不能为空
			if($rolename == null || $rolename == ""){
				ErrorSend('-100');
				return;
				
			}
			
			$Db = new DB(DBHOST, DATABASE, DBUSER, DBPASS);			
			$userresult = $Db->query("select * from xl_adminrole where rolename = ?",array($rolename));
			
			if(count($userresult)>0){
				ErrorSend('-101');
				return;
			}
			
			$result = $Db->query("insert into xl_adminrole(rolename) values(?)",array($rolename));
			$lastId = $Db->lastInsertId();
			$rarr = $Db->query("select * from xl_adminrole");
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr'] = $rarr;
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$Db->Closeconnection();
		}
		
		//删除管理员角色
		public function deleteAdmin_fun($postDb){
			$apower = new AdminPower();
			$isOk = $apower->isUserPowerToClient(__FUNCTION__,$postDb);
			if(!$isOk){
				return;
			}
			
			if(!isset($postDb['role'])){
				ErrorSend('role fail');
				return;
			}
			
			$role = $postDb['role'];
			$Db = new DB(DBHOST, DATABASE, DBUSER, DBPASS);			
			$Db->query("delete from xl_adminrole where id = ?",array($role));
			
			$rarr = $Db->query("select * from xl_adminrole");
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr'] = $rarr;
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$Db->Closeconnection();
		}
	}
?>