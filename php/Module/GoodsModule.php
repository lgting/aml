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
		
		//积分购买列表
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
				ReturnMsg('-1','参数信息错误');
			}
			
			if(!isset($postDb['oid'])){
				ReturnMsg('-1','参数信息错误');
			}
			
			if(!isset($postDb['bid'])){
				ReturnMsg('-1','参数信息错误');
			}
			
			$uid = $postDb["uid"];
			$oid = $postDb["oid"];
			$bid = $postDb["bid"];
			
			if(!is_numeric($uid)){
				ReturnMsg('-1','用户信息错误');
			}
			
			if(!is_numeric($bid)){
				ReturnMsg('-1','商户信息错误');
			}
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$userdb = $DB->query("select role from xl_userinfo where userid = ?",array($uid));
			$bossdb = $DB->query("select role from xl_userinfo where userid = ?",array($bid));
			
			if(count($userdb)<=0){
				//不是用户
				$DB->Closeconnection();
				ReturnMsg('-100','用户信息错误.');
			}
			
			if(count($bossdb)<=0){
				//不是boss
				$DB->Closeconnection();
				ReturnMsg('-101','商户信息错误.');
			}
			
			if($userdb[0]["role"] != User){
				//用户不是用户
				$DB->Closeconnection();
				ReturnMsg('-102','用户信息错误..');
			}
			
			if($bossdb[0]["role"] != Boss){
				//老板不是老板
				$DB->Closeconnection();
				ReturnMsg('-103','商户信息错误..');
			}
			
			$orderMsg = $DB->query("select * from xl_sourceorder where oid = ?",array($oid));
			if(count($orderMsg)<=0){
				//订单没找到
				$DB->Closeconnection();
				ReturnMsg('-105','订单信息错误.');
			}
			
			
			
			if($orderMsg[0]["userid"]!=$uid){
				//订单用户信息错误
				$DB->Closeconnection();
				ReturnMsg('-106','订单信息错误..');
			}
			
			if($orderMsg[0]["state"]==2){
				//订单用户信息错误
				$DB->Closeconnection();
				ReturnMsg('-107','订单信息错误...');
			}
			
			//积分使用
			$upnum = $DB->query("update xl_sourceorder set state = ?,bossid = ?,usetime=? where oid = ?",array(2,$bid,time(),$oid));
			if($upnum<=0){
				//积分使用失败
				$DB->Closeconnection();
				ReturnMsg('-104','积分使用失败...');
			}
			
			//设置缓存
			$redis_ocean = new Redis();
		    $redis_ocean->connect(RedISHost, RedISPORT);			
			$resUseKey = 'usesource:oid:'.$oid;		
			$redis_ocean->setex($resUseKey, 30, 'ttl come');
			
			ReturnMsg('ok','使用成功...');
			$DB->Closeconnection();
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
			$result = $DB->query("SELECT id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and type>=20 and showType>0");	
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

		function GetHomeGoodsList(){
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			//查询顶部商品
			$topResult = $DB->query("select id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and showType=1");	
			
			//其他首页商品
			$result = $DB->query("select id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and showType=2 and type<10 order by id desc");	
			
			$showArr = array();
			
			foreach ($result as $key => $value) {
				$Types = $value['type'];
				if(!isset($showArr[$Types])){
					$showArr[$Types] = array();
				}
				
				if($Types == 0 || $Types==2){
					if(count($showArr[$Types])<3){
						array_push($showArr[$Types],$value);
					}
				}
				else{
					array_push($showArr[$Types],$value);
				}
				
			}
			
			$backArr = [];
			$backArr['error']='ok';
			//顶部推荐
			$backArr['arrtop'] = $topResult;
			//特价
			$backArr['tearr'] = [];
			//推荐
			$backArr['tuiarr'] = [];
			//积分
			$backArr['sourcearr'] = [];
			
			if(isset($showArr[0])){
				$backArr['tearr'] = $showArr[0];
			}
			
			if(isset($showArr[1])){
				$backArr['tuiarr'] = $showArr[1];
			}
			
			if(isset($showArr[2])){
				$backArr['sourcearr']=$showArr[2];
			}
			
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$DB->CloseConnection();
		}
		
		//按照类型获得商品
		function getGoodsArrByType(){			
			if(!isset($_POST['gtype'])){
				ErrorSend('not gtype');
				exit();
			}
			if(!isset($_POST['ranktp'])){
				ErrorSend('not gtype');
				exit();
			}
			if(!isset($_POST['lift'])){
				ErrorSend('not gtype');
				exit();
			}
			if(!isset($_POST['page'])){
				ErrorSend('not page');
				exit();
			}
			if(!isset($_POST['userid'])){
				ErrorSend('userid fail');
				return;
			}
			
			//商品类型
			$gtypes = $_POST['gtype'];
			//ranktp 排行类型  1综合  2 价格  3销量  
			$ranktp = $_POST['ranktp'];
			//lift 排序规则 1升序  2降序
			$lift = $_POST['lift'];
			//分页
			$page = $_POST['page'];
			//用户编号
			$userid = $_POST['userid'];
			
			if($gtypes == -1){
				$this->GetHomeGoodsList();
				exit();
			}		
			
			if(!is_numeric($gtypes) || !is_numeric($ranktp) || !is_numeric($lift)|| !is_numeric($page)||!is_numeric($userid)){
				ErrorSend('is number');
				exit();
			}
			
			$rankName = 'addtime';
			
			if($ranktp == 1){
				$rankName = 'addtime';
			}
			else if($ranktp == 2){
				$rankName = 'price';
			}
			else if($ranktp == 3){
				$rankName = 'buynum';
			}

			$liftName = 'desc';
			if($lift == 1){
				$liftName = 'asc';
			}
			
			$endpage = 10;
			$startPage = $page * $endpage;
			
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$userInfo = $DB->query("select role from xl_userinfo where userid=?",array($userid));
			$role = 0;
			if(count($userInfo)>0){
				$role = $userInfo[0]['role'];
			}
			
			$sqls = "select id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and type = ? order by $rankName $liftName LIMIT ?,?";
			$resultArr = $DB->query($sqls,array($gtypes,$startPage,$endpage));
			
			
			$canbyGoods = [];
			foreach($resultArr as $key=>$value){
				$resultArr[$key]['iscanbuy']=true;
				if($value['buyType'] == BuyOne){
					array_push($canbyGoods,$value['id']);
				}
			}
			
			//查看商品是否已经购买过
			if(count($canbyGoods)>0){
				$canbyGoodsStr = '('.implode(',',$canbyGoods).')';
				
				//echo '$canbyGoodsStr='.$canbyGoodsStr;
				//echo "select * from xl_buylist where goodsid in $canbyGoodsStr and userid = $userid";
				//$buylist = $DB->query("select * from xl_buylist where goodsid in ? and userid = ?",array($canbyGoodsStr,$userid));	
				
				$buylist = $DB->query("select goodsid,buyid from xl_buylist where goodsid in $canbyGoodsStr and userid = $userid");
				$buyListArr = array();
				foreach($buylist as $key=>$value){
					$buyListArr[$value['goodsid']] = $value;
				}
				
				foreach($resultArr as $key=>$value){
					$resultArr[$key]['iscanbuy']=false;
					if(!isset($buyListArr[$value['id']])||$role == Boss||$value['buyType']==2){
						$resultArr[$key]['iscanbuy']=true;
					}
				}
				
			}
			
			//echo "select id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and type = $gtypes order by $rankName $liftName LIMIT $startPage,$endpage";
			//echo "<br>";
			echo json_encode(['error'=>'ok','arr'=>$resultArr]);
			$DB->CloseConnection();
		}
		
		//按照类型获得顶部推荐商品
		function getArrTopGoods(){
			
			if(!isset($_POST['gtype'])){
				ErrorSend('not gtype');
				exit();
			}
			
			//商品类型
			$gtypes = $_POST['gtype'];
			
			if(!is_numeric($gtypes)){
				ErrorSend('is number');
				exit();
			}
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$topArr = $DB->query("select id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and type = ? and typetop=1 order by addtime desc LIMIT 0,3",array($gtypes));
			echo json_encode(['error'=>'ok','arr'=>$topArr]);
			$DB->CloseConnection();
			
		}
		
		//商品购买记录列表
		function buylist_handle(){
			if(!isset($_POST['user'])){
				ErrorSend('user fail');
				return;
			}
			
			if(!isset($_POST['goodstype'])){
				ErrorSend('goodstype fail');
				return;
			}
			
			$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = [];
			$str = "";
			if(!isset($_POST['page'])){
				ErrorSend('page fail');
				return;
			}
					
			$page = $_POST['page'];	
			$goodstype = $_POST['goodstype'];
			$userid = $_POST['user'];
			
			$startPage = $page*10;
			$endPage = 10;
			
			$selectSql = '';
			if($goodstype == 1){
				//套餐商品
				$selectSql = "SELECT xl_buylist.*,icon,message,xl_goods.price,xl_goods.id,xl_goods.type FROM xl_buylist,xl_goods where xl_buylist.userid = ? and xl_buylist.goodsid = xl_goods.id 
				and xl_goods.type<20 and xl_goods.type<>2 and paystate = 1 order by buydate desc limit ?,?";
			}
			else if($goodstype == 3){
				//老板娘商品
				$selectSql = "SELECT xl_buylist.*,icon,message,xl_goods.price,xl_goods.id,xl_goods.type FROM xl_buylist,xl_goods where xl_buylist.userid = ? 
				and xl_buylist.goodsid = xl_goods.id and xl_goods.type >=20 and paystate = 1 order by buydate desc limit ?,?";
			}
			
			$result = $db->query($selectSql,array($userid,$startPage,$endPage));
			
			
			if(count($result)>0){
				$giveidArr = array();
				foreach ($result as $key => $value) {
					if($value['giveuid']>0){
						array_push($giveidArr,$value['giveuid']);
					}
					$result[$key]['username'] = "";
					$result[$key]['phone'] ="";
					
					$buydate = $value['buydate'];
					$daydate= floor((time()-$buydate)/86400);
					
					$result[$key]['iscanreturn'] = true;
					if($daydate>7){
						$result[$key]['iscanreturn'] = false;
					}
				}
				
				$giveidArrNum = count($giveidArr);
				
				if($giveidArrNum>0){
					$giveidArrNumStr = implode(',', $giveidArr);
					$giveidArrNumStr = '('.$giveidArrNumStr.')';
					$userResult = $db->query("select username,phone,userid from xl_userinfo where userid in ".$giveidArrNumStr);
					
					$giveidArr = array();
					foreach ($userResult as $key => $value) {
						$giveidArr[$value['userid']] = array('username'=>$value['username'],'phone'=>$value['phone']);						
					}
					
					foreach ($result as $key => $value) {
						$giveuid = $value['giveuid'];
						
						
						if(isset($giveidArr[$giveuid])){
							$result[$key]['username'] = $giveidArr[$giveuid]['username'];
							$result[$key]['phone'] = $giveidArr[$giveuid]['phone'];
						}
					}
				}
			}
			
			echo json_encode($result);
			$db->Closeconnection();
		}
		
		//获得商品详细信息
		function GetGoodsMsg(){
			if(!isset($_POST['goodsid'])){
				ErrorSend('goodsid fail');
				exit();
			}
			
			if(!isset($_POST['userid'])){
				ErrorSend('userid fail');
				exit();
			}
			
			$goodsid = $_POST['goodsid'];
			$userid = $_POST['userid'];
			$htmlmsg='';
			$gname = '';
			$message = '';
			$price = '';
			$icon = '';
			if(!is_numeric($goodsid)){
				ErrorSend('goodsid is number');
				exit();
			}
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("SELECT * from xl_goodsimage where goodsid = ?",array($goodsid));	
			$htmlRes = $DB->query("SELECT gname,message,price,icon,htmlmsg,type,buyType from xl_goods where id = ?",array($goodsid));
			
			//过去是否可以购买信息
			$buyuserlist = $DB->query("select buyid from xl_buylist where userid = ? and goodsid = ?",array($userid,$goodsid));
			$userinfo = $DB->query("select role from xl_userinfo where userid = ? ",array($userid));
			
			$role = 0;
			$iscanbuy = false;
			if(count($userinfo)>0){
				$role = $userinfo[0]['role'];
			}
			
			if(count($buyuserlist)<=0 || $role == Boss||$htmlRes[0]['buyType']==2){
				$iscanbuy = true;
			}
			
			$buytype = '';
			$type = '';
			if($result != null && count($htmlRes)>=0 && count($htmlRes[0])>=0){
				$htmlmsg = $htmlRes[0]['htmlmsg'];
				$gname = $htmlRes[0]['gname'];
				$message = $htmlRes[0]['message'];
				$price = $htmlRes[0]['price'];
				$icon = $htmlRes[0]['icon'];
				$buytype = $htmlRes[0]['buyType'];
				$type = $htmlRes[0]['type'];
			}
			
			$backArr = array('imgarr'=>$result,'htmlmsg'=>$htmlmsg,'gname'=>$gname,'message'=>$message,'price'=>$price,'icon'=>$icon,'iscanbuy'=>$iscanbuy,'buyType'=>$buytype,'type'=>$type,'error'=>'ok');	
			$json_objback = json_encode($backArr);
			echo $json_objback;
			$DB->Closeconnection();
		}
		
		//代理商看到他的品牌被那些老板购买的列表
		function AgentsBossGoods(){
			if(!isset($_POST['aid'])){
				ErrorSend('aid is null');
				exit();
			}
			
			if(!isset($_POST['page'])){
				ErrorSend('page is null');
				exit();
			}
			
			if(!isset($_POST['tp'])){
				ErrorSend('tp is null');
				exit();
			}
			
			$aid = $_POST['aid'];
			$page = $_POST['page'];
			$tp = $_POST['tp'];
			
			if(!is_numeric($aid)){
				ErrorSend('aid is number');
				exit();
			}
			
			if(!is_numeric($page)){
				ErrorSend('page is number');
				exit();
			}
			
			if(!is_numeric($tp)){
				ErrorSend('tp is number');
				exit();
			}
			
			$where = '=0';
			if($tp != 0){
				$where = '<>0';
			}

			$startpage = $page*10;
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("select a.*,b.price*0.01 as price,b.orderstate,b.setsname as gname,c.username,c.phone from xl_buy_agent_goods as a,xl_buylist as b,xl_userinfo as c
			where a.buyid = b.buyid and a.buyerid = c.userid and agentid = ? and b.orderstate $where order by a.id desc limit $startpage,10",[$aid]);	
			
			echo json_encode(['error'=>'ok','arr'=>$result]);
			$DB->Closeconnection();			
		}
		
		//代理商处理被购买的品牌
		function AgentHandleBossGoods(){
			if(!isset($_POST['aid'])){
				ErrorSend('aid is null');
				exit();
			}
			
			if(!isset($_POST['buyid'])){
				ErrorSend('buyid is null');
				exit();
			}
			
			$aid = $_POST['aid'];
			$buyid = $_POST['buyid'];
			
			if(!is_numeric($aid)){
				ErrorSend('aid is number');
				exit();
			}
			
			if(!is_numeric($buyid)){
				ErrorSend('buyid is number');
				exit();
			}
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("select * from xl_buy_agent_goods where agentid = $aid and buyid = $buyid");
			
			if(count($result)<=0){				
				ErrorSend('param fail1');
				$DB->Closeconnection();
				exit();
			}
			
			$id = $result[0]['id'];			
			$buyResult = $DB->query("select * from xl_buylist where buyid = $buyid");
			if(count($buyResult)<=0){				
				ErrorSend('param fail2');
				$DB->Closeconnection();
				exit();
			}
			
			//订单状态不对
			if($buyResult[0]['orderstate']!=NotUse){
				ErrorSend('-100');				
				$DB->Closeconnection();
				exit();
			}
			
			$ostate = HandleEnd;
			$DB->query("update xl_buylist set orderstate = $ostate where buyid = $buyid");
			$DB->query("update xl_buy_agent_goods set handletime = ? where id = $id",[time()]);
			ErrorSend('ok');
			$DB->Closeconnection();
		}
		
	}
?>