<?php
header("Content-type: text/html; charset=utf-8");
header('Access-Control-Allow-Origin:*');
require('./include.php');
require_once("./config.php");
require_once("./util.php");
use TencentYoutuyun\Youtu;
use TencentYoutuyun\Conf;


// 设置APP 鉴权信息 请在http://open.youtu.qq.com 创建应用

$appid='10096844';
$secretId='AKIDviKlNqJM2vx0vgJFvu4teGhJkgUQ8MMU';
$secretKey='OROo5VKYK1ZyCXL1WFqbGJjZYblLoLwM';
$userid='707670850';


session_start();
testCache();
function testCache(){	
	if(!isset($_SESSION['resultArr'])){
		
		
		$resultArr = array();

		//创建一个DOMDocument对象
		$doc=new DOMDocument();
		 //加载XML文件
		$doc->load("SmResult.xml");
		 //获取所有的book标签
		$LeiXingDom=$doc->getElementsByTagName("leixing");


		foreach($LeiXingDom as $leix){
			$types = $leix->getAttribute('types');
			$states = $leix->getAttribute('states');
			$msgs = $leix->getElementsByTagName('msg')->item(0)->nodeValue;

			if(!isset($resultArr[$types])){
				$resultArr[$types]= array();
			}

			if(!isset($resultArr[$types][$states])){
				$resultArr[$types][$states]= array();
			}
			array_push($resultArr[$types][$states],$msgs);
		}
			
		$_SESSION['resultArr'] = $resultArr;
	}
}



if(isset($_POST['saveimage'])){
	
	if(!isset($_POST['TopSaveimage'])){
		ErrorSend('parme error');
		return;
	}
	
	$size = file_get_contents($_POST['TopSaveimage'].','.$_POST['saveimage']);
	$size = strlen($_POST['saveimage'])/1024;
	if($size>1000){
		ErrorSend('tobig');
		return;
	}

	
	$ImgUrlArr = SaveImage($_POST['saveimage'],$_POST['TopSaveimage']);
	$ImgUrl = $ImgUrlArr['0'];
	
	Conf::setAppInfo($appid, $secretId, $secretKey, $userid,conf::API_YOUTU_END_POINT );
	// 人脸检测 调用列子
	//$uploadRet = YouTu::detectfaceBase($_POST['saveimage'],1);//:detectface('test11.jpg', 1);
	$uploadRet = YouTu::detectface($ImgUrl, 1);
	
	if(isset($uploadRet['error']) && $uploadRet['error'] == 'noface'){
		$json_objback = json_encode(array('error'=>'failurl'));
		echo $json_objback;
		return;
	}
	
	if(isset($uploadRet['errorcode']) && $uploadRet['errorcode'] != '0'){
		$json_objback = json_encode(array('error'=>'fail'));
		echo $json_objback;
		return;
	}
	
	//$backurls = resize_image($ImgUrlArr['1'],$ImgUrl,120,120);
	$backurls = SavePosSize($ImgUrlArr['1'],$ImgUrl,$uploadRet['face'][0]['x'],$uploadRet['face'][0]['y'],$uploadRet['face'][0]['width'],$uploadRet['face'][0]['height']);

	//获得脸的最大xy值。最小xy值
	$faceMinMaxArr = GetMinAndMax($uploadRet['face'][0]['face_shape']['face_profile']);
	//左眼
	$eysLeftMinMaxArr = GetMinAndMax($uploadRet['face'][0]['face_shape']['left_eye']);
	//右眼
	$eysRightMinMaxArr = GetMinAndMax($uploadRet['face'][0]['face_shape']['right_eye']);
	//嘴巴
	$mouthMinMaxArr = GetMinAndMax($uploadRet['face'][0]['face_shape']['mouth']);
	//鼻子
	$noseMinMaxArr = GetMinAndMax($uploadRet['face'][0]['face_shape']['nose']);

	//var_dump($faceMinMaxArr);
	//echo 'cx='.($faceMinMaxArr[1] - $faceMinMaxArr[0]).'cy='.($faceMinMaxArr[3] - $faceMinMaxArr[2]);

	$sex = $uploadRet['face'][0]['gender'];
	$sex = $sex>50?0:1;
	
	//是否有大小眼
	//EysTEysCompute($eysLeftMinMaxArr,$eysRightMinMaxArr);
	
	$resultArry = array("error"=>'ok',
					"beauty"=>$uploadRet['face'][0]['beauty'],
					'smallurl'=>$backurls,
					"0"=>EysTCompute($eysLeftMinMaxArr),
					"1"=>EysTEysTFCompute($eysLeftMinMaxArr,$eysRightMinMaxArr,$faceMinMaxArr),
					"2"=>NTFCompute($noseMinMaxArr,$faceMinMaxArr),
					"3"=>MTFCompute($mouthMinMaxArr,$faceMinMaxArr,$sex)
					);
	
	$json_objback = json_encode($resultArry,JSON_UNESCAPED_UNICODE);
	
	$conn = getConnect();
	$row = array(
		'namekeys' => $ImgUrlArr['1'],
		'msg' => $json_objback
	);
	mysql_insert('smResult', $row);
	
	echo $json_objback;
}
else if(isset($_GET['shareMsg'])){
	//echo 'msgs'.$_GET['shareMsg'];
	$shareMsg = $_GET['shareMsg'];	
	$shareArr = explode("_",$shareMsg);
	if(count($shareArr)<1)
	{
		ErrorSend('shareMsg Error');
		return;
	}
	
	$shareMsg = 'nx_'.$shareArr[1];	
	$conn = getConnect();
	$sql = "select ids,namekeys,msg from smResult where namekeys = ?";
	$stmt=$conn->prepare($sql);
	$stmt->bind_param("s", $shareMsg);
	$stmt->execute();
	//用来获得行数的集合
	$stmt->store_result();
	//绑定结果
	$stmt->bind_result($ids,$nkeys,$msgs);
	$stmt->fetch();
	/*while($stmt->fetch()){
		echo "--$ids--$namekeys--$msg--<hr>";
	}*/
	
	//用来获得数据的集合
	$rowNum = $stmt->num_rows();
	if($rowNum>=0){
		echo $msgs;
	}
	else{
		ErrorSend('no data');
	}		
	$stmt->free_result();
	$stmt->close();
	$conn->close();
}

