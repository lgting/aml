<?php
header('Access-Control-Allow-Origin:*');
require_once "WxTransfers.Config.php";
require_once "WxHongBao.Api.php";
require_once("../../../php/tool/PDO.class.php");
require_once("../../../php/tool/config.php");
require_once("../../../php/tool/util.php");

if(isset($_GET['type'])){
	$msgtypes = $_GET['type'];
	if($msgtypes == 'getMoney'){
		$openid = $_GET['openid'];
		$DB = new Db(DBHOST, SMDATABASE, DBUSER, DBPASS);
		
		$resultNum = $DB->query("select * from jbx_ysys");
		//var_dump($resultNum);
		$curNum = $resultNum[0]['countnum'];
		$haveMoney = $resultNum[0]['haveMoney'];
		$AllNum =  $resultNum[0]['AllNum'];
		
		if($haveMoney == 0){
			ErrorSend('fail');
			$DB->CloseConnection();
			exit();
		}
		$result = $DB->query("select * from jbx_yanzhi where openid = ?",array($openid));
		if(count($result)>0){
			$nums = $result[0]['nums'];
			$yanzhi = $result[0]['yanzhi'];
			
			/*if($yanzhi == 0){
				ErrorSend('-102');
				$DB->CloseConnection();
				exit();
			}*/
			
			$errorid = '0';
			if($nums!=0){
				//已经抽奖
				$errorid = '-100';
				ErrorSend($errorid);
				$DB->CloseConnection();
				exit();
			}
			else{
				$comNum = 65;
				
				if($yanzhi<75){
					$comNum = 50;
				}
				/*else if($yanzhi<65){
					$comNum = 75;
				}*/
				
				if($curNum<30){
					$comNum = 50;
				}

				$randid = rand(1,100);
				$backArr = array();
				if($randid > $comNum){
					//抽奖成功
					
					$testdemo = new WxHongBaoDemo();
					$drawstate = $testdemo->index($openid,"恭喜你中奖了");
					//$drawstate = 'SUCCESS';
					if($drawstate == 'SUCCESS'){
						$errorid = 'ok';
						$DB->query("update jbx_yanzhi set nums = 1,getmoney=1 where openid = ?",array($openid));
						$curNum +=1;
						$DB->query("update jbx_ysys set countnum = ".$curNum);
					}
					else if($drawstate == 'NOTENOUGH'){
						$errorid = 'failno';
					}
					else{
						$errorid = $drawstate;
					}
				}
				else{
					//抽奖失败
					$errorid = 'fail'.$comNum;
				}
				
				$DB->query("update jbx_yanzhi set nums = 1 where openid = ?",array($openid));
				
				$AllNum +=1;
				$DB->query("update jbx_ysys set AllNum = ".$AllNum);
				ErrorSend($errorid);
				$DB->CloseConnection();
			}

			
		}
		else{
			ErrorSend('fail');
		}

	}
	else if($msgtypes == 'xxlgetMoney'){
		xxl_fun();
	}
}


if(isset($_POST['type'])){
	if($_POST['type'] == 'xxlgetMoney'){
		xxl_fun();
	}
}

function xxl_fun(){
	$openid = $_POST['openid'];
	$DB = new Db(DBHOST, SMDATABASE, DBUSER, DBPASS);
	
	$resultNum = $DB->query("select * from jbx_xxlnum");
	//var_dump($resultNum);
	$curNum = $resultNum[0]['countnum'];
	$haveMoney = $resultNum[0]['haveMoney'];
	$AllNum =  $resultNum[0]['AllNum'];
	
	if($haveMoney == 0){
		ErrorSend('fail');
		$DB->CloseConnection();
		exit();
	}
	$result = $DB->query("select * from jbx_xxl where openid = ?",array($openid));
	if(count($result)>0){
		$nums = $result[0]['nums'];
		$source = $result[0]['jifen'];
		
		$errorid = '0';
		if($nums!=0){
			//已经抽奖
			$errorid = '-100';
			ErrorSend($errorid);
			$DB->CloseConnection();
			exit();
		}
		else{
			$comNum = 55;
			
			if($curNum<30){
				$comNum =50;
			}
			
			$comNum = 0;
			
			$randid = rand(1,100);
			$backArr = array();
			if($randid > $comNum){
				//抽奖成功
				
				$testdemo = new WxHongBaoDemo();
				$drawstate = $testdemo->index($openid,"恭喜你中奖了");
				//$drawstate = 'SUCCESS';
				if($drawstate == 'SUCCESS'){
					$errorid = 'ok';
					$DB->query("update jbx_xxl set nums = 1,getmoney=1 where openid = ?",array($openid));
					$curNum +=1;
					$DB->query("update jbx_xxlnum set countnum = ".$curNum);
				}
				else if($drawstate == 'NOTENOUGH'){
					$errorid = 'failno';
				}
				else{
					$errorid = $drawstate;
				}
			}
			else{
				//抽奖失败
				$errorid = 'fail'.$comNum;
			}
			
			$DB->query("update jbx_xxl set nums = 1 where openid = ?",array($openid));
			
			$AllNum +=1;
			$DB->query("update jbx_xxlnum set AllNum = ".$AllNum);
			ErrorSend($errorid);
			$DB->CloseConnection();
		}		
	}
	else{
		ErrorSend('fail');
	}
}

class WxHongBaoDemo{
	
	public function index($openid,$wishing){
		
		$path = WxTransfersConfig::getRealPath(); // 证书文件路径
		$config['wxappid'] = WxTransfersConfig::APPID;
		$config['mch_id'] = WxTransfersConfig::MCHID;
		$config['key'] = WxTransfersConfig::KEY;
		$config['PARTNERKEY'] = WxTransfersConfig::KEY;
		$config['api_cert'] = $path . WxTransfersConfig::SSLCERT_PATH;
		$config['api_key'] = $path . WxTransfersConfig::SSLKEY_PATH;
		$config['rootca'] = $path . WxTransfersConfig::SSLROOTCA;
		
		$wxtran=new WxHongBao($config);
		
		$wxtran->setLogFile('c:\transfers.log');//日志地址
		
		//转账
		$data=array(			
			'send_name'=>'苏州巨本熊',//商户名字
			're_openid'=>$openid,//openid
			'total_amount'=>100,//分
			'total_num'=>1,
			'wishing'=>$wishing,//描述
			'client_ip'=>$wxtran->getServerIp(),//服务器IP地址
			'act_name'=>'巨本熊颜值红包',
			'remark'=>'最终解释权归巨本熊所有'
		);
		
		//SUCCESS
		$result = $wxtran->transfers($data);
		if($result == 'SUCCESS'){
			return 'SUCCESS';
		}
		else{
			if($wxtran->error == 'NOTENOUGH'){
				//余额不足
				return 'NOTENOUGH';
			}
			else{
				return $wxtran->error;
			}
		}
		return 'fail';
	}
	
}




