<?php
	namespace Module;	
	header('Access-Control-Allow-Origin:*');
	
	class Goods{
		
		//出货列表
		public function ShipmentList_fun($postDb){
			
			if(!isset($postDb['bid'])){
				ErrorSend("bid notfind");
				return;
			}
			
			$bid = $postDb['bid'];
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			/*$result = $db->query("select xl_consumelist.*,xl_userinfo.userid,xl_userinfo.phone,gname from xl_consumelist,xl_userinfo,xl_goods where xl_userinfo.userid = xl_consumelist.userid and xl_consumelist.goodsid = xl_goods.id and bossid = ?",
			array($bid));*/
			
			$sumresult = $db->query("select coupon,count(coupon) as sellnum from xl_consumelist where bossid = ? group by coupon",array($bid));
			if(count($sumresult)<=0){
				$backArr = [];
				$backArr['error']='ok';
				$backArr['arr']= $sumresult;			
				$json_objback = json_encode($backArr);
				echo $json_objback;
				$db->Closeconnection();
				return;
			}
			
			$couponarr = array();
			$couponstrarr = array();
			$coupon = 0;
			foreach($sumresult as $key=>$values){
				$coupon = $values['coupon'];
				$couponarr[$coupon] = $values['sellnum'];
				array_push($couponstrarr,$coupon);
			}
			
			$couponstr = '('.implode(',',$couponstrarr).')';
			
			$xl_coupondb = $db->query("select id,cname,iconurl,type from xl_coupon where id in ".$couponstr);
			
			foreach($xl_coupondb as $key=>$values){
				$xl_coupondb[$key]['sellnum'] = 0;
				if(isset($couponarr[$values['id']])){
					$xl_coupondb[$key]['sellnum'] = $couponarr[$values['id']];
				}
			}
			
			//积分商品
			$xl_sourceorder = $db->query("select goodsid,sum(nums) as useridnum from xl_sourceorder where bossid = ? and state = 2 group by goodsid",array($bid));
			if(count($xl_sourceorder)>0){		
				$goodsArr = array();	
				$xl_goodskey = array();
						
				foreach($xl_sourceorder as $key=>$values){
					array_push($goodsArr,$values['goodsid']);
					$xl_goodskey[$values['goodsid']] = $values['useridnum'];
				}
				
				$sourcestr = implode(',',$goodsArr);
				$sourcestr = '('.$sourcestr.')';
				
				$xl_goodsdb = $db->query("select id, gname as cname, icon as iconurl from xl_goods where id in ".$sourcestr);
	
				foreach($xl_goodsdb as $key=>$values){
					$xl_goodsdb[$key]['sellnum'] = 0;
					if(isset($xl_goodskey[$values['id']])){
						$xl_goodsdb[$key]['sellnum'] = $xl_goodskey[$values['id']];
					}		
					$xl_goodsdb[$key]['type'] = 3;	
					$xl_goodsdb[$key]['cpid'] = $values['id'];	
				}
				
				$xl_coupondb = array_merge($xl_coupondb,$xl_goodsdb);
			}
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']= $xl_coupondb;			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$db->Closeconnection();
		}
		
		
		//按照时间查找用户
		public function selectShipmentByTime_fun($postDb){
			
			if(!isset($postDb['stm'])){
				ErrorSend('stm fail');
				return;
			}
			
			if(!isset($postDb['etm'])){
				ErrorSend('etm fail');
				return;
			}
			
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			
			$startTime = $postDb['stm'];
			$endTime = $postDb['etm'];
			$uid = $postDb['uid'];
			
			$startTime = strtotime($startTime);
			$endTime = strtotime($endTime);
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			
			$sumresult = $db->query("select coupon,count(coupon) as sellnum from xl_consumelist where bossid = ? and consumedate>? and consumedate <? group by coupon",array($uid,$startTime,$endTime));
			if(count($sumresult)<=0){
				$backArr = [];
				$backArr['error']='ok';
				$backArr['arr']= $sumresult;			
				$json_objback = json_encode($backArr);
				echo $json_objback;
				$db->Closeconnection();
				return;
			}
			
			$couponarr = array();
			$couponstrarr = array();
			$coupon = 0;
			foreach($sumresult as $key=>$values){
				$coupon = $values['coupon'];
				$couponarr[$coupon] = $values['sellnum'];
				array_push($couponstrarr,$coupon);
			}
			
			$couponstr = '('.implode(',',$couponstrarr).')';
			
			$xl_coupondb = $db->query("select id,cname,iconurl,type from xl_coupon where id in ".$couponstr);
			
			foreach($xl_coupondb as $key=>$values){
				$xl_coupondb[$key]['sellnum'] = 0;
				if(isset($couponarr[$values['id']])){
					$xl_coupondb[$key]['sellnum'] = $couponarr[$values['id']];
				}
			}
			
			//积分商品
			$xl_sourceorder = $db->query("select goodsid as cpid,goodsid,sum(nums) as useridnum from xl_sourceorder where bossid = ? and usetime>? and usetime<? and state = 2 group by goodsid",array($uid,$startTime,$endTime));
			if(count($xl_sourceorder)>0){		
				$goodsArr = array();	
				$xl_goodskey = array();
						
				foreach($xl_sourceorder as $key=>$values){
					array_push($goodsArr,$values['goodsid']);
					$xl_goodskey[$values['goodsid']] = $values['useridnum'];
				}
				
				$sourcestr = implode(',',$goodsArr);
				$sourcestr = '('.$sourcestr.')';
				
				$xl_goodsdb = $db->query("select id, gname as cname, icon as iconurl from xl_goods where id in ".$sourcestr);
	
				foreach($xl_goodsdb as $key=>$values){
					$xl_goodsdb[$key]['sellnum'] = 0;
					$xl_goodsdb[$key]['cpid'] = $values['id'];	
					if(isset($xl_goodskey[$values['id']])){
						$xl_goodsdb[$key]['sellnum'] = $xl_goodskey[$values['id']];
					}		
					$xl_goodsdb[$key]['type'] = 3;	
				}
				
				$xl_coupondb = array_merge($xl_coupondb,$xl_goodsdb);
			}
			
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']= $xl_coupondb;			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$db->Closeconnection();
		}
		
		//订单明细
		public function selectShipmentmsg_fun($postDb){		
			if(!isset($postDb['stm'])){
				ErrorSend('stm fail');
				return;
			}
			
			if(!isset($postDb['etm'])){
				ErrorSend('etm fail');
				return;
			}
			
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['cpid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['cptype'])){
				ErrorSend('cptype fail');
				return;
			}
			
			$startTime = $postDb['stm'];
			$endTime = $postDb['etm'];
			$startTime = strtotime($startTime);
			$endTime = strtotime($endTime);
			$uid = $postDb['uid'];
			$cpid = $postDb['cpid'];
			$cptype = $postDb['cptype'];
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$sqlstr = '';
			$xl_coupondb = null;
			if($cptype == 3){
				$sqlstr = 'select usetime as consumedate,gname as cname,nums,xl_userinfo.username as uname from xl_sourceorder,xl_goods,xl_userinfo where bossid = ? and state = 2
				 and usetime>? and usetime <? and goodsid = ? and goodsid = xl_goods.id and xl_userinfo.userid = xl_sourceorder.userid';
				 $xl_coupondb = $db->query($sqlstr,array($uid,$startTime,$endTime,$cpid));
				 
				foreach($xl_coupondb as $key=>$values){
					$xl_coupondb[$key]['cptype'] = 3;
				}				 
			}
			else{
				$sqlstr = "select xl_consumelist.*,cname,xl_userinfo.username as uname from xl_consumelist,xl_coupon,xl_userinfo where bossid = ? and consumedate>? and consumedate <? and coupon = ? and coupon=xl_coupon.id and xl_consumelist.userid = xl_userinfo.userid";
				$xl_coupondb = $db->query($sqlstr,array($uid,$startTime,$endTime,$cpid));
				
				foreach($xl_coupondb as $key=>$values){
					$xl_coupondb[$key]['nums'] = 1;
				}	
			}
			
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']= $xl_coupondb;			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$db->Closeconnection();
		}

		function DeleteGoods_Fun(){
			$apower = new AdminPower();
			$isOk = $apower->isUserPowerToClient(__FUNCTION__,$_POST);
			if(!$isOk){
				return;
			}
			
			if(!isset($_POST['gid'])){
				ErrorSend('gid fail');
				exit();
			}
			
			$gid = $_POST['gid'];
			
			if(!is_numeric($gid)){
				ErrorSend('gid fail');
				exit();
			}
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $db->query("select * from xl_buylist where goodsid = ?",array($gid));
			if(count($result)>0){
				ErrorSend('-100');
				exit();
			}
			
			$db->query("delete from xl_coupontogoods where goodsid = ?",array($gid));
			$db->query("delete from xl_goodsimage where goodsid = ?",array($gid));
			$db->query("delete from xl_goods where id = ?",array($gid));
			
			ErrorSend('ok');
			$db->Closeconnection();
		}
		
	}
	
?>