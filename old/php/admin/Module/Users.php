<?php
	namespace Module;	
	header('Access-Control-Allow-Origin:*');
	
	class Users{
		
		//所有代理商列表
		public function AgentList_fun($postDb){
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);			
			$useresult = $db->query("select userid,username,phone,remarks from xl_userinfo where role = ".Agent);
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']= $useresult;			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$db->Closeconnection();
		}
		
		//成为商户的交易列表
		public function Depositlist_fun($postDb){
			
			if(!isset($postDb['page'])){
				ErrorSend('page is number');
				return;
			}
			
			$pages = $postDb['page'];
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$endPage = 10;
			$startPage = $pages * $endPage;
			
			$gResult = $db->query("select xl_depositlist.*,xl_userinfo.username as uname,userid from xl_depositlist,xl_userinfo where xl_depositlist.username = xl_userinfo.userid limit ?,?",array($startPage,$endPage));
			
			$bossNameArr = array();
			$uid = 0;
			foreach($gResult as $key=>$value){
				$uid = $value['salesman'];
				$gResult[$key]['sname'] = '';
				if($uid > 0){
					array_push($bossNameArr,$uid);
				}
			}
			
			$bossArrStr = '';
			if(count($bossNameArr)>0){
				$bossArrStr = implode(',',$bossNameArr);
				$bossArrStr = '('.$bossArrStr.')';
				$bossResult = $db->query("select username,userid from xl_userinfo where userid in ".$bossArrStr);
				
				$bossKeyArr = array();

				foreach($bossResult as $key=>$value){
					$uid = $value['userid'];
					$bossKeyArr[$uid] = $value['username'];
				}
				
				foreach($gResult as $key=>$value){
					$uid = $value['salesman'];
					if(isset($bossKeyArr[$uid])){
						$gResult[$key]['sname'] = $bossKeyArr[$uid];
					}
				}		
			}
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']= $gResult;
			$backArr['pageMax']=  $db->query("select count(depositid) from xl_depositlist")[0]['count(depositid)'];	
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$db->Closeconnection();
		}
			
		
		//所有押金
		public function Deposit_Fun($postDb){
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);			
			$useresult = $db->query("select * from xl_deposit");
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']= $useresult;			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$db->Closeconnection();
		}
		
		//修改押金信息
		public function UpdateDeposit_Fun($postDb){
			$apower = new AdminPower();
			$isOk = $apower->isUserPowerToClient(__FUNCTION__,$postDb);
			if(!$isOk){
				return;
			}
			
			if(!isset($postDb['dpsum'])){
				ErrorSend('dpsum is null');
				return;
			}
			
			if(!isset($postDb['dpname'])){
				ErrorSend('dpname is null');
				return;
			}
			
			
			$dbsum = $postDb['dpsum'];
			$dpname = $postDb['dpname'];
			$dpid = $postDb['dpid'];
			
			if(!is_numeric($dpid) || $dpid<0){
				ErrorSend('dpid is fail');
				return;
			}
			
			if(!is_numeric($dbsum) || $dbsum<0){
				ErrorSend('dpsum is fail');
				return;
			}
			
			$dpnamelen = strlen($dpname);
			if($dpnamelen>100 || $dpnamelen<=0){
				ErrorSend('dpname size fail');
				return;
			}
			
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);			
			$useresult = $db->query("update  xl_deposit set dpsum = ?, dpname=? where dpid =?",array($dbsum,$dpname,$dpid));
			ErrorSend('ok');
			$db->Closeconnection();
		}
		
	}

?>