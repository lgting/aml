//支付订单参数
var payPam;
//支付数据
var payData = {};

function ToPay(pdata){
	jQuery.post("http://www.jubenxiong.com/wxapi/Pay/example/pay.php",pdata,function(respdata){	
		var atk = respdata;
		console.log('atk='+atk);
		payPam = JSON.parse(respdata)
		if(payPam.error!='ok'){
			alert(payPam.error);
			return;
		}
		
		if (typeof WeixinJSBridge == "undefined"){
			if( document.addEventListener ){
				document.addEventListener('WeixinJSBridgeReady', editAddress, false);
			}else if (document.attachEvent){
				document.attachEvent('WeixinJSBridgeReady', editAddress); 
				document.attachEvent('onWeixinJSBridgeReady', editAddress);
			}
		}else{
			editAddress(JSON.parse(payPam.edit));
		}
	});
}


function editAddress(eobj)
{
	WeixinJSBridge.invoke(
		'editAddress',
		eobj,
		function(res){
			var value1 = res.proviceFirstStageName;
			var value2 = res.addressCitySecondStageName;
			var value3 = res.addressCountiesThirdStageName;
			var value4 = res.addressDetailInfo;
			var tel = res.telNumber;
			
			callpay();
		}
	);
}


function jsApiCall()
{
	WeixinJSBridge.invoke(
		'getBrandWCPayRequest',
		 JSON.parse(payPam.jsapi),
		function(res){
			WeixinJSBridge.log(res.err_msg);
			alert(res.err_code+res.err_desc+res.err_msg);
			if(res.err_msg == 'get_brand_wcpay_request:ok'){
				//to url
				alert('tourl='+payData.notifyToUrl);
			}
		}
	);
}

function callpay()
{
	if (typeof WeixinJSBridge == "undefined"){
		if( document.addEventListener ){
			document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
		}else if (document.attachEvent){
			document.attachEvent('WeixinJSBridgeReady', jsApiCall); 
			document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
		}
	}else{
		jsApiCall();
	}
}