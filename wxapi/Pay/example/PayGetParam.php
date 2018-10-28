<?php
ini_set('date.timezone','Asia/Shanghai');
error_reporting(E_ERROR);

require_once "../lib/WxPay.Api.php";
require_once "WxPay.JsApiPay.php";
require_once 'log.php';

//初始化日志
$logHandler= new CLogFileHandler("../logs/".date('Y-m-d').'.log');
$log = Log::Init($logHandler, 15);

class PayGetParam
{
	//支付参数
	public function PayParam($payArr){
		
		//①、获取用户openid
		
		$openId = $payArr['openid'];//$tools->GetOpenidByCode($payArr['code']);//$tools->GetOpenid();
		
		//②、统一下单
		$input = new WxPayUnifiedOrder();
		$input->SetBody($payArr['gname']);
		$input->SetAttach($payArr['attach']);
		$input->SetOut_trade_no(WxPayConfig::MCHID.date("YmdHis"));
		$input->SetTotal_fee($payArr['price']);
		$input->SetTime_start(date("YmdHis"));
		$input->SetTime_expire(date("YmdHis", time() + 600));
		$input->SetGoods_tag($payArr['gname']);
		$input->SetNotify_url($payArr['tourl']);
		$input->SetTrade_type("JSAPI");
		$input->SetOpenid($openId);
		$order = WxPayApi::unifiedOrder($input);
		
		$tools = new JsApiPay();
		$jsApiParameters = $tools->GetJsApiParameters($order);
		
		//获取共享收货地址js函数参数
		$editAddress = $tools->GetEditAddressParameters();
		
		$resultArr = array('jsapi'=>$jsApiParameters,'edit'=>$editAddress,'error'=>'ok');
		
		$json_objback = json_encode($resultArr);
		echo $json_objback;
	}
}