//发送错误码
function ErrorSend($errorid){
	$json_arrback = array("error"=>$errorid);
	$json_objback = json_encode($json_arrback);
	echo $json_objback;
}

function GetFaceResult($types,$states,$sex){
	if(!isset($_SESSION['resultArr'])){
		echo ErrorSend('无数据');
	}
	
	$arrys = $_SESSION['resultArr'][$types][$states];		
	$ranid = rand(0,count($arrys)-1);		
	return $arrys[$ranid];
}


//下吧
//MTBarFCompute($mouthMinMaxArr,$faceMinMaxArr);

//获取对应部位min(x,y) max(x,y)
function GetMinAndMax($arr){
	$numLength = count($arr);
	$minx = 99999;
	$maxx = 0;
	
	$miny = 99999;
	$maxy = 0;
	
	
	for($i = 0;$i<$numLength;$i++){
		if($arr[$i]['x'] <$minx){
			$minx = $arr[$i]['x'];
		}
		
		if($arr[$i]['x'] >$maxx){
			$maxx = $arr[$i]['x'];
		}
		
		if($arr[$i]['y'] <$miny){
			$miny = $arr[$i]['y'];
		}
		
		if($arr[$i]['y'] >$maxy){
			$maxy = $arr[$i]['y'];
		}
	}
	
	return array("0"=>$minx,'1'=>$maxx,'2'=>$miny,'3'=>$maxy);
}

//计算百分比
function computePercent($com1,$com2){
	return $com1/$com2;
}

