<?php
header('Access-Control-Allow-Origin:*');

require_once("../../php/tool/config.php");
require_once("../../php/tool/PDO.class.php");

ini_set("display_errors", "on");

require_once dirname(__DIR__) . '../api_sdk/vendor/autoload.php';

use Aliyun\Core\Config;
use Aliyun\Core\Profile\DefaultProfile;
use Aliyun\Core\DefaultAcsClient;
use Aliyun\Api\Sms\Request\V20170525\SendSmsRequest;
use Aliyun\Api\Sms\Request\V20170525\QuerySendDetailsRequest;

// 加载区域结点配置
Config::load();

if(isset($_POST['type'])){
	$type = $_POST['type'];
	if($type == 'msg'){
		sendMsgRequest();
	}
	else if($type == 'checkcode'){
		checkMsgCode();
	}
	else if($type == 'bankcard'){
		checkBandInfo();
	}
	else if($type == 'modify'){
		checkModify();
	}
	else if($type == 'loginmsg'){
		loginSendMsgRequest();
	}
	else if($type == 'bankname'){
		$json_string = file_get_contents('banklist.json');
		// 把JSON字符串转成PHP数组
		$data = json_decode($json_string, true);
		$bank = $_POST['bank'];
		echo $data[$bank];
	}
}



function checkBandInfo(){
	if(!isset($_POST['cardno'])){
		exit();
	}
	$url = "https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardNo=";
	$url = $url.$_POST["cardno"]."&cardBinCheck=true";
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_TIMEOUT, 500);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
	curl_setopt($curl, CURLOPT_URL, $url);

	$res = curl_exec($curl);
	curl_close($curl);

	echo $res;
}

function checkMsgCode(){
	if(!isset($_POST['userid'])){
		exit();
	}
	
	if(!isset($_POST['phone'])){
		exit();
	}
	
	if(!isset($_POST['code'])){
		exit();
	}
	
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $DB->query("select rqstamp from xl_msgcode where userid=? and phone=? and codeval=?",array($_POST['userid'],$_POST['phone'],$_POST['code']));
	if(count($result)>0){
		$distime = time()-(int)$result[0]["rqstamp"];
		if($distime>300){
			$res = array("status"=>"202");
			echo json_encode($res);
		}
		else{
			$row = $DB->query("update xl_userinfo set phone=? where userid=?",array($_POST['phone'],$_POST['userid']));
			if($row>0){
				$res = array("status"=>"200");
				echo json_encode($res);
			}
			else{
				$res = array("status"=>"205");
				echo json_encode($res);
			}
		}
	}
	else{
		$res = array("status"=>"201");
		echo json_encode($res);
	}
	$DB->CloseConnection();
}

function checkModify(){
	if(!isset($_POST['userid'])){
		exit();
	}
	if(!isset($_POST['phone'])){
		exit();
	}
	if(!isset($_POST['code'])){
		exit();
	}
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $DB->query("select rqstamp from xl_msgcode where userid=? and phone=? and codeval=?",array($_POST['userid'],$_POST['phone'],$_POST['code']));
	if(count($result)>0){
		$distime = time()-(int)$result[0]["rqstamp"];
		if($distime>300){
			$res = array("status"=>"202");
			echo json_encode($res);
		}
		else{
			$res = array("status"=>"200");
			echo json_encode($res);
		}
	}
	else{
		$res = array("status"=>"201");
		echo json_encode($res);
	}
	$DB->CloseConnection();
}

