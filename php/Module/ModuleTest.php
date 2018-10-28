<?php
	namespace Module;
	use Module\DB;
	require("DB.php");

	class ModuleTest{
    	public static function TestFun($status){
			return "abcdefg";
		}
		
		public function okFun(){
			$db = new DB(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $db->query("select xl_clientslist.*,role,username,phone from xl_clientslist,xl_userinfo where userid = clientid and belongto =? and role = ?",array(21,3));
			var_dump($result);			
		}
	}

?>