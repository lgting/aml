<?php
header('Access-Control-Allow-Origin:*');
require("../tool/PDO.class.php");
require("../tool/config.php");
require("../tool/util.php");

if(isset($_POST['type'])){
	$gettype = $_POST['type'];
	switch($gettype){
		case 'goodslist':
			//拆
			GetGoodsList();
			break;
		case 'buygoods':
			//BuyGoods();
			break;
		case 'couponlist':
			//查看礼品券
			//GetCouponList();
			break;
		case 'consumelist':
			//获得使用过的优惠券列表
			//GetConsumeList();
			break;	
		case 'goodsmgs':
			//拆
			GetGoodsMsg();
			break;
		case 'GetGoods':
			GetGoodsListById();
			break;
		case 'GetHomeGoods':
			//拆
			GetHomeGoodsList();
			break;
	}
}

function GetGoodsList(){
	if(!isset($_POST['userid'])){
		ErrorSend('userid fail');
		return;
	}
	else if(!isset($_POST['page'])){
		ErrorSend('not page');
		return;
	}
	
	$startPageNum = $_POST['page'];
	if(!is_numeric($startPageNum) || $startPageNum < 0){
		ErrorSend('page is number');
		return;
	}

	$userid = $_POST['userid'];
	$role = 0;
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	//limit $startPageNum, $pageNum
	$pageNum = 10;
	$userresult = $DB->query("select username,role from xl_userinfo where userid = ?",array($userid));
	if(count($userresult)>0){
		$role = $userresult[0]['role'];
	}
	
	$result = $DB->query("SELECT id,gname,message,price,type,icon,buyType,showType,type from xl_goods where isshow = 1 and type=10 limit ?, ?",array($startPageNum,$pageNum));			
	$buylist = $DB->query("SELECT * from xl_buylist where userid = ?",array($userid));	
	$buyListArr = array();
	foreach($buylist as $key=>$value){
		$buyListArr[$value['goodsid']] = $value;
	}
	
	foreach($result as $key=>$value){
		$result[$key]['iscanbuy']=false;
		if(!isset($buyListArr[$value['id']])||$role == Boss||$value['buyType']==2){
			$result[$key]['iscanbuy']=true;
		}
	}
	
	$result['error']='ok';
	$json_objback = json_encode($result);
	echo $json_objback;
	$DB->CloseConnection();
}