function sendMsgRequest(){
	if(!isset($_POST['userid'])){
		exit();
	}
	if(!isset($_POST['phone'])){
		exit();
	}
	$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
	$result = $DB->query("select userid from xl_userinfo where phone=? and userid!=?",array($_POST['phone'],$_POST['userid']));
	if(count($result) > 0){
		echo '102';
		$DB->CloseConnection();
		return;
	}
	header('Content-Type: text/plain; charset=utf-8');
	$demo = new SmsDemo(
		"LTAINIk3IGczW61G",
		"NshNE1FiXyyRu0ZD5lokSgUiWqN28U"
	);
	$msgcode = rand(1000,9999);
	
	//暧昧雪梨短信验证
	$response = $demo->sendSms(
		"湫舜网络短信验证", // 短信签名
		"SMS_115395130", // 短信模板编号
		$_POST['phone'], // 短信接收者
		Array(  // 短信模板中字段的值
		    "code"=>$msgcode
		),
		"123"
	);
	
	
	/*$response = $demo->sendSms(
		"湫舜网络短信验证", // 短信签名
		"SMS_122287681", // 短信模板编号
		$_POST['phone'], // 短信接收者
		Array(  // 短信模板中字段的值
		    "code"=>$msgcode,
		    "product"=>"暧昧雪梨"
		),
		"123"
	);*/
	
	if($response->Code == "OK"){
		//$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("select * from xl_msgcode where userid=?",array($_POST['userid']));
		$row = 0;
		if(count($result)>0){
			$row = $DB->query("update xl_msgcode set requestid=?,codeval=?,rqstamp=?,phone=? where userid=?",array($response->RequestId,$msgcode,time(),$_POST['phone'],$_POST['userid']));
		}
		else{
			$row = $DB->query("insert into xl_msgcode(requestid,codeval,userid,rqstamp,phone) values(?,?,?,?,?)",array($response->RequestId,$msgcode,$_POST['userid'],time(),$_POST['phone']));
		}
		if($row>0){
			echo json_encode($response);
		}
		else{
			echo '';
		}
	}
	else{
		echo json_encode($response);
	}
	$DB->CloseConnection();
}

//登陆发送
function loginSendMsgRequest(){

	if(!isset($_POST['phone'])){
		echo json_encode(array('Code'=>'-100'));
		exit();
	}
	
	$phone = $_POST['phone'];
	
	//header('Content-Type: text/plain; charset=utf-8');
	$demo = new SmsDemo(
		"LTAINIk3IGczW61G",
		"NshNE1FiXyyRu0ZD5lokSgUiWqN28U"
	);
	$msgcode = rand(1000,9999);
	
	//暧昧雪梨短信验证
	$response = $demo->sendSms(
		"湫舜网络短信验证", // 短信签名
		"SMS_115395130", // 短信模板编号
		$phone, // 短信接收者
		Array(  // 短信模板中字段的值
		    "code"=>$msgcode
		),
		"123"
	);
	

	
	//$response->setError($response->Code);
	
	if(strtolower($response->Code) == "ok"){
		$DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		$result = $DB->query("select * from xl_msgcode where phone=? and states = 1",array($phone));
		$row = 0;
		
		if(count($result)>0){
			$codeid = $result[0]['codeid'];
			$row = $DB->query("update xl_msgcode set requestid=?,codeval=?,rqstamp=? where codeid=?",array($response->RequestId,$msgcode,time(),$codeid));
		}
		else{
			$row = $DB->query("insert into xl_msgcode(requestid,codeval,userid,rqstamp,phone,states) values(?,?,?,?,?,?)",array($response->RequestId,$msgcode,0,time(),$phone,1));
		}
		$DB->CloseConnection();
		//$response->setError('ok');
	}
	
	
	echo json_encode($response);
	
	
}


/**
 * Class SmsDemo
 *
 * @property \Aliyun\Core\DefaultAcsClient acsClient
 */
class SmsDemo
{

    /**
     * 构造器
     *
     * @param string $accessKeyId 必填，AccessKeyId
     * @param string $accessKeySecret 必填，AccessKeySecret
     */
    public function __construct($accessKeyId, $accessKeySecret)
    {

        // 短信API产品名
        $product = "Dysmsapi";

        // 短信API产品域名
        $domain = "dysmsapi.aliyuncs.com";

        // 暂时不支持多Region
        $region = "cn-hangzhou";

        // 服务结点
        $endPointName = "cn-hangzhou";

        // 初始化用户Profile实例
        $profile = DefaultProfile::getProfile($region, $accessKeyId, $accessKeySecret);

        // 增加服务结点
        DefaultProfile::addEndpoint($endPointName, $region, $product, $domain);

        // 初始化AcsClient用于发起请求
        $this->acsClient = new DefaultAcsClient($profile);
    }

