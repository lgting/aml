<?php
header("Content-type: text/html; charset=utf-8");
header('Access-Control-Allow-Origin:*');
require_once('../config.php');
require_once('../util.php');

if(isset($_POST["uname"]) && isset($_POST["pwd"])){
	$username = $_POST["uname"];
	$pwd = $_POST["pwd"];
	
	$conn = getConnect();
	$sql = "select userid from xl_userinfo where username = ? and userpwd=?";
	$stmt=$conn->prepare($sql);
	$stmt->bind_param("ss", $username,$pwd);
	$stmt->execute();
	//用来获得行数的集合
	$stmt->store_result();
	//绑定结果
	$stmt->bind_result($ids);
	$stmt->fetch();

	//用来获得数据的集合
	$rowNum = $stmt->num_rows();
	if($rowNum>0){
		ErrorSend('ok');
	}
	else{
		ErrorSend('fail');
	}		
	$stmt->free_result();
	$stmt->close();
	$conn->close();	
}

function GetCode(){
	$letterStr = "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
	$letterStrArr =  explode(',',$letterStr);
	return $letterStrArr;
}
?>