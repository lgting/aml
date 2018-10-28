<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript" src="http://www.jubenxiong.com/js/jquery-3.2.1.min.js" ></script>
		<script type="text/javascript" src="../../jquery.form.js" ></script>
		<script type="text/javascript" src="../depositpay.js" ></script>
		<title></title>
	</head>
	<body>
		<button id='payDeposit'> payDeposit </button>
<!--		
		<form name=alipayment id="alipay-form" action="http://www.jubenxiong.com/wxapi/Pay/example/pay.php" method=get target="_blank">  
			<input type="hidden" name="glass_trade_no" id="id_trade_no">  
		</form>-->
		
	</body>
	
	<script>
		
		function getQueryString(name) {  
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");  
			var r = window.location.search.substr(1).match(reg);  
			if (r != null) return unescape(r[2]); return null;  
		}  
		  
		depositPayData.codes = getQueryString("code");
		console.log('code='+depositPayData.codes);
		
		$(document).ready(function(){			
			$("#payDeposit").click(function(){
				depositPayData.notifyToUrl = '支付完成咯';
				var backmsg = {type:'DepositPayParam',dptype:1,clientid:1,salesmanid:2,code:depositPayData.codes};			
				ToPay(backmsg);
			});
			
		});
	</script>
</html>
