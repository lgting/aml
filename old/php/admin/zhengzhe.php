<?php
header("Content-Type: text/html;charset=utf-8");
$str = '<center><img src="asedsfasdfase" height="120" width="120">
<div>
<img src="/uploads/images/2017020716154163.jpg" height="120" width="120"><div>
<img src="/uploads/images/2017020716154162.jpg" height="120" width="120">

<br />PHP正则提取或更改图片img标记中的任意属性</center>';
// 
//preg_match_all('/<img.+src=\"?(.+\.(jpg|gif|bmp|bnp|png))\"?.+>/i',$str,$match);
//preg_match_all('/<img.+src=\"?(.+\.(jpg|gif|bmp|bnp|png))\"?.+>/i',$str,$match);
preg_match_all('/<img.*?src="(.*?)".*?>/is',$str,$match);

///src=".*?"/
$htmlResArr = $match[1];
			$htmlResArrNum = count($match[1]);
for($i=0;$i<$htmlResArrNum;$i++){
				
				$str = str_replace($htmlResArr[$i],'aaa'.$i,$str);
			}



//preg_replace('/(<img.+src=\"?.+)(images\/)(.+\.(jpg|gif|bmp|bnp|png)\"?.+>)/i',"\${1}uc/images/\${3}",$str);
//echo "<hr/>"+$str;

/*PHP正则替换图片img标记中的任意属性*/
//1、将src="/uploads/images/20100516000.jpg"替换为src="/uploads/uc/images/2017020716154162.jpg")
//print 

/*$str = preg_replace('/(<img.+src=\"?.+)(images\/)(.+\.(jpg|gif|bmp|bnp|png)\"?.+>)/i',"aaaaa",$str);
echo "<hr/>".$str;*/

$str = str_replace('/uploads/images/2017020716154162.jpg',"aaaaa",$str);
echo "<br/>".$str;

//$str2 = 'runo o   b';
//$str2 = preg_replace('/\s+/', '', $str2);
//// 将会改变为'runoob'
//echo $str2;

//echo $match[1];

//if (preg_match_all("/php/i", "PHP is the web scripting language of choice.",$match)) {
//  echo "查找到匹配的字符串 php。";
//	print($match);
//} else {
//  echo "未发现匹配的字符串 php。";
//}
?>