//眼睛比较（眼睛信息）
function EysTCompute($com1){
	$cx = $com1[1] - $com1[0];
	$cy = $com1[3] - $com1[2];
	$result = $cy/$cx;
	
	//大眼睛
	$bigMax = 0.55;
	//圆眼睛
	$big = 0.5;
	//普通
	$com = 0.35;
	//小yanj
	$small = 0.25;
	$backResult = 0;
	if($result >= $bigMax){
		$backResult =  0;
	}
	else if($result >= $big && $result<$bigMax){
		$backResult =  1;
	}
	else if($result >= $com && $result<$big){
		$backResult =  2;
	}
	else{
		$backResult =  3;
	}
	
	return $backResult = GetFaceResult(0,$backResult,0);
}

//眼睛间距比较（左眼，右眼，脸）
function EysTEysTFCompute($left,$right,$face){
	//脸宽间距
	$facecx = $face[1] - $face[0];
	$eyscx = $right[0] - $left[1];
	$result = $eyscx/$facecx;
	
	$backResult = 0;
	//两眼宽
	$bigMax = 0.34;
	//中正
	$big = 0.26;
	//普通
	$com = 0.25;
	
	if($result >= $bigMax){
		$backResult =0;
	}
	else if($result >= $big && $result<$bigMax){
		$backResult =1;
	}
	else{
		$backResult =2;
	}
	return $backResult = GetFaceResult(0,$backResult,0);
}

//两眼不齐
function EysTEysCompute($left,$right){
	$leftx = $left[1] - $left[0] + ($left[3] - $left[2]);
	$rightx = $right[1] - $right[0] + ($right[3] - $right[2]);
	
	$result = 0;
	if($leftx>$rightx){
		$result = $rightx/$leftx;
	}
	else{
		$result = $leftx/$rightx;
	}
	
	echo $result;
	
	if($result<0.95){
		echo ' 两眼不齐';
	}
	echo ' ok';	
}

//鼻子
function NTFCompute($nose,$face){
	$nosex = $nose[1] - $nose[0];
	$nosey = $nose[3] - $nose[2];
	
	
	$facex = $face[1] - $face[0];
	$facey = $face[3] - $face[2];
	
	/* x 
		0.24 鼻子窄
		0.25 0.27 鼻子小
		0.28 0.3  鼻子中
		0.31	  鼻子大
	*/
	
	/* y 
		0.33  鼻梁短
		0.34 0.38 鼻梁小
		0.39 0.43 鼻梁总
		0.44	  鼻梁长
	*/
	
	//echo '鼻子='.($nosex/$facex);
	//echo '鼻子='.($nosey/$facey);
	
	//大
	$bigMax = 0.31;
	//中
	$big = 0.26;
	//小
	$com = 0.25;
	
	$backResult = 0;
	
	$result = $nosex/$facex;
	if($result >= $bigMax){
		$backResult = 0;
	}
	else if($result >= $big && $result<$bigMax){
		$backResult = 1;
	}
	else{
		$backResult = 2;
	}
	
	return $backResult = GetFaceResult(0,$backResult,0);
}

//嘴巴
function MTFCompute($mouth,$face,$sex){
	$mouthx = $mouth[1] - $mouth[0];
	$mouthy = $mouth[3] - $mouth[2];
	
	
	$facex = $face[1] - $face[0];
	$facey = $face[3] - $face[2];
	
	//大
	//中
	//小
	
	/* x 
		0.3   小嘴巴
		0.31 0.37  正常
		0.38 0.43  合适
		0.44		大嘴巴
	*/
	
	/* y 
		0.15 	
		0.16 0.19
		0.2 0.23
		0.239
	*/
	
	
	//echo '嘴巴='.($mouthx/$facex);
	//echo '嘴巴='.($mouthy/$facey);
	
	//大
	$bigMax = 0.44;
	//中
	$big = 0.32;
	//小
	$com = 0.31;
	
	$backResult = 0;
	$result = $mouthx/$facex;
	if($result >= $bigMax){
		$backResult = 0;
	}
	else if($result >= $big && $result<$bigMax){
		if($sex==0){
			$backResult = 2;
		}
		else{
			$backResult=1;
		}
	}
	else{
		if($sex==0){
			$backResult=4;
		}
		else{
			$backResult=3;
		}
	}
	
	return $backResult = GetFaceResult(0,$backResult,$sex);
}

