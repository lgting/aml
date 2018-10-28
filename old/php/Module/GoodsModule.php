<?php
	namespace Module;	
	header('Access-Control-Allow-Origin:*');
	use Redis;
	class GoodsModule{
		//积分商城列表
		public function ShowSorceShop(){
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("SELECT id,gname,message,price,type,icon,showType,buyType from xl_goods where isshow = 1 and type=2 and showType>0");	
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']=$result;
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$DB->Closeconnection();
		}
		
		//购买积分操作
		public function BuySorceShop($postDb){
			if(!isset($postDb['gid'])){
				ErrorSend('gid fail');
				return;
			}
			
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['num'])){
				ErrorSend('num fail');
				return;
			}
			
			$gid = $postDb["gid"];
			$num = $postDb["num"];
			$uid = $postDb["uid"];
			
			if($num<1){
				//数量必须大于0
				ErrorSend("-104");
				return;
			}
			
			//查看用户存在不
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$userresult = $DB->query("SELECT username,role,source from xl_userinfo where userid=?",array($uid));	
			if(count($userresult)<=0){
				//用户不存在
				ErrorSend("-100");
				$DB->Closeconnection();
				return;
			}
			
			$goodsdb = $DB->query("select id,gname,message,price,type,icon,showType,buyType from xl_goods where id = ?",array($gid));
			if(count($goodsdb)<=0){
				//商品不存在
				ErrorSend("-101");
				$DB->Closeconnection();
				return;
			}
			
			//如果商品只能购买一次
			if($goodsdb[0]['buyType'] == 1){
				if($num>1){
					//商品只能购买一件
					ErrorSend("-102");
					$DB->Closeconnection();
					return;
				}
				$orderdb = $DB->query("select * from xl_sourceorder where goodsid = ? and userid = ?",array($gid,$uid));
				if(count($orderdb) > 0){
					//商品只能购买一件
					ErrorSend("-102");
					$DB->Closeconnection();
					return;
				}
			}
			
			$cursource = $userresult[0]["source"];
			$needsource = $goodsdb[0]["price"] *$num;
			
			//查看积分是否足够
			if($cursource < $needsource){
				ErrorSend("-103");
				$DB->Closeconnection();
				return;
			}
			
			
			//生成购买订单
			$addNum = $DB->query("insert into xl_sourceorder(oid,userid,goodsid,source,state,times,nums) values(?,?,?,?,?,?,?)",array(uniqid(),$uid,$gid,$needsource,1,time(),$num));
			//扣积分
			if($addNum >0){
				$DB->query("update xl_userinfo set source = ? where userid = ?",array($cursource-$needsource,$uid));
			}
			
			ErrorSend("ok");
		}
		
		//购买列表
		public function buyList($postDb){
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['page'])){
				ErrorSend('page fail');
				return;
			}
			
			
			$uid = $postDb["uid"];
			$page = $postDb['page'];
    		$startPage = $page*10;
			$endPage = 10;
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("select xl_sourceorder.*,username, gname,headimgurl,message from xl_sourceorder,xl_userinfo,xl_goods where xl_sourceorder.userid = xl_userinfo.userid
				and xl_sourceorder.goodsid = xl_goods.id and xl_userinfo.userid = ? order by times limit ?,?",array($uid,$startPage,$endPage));
			
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']=$result;
			$json_objback = json_encode($backArr);
			echo $json_objback;
			
			$DB->Closeconnection();
		}
		
		//使用积分商品
		public function useSourceGoods($postDb){
			if(!isset($postDb['uid'])){
				ErrorSend('uid fail');
				return;
			}
			
			if(!isset($postDb['oid'])){
				ErrorSend('oid fail');
				return;
			}
			
			if(!isset($postDb['bid'])){
				ErrorSend('bid fail');
				return;
			}
			
			$uid = $postDb["uid"];
			$oid = $postDb["oid"];
			$bid = $postDb["bid"];
			
			if(!is_numeric($uid)){
				ErrorSend("uid is number");
				return;
			}
			
			if(!is_numeric($bid)){
				ErrorSend("bid is number");
				return;
			}
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$userdb = $DB->query("select role from xl_userinfo where userid = ?",array($uid));
			$bossdb = $DB->query("select role from xl_userinfo where userid = ?",array($bid));
			
			if(count($userdb)<=0){
				//不是用户
				ErrorSend("-100");
				$DB->Closeconnection();
				return;
			}
			
			if(count($bossdb)<=0){
				//不是boss
				ErrorSend("-101");
				$DB->Closeconnection();
				return;
			}
			
			if($userdb[0]["role"] != User){
				//用户不是用户
				ErrorSend("-102");
				$DB->Closeconnection();
				return;
			}
			
			if($bossdb[0]["role"] != Boss){
				//老板不是老板
				ErrorSend("-103");
				$DB->Closeconnection();
				return;
			}
			
			$orderMsg = $DB->query("select * from xl_sourceorder where oid = ?",array($oid));
			if(count($orderMsg)<=0){
				//订单没找到
				ErrorSend("-105");
				$DB->Closeconnection();
				return;
			}
			
			
			
			if($orderMsg[0]["userid"]!=$uid){
				//订单用户信息错误
				ErrorSend("-106");
				$DB->Closeconnection();
				return;
			}
			
			if($orderMsg[0]["state"]==2){
				//订单用户信息错误
				ErrorSend("-107");
				$DB->Closeconnection();
				return;
			}
			
			//积分使用
			$upnum = $DB->query("update xl_sourceorder set state = ?,bossid = ?,usetime=? where oid = ?",array(2,$bid,time(),$oid));
			if($upnum<=0){
				//积分使用失败
				ErrorSend("-104");
				$DB->Closeconnection();
				return;
			}
			
			ErrorSend("ok");
			$DB->Closeconnection();
			
			//设置缓存
			$redis_ocean = new Redis();
		    $redis_ocean->connect(RedISHost, RedISPORT);			
			$resUseKey = 'usesource:oid:'.$oid;		
			$redis_ocean->setex($resUseKey, 30, 'ttl come');
			
		}
		
		//使用订单状态
		public function useSourceOrderState($postDb){
			if(!isset($postDb['hand'])){
				ErrorSend('hand fail');
				return;
			}
			
			$hand = $_POST['hand'];
			$redis_ocean = new Redis();
			$redis_ocean->connect(RedISHost, RedISPORT);
			if($redis_ocean->exists($hand)){				
				$redis_ocean->delete($hand);
				echo '200';
				return;
			}
			
			echo '-100';
		}
		
		//赠送
		public function GoodsGive($postDb){
			
			if(!isset($postDb['guid'])){
				ErrorSend('guid fail');
				return;
			}
			
			if(!isset($postDb['tguid'])){
				ErrorSend('tguid fail');
				return;
			}
			
			if(!isset($postDb['buyid'])){
				ErrorSend('buyid fail');
				return;
			}
			
			$guid = $postDb['guid'];
			$tguid = $postDb['tguid'];
			$buyid = $postDb['buyid'];
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$buydb = $DB->query("select * from xl_buylist where buyid = ?",array($buyid));
			
			$giveuserdb = $DB->query("select role from xl_userinfo where userid = ?",array($guid));
			
			$togiveuserdb = $DB->query("select role from xl_userinfo where userid = ?",array($tguid));
			
			//判断数据是否存在
			if(count($buydb)<=0 || count($giveuserdb)<=0 || count($togiveuserdb)<=0){
				ErrorSend('db fail');
				$DB->Closeconnection();
				return;
			}
			
			$belongtoid = 0;
			$clientdb = $DB->query("select * from xl_clientslist where clientid = ?",array($tguid));
			if(count($clientdb)>0){
				$belongtoid = $clientdb[0]['belongto'];
			}
			
			//被赠送者绑定了其他商户
			if($belongtoid> 0 && $belongtoid != $guid){
				ErrorSend('-103');
				$DB->Closeconnection();
				return;
			}
			
			//赠送状态
			$giveState = $buydb[0]["givestate"];
			//订单状态
			$orderState = $buydb[0]["orderstate"];
			//购买者用户编号
			$buyuserid = $buydb[0]["userid"];
			//商品编号
			$goodsid = $buydb[0]["goodsid"];
			//支付订单编号
			$transaction_id = $buydb[0]["serialnum"];
			$setsname = $buydb[0]["setsname"];
			$price = $buydb[0]["price"];
			$giftnum = $buydb[0]["giftnum"];
			$expnum = $buydb[0]["expnum"];
			
			
			//1.判断商品是否被使用过
			if($orderState != NotUse){
				ErrorSend('-100');
				$DB->Closeconnection();
				return;
			}
			
			//2.判断商品是否被转赠过
			if($giveState != NotGive){
				ErrorSend('-101');
				$DB->Closeconnection();
				return;
			}
			
			//赠送者不是购买者
			if($guid != $buyuserid){
				ErrorSend('-102');
				$DB->Closeconnection();
				return;
			}
			
			//添加
			$DB->query("insert into xl_buylist(serialnum,setsname,buydate,giftnum,expnum,bindinfo,notes,userid,price,goodsid,givestate,orderstate,giveuid,givetime)
			values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
			array($transaction_id,$setsname,time(),$giftnum,$expnum,0,'givebuy',$tguid,$price,$goodsid,ToGive,NotUse,$guid,time()));
			
			$lastbuyid = $DB->lastInsertId();
			
			//给玩家添加礼品券
			$couponList = $DB->query("select * from xl_coupontogoods where goodsid = ?",array($goodsid));
			
			if($couponList != null && count($couponList)>0){				
				$arrlen = count($couponList);
				$couponMsg;
				for($i = 0;$i<$arrlen;$i++){
					
					$cid = $couponList[$i]['couponid'];
					$couponMsg = $DB->query("select * from xl_coupon where id = ".$cid);
					
					if(count($couponMsg)<=0){
						continue;
					}
					
					$datefrom = time() + $couponMsg[0]['starttime'];
					$dateto = $datefrom + $couponMsg[0]['endtime'];
					
					$sqlStr = $cid.",".$tguid.",".$datefrom.",".$dateto.",".$goodsid.",".$lastbuyid;
					//添加到客户列表
					$DB->query("insert into xl_couponlist(cpuuid,belongto,datefrom,dateto,goodsid,buyid) value(".$sqlStr.")");				
				}				
			}
			
			//修改订单状态
			$DB->query("update xl_buylist set givestate = ?,giveuid=?,givetime=? where buyid = ?",array(Give,$tguid,time(),$buyid));
			
			ErrorSend('ok');
			$DB->Closeconnection();
		}
		
		
		//获得优惠券列表
		function GetCouponList(){
			if(!isset($_POST['buyid'])){
				ErrorSend('not buyid');
				exit();
			}

			$buyid = $_POST['buyid'];

			if(!is_numeric($buyid)){
				ErrorSend('buyid is number');
				exit();
			}
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);

			$selectsql = 'select u.*,cname,message,iconurl,type from xl_couponlist as u left join xl_coupon a on u.cpuuid = a.id where buyid = '.$buyid;
			$nouseresult = $DB->query($selectsql);
			
			$useresult = $DB->query("select xl_coupon.*,consumedate,cptype from xl_consumelist,xl_coupon where xl_consumelist.coupon = xl_coupon.id and xl_consumelist.buyid =".$buyid);
			
			$nouseNum = count($nouseresult);
			$useNum = count($useresult);
			
			$resultArr = array();
			$curTime = time();
			for($i=0;$i<$nouseNum;$i++){
				$arrs = array();
				$arrs['cname'] = $nouseresult[$i]['cname'];
				$arrs['message'] = $nouseresult[$i]['message'];
				$arrs['iconurl'] = $nouseresult[$i]['iconurl'];
				$arrs['state'] = 0;
				$arrs['dateto'] = $nouseresult[$i]['dateto'];
				$arrs['datefrom'] = $nouseresult[$i]['datefrom'];
				
				$endtm = intval($arrs['dateto']);

				if($curTime>$endtm){
					$arrs['state'] = 2;
				}
				
				$arrs['consumedate'] = "";
				$arrs['cptype'] = $nouseresult[$i]['cptype'];
				$arrs['cpid'] = $nouseresult[$i]['cpid'];
				$arrs['cpuuid'] = $nouseresult[$i]['cpuuid'];
				array_push($resultArr,$arrs);		
			}
			
			for($i=0;$i<$useNum;$i++){
				$arrs = array();
				$arrs['cname'] = $useresult[$i]['cname'];
				$arrs['message'] = $useresult[$i]['message'];
				$arrs['iconurl'] = $useresult[$i]['iconurl'];
				$arrs['state'] = 1;
				$arrs['dateto'] = "";
				$arrs['datefrom'] = "";
				$arrs['consumedate'] = $useresult[$i]['consumedate'];
				//$arrs['cptype'] = $nouseresult[$i]['cptype'];
				//$arrs['cpid'] = $nouseresult[$i]['cpid'];
				//$arrs['cpuuid'] = $nouseresult[$i]['cpuuid'];
				array_push($resultArr,$arrs);		
			}
			
			
			$backarr = array('arr'=>$resultArr,'error'=>'ok');
			$json_objback = json_encode($backarr);
			echo $json_objback;
		}
		
		
		//商户商品
		public function ShowBossShop(){
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("SELECT id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and type=3 and showType>0");	
			$backArr = [];
			$backArr['error']='ok';
			$backArr['arr']=$result;
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$DB->Closeconnection();
		}
		
		
		//套餐退款操作
		public function ExitGoods($postDb){
			if(!isset($postDb['buyid'])){
				ErrorSend('not buyid');
				return;
			}
			
			if(!isset($postDb['serialnum'])){
				ErrorSend('not serialnum');
				return;
			}
			
			$buyid = $postDb['buyid'];
			$serialnum = $postDb['serialnum'];
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			
			$buyResult = $DB->query("select * from xl_buylist where buyid =?",array($buyid));
			
			if(count($buyResult)<=0){
				//订单不存在
				ErrorSend('-100');
				return;
			}

			$serialnumdb = $buyResult[0]['serialnum'];
			$orderstate = $buyResult[0]['orderstate'];
			$givestate = $buyResult[0]['givestate'];
			$buydate = $buyResult[0]['buydate'];
			if($serialnumdb != $serialnum){
				//订单不存在
				ErrorSend('-100');
				return;
			}
			
			//NotUse
			//NotGive
			if($orderstate != NotUse){
				//订单已经被使用不能退款
				ErrorSend('-101');
				return;
			}
			
			if($givestate != NotGive){
				//转赠订单不能退款
				ErrorSend('-102');
				return;
			}
			
			$daydate= floor((time()-$buydate)/86400);

			if($daydate>7){
				//超过7天不能退货
				ErrorSend('-103');
				return;
			}
			
			$DB->query("update xl_buylist set orderstate = ?,exitTime=? where buyid =?",array(ExitIng,time(),$buyid));
			ErrorSend('ok');
			$DB->CloseConnection();
		}
		
		//取消退款
		public function ExitExitGoods($postDb){
			if(!isset($postDb['buyid'])){
				ErrorSend('not buyid');
				return;
			}
			
			if(!isset($postDb['serialnum'])){
				ErrorSend('not serialnum');
				return;
			}
			
			$buyid = $postDb['buyid'];
			$serialnum = $postDb['serialnum'];
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			
			$buyResult = $DB->query("select * from xl_buylist where buyid =?",array($buyid));
			
			if(count($buyResult)<=0){
				//订单不存在
				ErrorSend('-100');
				return;
			}

			$serialnumdb = $buyResult[0]['serialnum'];
			$orderstate = $buyResult[0]['orderstate'];
			$buydate = $buyResult[0]['buydate'];
			
			if($serialnumdb != $serialnum){
				//订单不存在
				ErrorSend('-100');
				return;
			}
			
			
			if($orderstate == ExitEnd){
				//已经退款成功
				ErrorSend('-102');
				return;
			}
			
			//NotUse
			//NotGive
			if($orderstate != ExitIng){
				//非退款状态不能退款
				ErrorSend('-101');
				return;
			}
			
			$daydate= floor((time()-$buydate)/86400);	
			$resultBack = array('iscanreturn'=>true,'orderstate'=>0,'buyid'=>$buyid);

			if($daydate>7){
				$resultBack['iscanreturn'] = false;
			}
			
			$DB->query("update xl_buylist set orderstate = ?,exitTime=? where buyid =?",array(NotUse,time(),$buyid));
			
			$backarr = array('arr'=>$resultBack,'error'=>'ok');
			$json_objback = json_encode($backarr);
			echo $json_objback;
			$DB->CloseConnection();
		}
	}
?>