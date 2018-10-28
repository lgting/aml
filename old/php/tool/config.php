<?php

	define("DBHOST", "127.0.0.1");
	define("DBUSER", "root");	
	define("DBPASS", "jbx666");
	define("DATABASE", "xl_shop");
	define("RedISHost", "127.0.0.1");
	define("RedISPORT", "6379");
	define("User", 1);
	define("Boss", 2);
	define("SAlESMAN", 3);
	define("HelpSAlESMAN", 4);
	define("Agent", 5);
	define("ROOTURL", "http://www.amyshirley.com/aml/");
	define("APPID", "wxd42787e75e0a0d24");
	define("APPSECRET", "0d415f8b9fee845bd313df76955444b9");
	define("ComPanyName", "湫舜网络");
	define("Remark","最终解释权归湫舜网络所有");
	
	define("UseTypeSource", 1);
	define("UseTypeMoney", 2);
	//提现
	define("UseTypeWithdraw", 3);	
	
	define("AgentToHelpSellMoney", 0.05);
	
	
	//保存路径
	define("GoodsImgSavePath", "../../img/");
	//删除图片的前缀
	define("GoodsImgTopPath", "../../");
	//数据存储前缀
	define("GoodsImgDBTop", "img/");
	
	define("CouponUrl", "../../img/coupon/");
	define("CouponDBTop", "img/coupon/");
	
	//未使用
	define("NotUse", 0);
	//使用中
	define("UseIng", 1);
	//用完了
	define("EndUse", 2);
	//用完了
	define("ExitIng", 3);
	//用完了
	define("ExitEnd", 4);
	
	//未转赠
	define("NotGive", 0);
	//赠送者
	define("Give", 1);
	//被赠送者
	define("ToGive", 2);
?>