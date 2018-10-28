<?php
	header('Access-Control-Allow-Origin:*');
	require_once("tool/config.php");
	require_once("include.php");
	require_once("tool/util.php");
	
	use Module\UserModule;
	use Module\GoodsModule;
	use Module\LoginModule;
	use Module\StoreModule;
	use Module\DB;

	$noLoginExitArr = ['login','goodsmgs','goodsbytp','topgoods','agentgoods','handleagentgoods','loginredis'];
	$controller = '';
	
	if(isset($_GET['c'])){
		$controller = 'Module\\'.$_GET['c'].'Module';
	}
	
	if(isset($_POST['type'])){
		$types = $_POST['type'];
		
		
		
		if($controller && $controller!=''){

			if(!class_exists($controller)){
				ReturnMsg('-1','class not find');
			}

			$opclass = new $controller();
	
			if(method_exists($opclass,$types)){
				
				if(!in_array($types,$noLoginExitArr)){
					CheckRouteToken();
				}
				
				$opclass->$types($_POST);
				exit();
			}
		}
		else{
			
			if(!in_array($types,$noLoginExitArr)){
				CheckRouteToken();
			}
			
		}
		
		
		switch($types){
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
			case 'homegoodslist':
				//首页商品列表
				$goods = new GoodsModule();
				$goods->GetHomeGoodsList();				
			break;
			case 'goodsbytp':
				//按照类型获得对应商品
				$goods = new GoodsModule();
				$goods->getGoodsArrByType();				
			break;
			case 'buylist':
				//购买记录
				$goods = new GoodsModule();
				$goods->buylist_handle();
			break;
			case 'login':				
				//登陆
				$logins = new LoginModule();
				$logins->LoginCheck();
			break;
			case 'goodsmgs':
				//商品详情
				$goods = new GoodsModule();
				$goods->GetGoodsMsg();
			break;
			case 'userinfo':
				//用户信息
				$userM = new UserModule();
				$userM->GetUserInfoClient();
			break;
			case 'extuser':
				//用户推荐列表
				$userM = new UserModule();
				$userM->extension_fun();
			break;
			case 'topgoods':
				$goods = new GoodsModule();
				$goods->getArrTopGoods();
			break;
			case 'tlogin':
				CheckToken();
			break;
			case 'agentgoods':
				//代理商商品购买列表
				$goods = new GoodsModule();
				$goods->AgentsBossGoods();
			break;
			case 'handleagentgoods':
				//代理处理购买商品
				$goods = new GoodsModule();
				$goods->AgentHandleBossGoods();
			break;
			case 'loginredis':
				$logins = new LoginModule();
				$logins->loginredis();
			break;
		}
	}
	
	//检验token 
	 function CheckRouteToken(){

		 if(!isset($_POST['openid']) || !isset($_POST['token'])){
			 ErrorSend('-1000');
			 exit();
		 }

		 $token = $_POST['token'];
		 $openid = $_POST['openid'];

		 $DB = new Db(DBHOST, DATABASE, DBUSER, DBPASS);
		 $result = $DB->query("SELECT loginkey from xl_userinfo where openid = ?",array($openid));
		 if(count($result)>0){
			 $keys = $result[0]['loginkey'];
			 $rtoken = md5($openid.$keys);
			 if($rtoken != $token){
				 //token 失效
				 //.$rtoken.'=='.$token.'openid='.$openid
				 ErrorSend('-1002');
				 $DB->Closeconnection();
				 exit();
			 }
		 }
		 else{
			 ErrorSend('-1001');
			 $DB->Closeconnection();
			 exit();
		 }
		 
	 }
	
	
?>