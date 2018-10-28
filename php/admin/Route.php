<?php
	header('Access-Control-Allow-Origin:*');
	require_once("../tool/config.php");
	require_once("include.php");
	require_once("../tool/util.php");
	
	use Module\AdminModule;
	use Module\Goods;
	use Module\Users;
	if(!IsAuthority()){
		return;
	}

	if(isset($_POST['type'])){
		$types = $_POST['type'];
		switch($types){
			case "adminlist":
				 $admins = new AdminModule();
				 $admins->showAdminList_fun();
				 break;
			break;
			case "showadminpower":
				 $admins = new AdminModule();
				 $admins->ShowAdminPower_fun();
				 break;
			break;
			case "adminuser":
				$admins = new AdminModule();
				$admins->AddAdmin_fun($_POST);
				break;
			case "editadminrole":
				$admins = new AdminModule();
				$admins->EditAdminRole_fun($_POST);				
				break;
			case "editAdmin":
				$admins = new AdminModule();
				$admins->EditAdminUserPower_fun($_POST);
				break;
			case "addadminrole":
				$admins = new AdminModule();
				$admins->addAdminRole_fun($_POST);
				break;
			case "deleteAdmin":
				$admins = new AdminModule();
				$admins->deleteAdmin_fun($_POST);
				break;
			case 'shipmentlist':
				//出货
				$goods = new Goods();
				$goods->ShipmentList_fun($_POST);
				break;
			case 'sshipmentbytime':
				//按照时间查找用户出货记录
				$goods = new Goods();
				$goods->selectShipmentByTime_fun($_POST);
				break;
			case 'sshipmentmsg':
				//对货明细
				$goods = new Goods();
				$goods->selectShipmentmsg_fun($_POST);
				break;
			case 'agentlist':
				//代理商列表
				$users = new Users();
				$users->AgentList_fun($_POST);			
				break;
			case 'depositlist':
				//押金交付列表
				$users = new Users();
				$users->Depositlist_fun($_POST);	
				break;
			case 'deposit':
				$users = new Users();
				$users->Deposit_Fun($_POST);	
				break;
			case 'deposit':
				$users = new Users();
				$users->Deposit_Fun($_POST);	
				break;
			case 'updeposit':
				$users = new Users();
				$users->UpdateDeposit_Fun($_POST);
				break; 
			case 'deletegoods':
				//删除商品
				$goods = new Goods();
				$goods->DeleteGoods_Fun();
				break; 
		}
	}
?>