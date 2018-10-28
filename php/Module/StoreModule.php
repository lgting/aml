<?php
namespace Module;	
header('Access-Control-Allow-Origin:*');


class StoreModule{
	
	//查询美体师列表
	public function showBeautiesList($postDb){
		
		
		if(!isset($postDb['bid'])){
			ReturnMsg('-1','商户信息错误');
		}
		
		
		if(!isset($postDb['page'])){
			ErrorSend('page fail');
			return;
		}
		
		$bid = $postDb['bid'];
		$page = $postDb['page'];
		
		$endPage = 30;
		$startPage = $page*$endPage;
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("select beautiesid,xl_store_beauties.addtime,headimgurl,role,username,phone from xl_store_beauties,xl_userinfo 
		where beautiesid = xl_userinfo.userid and bossid = ? order by xl_store_beauties.id desc limit ?,?",array($bid,$startPage,$endPage));
		
		$resultMsg = array('error'=>'ok');	
		$resultMsg['arr'] = $result;
		exit(json_encode($resultMsg));
		$db->Closeconnection();		
	}
	
	//添加美体师
	public function AddBeauties($postDb){
		if(!isset($postDb['bid'])){
			ReturnMsg('-1','商户信息错误');
		}

		if(!isset($postDb['uid'])){
			ReturnMsg('-1','用户信息错误');
		}
		
		$bossid = $postDb['bid'];
		$beautiesid = $postDb['uid'];
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		$result = $db->query("select id from xl_store_beauties where bossid = ? and beautiesid = ?",[$bossid,$beautiesid]);
		if(count($result)>0){
			ReturnMsg('-1','您已经绑定过该美体师');
		}
		
		$bossRes = $db->query("select userid,role from xl_userinfo where userid = ?",[$bossid]);
		
		if(count($bossRes)<=0 || $bossRes[0]['role']!=Boss){
			ReturnMsg('-1','商户信息错误.');
		}
		
		$userRes = $db->query("select userid,role from xl_userinfo where userid = ?",[$beautiesid]);
		if(count($userRes)<=0 || $userRes[0]['role']!=User){
			ReturnMsg('-1','用户信息错误.');
		}
		
		$curtime = time();
		$result = $db->query("insert into xl_store_beauties (bossid,beautiesid,addtime) values (?,?,?)",[$bossid,$beautiesid,$curtime]);
		
		$Beauties = Beauties;
		
		$db->query("update xl_userinfo set role = $Beauties where userid = $beautiesid");
		$db->Closeconnection();
		ReturnMsg('ok','添加美体师信息成功');
	}
	
	//删除美体师
	public function delBeauties($postDb){
		
		if(!isset($postDb['bid'])){
			ReturnMsg('fail','商户信息错误');
		}

		if(!isset($postDb['uid'])){
			ReturnMsg('fail','用户信息错误');
		}
		
		
		$bossid = $postDb['bid'];
		$beautiesid = $postDb['uid'];	
		
		if(!is_numeric($bossid)){
			ReturnMsg('-1','商户信息错误');
		}
		
		if(!is_numeric($beautiesid)){
			ReturnMsg('-1','用户信息错误');
		}
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $db->query("delete from xl_store_beauties where bossid = $bossid and beautiesid = $beautiesid");
		
		$User = User;
		
		$beautiesres = $db->query("select * from xl_store_beauties where beautiesid = $beautiesid");
		if(count($beautiesres)<=0){
			$db->query("update xl_userinfo set role = $User where userid = $beautiesid");
		}
		
		$db->Closeconnection();
		
		ReturnMsg('ok','删除成功!');
	}
	
	public function FindUserByPhone($postDb){
		if(!isset($postDb['phone'])){
			ReturnMsg('-1','电话号码错误');
		}			
		
		$phone = $postDb['phone'];
		$bid = 0;
		if(isset($postDb['bid'])){
			$bid = $postDb['bid'];
		}	
		
		if($phone == "" || $phone == null){
			ReturnMsg('-2','电话号码错误');
		}
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$upresult = [];
		$result = $db->query("select userid,role,username,phone,headimgurl from xl_userinfo where phone=?",array($phone));
		
		//没有这个用户
		if(count($result)<=0){
			$db->CloseConnection();
			ReturnMsg('-3','抱歉.没有找到这个用户!');
		}
		
		$userid = $result[0]["userid"];
		
		if($bid>0){
			$upresult = $db->query("select * from xl_store_beauties where beautiesid = ? and bossid=?",array($userid,$bid));
		}
		else{
			$upresult = $db->query("select * from xl_store_beauties where beautiesid = ? limit 5",[$userid]);
		}
		
		if($bid>0 && count($upresult)<=0){
			$db->Closeconnection();	
			ReturnMsg('-4','抱歉.没有找到这个美体师!');
		}
		
		
		ReturnMsg('ok','',['result'=>$result,'uparr'=>$upresult]);
	}


	public function addOldStore($postDb){
		
		/*$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$upresult = [];
		$result = $db->query("select * from xl_userinfo where role = 2");
		
		$ids = 1;
		foreach($result as $k=>$v){
			$userid = $v['userid'];
			$username = '';
			$skey = '0'.rand(1000, 9999).($ids*3).rand(1, 99);
			
			$db->query("insert into xl_store(bossid,storekey,storename) values(?,?,?)",[$userid,$skey,'']);
			$ids+=1;
		}	
		$create_unique = '0'.rand(1000, 9999).(1*3).rand(1, 99);
		ReturnMsg('ok','',$create_unique);*/
	}
	
	
	//按照编号或者店铺名字查询
	public function selectStore($postDb){
		
		if(!isset($postDb['select'])){
			ReturnMsg('-1','请输入要搜索的信息');
		}
		
		$select = $postDb['select'];
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$res = $db->query("select * from xl_store where storekey = ? or storename= ?",[$select,$select]);
		
		$db->Closeconnection();
		ReturnMsg('ok','',$res);
	}
	
	//修改店铺名称
	public function storeEdit($postDb){
		if(!isset($postDb['sname'])){
			ReturnMsg('-1','店铺信息错误');
		}
		
		if(!isset($postDb['bid'])){
			ReturnMsg('-2','商户信息错误');
		}
		
		$storename = trim($postDb['sname']);
		$bossid = $postDb['bid'];
		
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		
		
		$storeRes = $db->query("select * from xl_store where bossid = ?",[$bossid]);
		if(count($storeRes)<=0){
			$db->Closeconnection();
			ReturnMsg('ok','店铺信息不存在');
		}
		
		
		$storeNameRes = $db->query("select * from xl_store where storename = ?",[$storename]);
		if(count($storeNameRes )>0){
			$db->Closeconnection();
			ReturnMsg('-4','已经有相同名的店铺');
		}
		
		$dbstorename = $storeRes[0]['storename'];
		if($dbstorename !='' && $dbstorename!=null){
			$db->Closeconnection();
			ReturnMsg('-3','店铺名称已经绑定!');
		}
		
		$res = $db->query("update xl_store set storename = ? where bossid = ?",[$storename,$bossid]);
		$db->query("update xl_userinfo set username = ? where userid = ?",[$storename,$bossid]);
		
		ReturnMsg('ok','修改成功');
	}
	
	public function getStoreInfo($postDb){
		if(!isset($postDb['bid'])){
			ReturnMsg('-2','商户信息错误');
		}
		
		$bossid = $postDb['bid'];
		$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$storeRes = $db->query("select * from xl_store where bossid = ?",[$bossid]);
		
		$db->Closeconnection();
		if(count($storeRes)<=0){
			ReturnMsg('ok','店铺信息不存在');
		}
		
		ReturnMsg('ok','',$storeRes);
	}
	
	public function aa(){
		    
			try {  
		        $pdo->beginTransaction(); // 开启一个事务  
		        $row = null;  
		        $row = $pdo->exec("xxx"); // 执行第一个 SQL  
		        if (!$row)   
		            throw new PDOException('提示信息或执行动作'); // 如出现异常提示信息或执行动作  
		        $row = $pdo->exec("xxx"); // 执行第二个 SQL  
		        if (!$row)   
		            throw new PDOException('提示信息或执行动作');  
		        $pdo->commit();  
		    } catch (PDOException $e) {  
		        $pdo->rollback(); // 执行失败，事务回滚  
		        exit($e->getMessage());  
		    }  
		
	}
	
}

?>