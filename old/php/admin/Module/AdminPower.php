<?php
namespace Module;	
header('Access-Control-Allow-Origin:*');
	
	class AdminPower{
		
		public function isUserPower($funName,$postDb){
			
			
			$userinfo = getUserInfo($postDb['amlkey']);
			$role = $userinfo['role'];
			
			$Db = new DB(DBHOST, DATABASE, DBUSER, DBPASS);			
			$resultpower = $Db->query("select * from xl_adminpower where funname = '".$funName."'");			
			$resultrole = $Db->query("select * from xl_adminrole where id = ".$role);
			
			$Db->CloseConnection();
			
			if(count($resultrole)<=0 || count($resultpower)<=0)
				return false;
			
			$powerstrid = $resultpower[0]['pid'];
			$powerstr = $resultrole[0]['powerid'];
			$powerstrArr = explode(',', $powerstr);
			
			
			if(in_array($powerstrid, $powerstrArr)){
				return true;
			}
			return false;		
			
		}
		
		//输出权限不足
		public function isUserPowerToClient($funName,$postDb){
			$isok = $this->isUserPower($funName,$postDb);
			if(!$isok){
				echo json_encode(array('error'=>'-1002'));
				return false;
			}
			return true;
		}
		
	}
?>