//下吧
function MTBarFCompute($mouth,$face){
	$mouthy = $face[3] - $mouth[3];
	
	$facey = $face[3] - $face[2];
	
	/**
	0.18
	0.18 0.25
	0.26 0.3
	0.31
	*/
	
	echo '下吧='.($mouthy/$facey);
}


// 人脸定位 调用demo
//$uploadRet = YouTu::faceshape('a.jpg', 1);
//var_dump($uploadRet);

//黄图识别
//$uploadRet = YouTu::imageporn('test.jpg', 1);
//var_dump($uploadRet);
//$uploadRet = YouTu::imagepornurl('http://open.youtu.qq.com/content/img/product/face/face_05.jpg', 1);
//var_dump($uploadRet);

//身份证ocr

//$uploadRet = YouTu::idcardocr('test.jpg', 1);
//var_dump($uploadRet);
//$uploadRet = YouTu::idcardocrurl('http://open.youtu.qq.com/content/img/product/face/face_05.jpg', 1);
//var_dump($uploadRet);

//名片
//$uploadRet = YouTu::namecardocr('test.jpg', 1);
//var_dump($uploadRet);
//$uploadRet = YouTu::namecardocrurl('http://open.youtu.qq.com/content/img/product/face/face_05.jpg', 1);
//var_dump($uploadRet);


