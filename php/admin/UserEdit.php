<?php
header('Access-Control-Allow-Origin:*');
require("../tool/config.php");
require("../tool/util.php");
require_once("include.php");
use Module\AdminPower;
use Module\DB;;

if(isset($_POST['type'])){
	$gettype = $_POST['type'];
	switch($gettype){
		case 'editAdmin':
			EditAdmin();
			break;
		case 'userlist':
			getUserList();
			break;
		case 'select':
			selectUser();
			break;
		case 'sellerlist':
			sellerList();
			break;
		case 'offlinelist':
			offlinelist();
			break;
		case 'login':
			login();
			break;
		case 'transferUser':
			transferUser();
			break;
		case 'uselist':
			useList();
		break;
		case 'uselistMsg':
			uselistMsg();
		break;
		case 'selectuselist':
			selectuselist();
		break;
		case 'getuserinfo':
			GetUserInfoById();
		break;
	}
}

	function EditAdmin(){
		if(!IsAuthority())
			return;
		
		$apower = new AdminPower();
		$isOk = $apower->isUserPowerToClient(__FUNCTION__,$_POST);
		if(!$isOk){
			return;
		}
		
		if(!isset($_POST['userid'])){
			ErrorSend('not userid');
			exit();
		}
		else if(!isset($_POST['adminid'])){
			ErrorSend('not adminid');
			exit();
		}
		else if(!isset($_POST['role'])){
			ErrorSend('not role');
			exit();
		}
		else if(!isset($_POST['issystem'])){
			ErrorSend('not issystem');
			exit();
		}
		else if(!isset($_POST['agentid'])){
			ErrorSend('not agentid');
			exit();
		}
		else if(!isset($_POST['remarks'])){
			ErrorSend('not remarks');
			exit();
		}
		
		
		$userid = $_POST['userid'];
		$adminid = $_POST['adminid'];
		$role = $_POST['role'];
		$issystem = $_POST['issystem'];
		$remarks = $_POST['remarks'];
		$agentid = $_POST['agentid'];
		
		if(!is_numeric($userid)){
			ErrorSend('userid is number');
			exit();
		}
		else if(!is_numeric($adminid)){
			ErrorSend('adminid is number');
			exit();
		}
		else if(!is_numeric($role)){
			ErrorSend('role is number');
			exit();
		}
		
		if(($role>User && $role<Agent) && $agentid<=0){
			ErrorSend('请选择代理商');
			exit();
		}
		
		if($role == Beauties){
			ErrorSend('美体师要先绑定商家');
			exit();
		}
		
		//用户绑定了商户。如果升级成其他角色咋处理
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);	
		$userinfo = $DB->query("select role from xl_userinfo where userid = ?",array($userid));
		if(count($userinfo)<=0){
			ErrorSend('user is null');
			exit();
		}
		
		$urole = $userinfo[0]['role'];
		/*if($role !=Agent && $urole != $role){
			ErrorSend('-100');
			$DB->Closeconnection();
			exit();
		}*/
		
		$userresult = $DB->query("select * from xl_clientslist where belongto = ?",array($userid));
		if(count($userresult)>0 && $urole != $role){
			ErrorSend('-101');
			$DB->Closeconnection();
			exit();
		}

		
		if($issystem=="true"){
			$issystem = 1;
		}
		else{
			$issystem = 0;
		}
		
		//修改角色
		$DB->query("update xl_userinfo set role = ?,issystem=?,remarks=? where userid=?",array($role,$issystem,$remarks,$userid));
		//如果是从上级降到下级那么砍掉与原来上级的关系(比如从业务员变成了客户。那么砍掉业务员和代理商的关系)
		//$sql1 = "delete from xl_clientslist where clientid = ".$userid;
		//$sql2 = "delete from xl_agentuser where userid = ".$userid;
		
		//echo 'sql1='.$sql1.'=sql2='.$sql2;
		
		$DB->query("delete from xl_clientslist where clientid = ".$userid);
		$DB->query("delete from xl_agentuser where userid = ".$userid);
		
		//if($agentid>0){
		if($role>User && $role<Beauties){
			$DB->query("insert into xl_clientslist(clientid,belongto,conndate,agentid)values(?,?,?,?)",[$userid,$agentid,time(),$agentid]);
			$agentresult = $DB->query("select * from xl_agentuser where userid = ? and aid=?",array($userid,$agentid));
			if(count($agentresult)<=0){
				$DB->query("insert into xl_agentuser(aid,userid,conndate) values(?,?,?)",array($agentid,$userid,time()));
			}
		}
		
		
		$logs = '设置管理员-'.$userid.'-'.GetUserRole($role);
		$DB->query("insert into xl_uselog (useid,usemsg,usetm)values(?,?,?)",array($adminid,$logs,time()));
		$DB->Closeconnection();	
		ErrorSend('ok');
		
	}
	
	//获得用户列表
	function getUserList(){
		if(!IsAuthority())
			return;
		
		if(!isset($_POST['page'])){
			ErrorSend('not page');
			exit();
		}
		
		if(!isset($_POST['roletype'])){
			ErrorSend('not roletype');
			exit();
		}
		
		getUserList_hander($_POST['page'],$_POST['roletype']);
	}
	
	function getUserList_hander($pages,$roles){
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$endPage = 10;
		$startPage = $pages*$endPage;
		
		$result = [];
		if($roles == 0){
			$result = $DB->query("select * from xl_userinfo where phone<>'' limit ?,?",array($startPage,$endPage));
			$maxResult = $DB->query("select count(userid) from xl_userinfo where phone<>''");
		
		}
		else{
			$result = $DB->query("select * from xl_userinfo where role = ? and phone<>'' limit ?,?",array($roles,$startPage,$endPage));
			$maxResult = $DB->query("select count(userid) from xl_userinfo where role = ? and phone<>''",array($roles));
		
		}
		
		
		/*$agentNameArr = array();
		$uid = 0;
		foreach($result as $key=>$value){
			$uid = $value['userid'];
			$result[$key]['sname'] = '';
			$result[$key]['aid'] = 0;
			if($uid > 0){
				array_push($agentNameArr,$uid);
			}
		}
		
		$agentArrStr = '';
		if(count($agentNameArr)>0){
			$agentArrStr = implode(',',$agentNameArr);
			$agentArrStr = '('.$agentArrStr.')';
			$aResult = $DB->query("select username,userid from xl_userinfo where userid in (select aid from xl_userinfo,xl_agentuser 
				where xl_userinfo.userid = xl_agentuser.userid and xl_userinfo.userid in  ".$agentArrStr.")");
			
			$agentKeyArr = array();

			foreach($aResult as $key=>$value){
				$uid = $value['userid'];
				$agentKeyArr[$uid] = [$value['username'],$value['userid']];
			}
			
			foreach($result as $key=>$value){
				$uid = $value['userid'];
				if(isset($agentKeyArr[$uid])){
					$result[$key]['sname'] = $agentKeyArr[$uid];
					$result[$key]['aid'] = $agentKeyArr[$uid];
				}
			}		
		}*/
		
		
		
		$backresult = array();
		$backresult['error']='ok';
		$backresult['arr'] = $result;
		$backresult['pageMax'] = $maxResult[0]['count(userid)'];
		$DB->Closeconnection();
		$json_objback = json_encode($backresult,JSON_UNESCAPED_UNICODE);
		echo $json_objback;
	}
	
	function selectUser(){
		if(!isset($_POST['msg'])){
			ErrorSend('not msg');
			exit();
		}
		
		if(!isset($_POST['roletype'])){
			ErrorSend('not roletype');
			exit();
		}
		
		$curRole = $_POST['roletype'];
		
		$selectMsg = $_POST['msg'];
		if($selectMsg=='' || $selectMsg == null)
		{
			getUserList_hander(0,$curRole);
			exit();
		}
		
		$backresult = array();
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		if($curRole == 0){
			$result = $DB->query("select * from xl_userinfo where userid = ?",array($selectMsg));
		}
		else{
			$result = $DB->query("select * from xl_userinfo where userid = ? and role = ?",array($selectMsg,$curRole));
		}
		
		GetRoleArr($result,$DB);
		
		if($curRole == 0){
			$result = $DB->query("select * from xl_userinfo where username like '%".$selectMsg."%'");
		}
		else{
			$result = $DB->query("select * from xl_userinfo where username like '%".$selectMsg."%' and role = ?",array($curRole));
		}
		
		GetRoleArr($result,$DB);
		
		
		if($curRole == 0){
			$result = $DB->query("select * from xl_userinfo where phone like '%".$selectMsg."%'");
		}
		else{
			$result = $DB->query("select * from xl_userinfo where phone like '%".$selectMsg."%' and role = ?",array($curRole));
		}
		GetRoleArr($result,$DB);
		
		
		$DB->Closeconnection();
		ErrorSend('not find'.$_POST['msg']);
		exit();
	}
	
	function offlinelist(){
		if(!IsAuthority())
			return;
		
		if(!isset($_POST['userid'])){
			ErrorSend('not userid');
			exit();
		}
		
		if(!isset($_POST['page'])){
			ErrorSend('not page');
			exit();
		}
		
		$pages = $_POST['page'];
		$endPage = 10;
		$startPage = $pages*$endPage;
		
		$userid = $_POST['userid'];
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$result = $DB->query("select xl_clientslist.*,username,phone,role,accounts,sex,userid from xl_clientslist,xl_userinfo where belongto = ? and clientid = userid limit ?,?",array($userid,$startPage,$endPage));
		$Countresult = $DB->query("select count(listid) from xl_clientslist where belongto = ?",array($userid));
		
		$backresult['error']='ok';
		$backresult['arr'] = $result;
		$backresult['pageMax'] = $Countresult[0]['count(listid)'];
		$json_objback = json_encode($backresult);
		echo $json_objback;
		$DB->Closeconnection();
	}
	
	function login(){
		if(!isset($_POST['uname'])){
			ErrorSend('not uname');
			exit();
		}
		
		if(!isset($_POST['pwd'])){
			ErrorSend('not pwd');
			exit();
		}
		
		$pwd = $_POST['pwd'];
		$pwd = md5($pwd);
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$result = $DB->query("select * from adminUser where username = ? and userpwd = ?",array($_POST['uname'],$pwd));
		if(count($result)>0){
			
			$UseKey = time().rand(100,10000).$result[0]['id'];
			$redis_ocean = new Redis();
		    $redis_ocean->connect(RedISHost, RedISPORT);	

			//存储userid 和角色
			$redis_ocean->setex($UseKey, 60*60*2, $result[0]['id']);
			$redis_ocean->setex($UseKey.'role', 60*60*2, $result[0]['role']);
			
			$resultGroup = $DB->query("SELECT * from xl_adminpowergroup");
			$resultp = $DB->query("SELECT * from xl_adminpower");	
			$roleResult = $DB->query("SELECT * from xl_adminrole");
			
			$backresult = array();
			$backresult['error']='ok';
			$backresult['key'] = $UseKey;
			$backresult['garr'] = $resultGroup;
			$backresult['arr'] = $resultp;
			$backresult['uarr'] = $result;
			$backresult['rarr'] = $roleResult;
			
			echo json_encode($backresult);
			$DB->Closeconnection();
			
			return;
		}
		
		ErrorSend('-101');
	}
	
	//通过角色获得数据
	function GetRoleArr($result,$DB){
		if(count($result)>0){
			$backresult['error']='ok';
			$backresult['arr'] = $result;
			$backresult['pageMax'] = count($result);
			$json_objback = json_encode($backresult);
			echo $json_objback;
			$DB->Closeconnection();
			exit();
		}
	}
	
	function GetUserRole($role){
		switch($role){
			case User:
				return '客户';
			break;
			case Boss:
				return '商户';
			break;
			case SAlESMAN:
				return '业务员';
			break;
			case HelpSAlESMAN:
				return '美导';
			break;
			case Agent:
				return '代理商';
			break;
			case Beauties:
				return '美体师';
		}
		return '';
	}
	
	//转移用户
	function transferUser(){		
		if(!IsAuthority())
			return;
		
		$apower = new AdminPower();
		$isOk = $apower->isUserPowerToClient(__FUNCTION__,$_POST);
		if(!$isOk){
			return;
		}
		
		if(!isset($_POST['uid'])){
			ErrorSend('not uid');
			exit();
		}
		
		if(!isset($_POST['tuid'])){
			ErrorSend('not tuid');
			exit();
		}
		
		//用户编号
		$uid = $_POST['uid'];
		//转移给用户编号
		$tuid = $_POST['tuid'];
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$uresult = $DB->query("select role,issystem from xl_userinfo where userid=?",array($uid));
		$turesult = $DB->query("select role,issystem from xl_userinfo where userid=?",array($tuid));
		
		$urole = $uresult[0]['role'];
		$turole = $turesult[0]['role'];
		
		$tuissystem = $turesult[0]['issystem'];
		
		/*if($urole!=Agent){
			//非代理商不转移
			ErrorSend('-104');
			return;
		}*/
		
		
		if($urole<=1 || $turole<=1){
			//用户直接不可以转换
			ErrorSend('-100');
			return;
		}
		
		if($urole != $turole){
			//用户类型不对称
			ErrorSend('-101');
			return;
		}
		
		if($tuissystem != 1){
			//转移方不是系统用户
			ErrorSend('-102');
			return;
		}
		

		$unum = $DB->query("update xl_clientslist set belongto = ? where belongto = ?",array($tuid,$uid));	
		if($urole==Agent){
			 $DB->query("update xl_clientslist set agentid = ? where agentid = ?",array($tuid,$uid));
			 $DB->query("update xl_agentuser set aid = ? where aid = ?",array($tuid,$uid));
		}
		
		ErrorSend('ok');
	}
	
	function useListFun($page){
		
		$startpage = $page * 10;
		$endpage = 10;
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$uresult = $DB->query("select xl_goodsuse.*,xl_goods.gname from xl_goodsuse,xl_goods where  xl_goodsuse.goodsid = xl_goods.id order by usetime desc limit ?,?",
		array($startpage,$endpage));
		
		$Countresult = $DB->query("select count(ids) from xl_goodsuse");
		
		$ulens = count($uresult);
		$uarr = array();
		for($i=0;$i<$ulens;$i++){
			
			$bossid = $uresult[$i]["bossid"];
			$userid = $uresult[$i]["userid"];
			
			
			if(!in_array($bossid,$uarr)){
				array_push($uarr,$bossid);
			}
			
			if(!in_array($userid,$uarr)){
				array_push($uarr,$userid);
			}			
		}
		
		if(count($uarr)<=0){
			$backresult['error']='ok';
			$backresult['arr'] = [];
			$backresult['pageMax'] = 0;
			$json_objback = json_encode($backresult);
			echo $json_objback;
			$DB->Closeconnection();
			exit();
		}
		
		$userstr = implode(",",$uarr);
		
		$userarr = $DB->query("select userid,username from xl_userinfo where userid in (".$userstr.")");
		
		$userNameCount = count($userarr);
		$userNameArr = array();
		for($i=0;$i<$userNameCount;$i++){
			$userNameArr[$userarr[$i]['userid']] = $userarr[$i]['username'];
		}
		
		for($i=0;$i<$ulens;$i++){
			
			$bossid = $uresult[$i]["bossid"];
			$userid = $uresult[$i]["userid"];
			
			$uresult[$i]["bossname"] = $userNameArr[$bossid];
			$uresult[$i]["username"] = $userNameArr[$userid];
		}
		
		
		$backresult['error']='ok';
		$backresult['arr'] = $uresult;
		$backresult['pageMax'] = $Countresult[0]['count(ids)'];
		$json_objback = json_encode($backresult);
		echo $json_objback;
		$DB->Closeconnection();
		
	}
	
	//使用记录
	function useList(){
		if(!IsAuthority())
			return;
		
		if(!isset($_POST['page'])){
			ErrorSend('not page');
			exit();
		}
		
		$page = $_POST['page'];
		
		useListFun($page);

	}
	
	//用户交易分成详情
	function uselistMsg(){
		if(!IsAuthority())
			return;
		
		if(!isset($_POST['useid'])){
			ErrorSend('not useid');
			exit();
		}
		
		$useid = $_POST['useid'];
		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$uresult = $DB->query("select xl_goodsusemsg.*,xl_userinfo.username,phone from xl_goodsusemsg,xl_userinfo where xl_goodsusemsg.userid = xl_userinfo.userid and useid = ? "
		,array($useid));
		
		$backresult['error']='ok';
		$backresult['arr'] = $uresult;
		$json_objback = json_encode($backresult);
		echo $json_objback;
		$DB->Closeconnection();
	}
	
	//收支明细查询
	function selectuselist(){
		if(!IsAuthority())
			return;
			
		$selectmsg = $_POST['select'];
		
		if($selectmsg == null || $selectmsg == ""){
			useListFun(0);
			return;
		}

		
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$uresult = $DB->query("select userid,username from xl_userinfo where (xl_userinfo.username like ? or phone like ?) ",
		array('%'.$selectmsg.'%','%'.$selectmsg.'%'));
		
		
		$rarrs = array();
		$uresultNum = count($uresult);
		for($i=0;$i<$uresultNum;$i++){
			array_push($rarrs,$uresult[$i]["userid"]);
		}
		
		$rarrStr = implode(',',$rarrs);
		if($rarrStr == null || $rarrStr == ""){
			$backresult['error']='ok';
			$backresult['arr'] = array();
			$backresult['pageMax'] = 0;
			$json_objback = json_encode($backresult);
			echo $json_objback;
			$DB->Closeconnection();
			return;
		}
		
		$rarrStr = "(".$rarrStr.")";
		
		$useArr = $DB->query("select xl_goodsuse.*,xl_goods.gname from xl_goodsuse,xl_goods where xl_goodsuse.goodsid = xl_goods.id and 
		(bossid in ".$rarrStr." or userid in ".$rarrStr.") order by usetime limit 0,100");
		
		$ulens = count($useArr);
		
		if($ulens<=0){
			$backresult['error']='ok';
			$backresult['arr'] = array();
			$backresult['pageMax'] = 0;
			$json_objback = json_encode($backresult);
			echo $json_objback;
			$DB->Closeconnection();
			return;
		}
		
		$uarr = array();
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
		
		$userarr = $DB->query("select userid,username from xl_userinfo where userid in (".$userstr.")");
		
		$userNameCount = count($userarr);
		$userNameArr = array();
		for($i=0;$i<$userNameCount;$i++){
			$userNameArr[$userarr[$i]['userid']] = $userarr[$i]['username'];
		}
		
		for($i=0;$i<$ulens;$i++){
			
			$bossid = $useArr[$i]["bossid"];
			$userid = $useArr[$i]["userid"];
			
			$useArr[$i]["bossname"] = $userNameArr[$bossid];
			$useArr[$i]["username"] = $userNameArr[$userid];
		}
		
		$backresult['error']='ok';
		$backresult['arr'] = $useArr;
		$backresult['pageMax'] = 1;
		$json_objback = json_encode($backresult);
		echo $json_objback;
		$DB->Closeconnection();
		
	}
	
	//获得用户信息
	function GetUserInfoById(){
		if(!isset($_POST['userid'])){
			ErrorSend('not userid');
			exit();
		}
		
		$userid = $_POST['userid'];
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$uresult = $DB->query("select username,userid from xl_userinfo where userid = (select aid from xl_agentuser where userid = ?)",[$userid]);
		
		echo json_encode(['error'=>'ok','arr'=>$uresult]);
		$DB->Closeconnection();
	}
	
	
?>