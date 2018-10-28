<?php

namespace Module;	
header('Access-Control-Allow-Origin:*');
use Redis;
	class LoginModule{
		
		public function loginredis(){
			
			$redis_ocean = new Redis();
			$redis_ocean->pconnect(RedISHost, RedISPORT);

			if(!$redis_ocean->exists('redistest')){
				$redis_ocean->setex('redistest', 60*60*24*5, 'aaaaaabbbbbbccccccddddd');
				echo json_encode(array('error'=>'is first error'));
				exit();
			}			
			
			echo json_encode(array('error'=>'ok','openid'=>$redis_ocean->get('redistest')));
		}
		
		//登陆验证
		public function LoginCheck(){
			
			if(!isset($_POST['phone'])){
				ErrorSend('-100');
				exit();
			}
			
			if(!isset($_POST['code'])){
				ErrorSend('-100');
				exit();
			}
			
			if(!isset($_POST['wxopenid'])){
				ErrorSend('-100');
				exit();
			}
			
			
			$phone = $_POST['phone'];
			$codes = $_POST['code'];
			$wxopenid = $_POST['wxopenid'];
			
			if(strlen($phone)>12 || strlen($codes)>5){
				ErrorSend('-100');
				exit();
			}
			
			$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
			$result = $DB->query("select rqstamp from xl_msgcode where phone=? and codeval=? and states = 1",array($phone,$codes));
			if(count($result)>0){
				$distime = time()-(int)$result[0]["rqstamp"];
				if($distime>300){
					//验证超时
					ErrorSend('-101');
				}
				else{
					
					$selfopenid = '';
					$userid = 0;
					
					//$uinfo = $DB->query("select * from xl_userinfo where wxopenidkey = ?",array($wxopenid));
					$uinfo = $DB->query("select * from xl_userinfo where phone = ?",array($phone));
					if(count($uinfo)>0){					
						$selfopenid = $uinfo[0]['openid'];
						$userid = $uinfo[0]['userid'];
					}
					else{
						//添加新用户
						$randHeadid = rand(1,7);
						//$headerUrl = ROOTURL.'img/headimg/'.$randHeadid.'.jpg';
						$headerUrl = ROOTURL.'img/headimg/aml_logo.png';
						
						
						$nameArr = ['叮当','小白','佩婷','大白','丸子','皮卡丘','巨本熊'];
						$rnames = $nameArr[$randHeadid-1];
						
						$uinfo = $DB->query("select * from xl_userinfo where wxopenidkey = ?",array($wxopenid));
						if(count($uinfo)>0){
							$userid = $uinfo[0]['userid'];
							$selfopenid = md5($userid.'-'.rand(100,999));
							$urows = $DB->query('update xl_userinfo set username=?,phone=?,role=?,accounts=?, openid = ?,headimgurl=?,regTime=?,sex=? where userid = ?',array($phone,$phone,User,0,$selfopenid,$headerUrl,time(),1,$userid));
						}						
						
					}
					
					
					/*$uinfo = $DB->query("select * from xl_userinfo where phone = ?",array($phone));
					if(count($uinfo)>0){					
						$selfopenid = $uinfo[0]['openid'];
						$userid = $uinfo[0]['userid'];
					}
					else{
						//添加新用户
						$randHeadid = rand(1,7);
						$headerUrl = ROOTURL.'img/headimg/'.$randHeadid.'.jpg';
						
						$nameArr = ['叮当','小白','佩婷','大白','丸子','皮卡丘','巨本熊'];
						$rnames = $nameArr[$randHeadid-1];
						
						$rows = $DB->query("insert into xl_userinfo(username,phone,role,accounts,openid,headimgurl,regTime,sex)VALUES(?,?,?,?,?,?,?,?)",array($phone,$phone,User,0,'',$headerUrl,time(),1));
						if($rows>0){
							
							$lastid = $DB->lastInsertId();
							$userid = $lastid;
							$selfopenid = md5($lastid.'-'.rand(100,999));
							$urows = $DB->query('update xl_userinfo set openid = ? where userid = ?',array($selfopenid,$lastid));					
						}
						
					}*/
					
					
					
					if($selfopenid!=''){
						//直接返回用户openid
						//存储一个selfopenid = md5(userid-rand(100-999))
						//发送一个 key = md5(rand(1000-99999))
						//设置一个Redis
						
						$keys = md5(rand(1000,99999));		
						
						/*$redis_ocean = new Redis();
						$redis_ocean->pconnect(RedISHost, RedISPORT);				
						$redis_ocean->setex($selfopenid, 60*60*24*3, $keys);*/
						
						$DB->query('update xl_userinfo set loginkey=? where userid = ?',array($keys,$userid));
						
						echo json_encode(array('error'=>'ok','openid'=>$selfopenid,'key'=>$keys,'userid'=>$userid));
					}
					else{
						ErrorSend('-102');
					}
				}
			}
			else{
				//短信验证失败
				ErrorSend('-103');
			}
			
			//ErrorSend('phone='.$phone.'--'.json_encode($result).'--code--'.$codes);
			$DB->CloseConnection();			
		}
		
		
		
	}

?>