/***************************************************/
	function snap($photo , $rtn = false){
		$name = time() .rand(1,1000). '.jpg';
		$thumbnail = time() .rand(1,1000). '.jpg';
		$result = array(
			'name' => $name,
			'thumbnail'=> $thumbnail,
			'width' => 0,
			'height' => 0
		);
		$exif = exif_read_data($photo);
		list($imgw,$imgh,$type) = getimagesize($photo);
		if($type != 2){
			return $result;
		}else{
			$img = imagecreatefromjpeg($photo);
			if (!empty($exif['Orientation'])) {
				switch ($exif['Orientation']) {
					case 3:
						$img = imagerotate($img, 180, 0);
						break;
					case 6:
						$img = imagerotate($img, -90, 0);
						break;
					case 8:
						$img = imagerotate($img, 90, 0);
						break;
				}
			}
			$dest = dirname($photo)."/".$name;
			$tndest = dirname($photo)."/".$thumbnail;

			$imgw = imagesx($img);
			$imgh = imagesy($img);
			$width = 483;
			$height = round(($imgh*$width)/$imgw);
			$im = imagecreatetruecolor($width, $height);
			imagecopyresampled($im, $img, 0, 0, 0, 0, $width, $height, $imgw, $imgh);
			//imagecopyresampled imagecopyresized
			imagejpeg($im, $dest, 70);
			if($rtn){
				$tnh = 200;
				$tnw = round(($imgw*$tnh)/$imgh);
				$tnim = imagecreatetruecolor($tnw, $tnh);
				imagecopyresampled($tnim, $im, 0, 0, 0, 0, $tnw, $tnh, $width, $height);
				imagejpeg($tnim, $tndest, 70);
				imagedestroy($tnim);
			}

			$result['width'] = $width;
			$result['height'] = $height;
			imagedestroy($im);
			imagedestroy($img);
		}
		return $result;
	}
	
	
	// 重置图片文件大小
	function resize_image($filename, $tmpname, $xmax, $ymax)
	{
		$ext = explode(".",$filename);
		$ext = $ext[count($ext)-1];
		
		if($ext == "jpg" || $ext == "jpeg")
			$im = imagecreatefromjpeg($tmpname);
		elseif($ext == "png")
			$im = imagecreatefrompng($tmpname);
		elseif($ext == "gif")
			$im = imagecreatefromgif($tmpname);
	 
		$x = imagesx($im);
		$y = imagesy($im);
	 
		if($x >= $y) {
			$newx = $xmax;
			$newy = $newx * $y / $x;
		}
		else {
			$newy = $ymax;
			$newx = $x / $y * $newy;
		}
		
		//$exttt = explode(".",$filename);
		//echo '$exttt'.$exttt[0];
		//echo 'newx'.$newx.'$newy'.$newy.'$x'.$x.'$y'.$y;
		
		$path = "./img/";
		$dest = 'small'.explode(".",$filename)[0].'.jpg';
		$im2 = imagecreatetruecolor($newx, $newy);
		
		
		imagecopyresized($im2, $im, 0, 0, 0, 0, floor($newx), floor($newy), $x, $y);
		imagejpeg($im2, $path.$dest, 70); 
		return $dest;
	}
	
	
	function SaveImage($base_img,$SaveImage){
			//  $base_img是获取到前端传递的src里面的值，也就是我们的数据流文件
			//$base_img = str_replace('data:image/jpg;base64,', '', $base_img);
			//  设置文件路径和文件前缀名称
			$path = "./img/";
			$prefix='nx_';
			$houzArr = explode(';',$SaveImage);
			$houzArr = explode('/',$houzArr[0]);
			
			$houZ = $houzArr[1];
			if($houZ == 'jpeg'){
				$houZ = 'jpg';
			}
			
			$output_file = $prefix.time().rand(100,999).'.'.$houZ;
			$path = $path.$output_file;
			//创建将数据流文件写入我们创建的文件内容中
			$ifp = fopen( $path, "wb" );
			fwrite( $ifp, base64_decode( $base_img) );
			fclose( $ifp );
			return array('0'=>$path,'1'=>$output_file);
	}
	
	function SavePosSize($filename,$tempurl,$x,$y,$w,$h){
		
		$fileArr = explode(".",$filename);
		switch ($fileArr[1]) {
			case 'jpg':
			case 'jpeg':
				$im = imagecreatefromjpeg($tempurl);
				break;
			case 'png':
				$im = imagecreatefrompng($tempurl);
				break;
			case 'gif':
				$im = imagecreatefromgif($tempurl);
				break;
		}
		
		$ow = imagesx($im);
		$oh = imagesy($im);
		
		
		$addSize = 90;
		$resultSize = $w;
		if($w > $h)
			$resultSize = $h;
		
		/*$centerx = $x + $w*0.5;
		$centery = $y + $h*0.5;
		
		$x = $centerx - ($resultSize*0.5 + $addSize)；
		$y = $centery - ($resultSize*0.5 + $addSize)；
		
		$w = */
		
		
		
	
		
		$x -= $addSize;
		$y -=$addSize;
		$w = $h = $resultSize+$addSize*2;
		
		if($x<0){
			$x = 0;
		}
		
		if($y<0){
			$y = 0;
		}
		
		$smresultSize = $ow;
		if($ow > $oh)
			$smresultSize = $oh;
		
		if($x + $w > $smresultSize){
			$w = $h = $smresultSize - $x;
		}
		
		if($y + $w > $smresultSize){
			$w = $h = $smresultSize - $y;
		}
		
		$newim  = imagecreatetruecolor($w, $h); //产生新图片 100 100 为新图片的宽和高  
		imagecopyresampled($newim ,  $im , 0, 0,  $x ,  $y , $w, $h,  $w ,  $h );  
		//参数[1] [2] [3][4] [5] [6] [7]  [8]  [9] [10]   
		//[5]  客户端选择区域左上角x轴坐标   
		//[6]  客户端选择区域左上角y轴坐标   
		//[7]  生成新图片的宽   
		//[8]  生成新图片的高   
		//[9]  客户端选择区 的宽   
		//[10] 客户端选择区 的高        
		
		$path = "./img/";
		$dest = 'small'.$fileArr[0].'.jpg';
		
		imagejpeg($newim, $path.$dest,$addSize);  
		imagedestroy($im);  
		imagedestroy($newim );  
		return $dest;
	}

?>