    /**
     * 发送短信范例
     *
     * @param string $signName <p>
     * 必填, 短信签名，应严格"签名名称"填写，参考：<a href="https://dysms.console.aliyun.com/dysms.htm#/sign">短信签名页</a>
     * </p>
     * @param string $templateCode <p>
     * 必填, 短信模板Code，应严格按"模板CODE"填写, 参考：<a href="https://dysms.console.aliyun.com/dysms.htm#/template">短信模板页</a>
     * (e.g. SMS_0001)
     * </p>
     * @param string $phoneNumbers 必填, 短信接收号码 (e.g. 12345678901)
     * @param array|null $templateParam <p>
     * 选填, 假如模板中存在变量需要替换则为必填项 (e.g. Array("code"=>"12345", "product"=>"阿里通信"))
     * </p>
     * @param string|null $outId [optional] 选填, 发送短信流水号 (e.g. 1234)
     * @return stdClass
     */
    public function sendSms($signName, $templateCode, $phoneNumbers, $templateParam = null, $outId = null) {

        // 初始化SendSmsRequest实例用于设置发送短信的参数
        $request = new SendSmsRequest();

        // 必填，设置雉短信接收号码
        $request->setPhoneNumbers($phoneNumbers);

        // 必填，设置签名名称
        $request->setSignName($signName);

        // 必填，设置模板CODE
        $request->setTemplateCode($templateCode);

        // 可选，设置模板参数
        if($templateParam) {
            $request->setTemplateParam(json_encode($templateParam));
        }

        // 可选，设置流水号
        if($outId) {
            $request->setOutId($outId);
        }

        // 发起访问请求
        $acsResponse = $this->acsClient->getAcsResponse($request);

        // 打印请求结果
        // var_dump($acsResponse);

        return $acsResponse;

    }

    /**
     * 查询短信发送情况范例
     *
     * @param string $phoneNumbers 必填, 短信接收号码 (e.g. 12345678901)
     * @param string $sendDate 必填，短信发送日期，格式Ymd，支持近30天记录查询 (e.g. 20170710)
     * @param int $pageSize 必填，分页大小
     * @param int $currentPage 必填，当前页码
     * @param string $bizId 选填，短信发送流水号 (e.g. abc123)
     * @return stdClass
     */
    public function queryDetails($phoneNumbers, $sendDate, $pageSize = 10, $currentPage = 1, $bizId=null) {

        // 初始化QuerySendDetailsRequest实例用于设置短信查询的参数
        $request = new QuerySendDetailsRequest();

        // 必填，短信接收号码
        $request->setPhoneNumber($phoneNumbers);

        // 选填，短信发送流水号
        $request->setBizId($bizId);

        // 必填，短信发送日期，支持近30天记录查询，格式Ymd
        $request->setSendDate($sendDate);

        // 必填，分页大小
        $request->setPageSize($pageSize);

        // 必填，当前页码
        $request->setCurrentPage($currentPage);

        // 发起访问请求
        $acsResponse = $this->acsClient->getAcsResponse($request);

        // 打印请求结果
        // var_dump($acsResponse);

        return $acsResponse;
    }

}

// 调用示例：
//
//
//
//echo "SmsDemo::queryDetails\n";
//$response = $demo->queryDetails(
//  "12345678901",  // phoneNumbers 电话号码
//  "20170718", // sendDate 发送时间
//  10, // pageSize 分页大小
//  1 // currentPage 当前页码
//  // "abcd" // bizId 短信发送流水号，选填
//);
//
//print_r($response);
?>