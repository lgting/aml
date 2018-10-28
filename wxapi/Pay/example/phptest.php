<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript" src="../../../../js/jquery-3.2.1.min.js" ></script>
		<script type="text/javascript" src="../payjs.js" ></script>
		<title></title>
	</head>
	<body>
		<button id='getuserInfoBtn'> getUserInfo </button>
		<button id='getgoodlist'> getgoodlist </button>
		<button id='paybtn'> Pay </button>
		<button id='payParambtn'> payParambtn </button>
		<button id='payDeposit'> payDeposit </button>
		
		<form name=alipayment id="alipay-form" action="http://www.jubenxiong.com/wxapi/Pay/example/pay.php" method=get target="_blank">  
			<input type="hidden" name="glass_trade_no" id="id_trade_no">  
		</form>
		
	</body>
	
	<script>
		
		function getQueryString(name) {  
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");  
			var r = window.location.search.substr(1).match(reg);  
			if (r != null) return unescape(r[2]); return null;  
		}  
		  
		payData.codes = getQueryString("code");
		console.log('code='+payData.codes);
		
		$(document).ready(function(){
		
			$("#getuserInfoBtn").click(function(){
				var backmsg = {type:'userinfo',openid:'sdasd'};
				jQuery.post("http://192.168.2.232/aml/php/ttl/userFunction.php",backmsg,function(respdata){
					var atk = respdata;
					console.log('res='+atk);
				});
			});
			
			$("#getgoodlist").click(function(){
				var backmsg = {type:'goodslist',openid:'sdasd',page:0};
				jQuery.post("http://192.168.2.232/aml/php/ttl/goodsFunction.php",backmsg,function(respdata){
					var atk = respdata;
					console.log('res='+atk);
				});
			});
			
			
			$("#paybtn").click(function(){
				var backmsg = {tourl:'http://www.jubenxiong.com/wxapi/Pay/example/phptest.php'}
				//http://www.jubenxiong.com/wxapi/Pay/example/oauth2.php
				jQuery.get("http://www.jubenxiong.com/wxapi/Pay/example/oauth2.php",backmsg,function(respdata){
					var atk = respdata;
					console.log('res='+atk);
				});
				/*var backmsg = {type:'buygoods'};
				jQuery.post("http://192.168.2.232/aml/php/ttl/goodsFunction.php",backmsg,function(respdata){
					var atk = respdata;
					console.log('res='+atk);
				});*/
			});
			
			
			
			
			var payPam;
			
			$("#payParambtn").click(function(){
				payData.notifyToUrl = '个合格合格';
				var backmsg = {type:'GoodsPayParam',goodsid:1,userid:1,code:payData.codes};			
				ToPay(backmsg);

			});
			
			$("#payDeposit").click(function(){
				
			});
			
		});
	</script>
</html>