//获得单个商品详细信息
function GetGoodsListById(){
	if(!isset($_POST['goodsid'])){
		ErrorSend('goodsid fail');
		exit();
	}
	
	$goodsid = $_POST['goodsid'];
	if(!is_numeric($goodsid)){
		ErrorSend('goodsid is number');
		exit();
	}
	

	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$pageNum = 5;
	$result = $DB->query("SELECT * from xl_goods where id = ?",array($goodsid));	
	
	$backArr = array();
	$backArr['error']='ok';
	$backArr['db']=$result;
	$json_objback = json_encode($backArr);
	echo $json_objback;
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
	if(count($htmlRes)>=0 && count($htmlRes[0])>=0){
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
}

function BuyGoods(){
	$json = '{"transaction_id":"abcdefg","attach":"GoodsPayParam;1;380ttcc;380;1"}'; 
	$data = json_decode($json);
	//array('transaction_id'=>'abcdefg','attach'=>'GoodsPayParam;1;380套餐;380;1');
	
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$attach = explode(";",$data->attach);
			$result = $DB->query("select * from xl_buylist where serialnum = ?",array($data->transaction_id));
			$price = intval($attach[3]);
			$goodsid = intval($attach[4]);
			$userid = intval($attach[1]);
			if($result == null || count($result)<=0 || count($result[0])<=0 || $result[0]['buyid'] == 0){
				//没有这个订单重新添加
				
				//给玩家添加礼品券
				$couponList = $DB->query("select * from xl_coupontogoods where goodsid = ?",array($goodsid));
				$giftArr = array('1'=>0,'2'=>0);
				if($couponList != null && count($couponList)>0){
					
					$arrlen = count($couponList);
					$couponMsg;
					for($i = 0;$i<$arrlen;$i++){
						if(count($couponList[$i])>0){
							$cid = $couponList[$i]['couponid'];
							$couponMsg = $DB->query("select * from xl_coupon where id = ".$cid);
							
							if($couponMsg == null || count($couponMsg)<=0 || count($couponMsg[0])<=0 || $couponMsg[0]['id'] == 0){
								continue;
							}
							
							$giftArr[$couponMsg[0]['type']]+=$couponList[$i]['nums'];
							$datefrom = time() + $couponMsg[0]['starttime'];
							$dateto = $datefrom + $couponMsg[0]['endtime'];
							
							
							$sqlStr = $cid.",".$userid.",".$datefrom.",".$dateto;
//							echo "insert into xl_couponlist(cpuuid,belongto,datefrom,dateto) value(".$sqlStr.")";
							//添加到客户列表
							$DB->query("insert into xl_couponlist(cpuuid,belongto,datefrom,dateto) value(".$sqlStr.")");
						}
					}
					
				}
				
				//添加购买列表
				$giftnum = $giftArr['1'];
				$expnum = $giftArr['2'];
				
				$result = $DB->query("insert into xl_buylist(serialnum,setsname,buydate,giftnum,expnum,bindinfo,notes,userid,price)values(?,?,?,?,?,?,?,?,?)",array($data->transaction_id,$attach[2],time(),$giftnum,$expnum,0,'buy',$userid,$price));
				
				//修改客户的优惠券列表
				//$DB->query('update ')	
			}
		
	echo 'ooovvv';
}

//获得优惠券列表
function GetCouponList(){
	if(!isset($_POST['userid'])){
		ErrorSend('not userid');
		exit();
	}
	if(!isset($_POST['page'])){
		ErrorSend('not page');
		exit();
	}
	if(!isset($_POST['goodsid'])){
		ErrorSend('not goodsid');
		exit();
	}
	
	$startPageNum = $_POST['page'];
	$userid = $_POST['userid'];
	$goodsid = $_POST['goodsid'];
	if(!is_numeric($startPageNum) || $startPageNum < 0){
		ErrorSend('page is number');
		exit();
	}
	
	if(!is_numeric($userid)){
		ErrorSend('userid is number');
		exit();
	}
	
	if(!is_numeric($goodsid)){
		ErrorSend('goodsid is number');
		exit();
	}
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$pageNum = 15;
	$selectsql = 'select u.*,cname,message,iconurl,type from xl_couponlist as u left join xl_coupon a on u.cpuuid = a.id where u.belongto = ? and u.goodsid = ? limit ?,?';
	$result = $DB->query($selectsql,array($userid,$goodsid,$startPageNum,$pageNum));
	
	$backarr = array('arr'=>$result,'error'=>'ok');
	$json_objback = json_encode($backarr);
	echo $json_objback;
	
}

//获得使用过的优惠券列表
function GetConsumeList(){
	if(!isset($_POST['userid'])){
		ErrorSend('not userid');
		exit();
	}
	else if(!isset($_POST['page'])){
		ErrorSend('not page');
		exit();
	}
	
	$startPageNum = $_POST['page'];
	$userid = $_POST['userid'];
	if(!is_numeric($startPageNum) || $startPageNum < 0){
		ErrorSend('page is number');
		exit();
	}
	
	if(!is_numeric($userid)){
		ErrorSend('userid is number');
		exit();
	}

	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$pageNum = 20;
	$result = $DB->query("select xl_coupon.*,consumedate,gname from xl_consumelist,xl_coupon,xl_goods where xl_consumelist.coupon = xl_coupon.id and xl_consumelist.goodsid = xl_goods.id and xl_consumelist.userid = ? order by consumedate desc limit ?, ?",array($userid,$startPageNum,$pageNum));
	
	$backarr = array();
	$backarr['error']='ok';
	$backarr['arr']=$result;
	$json_objback = json_encode($backarr);
	echo $json_objback;
}

function GetHomeGoodsList(){
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $DB->query("SELECT id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and showType<2 and type<20 and type<>2");	
	
	$showArr = array();
	
	foreach ($result as $key => $value) {
		$showType = $value['showType'];
		if(!isset($showArr[$showType])){
			$showArr[$showType] = array();
		}
		
		array_push($showArr[$showType],$value);
	}
	
	$sourceResult = $DB->query("SELECT id,gname,message,price,type,icon,showType,buyType,buynum,topicon from xl_goods where isshow = 1 and type=2 and showType<3");
	
	$backArr = [];
	$backArr['error']='ok';
	$backArr['arr'] = [];
	if(isset($showArr[2])){
		$backArr['arr'] = $showArr[2];
	}
	$backArr['arrtop'] = $showArr[1];
	$backArr['sourcearr']=$sourceResult;
	$json_objback = json_encode($backArr);
	echo $json_objback;
}

?>