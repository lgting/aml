<?php
	header('Access-Control-Allow-Origin:*');
	require_once("tool/config.php");
	require_once("include.php");
	require_once("tool/util.php");
	
	use Module\UserModule;
	use Module\GoodsModule;
	
//	require_once("./Module/UserModule.php");
//	require("./tool/PDO.class.php");
//	use Module\ModuleTest;
//	use Module\UserModule;
	
//	$test = new ModuleTest();
//	echo $test->okFun('aaabbbccc');
//	echo ModuleTest::TestFun("6");
	if(isset($_POST['type'])){
		$types = $_POST['type'];
		switch($types){
			case "applysellman":
				$userM = new UserModule();
				$userM->ApplySellman($_POST); 
			break;
			case "showagentlist":
				//代理商下面的申请列表
				$userM = new UserModule();
				$userM->showAgentList($_POST);
			break;
			case "afubyphone":
				//代理商查找用户信息
				$userM = new UserModule();
				$userM->AgentFindUserByPhone($_POST);
			break;
			case "allaboss":
				//代理商下所有的商户信息
				$userM = new UserModule();
				$userM->AgengAllBoss($_POST);
			break;
			case "bthconn":
				//商户绑定美导
				$userM = new UserModule();
				$userM->BossToHelpManConn($_POST);
			break;
			case "acsorh":
				//代理商绑业务或者美导
				$userM = new UserModule();
				$userM->AgentCreateSellOrHelpSell($_POST);
			break;
			case "sourceshophome":
				//积分商城首页
				$goods = new GoodsModule();
				$goods->ShowSorceShop();
			break;
			case "busourcegoods":
				//购买积分商品
				$goods = new GoodsModule();
				$goods->BuySorceShop($_POST);
			break;
			case "sourcebuyhistroy":
				//积分购买记录
				$goods = new GoodsModule();
				$goods->buyList($_POST);
			break;
			case "usesourcegoods":
				//使用积分商品
				$goods = new GoodsModule();
				$goods->useSourceGoods($_POST);
			break;
			case "usesourcehand":
				//使用积分商品
				$goods = new GoodsModule();
				$goods->useSourceOrderState($_POST);
			break;
			case "goodsgive":
				//赠送商品
				$goods = new GoodsModule();
				$goods->GoodsGive($_POST);
			break;
			case "couponlist":
				//商品下的券
				$goods = new GoodsModule();
				$goods->GetCouponList($_POST);
			break;
			case "finduserbyphone":
				//按照手机号码查找用户
				$userM = new UserModule();
				$userM->FindUserByPhone($_POST);			
			break;
			case "showbossshop":
				//老板娘商品
				$goods = new GoodsModule();
				$goods->ShowBossShop($_POST);			
			break;
			case "exitgoods":
				//退款
				$goods = new GoodsModule();
				$goods->ExitGoods($_POST);
			break;
			case"exitexitgoods":
				//取消退款
				$goods = new GoodsModule();
				$goods->ExitExitGoods($_POST);
			break;
			case 'testAddMsg':
				$userM = new UserModule();
				$userM->testAddMsg($_POST);
			break;
			case 'updatecommission':
				$userM = new UserModule();
				$userM->updateCommission($_POST);
			break;
			case 'bossec':
				//商户取消绑定业务或者美导
				$userM = new UserModule();
				$userM->BossToExitConn($_POST);
			break;
			case 'exitsaleorhelp':
				//取消绑定业务或者美导
				$userM = new UserModule();
				$userM->ExitSaleOrHelp($_POST);
			break;
			case 'userinfoheart':
				//用户更新信息
				$userM = new UserModule();
				$userM->UserInfoHeart($_POST);
			break;
		}
	}
?>