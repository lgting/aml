<?php
header('Access-Control-Allow-Origin:*');
require_once('../tool/config.php');
require_once('../tool/util.php');
require_once('ImageHander.php');
require_once("../tool/config.php");
require_once("../tool/PDO.class.php");
ini_set('pcre.backtrack_limit', 999999999);  
if(!IsAuthority()){
	exit();
}


if(isset($_POST['addGoods'])){
	AddGoods();
}
else if(isset($_POST['selectGoods'])){
	//查询
	SelectGoods($_POST['selectGoods']);
}
else if(isset($_POST['getGoods'])){
	getGoods($_POST['getGoods']);
}
else if(isset($_POST['updateGoods'])){
	updateGoods();
}
else if(isset($_POST['goodsimage'])){
	goodsimage_fun();
}
else if(isset($_POST['editGoods'])){
	editGoods_fun();
}
else if(isset($_POST['buylist'])){
	buylist_fun();
}
else if(isset($_POST['selectGoodsbyName'])){
	selectGoodsbyNames_fun();
}


function AddGoods(){
	if(!isset($_POST['names'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['msg'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['price'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['checkisshow'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['giveIntegral'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['bosscomm'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['salesmancomm'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['htmlmsg'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['icon'])){
		ErrorSend('icon param fail');
		exit();
	}
	else if(!isset($_POST['imgarr'])){
		ErrorSend('imgarr param fail');	
		exit();
	}
	else if(!isset($_POST['buymessage'])){
		ErrorSend('buymessage param fail');	
		exit();
	}
	else if(!isset($_POST['showType'])){
		ErrorSend('showType param fail');	
		exit();
	}
	else if(!isset($_POST['buyType'])){
		ErrorSend('buyType param fail');	
		exit();
	}
	else if(!isset($_POST['goodstype'])){
		ErrorSend('goodstype param fail');	
		exit();
	}
	else if(!isset($_POST['extsource'])){
		ErrorSend('extsource param fail');	
		exit();
	}
	else if(!isset($_POST['commagent'])){
		ErrorSend('commagent param fail');	
		exit();
	}
	
	
	
	
	
	
	$names = $_POST['names'];
	$msg = $_POST['msg'];
	$price = $_POST['price'];
	$checkisshow = $_POST['checkisshow'];
	$giveIntegral = $_POST['giveIntegral'];
	$bosscomm = $_POST['bosscomm'];
	$salesmancomm = $_POST['salesmancomm'];
	$htmlmsg = $_POST['htmlmsg'];
	$showType = $_POST['showType'];
	$buyType = $_POST['buyType'];
	$goodstype = $_POST['goodstype'];
	$extsource = $_POST['extsource'];
	$commagent = $_POST['commagent'];
	
	
	if($names == null || $names == ''){
		ErrorSend('names is null');
		exit();
	}
	
	if(!is_numeric($price)){
		ErrorSend('price is number');
		exit();
	}	
	else if(!is_numeric($giveIntegral)){
		ErrorSend('giveIntegral is number');
		exit();
	}
	else if(!is_numeric($bosscomm)){
		ErrorSend('bosscomm is number');
		exit();
	}
	else if(!is_numeric($salesmancomm)){
		ErrorSend('salesmancomm is number');
		exit();
	}
	
	if($checkisshow == 'true'){
		$checkisshow = 1;
	}
	else{
		$checkisshow = 0;
	}
	$iconurl = '';
	if($_POST['icon']!='' && $_POST['icon']!=null){
		$imagePath = SaveImage($_POST['icon'],GoodsImgDBTop,GoodsImgSavePath);	
		$iconurl = $imagePath['2'];
	}
	
	//列表素组
	$imgarr = json_decode($_POST['imgarr']);	
	$imgarrCount = count($imgarr);
	
	$imgPath = array();
	if($imgarrCount>0){		
		for($i=0;$i<$imgarrCount;$i++){
			$imgPath[$i] = SaveImage($imgarr[$i],GoodsImgDBTop,GoodsImgSavePath)['2'];
			//'img/'.SaveImage($imgarr[$i])['1'];
		}
	}
	if($htmlmsg!=null && $htmlmsg!=''){
		preg_match_all('/<img.*?src="(.*?)".*?>/is',$htmlmsg,$match);
		if(count($match)>1){
			$htmlResArr = $match[1];
			$htmlResArrNum = count($match[1]);
			for($i=0;$i<$htmlResArrNum;$i++){
				$imgUrl = $imgPath[$i] = SaveImage($htmlResArr[$i],GoodsImgDBTop,GoodsImgSavePath)['2'];//'img/'.SaveImage($htmlResArr[$i])['1'];
				$htmlmsg = str_replace($htmlResArr[$i],$imgUrl,$htmlmsg);
			}
		}
	}
	
//	var_dump($match);
//	echo 'cent='.$htmlResArrNum.'aaa='.$htmlmsg;
//	return;
	$buymessage = $_POST['buymessage'];
	$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$row1 = $db->query("insert into xl_goods(gname,message,price,isshow,addtime,giveIntegral,commissionboss,commissionsalesman,htmlmsg,type,icon,buymessage,showType,buyType,extsource,commagent)
	values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",array($names,$msg,$price,$checkisshow,time(),$giveIntegral,$bosscomm,$salesmancomm,$htmlmsg,$goodstype,$iconurl,$buymessage,$showType,$buyType,$extsource,$commagent));
	
	
	//滚动图片列表
	if($row1>0){
		$goodsid = $db->lastInsertId();
		$counts = count($imgPath);
		for($i = 0;$i<$counts;$i++){
			$db->query("insert into xl_goodsimage(goodsid,types,iconurl,rank)values(?,?,?,?)",array($goodsid,1,$imgPath[$i],0));
		}
	}
	$db->Closeconnection();
	ErrorSend('ok');
}

function SelectGoods($pages){
	if(!IsAuthority()){
		exit();
	}
		
	
	if(!is_numeric($pages)){
		ErrorSend('page is number');
		exit();
	}
	
	$conn = getConnect();
	
	$sql = "SELECT count(*) FROM xl_goods";
	
	$result = $conn->query($sql);
	$res = $result->fetch_assoc();
	$pageMax = $res['count(*)'];//['total'];
	
	
	$pageNum = 10;
	$startPageNum = $pageNum * $pages;
	$sql = "SELECT * FROM xl_goods limit $startPageNum, $pageNum";
	$arr = [];
	$result = $conn->query($sql);
	if ($result->num_rows > 0) {
	    // 输出数据
	    while($row = $result->fetch_assoc()) {
	    	array_push($arr,$row);
//	        $arr->push($row);
	    }
//		$arr = $result->fetch_array();
	}
	
	$backArr = array('error'=>'ok',
	'arr'=>$arr,
	'pageMax'=>$pageMax);
	
	$json_objback = json_encode($backArr,JSON_UNESCAPED_UNICODE);
	echo $json_objback;
}


function getGoods($gid){
	
	if(!IsAuthority()){
		exit();
	}
	
	if(!is_numeric($gid)){
		ErrorSend('gid is number');
		exit();
	}
	
	$conn = getConnect();
	$sql = "SELECT * FROM xl_goods where id = $gid";
	$arr = [];
	$result = $conn->query($sql);
	if ($result->num_rows > 0) {
	    // 输出数据
	    while($row = $result->fetch_assoc()) {
	    	array_push($arr,$row);
	    }
	}
	
	$backArr = array('error'=>'ok',
	'arr'=>$arr);
	
	$json_objback = json_encode($backArr);
	echo $json_objback;
}

function updateGoods(){
	
	if(!IsAuthority())
		return;
    
    if(!isset($_POST['id'])){
		ErrorSend('edit goods param fail');
		exit();
	}
    
	if(!isset($_POST['names'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['msg'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['price'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['checkisshow'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['giveIntegral'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['bosscomm'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['salesmancomm'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['htmlmsg'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['buyType'])){
		ErrorSend('buyType param fail');	
		exit();
	}
	else if(!isset($_POST['goodstype'])){
		ErrorSend('goodstype param fail');	
		exit();
	}
	else if(!isset($_POST['extsource'])){
		ErrorSend('extsource param fail');	
		exit();
	}
	else if(!isset($_POST['showType'])){
		ErrorSend('showType param fail');	
		exit();
	}
	
	
	$id = $_POST['id'];
	$names = $_POST['names'];
	$msg = $_POST['msg'];
	$price = $_POST['price'];
	$checkisshow = $_POST['checkisshow'];
	$giveIntegral = $_POST['giveIntegral'];
	$bosscomm = $_POST['bosscomm'];
	$salesmancomm = $_POST['salesmancomm'];
	$htmlmsg = $_POST['htmlmsg'];
	$buyType = $_POST['buyType'];
	$goodstype = $_POST['goodstype'];
	$extsource = $_POST['extsource'];
	$showType = $_POST['showType'];
	
	if(!is_numeric($id)){
		ErrorSend('id is number');
		exit();
	}	
	else if(!is_numeric($price)){
		ErrorSend('price is number');
		exit();
	}
	else if(!is_numeric($giveIntegral)){
		ErrorSend('giveIntegral is number');
		exit();
	}
	else if(!is_numeric($bosscomm)){
		ErrorSend('bosscomm is number');
		exit();
	}
	else if(!is_numeric($salesmancomm)){
		ErrorSend('salesmancomm is number');
		exit();
	}
	
	if($checkisshow == 'true'){
		$checkisshow = 1;
	}
	else{
		$checkisshow = 0;
	}
	
	$conn = getConnect();	
	$sql = "update xl_goods set gname = '$names',message='$msg',price=$price,isshow=$checkisshow,
	giveIntegral=$giveIntegral,commissionboss=$bosscomm,commissionsalesman=$salesmancomm,
	htmlmsg='$htmlmsg' where id = $id";
	
	$result = $conn->query($sql);	
	ErrorSend('ok');
	
}

//图片地址
function goodsimage_fun(){
	if(!isset($_POST['goodsimage'])){
		ErrorSend('goodsid not');
		return;
	}
	
	$goodsid = $_POST['goodsimage'];
	
	$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $db->query("select * from xl_goodsimage where goodsid = ?",array($goodsid));
	
	$backresult['error']='ok';
	$backresult['arr'] = $result;
	$json_objback = json_encode($backresult);
	echo $json_objback;
	$db->Closeconnection();
}

//编辑商品
function editGoods_fun(){
	if(!IsAuthority()){
		exit();
	}
		
    	
	if(!isset($_POST['names'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['msg'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['price'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['checkisshow'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['giveIntegral'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['bosscomm'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['salesmancomm'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['htmlmsg'])){
		ErrorSend('edit goods param fail');
		exit();
	}
	else if(!isset($_POST['icon'])){
		ErrorSend('icon param fail');
		exit();
	}
	else if(!isset($_POST['imgarr'])){
		ErrorSend('imgarr param fail');	
		exit();
	}
	else if(!isset($_POST['buymessage'])){
		ErrorSend('buymessage param fail');	
		exit();
	}
	else if(!isset($_POST['goodsid'])){
		ErrorSend('goodsid param fail');	
		exit();
	}
	else if(!isset($_POST['showType'])){
		ErrorSend('showType param fail');	
		exit();
	}
	else if(!isset($_POST['buyType'])){
		ErrorSend('buyType param fail');	
		exit();
	}
	else if(!isset($_POST['goodstype'])){
		ErrorSend('goodstype param fail');	
		exit();
	}
	else if(!isset($_POST['extsource'])){
		ErrorSend('extsource param fail');	
		exit();
	}
	else if(!isset($_POST['commagent'])){
		ErrorSend('commagent param fail');	
		exit();
	}
	
	
	$names = $_POST['names'];
	$msg = $_POST['msg'];
	$price = $_POST['price'];
	$checkisshow = $_POST['checkisshow'];
	$giveIntegral = $_POST['giveIntegral'];
	$bosscomm = $_POST['bosscomm'];
	$salesmancomm = $_POST['salesmancomm'];
	$htmlmsg = $_POST['htmlmsg'];
	$gid = $_POST['goodsid'];
	$showType = $_POST['showType'];
	$buyType = $_POST['buyType'];
	$goodstype = $_POST['goodstype'];
	$extsource = $_POST['extsource'];
	$commagent = $_POST['commagent'];
	if($names == null || $names == ''){
		ErrorSend('names is null');
		exit();
	}
	
	if(!is_numeric($price)){
		ErrorSend('price is number');
		exit();
	}	
	else if(!is_numeric($giveIntegral)){
		ErrorSend('giveIntegral is number');
		exit();
	}
	else if(!is_numeric($bosscomm)){
		ErrorSend('bosscomm is number');
		exit();
	}
	else if(!is_numeric($salesmancomm)){
		ErrorSend('salesmancomm is number');
		exit();
	}
	
	if($checkisshow == 'true'){
		$checkisshow = 1;
	}
	else{
		$checkisshow = 0;
	}
	
	
	
	$buymessage = $_POST['buymessage'];
	//data:image/jpg;base64
	$iconurl = '';
	
	$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);	
	
	//需要删除的照片数组
	$deleteImgArr = array();
	//获得所有旧照片
	$oldImg = $db->query("select icon,htmlmsg from xl_goods where id=?",array($gid));
	$resultDeleteImgArr = $db->query("select iconurl from xl_goodsimage where goodsid=?",array($gid));
	
	$deleteImgLen = count($resultDeleteImgArr);
	for($i=0;$i<$deleteImgLen;$i++){
		array_push($deleteImgArr,$resultDeleteImgArr[$i]['iconurl']);
	}
	
	//获得html当中的图片信息
	$oldhtmlmsg = $oldImg[0]['htmlmsg'];
	if($oldhtmlmsg!=null && $oldhtmlmsg!=''){
		preg_match_all('/<img.*?src="(.*?)".*?>/is',$oldhtmlmsg,$matchold);
		if(count($matchold)>1){
			$htmlResArr = $matchold[1];
			$htmlResArrNum = count($matchold[1]);			
			for($i=0;$i<$htmlResArrNum;$i++){	
				array_push($deleteImgArr,$htmlResArr[$i]);		
			}
		}
	}
	
	if($_POST['icon']!='' && $_POST['icon']!=null){
		
		$icons = $_POST['icon'];
		
		$baseimgArr = explode(',',$icons);
//		echo('$baseimgArr'.count($baseimgArr));
		if(count($baseimgArr)>1){
			$imagePath = SaveImage($_POST['icon'],GoodsImgDBTop,GoodsImgSavePath);//SaveImage($_POST['icon']);	
			$iconurl = $imagePath['2'];		
			array_push($deleteImgArr,$oldImg[0]["icon"]);		
		}
		else{
			$iconurl = $icons;
		}
		
	}
	
	//列表素组
	$imgarr = json_decode($_POST['imgarr']);	
	$imgarrCount = count($imgarr);
	
	$imgPath = array();
	if($imgarrCount>0){		
		for($i=0;$i<$imgarrCount;$i++){
			
			$imagesprArr = explode(',',$imgarr[$i]);
			if(count($imagesprArr)>1){
				$imgPath[$i] = SaveImage($imgarr[$i],GoodsImgDBTop,GoodsImgSavePath)['2'];//'img/'.SaveImage($imgarr[$i])['1'];
			}
			else{
				$imgPath[$i] = $imgarr[$i];
				if (in_array($imgPath[$i], $deleteImgArr)){
					foreach($deleteImgArr as $k=>$v){  
				        if($v == $imgPath[$i]){  
				            unset($deleteImgArr[$k]);
							break;  
				        }  
				    }  
				}
			}
		}
	}
	
	if($htmlmsg!=null && $htmlmsg!=''){
		preg_match_all('/<img.*?src="(.*?)".*?>/is',$htmlmsg,$match);
		if(count($match)>1){
			$htmlResArr = $match[1];
			$htmlResArrNum = count($match[1]);
			
			//var_dump($htmlResArr);
			//return;
			
			for($i=0;$i<$htmlResArrNum;$i++){
				
				$imagesprArr = explode(',',$htmlResArr[$i]);
				if(count($imagesprArr)>1){
					$imgUrl = SaveImage($htmlResArr[$i],GoodsImgDBTop,GoodsImgSavePath)['2'];//'img/'.SaveImage($htmlResArr[$i])['1'];
					$htmlmsg = str_replace($htmlResArr[$i],$imgUrl,$htmlmsg);
				}
				else{
					//剔除要删除的旧照片
					if (in_array($htmlResArr[$i], $deleteImgArr)){
						foreach($deleteImgArr as $k=>$v){  
					        if($v == $htmlResArr[$i]){  
					            unset($deleteImgArr[$k]);
								break;  
					        }
					    }  
					}
				}		
			}
		}
	}
	
	
	
	$row1 = $db->query("update xl_goods set gname=?,message=?,price=?,isshow=?,giveIntegral=?,commissionboss=?,commissionsalesman=?,htmlmsg=?,type=?,icon=?,buymessage=?,showType=?,buyType=?,extsource=?,commagent=? where id=?",
	array($names,$msg,$price,$checkisshow,$giveIntegral,$bosscomm,$salesmancomm,$htmlmsg,$goodstype,$iconurl,$buymessage,$showType,$buyType,$extsource,$commagent,$gid));
	
	
	$db->query("delete from xl_goodsimage where goodsid = ?",array($gid));
	
	
	//滚动图片列表
	$counts = count($imgPath);
	for($i = 0;$i<$counts;$i++){
		$db->query("insert into xl_goodsimage(goodsid,types,iconurl,rank)values(?,?,?,?)",array($gid,1,$imgPath[$i],0));
	}
	
	//删除旧照片
	$deleteImgLen = count($deleteImgArr);
	foreach($deleteImgArr as $k=>$v){ 
		if(file_exists(GoodsImgTopPath.$v)){
			unlink(GoodsImgTopPath.$v);
//			echo 'delete file ='.GoodsImgTopPath.$v;
		}
		else{
			
//			echo 'not find ='.GoodsImgTopPath.$v;
		}
	}
	
	$db->Closeconnection();
	ErrorSend('ok');
//	$arrys = array($names,$msg,$price,$checkisshow,$giveIntegral,$bosscomm,$salesmancomm,$htmlmsg,$iconurl,$buymessage,$gid);
//	var_dump($arrys);
}

function str_replace_limit($search, $replace, $subject, $limit=-1){  
    if(is_array($search)){  
        foreach($search as $k=>$v){  
            $search[$k] = '`'. preg_quote($search[$k], '`'). '`';  
        }  
    }else{  
        $search = '`'. preg_quote($search, '`'). '`';  
    }  
    return preg_replace($search, $replace, $subject, $limit);  
}

//购买记录
function buylist_fun(){
	
	if(!isset($_POST['page'])){
		ErrorSend('page param fail');	
		exit();
	}
	
	$pages = $_POST['page'];	
	if(!is_numeric($pages)){
		ErrorSend('page is number');
		exit();
	}
	
	$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$endPage = 10;
	$startPage = $pages * $endPage;
	$result = $db->query("select b.*,u.username,u.phone from xl_buylist as b left join xl_userinfo as u on b.userid = u.userid LIMIT ?,?",
	array($startPage,$endPage));
	
	$backarr = array();
	$backarr['error'] = 'ok';
	$backarr['arr'] = $result;
	$backarr['pageMax'] = $db->query("select count(buyid) from xl_buylist")[0]['count(buyid)'];
	
	
	echo json_encode($backarr);
}

//模糊查询商品
function selectGoodsbyNames_fun(){
	if(!isset($_POST['gname'])){
		ErrorSend('gname param fail');	
		exit();
	}
	
	$gname = $_POST['gname'];
	
	if($gname == "" || $gname == null){
		SelectGoods(0);
		return;
	}
	
	$db = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	
	
	$result = $db->query("select * from xl_goods where gname like ?",array("%$gname%"));
	$backarr = array();
	$backarr['error'] = 'ok';
	$backarr['arr'] = $result;
	$backarr['pageMax'] = 1;
	
	echo json_encode($backarr);
}

?>