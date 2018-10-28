/*
Navicat MySQL Data Transfer

Source Server         : self2
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : xl_shop2

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2018-04-25 17:10:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for adminuser
-- ----------------------------
DROP TABLE IF EXISTS `adminuser`;
CREATE TABLE `adminuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `userpwd` varchar(255) NOT NULL,
  `userkey` varchar(255) NOT NULL DEFAULT '0',
  `role` int(11) NOT NULL DEFAULT '1' COMMENT '角色',
  `createTime` varchar(11) NOT NULL COMMENT '任命时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminuser
-- ----------------------------
INSERT INTO `adminuser` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '', '3', '');
INSERT INTO `adminuser` VALUES ('2', 'admin2', 'e10adc3949ba59abbe56e057f20f883e', '0', '2', '');
INSERT INTO `adminuser` VALUES ('3', 'admin3', 'e10adc3949ba59abbe56e057f20f883e', '0', '2', '1520328311');
INSERT INTO `adminuser` VALUES ('4', 'admin4', 'e10adc3949ba59abbe56e057f20f883e', '0', '3', '1520328330');
INSERT INTO `adminuser` VALUES ('6', 'adminttl', '5c041969cd90b7f100c738ea581e6c14', '0', '3', '1524194910');
INSERT INTO `adminuser` VALUES ('7', 'admintpx', '5c041969cd90b7f100c738ea581e6c14', '0', '3', '1524194928');

-- ----------------------------
-- Table structure for xl_adminpower
-- ----------------------------
DROP TABLE IF EXISTS `xl_adminpower`;
CREATE TABLE `xl_adminpower` (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `names` varchar(100) NOT NULL COMMENT '功能名称',
  `funname` varchar(100) NOT NULL COMMENT '服务器方法名称',
  `pagename` varchar(100) NOT NULL COMMENT '客户端对应page',
  `groupid` int(11) NOT NULL DEFAULT '0' COMMENT '分组编号',
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_adminpower
-- ----------------------------
INSERT INTO `xl_adminpower` VALUES ('1', '查看商品', 'SelectGoods', 'goodslist', '1');
INSERT INTO `xl_adminpower` VALUES ('2', '添加商品', 'AddGoods', 'addgoods', '1');
INSERT INTO `xl_adminpower` VALUES ('3', '编辑商品', 'editGoods_fun', '', '1');
INSERT INTO `xl_adminpower` VALUES ('4', '查看优惠券', 'couponlist', 'couponList', '1');
INSERT INTO `xl_adminpower` VALUES ('5', '添加优惠券', 'addcoupon', 'addcoupon', '1');
INSERT INTO `xl_adminpower` VALUES ('6', '编辑优惠券', 'editcoupon', '', '1');
INSERT INTO `xl_adminpower` VALUES ('7', '删除优惠券', 'deletecoupon', '', '1');
INSERT INTO `xl_adminpower` VALUES ('8', '绑定优惠券', 'bindcoupon', '', '1');
INSERT INTO `xl_adminpower` VALUES ('9', '提现功能', 'tomoney', 'withdrawlist', '2');
INSERT INTO `xl_adminpower` VALUES ('10', '查看转账记录', 'drawrecord_handle', 'drawrecord', '2');
INSERT INTO `xl_adminpower` VALUES ('11', '购买记录', 'buylist_fun', 'buylist', '2');
INSERT INTO `xl_adminpower` VALUES ('12', '积分购买记录', 'sourcebuylist', 'sourcebuylist', '2');
INSERT INTO `xl_adminpower` VALUES ('13', '用户收支明细', 'useList', 'moneyuse', '2');
INSERT INTO `xl_adminpower` VALUES ('14', '查看用户列表', 'getUserList', 'userlist', '3');
INSERT INTO `xl_adminpower` VALUES ('15', '编辑用户信息', 'EditAdmin', '', '3');
INSERT INTO `xl_adminpower` VALUES ('16', '查看用户下线', 'offlinelist', 'OfflineUser', '3');
INSERT INTO `xl_adminpower` VALUES ('17', '管理员', 'EditAdminRole_fun', 'adminList', '3');
INSERT INTO `xl_adminpower` VALUES ('18', '添加管理员', 'AddAdmin_fun', 'addAdmin', '3');
INSERT INTO `xl_adminpower` VALUES ('19', '编辑管理员角色', '', 'adminRoleList', '3');
INSERT INTO `xl_adminpower` VALUES ('20', '删除管理员', 'deleteAdmin_fun', '', '3');
INSERT INTO `xl_adminpower` VALUES ('21', '添加管理员角色', 'addAdminRole_fun', 'addAdminRole', '3');
INSERT INTO `xl_adminpower` VALUES ('22', '退款信息', '', 'ExitGoods', '2');
INSERT INTO `xl_adminpower` VALUES ('23', '编辑管理员权限', 'EditAdminUserPower_fun', '', '3');
INSERT INTO `xl_adminpower` VALUES ('24', '押金列表', '', 'depositlist', '3');
INSERT INTO `xl_adminpower` VALUES ('25', '转移用户', 'transferUser', '', '3');
INSERT INTO `xl_adminpower` VALUES ('26', '押金配置列表', '', 'deposit', '2');
INSERT INTO `xl_adminpower` VALUES ('27', '修改押金配置', 'UpdateDeposit_Fun', '', '2');
INSERT INTO `xl_adminpower` VALUES ('28', '删除商品', 'DeleteGoods_Fun', '', '1');

-- ----------------------------
-- Table structure for xl_adminpowergroup
-- ----------------------------
DROP TABLE IF EXISTS `xl_adminpowergroup`;
CREATE TABLE `xl_adminpowergroup` (
  `gid` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限组',
  `gname` varchar(100) NOT NULL COMMENT '组对应名称',
  PRIMARY KEY (`gid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_adminpowergroup
-- ----------------------------
INSERT INTO `xl_adminpowergroup` VALUES ('1', '商品权限');
INSERT INTO `xl_adminpowergroup` VALUES ('2', '财务权限');
INSERT INTO `xl_adminpowergroup` VALUES ('3', '用户权限');

-- ----------------------------
-- Table structure for xl_adminrole
-- ----------------------------
DROP TABLE IF EXISTS `xl_adminrole`;
CREATE TABLE `xl_adminrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `rolename` varchar(100) NOT NULL COMMENT '角色名字',
  `powerid` varchar(100) DEFAULT '' COMMENT '权限字符串',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_adminrole
-- ----------------------------
INSERT INTO `xl_adminrole` VALUES ('2', '管理员', '1,2,3,4,5,6,7,8,14');
INSERT INTO `xl_adminrole` VALUES ('3', '超级管理员', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28');
INSERT INTO `xl_adminrole` VALUES ('10', '角色管理员', '16');
INSERT INTO `xl_adminrole` VALUES ('11', '财务管理员', null);

-- ----------------------------
-- Table structure for xl_agentuser
-- ----------------------------
DROP TABLE IF EXISTS `xl_agentuser`;
CREATE TABLE `xl_agentuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT '0' COMMENT '代理商编号',
  `userid` int(11) DEFAULT '0' COMMENT '用户编号',
  `conndate` varchar(11) NOT NULL COMMENT '关联时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_agentuser
-- ----------------------------
INSERT INTO `xl_agentuser` VALUES ('165', '0', '509', '1524394718');
INSERT INTO `xl_agentuser` VALUES ('164', '0', '359', '1524224818');
INSERT INTO `xl_agentuser` VALUES ('163', '0', '368', '1524224706');
INSERT INTO `xl_agentuser` VALUES ('162', '330', '339', '1524205319');
INSERT INTO `xl_agentuser` VALUES ('161', '330', '335', '1524199007');
INSERT INTO `xl_agentuser` VALUES ('159', '0', '328', '1524129562');
INSERT INTO `xl_agentuser` VALUES ('158', '326', '325', '1524129301');
INSERT INTO `xl_agentuser` VALUES ('160', '326', '329', '1524134279');
INSERT INTO `xl_agentuser` VALUES ('155', '326', '327', '1524128590');

-- ----------------------------
-- Table structure for xl_applylist
-- ----------------------------
DROP TABLE IF EXISTS `xl_applylist`;
CREATE TABLE `xl_applylist` (
  `applyid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `applyuid` int(11) NOT NULL DEFAULT '0' COMMENT '申请人userid',
  `applytouid` int(11) NOT NULL DEFAULT '0' COMMENT '向谁申请的userid',
  `applytime` varchar(11) NOT NULL DEFAULT '申请时间' COMMENT '0',
  `applytype` int(11) NOT NULL DEFAULT '0' COMMENT '申请类型',
  PRIMARY KEY (`applyid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_applylist
-- ----------------------------

-- ----------------------------
-- Table structure for xl_bankinfos
-- ----------------------------
DROP TABLE IF EXISTS `xl_bankinfos`;
CREATE TABLE `xl_bankinfos` (
  `bankid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `bankname` varchar(120) NOT NULL,
  `code` varchar(15) NOT NULL,
  `banknum` varchar(19) NOT NULL,
  `bankaccount` varchar(50) NOT NULL,
  PRIMARY KEY (`bankid`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_bankinfos
-- ----------------------------
INSERT INTO `xl_bankinfos` VALUES ('12', '22', '中国工商银行', 'ICBC', '6222021001005520781', '孙成培');
INSERT INTO `xl_bankinfos` VALUES ('13', '21', '中国农业银行', 'ABC', '6228480038536623978', '123456');
INSERT INTO `xl_bankinfos` VALUES ('14', '156', '中国工商银行', 'ICBC', '6222021001100330775', '陈雪丽');
INSERT INTO `xl_bankinfos` VALUES ('15', '157', '中国工商银行', 'ICBC', '6222021001100330775', '陈雪丽');
INSERT INTO `xl_bankinfos` VALUES ('16', '153', '中国工商银行', 'ICBC', '6222021001100330775', '陈雪丽');
INSERT INTO `xl_bankinfos` VALUES ('17', '317', '中国工商银行', 'ICBC', '6222021001005530784', '123');
INSERT INTO `xl_bankinfos` VALUES ('20', '325', '中国工商银行', 'ICBC', '6222021001005530784', '打钩');

-- ----------------------------
-- Table structure for xl_buylist
-- ----------------------------
DROP TABLE IF EXISTS `xl_buylist`;
CREATE TABLE `xl_buylist` (
  `buyid` int(11) NOT NULL AUTO_INCREMENT,
  `serialnum` varchar(100) NOT NULL COMMENT '标识符',
  `setsname` varchar(255) NOT NULL COMMENT '名字',
  `buydate` varchar(15) NOT NULL COMMENT '购买日期',
  `giftnum` int(11) DEFAULT '0' COMMENT '礼品券数量',
  `expnum` int(11) DEFAULT '0' COMMENT '体验券数量',
  `bindinfo` varchar(50) DEFAULT NULL COMMENT '绑定信息（老板娘或者业务员编号）',
  `notes` text,
  `userid` int(11) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL COMMENT '价格',
  `goodsid` int(11) DEFAULT NULL COMMENT '商品编号',
  `givestate` int(11) DEFAULT '0' COMMENT '赠送状态',
  `orderstate` int(11) DEFAULT '0' COMMENT '订单状态',
  `giveuid` int(11) DEFAULT '0' COMMENT '赠送与被赠送用户编号',
  `givetime` varchar(11) DEFAULT '0' COMMENT '赠送时间',
  `buyNum` int(11) DEFAULT '1' COMMENT '购买数量',
  `exitTime` varchar(11) NOT NULL DEFAULT '' COMMENT '退款时间',
  PRIMARY KEY (`buyid`)
) ENGINE=MyISAM AUTO_INCREMENT=295 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_buylist
-- ----------------------------
INSERT INTO `xl_buylist` VALUES ('287', '4200000084201804202303723288', '克丽缇娜推广卡', '1524209789', '1', '3', '0', 'buy', '346', '10000.00', '78', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('288', '4200000093201804202284602322', '克丽缇娜推广卡', '1524213808', '1', '3', '0', 'buy', '384', '10000.00', '78', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('289', '4200000100201804202553428210', '克丽缇娜推广卡', '1524216143', '1', '3', '0', 'buy', '366', '10000.00', '78', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('290', '4200000096201804202357228400', '克丽缇娜推广卡', '1524224616', '0', '2', '0', 'buy', '368', '10000.00', '78', '0', '1', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('291', '4200000089201804202446676411', '克丽缇娜推广卡', '1524224798', '0', '2', '0', 'buy', '359', '10000.00', '78', '0', '1', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('292', '4200000097201804212862616743', '克丽缇娜推广卡', '1524281450', '1', '3', '0', 'buy', '500', '10000.00', '78', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('293', '4200000084201804223968190272', '克丽缇娜推广卡', '1524393005', '1', '1', '0', 'buy', '508', '1990.00', '78', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('294', '4200000081201804224091565235', '克丽缇娜推广卡', '1524393381', '0', '1', '0', 'buy', '509', '1990.00', '78', '0', '1', '0', '0', '1', '');

-- ----------------------------
-- Table structure for xl_clientslist
-- ----------------------------
DROP TABLE IF EXISTS `xl_clientslist`;
CREATE TABLE `xl_clientslist` (
  `listid` int(11) NOT NULL AUTO_INCREMENT,
  `clientid` varchar(50) NOT NULL,
  `belongto` varchar(50) NOT NULL,
  `conndate` varchar(15) NOT NULL,
  `agentid` int(11) DEFAULT '0' COMMENT '代理商编号',
  PRIMARY KEY (`listid`)
) ENGINE=MyISAM AUTO_INCREMENT=282 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_clientslist
-- ----------------------------
INSERT INTO `xl_clientslist` VALUES ('281', '509', '339', '1524394718', '0');
INSERT INTO `xl_clientslist` VALUES ('280', '359', '339', '1524224818', '0');
INSERT INTO `xl_clientslist` VALUES ('279', '368', '339', '1524224706', '0');
INSERT INTO `xl_clientslist` VALUES ('278', '339', '335', '1524205319', '330');
INSERT INTO `xl_clientslist` VALUES ('277', '339', '330', '1524205319', '330');
INSERT INTO `xl_clientslist` VALUES ('274', '328', '325', '1524129562', '0');
INSERT INTO `xl_clientslist` VALUES ('276', '335', '330', '1524199007', '330');
INSERT INTO `xl_clientslist` VALUES ('272', '325', '326', '1524129301', '326');
INSERT INTO `xl_clientslist` VALUES ('275', '329', '325', '1524134279', '326');
INSERT INTO `xl_clientslist` VALUES ('269', '327', '326', '1524128590', '326');

-- ----------------------------
-- Table structure for xl_consumelist
-- ----------------------------
DROP TABLE IF EXISTS `xl_consumelist`;
CREATE TABLE `xl_consumelist` (
  `consumeid` int(11) NOT NULL AUTO_INCREMENT,
  `coupon` varchar(30) NOT NULL,
  `cptype` int(11) DEFAULT '1',
  `username` varchar(50) NOT NULL,
  `consumedate` varchar(15) NOT NULL,
  `notes` text,
  `userid` int(11) DEFAULT '0' COMMENT '用户编号',
  `goodsid` int(11) DEFAULT '0' COMMENT '默认编号',
  `buyid` int(11) DEFAULT '0' COMMENT '购买编号',
  `bossid` int(11) NOT NULL DEFAULT '0' COMMENT '在那个老板娘那里使用的',
  PRIMARY KEY (`consumeid`)
) ENGINE=MyISAM AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_consumelist
-- ----------------------------
INSERT INTO `xl_consumelist` VALUES ('101', '22', '1', '329', '1524134527', '', '329', '39', '280', '325');
INSERT INTO `xl_consumelist` VALUES ('100', '4', '1', '329', '1524134362', '', '329', '31', '279', '325');
INSERT INTO `xl_consumelist` VALUES ('99', '4', '1', '329', '1524134279', '', '329', '31', '274', '325');
INSERT INTO `xl_consumelist` VALUES ('98', '22', '1', '328', '1524134080', '', '328', '39', '277', '325');
INSERT INTO `xl_consumelist` VALUES ('97', '21', '1', '328', '1524134072', '', '328', '39', '277', '325');
INSERT INTO `xl_consumelist` VALUES ('96', '23', '1', '328', '1524133889', '', '328', '39', '277', '325');
INSERT INTO `xl_consumelist` VALUES ('95', '4', '1', '328', '1524133677', '', '328', '31', '278', '325');
INSERT INTO `xl_consumelist` VALUES ('94', '4', '1', '328', '1524129737', '', '328', '31', '271', '325');
INSERT INTO `xl_consumelist` VALUES ('93', '4', '1', '328', '1524129562', '', '328', '31', '269', '325');
INSERT INTO `xl_consumelist` VALUES ('102', '23', '1', '329', '1524134548', '', '329', '39', '280', '325');
INSERT INTO `xl_consumelist` VALUES ('103', '21', '1', '329', '1524134560', '', '329', '39', '280', '325');
INSERT INTO `xl_consumelist` VALUES ('104', '33', '1', '368', '1524224706', '', '368', '78', '290', '339');
INSERT INTO `xl_consumelist` VALUES ('105', '32', '1', '368', '1524224715', '', '368', '78', '290', '339');
INSERT INTO `xl_consumelist` VALUES ('106', '33', '1', '359', '1524224818', '', '359', '78', '291', '339');
INSERT INTO `xl_consumelist` VALUES ('107', '32', '1', '359', '1524224835', '', '359', '78', '291', '339');
INSERT INTO `xl_consumelist` VALUES ('108', '33', '1', '509', '1524394718', '', '509', '78', '294', '339');

-- ----------------------------
-- Table structure for xl_coupon
-- ----------------------------
DROP TABLE IF EXISTS `xl_coupon`;
CREATE TABLE `xl_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cname` varchar(255) DEFAULT NULL COMMENT '名字',
  `message` varchar(255) DEFAULT NULL COMMENT '优惠券描述',
  `iconurl` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `type` int(11) DEFAULT NULL COMMENT '类型（待定）',
  `money` float DEFAULT NULL COMMENT '减掉的钱',
  `starttime` int(11) DEFAULT NULL COMMENT '活动开始时间',
  `endtime` int(11) DEFAULT NULL COMMENT '活动结束时间',
  `addtime` varchar(15) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_coupon
-- ----------------------------
INSERT INTO `xl_coupon` VALUES ('4', '面膜券', '发酵玻尿酸补水面膜', 'img/coupon/couponhead.png', '1', '100', '0', '2592000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('5', '精华液券', '枸杞灵芝原浆鲜颜活肌精华液', 'img/coupon/couponhead.png', '1', '100', '0', '2592000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('6', '美霜券', '科妍鲜颜酵美霜', 'img/coupon/couponhead.png', '1', '100', '0', '5184000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('7', '醒乳券', '科妍鲜颜酵醒乳', 'img/coupon/couponhead.png', '1', '100', '0', '7776000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('8', '面霜券', '密酿鲜颜活肌原浆面霜', 'img/coupon/couponhead.png', '1', '100', '0', '10368000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('9', '肌原水券', '青柠檬鲜颜活肌原水', 'img/coupon/couponhead.png', '1', '100', '0', '12960000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('10', '丰胸券', '3d丰胸，立马变大', 'img/coupon/couponhead.png', '2', '1000', '0', '15552000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('11', '瘦身券', '立体瘦身，婀罗多姿', 'img/coupon/couponhead.png', '2', '2000', '0', '18144000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('17', '艾灸券｜美丽故事', '凭此券可至美丽故事美容美甲SPA会所享受艾灸一次', 'img/coupon/couponhead.png', '2', null, '0', '3456000', '1510907158');
INSERT INTO `xl_coupon` VALUES ('14', '美甲券｜美丽故事', '凭此券可至美丽故事美容美甲SPA会所享受美甲一次', 'img/coupon/couponhead.png', '1', null, '0', '3456000', '1510904948');
INSERT INTO `xl_coupon` VALUES ('18', '拔罐券｜美丽故事', '凭此券可至美丽故事美容美甲SPA会所享受拔罐一次', 'img/coupon/couponhead.png', '2', null, '0', '3456000', '1510907537');
INSERT INTO `xl_coupon` VALUES ('21', '材木始科研洁面乳', '', 'img/coupon/couponhead.png', '1', null, '0', '2592000', '1522115074');
INSERT INTO `xl_coupon` VALUES ('22', '逦妍国际面部七合一护理', '', 'img/coupon/couponhead.png', '2', null, '0', '2592000', '1522115137');
INSERT INTO `xl_coupon` VALUES ('23', '逦妍国际背部病理性调理', '', 'img/coupon/couponhead.png', '2', null, '0', '2592000', '1522115220');
INSERT INTO `xl_coupon` VALUES ('30', '克丽缇娜（光复西路店）项目体验券', '', 'img/coupon/couponhead.png', '2', null, '0', '2592000', '1524187253');
INSERT INTO `xl_coupon` VALUES ('31', '克丽缇娜（光复西路店）项目体验券', '', 'img/coupon/couponhead.png', '2', null, '0', '2592000', '1524187320');
INSERT INTO `xl_coupon` VALUES ('32', '克丽缇娜（光复西路店）项目体验券', '', 'img/coupon/couponhead.png', '2', null, '0', '2592000', '1524187346');
INSERT INTO `xl_coupon` VALUES ('33', '克丽缇娜（光复西路店）精美礼品券', '', 'img/coupon/couponhead.png', '1', null, '0', '2592000', '1524187375');

-- ----------------------------
-- Table structure for xl_couponlist
-- ----------------------------
DROP TABLE IF EXISTS `xl_couponlist`;
CREATE TABLE `xl_couponlist` (
  `cpid` int(11) NOT NULL AUTO_INCREMENT,
  `cpuuid` varchar(35) NOT NULL COMMENT '礼品券编号',
  `belongto` varchar(50) NOT NULL COMMENT '属于userid',
  `datefrom` varchar(15) NOT NULL,
  `dateto` varchar(15) NOT NULL,
  `cptype` int(11) DEFAULT '1',
  `goodsid` int(11) DEFAULT '0' COMMENT '优惠券对应商品编号',
  `buyid` int(11) DEFAULT '0' COMMENT '购买唯一编号',
  PRIMARY KEY (`cpid`)
) ENGINE=MyISAM AUTO_INCREMENT=1224 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_couponlist
-- ----------------------------
INSERT INTO `xl_couponlist` VALUES ('1222', '32', '509', '1524393381', '1526985381', '1', '78', '294');
INSERT INTO `xl_couponlist` VALUES ('1221', '33', '508', '1524393005', '1526985005', '1', '78', '293');
INSERT INTO `xl_couponlist` VALUES ('1220', '32', '508', '1524393005', '1526985005', '1', '78', '293');
INSERT INTO `xl_couponlist` VALUES ('1219', '33', '500', '1524281450', '1526873450', '1', '78', '292');
INSERT INTO `xl_couponlist` VALUES ('1218', '32', '500', '1524281450', '1526873450', '1', '78', '292');
INSERT INTO `xl_couponlist` VALUES ('1217', '31', '500', '1524281450', '1526873450', '1', '78', '292');
INSERT INTO `xl_couponlist` VALUES ('1216', '30', '500', '1524281450', '1526873450', '1', '78', '292');
INSERT INTO `xl_couponlist` VALUES ('1213', '31', '359', '1524224798', '1526816798', '1', '78', '291');
INSERT INTO `xl_couponlist` VALUES ('1212', '30', '359', '1524224798', '1526816798', '1', '78', '291');
INSERT INTO `xl_couponlist` VALUES ('1209', '31', '368', '1524224616', '1526816616', '1', '78', '290');
INSERT INTO `xl_couponlist` VALUES ('1208', '30', '368', '1524224616', '1526816616', '1', '78', '290');
INSERT INTO `xl_couponlist` VALUES ('1207', '33', '366', '1524216143', '1526808143', '1', '78', '289');
INSERT INTO `xl_couponlist` VALUES ('1206', '32', '366', '1524216143', '1526808143', '1', '78', '289');
INSERT INTO `xl_couponlist` VALUES ('1205', '31', '366', '1524216143', '1526808143', '1', '78', '289');
INSERT INTO `xl_couponlist` VALUES ('1204', '30', '366', '1524216143', '1526808143', '1', '78', '289');
INSERT INTO `xl_couponlist` VALUES ('1203', '33', '384', '1524213808', '1526805808', '1', '78', '288');
INSERT INTO `xl_couponlist` VALUES ('1202', '32', '384', '1524213808', '1526805808', '1', '78', '288');
INSERT INTO `xl_couponlist` VALUES ('1201', '31', '384', '1524213808', '1526805808', '1', '78', '288');
INSERT INTO `xl_couponlist` VALUES ('1200', '30', '384', '1524213808', '1526805808', '1', '78', '288');
INSERT INTO `xl_couponlist` VALUES ('1199', '33', '346', '1524209789', '1526801789', '1', '78', '287');
INSERT INTO `xl_couponlist` VALUES ('1198', '32', '346', '1524209789', '1526801789', '1', '78', '287');
INSERT INTO `xl_couponlist` VALUES ('1197', '31', '346', '1524209789', '1526801789', '1', '78', '287');
INSERT INTO `xl_couponlist` VALUES ('1196', '30', '346', '1524209789', '1526801789', '1', '78', '287');
INSERT INTO `xl_couponlist` VALUES ('1195', '6', '326', '1524146641', '1529330641', '1', '42', '286');
INSERT INTO `xl_couponlist` VALUES ('1194', '5', '326', '1524146641', '1526738641', '1', '42', '286');
INSERT INTO `xl_couponlist` VALUES ('1193', '4', '326', '1524146641', '1526738641', '1', '42', '286');
INSERT INTO `xl_couponlist` VALUES ('1192', '6', '325', '1524146604', '1529330604', '1', '42', '285');
INSERT INTO `xl_couponlist` VALUES ('1191', '5', '325', '1524146604', '1526738604', '1', '42', '285');
INSERT INTO `xl_couponlist` VALUES ('1190', '4', '325', '1524146604', '1526738604', '1', '42', '285');
INSERT INTO `xl_couponlist` VALUES ('1189', '4', '325', '1524146584', '1526738584', '1', '31', '284');
INSERT INTO `xl_couponlist` VALUES ('1188', '6', '329', '1524142898', '1529326898', '1', '42', '283');
INSERT INTO `xl_couponlist` VALUES ('1187', '5', '329', '1524142898', '1526734898', '1', '42', '283');
INSERT INTO `xl_couponlist` VALUES ('1186', '4', '329', '1524142898', '1526734898', '1', '42', '283');
INSERT INTO `xl_couponlist` VALUES ('1185', '6', '325', '1524142890', '1529326890', '1', '42', '282');
INSERT INTO `xl_couponlist` VALUES ('1182', '4', '329', '1524135350', '1526727350', '1', '31', '281');
INSERT INTO `xl_couponlist` VALUES ('1183', '4', '325', '1524142890', '1526734890', '1', '42', '282');
INSERT INTO `xl_couponlist` VALUES ('1173', '21', '325', '1524133313', '1526725313', '1', '39', '276');
INSERT INTO `xl_couponlist` VALUES ('1172', '22', '325', '1524133313', '1526725313', '1', '39', '276');
INSERT INTO `xl_couponlist` VALUES ('1171', '23', '325', '1524133313', '1526725313', '1', '39', '276');
INSERT INTO `xl_couponlist` VALUES ('1184', '5', '325', '1524142890', '1526734890', '1', '42', '282');
INSERT INTO `xl_couponlist` VALUES ('1169', '4', '325', '1524132869', '1526724869', '1', '31', '272');
INSERT INTO `xl_couponlist` VALUES ('1167', '4', '325', '1524129678', '1526721678', '1', '31', '270');
INSERT INTO `xl_couponlist` VALUES ('1165', '4', '325', '1524129415', '1526721415', '1', '31', '268');

-- ----------------------------
-- Table structure for xl_coupontogoods
-- ----------------------------
DROP TABLE IF EXISTS `xl_coupontogoods`;
CREATE TABLE `xl_coupontogoods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goodsid` int(11) DEFAULT NULL COMMENT '商品编号',
  `couponid` int(11) DEFAULT NULL COMMENT '优惠券编号',
  `nums` int(11) DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_coupontogoods
-- ----------------------------
INSERT INTO `xl_coupontogoods` VALUES ('75', '98', '8', '1');
INSERT INTO `xl_coupontogoods` VALUES ('74', '97', '5', '1');
INSERT INTO `xl_coupontogoods` VALUES ('73', '96', '8', '1');
INSERT INTO `xl_coupontogoods` VALUES ('72', '87', '7', '1');
INSERT INTO `xl_coupontogoods` VALUES ('70', '89', '8', '1');
INSERT INTO `xl_coupontogoods` VALUES ('69', '91', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('68', '93', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('67', '94', '7', '1');
INSERT INTO `xl_coupontogoods` VALUES ('66', '95', '8', '1');
INSERT INTO `xl_coupontogoods` VALUES ('65', '81', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('64', '82', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('59', '84', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('62', '85', '7', '1');
INSERT INTO `xl_coupontogoods` VALUES ('63', '83', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('71', '88', '5', '1');
INSERT INTO `xl_coupontogoods` VALUES ('60', '86', '9', '1');
INSERT INTO `xl_coupontogoods` VALUES ('57', '79', '9', '1');
INSERT INTO `xl_coupontogoods` VALUES ('27', '22', '9', '1');
INSERT INTO `xl_coupontogoods` VALUES ('28', '23', '7', '1');
INSERT INTO `xl_coupontogoods` VALUES ('29', '24', '9', '1');
INSERT INTO `xl_coupontogoods` VALUES ('30', '25', '7', '1');
INSERT INTO `xl_coupontogoods` VALUES ('31', '26', '6', '1');
INSERT INTO `xl_coupontogoods` VALUES ('32', '28', '9', '1');
INSERT INTO `xl_coupontogoods` VALUES ('33', '29', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('34', '30', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('35', '31', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('36', '32', '8', '1');
INSERT INTO `xl_coupontogoods` VALUES ('54', '78', '32', '1');
INSERT INTO `xl_coupontogoods` VALUES ('53', '78', '33', '1');
INSERT INTO `xl_coupontogoods` VALUES ('40', '39', '23', '1');
INSERT INTO `xl_coupontogoods` VALUES ('41', '39', '22', '1');
INSERT INTO `xl_coupontogoods` VALUES ('42', '39', '21', '1');

-- ----------------------------
-- Table structure for xl_deposit
-- ----------------------------
DROP TABLE IF EXISTS `xl_deposit`;
CREATE TABLE `xl_deposit` (
  `dpid` int(11) NOT NULL AUTO_INCREMENT,
  `dptype` int(11) NOT NULL,
  `dpsum` decimal(10,2) NOT NULL,
  `dpname` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`dpid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of xl_deposit
-- ----------------------------
INSERT INTO `xl_deposit` VALUES ('2', '1', '0.01', '业务绑定商户押金');

-- ----------------------------
-- Table structure for xl_depositlist
-- ----------------------------
DROP TABLE IF EXISTS `xl_depositlist`;
CREATE TABLE `xl_depositlist` (
  `depositid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `salesman` varchar(50) NOT NULL,
  `sum` int(11) DEFAULT '0',
  `depositdate` varchar(15) NOT NULL,
  `tactionid` varchar(255) DEFAULT NULL COMMENT '微信订单号',
  `dpname` varchar(255) DEFAULT NULL COMMENT '描述',
  `dptype` int(11) DEFAULT NULL COMMENT '押金编号',
  PRIMARY KEY (`depositid`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_depositlist
-- ----------------------------
INSERT INTO `xl_depositlist` VALUES ('48', '325', '329', '1', '1524129301', '4200000085201804191307203152', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('49', '339', '335', '1', '1524205319', '4200000093201804201993643169', '业务绑定商户押金', '1');

-- ----------------------------
-- Table structure for xl_drawrecord
-- ----------------------------
DROP TABLE IF EXISTS `xl_drawrecord`;
CREATE TABLE `xl_drawrecord` (
  `recordid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `drawdate` varchar(15) NOT NULL,
  `finishdate` varchar(15) NOT NULL,
  `sum` decimal(11,2) DEFAULT '0.00',
  `notes` text,
  PRIMARY KEY (`recordid`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_drawrecord
-- ----------------------------
INSERT INTO `xl_drawrecord` VALUES ('13', '325', '1524130111', '1524131843', '1.00', null);
INSERT INTO `xl_drawrecord` VALUES ('14', '325', '1524132026', '1524132140', '3.00', null);
INSERT INTO `xl_drawrecord` VALUES ('15', '325', '1524134633', '1524134674', '1.00', null);
INSERT INTO `xl_drawrecord` VALUES ('16', '325', '1524191153', '1524191153', '1.00', null);
INSERT INTO `xl_drawrecord` VALUES ('17', '325', '1524191305', '1524191305', '1.00', null);
INSERT INTO `xl_drawrecord` VALUES ('18', '325', '1524192516', '1524192516', '1.00', null);

-- ----------------------------
-- Table structure for xl_extension
-- ----------------------------
DROP TABLE IF EXISTS `xl_extension`;
CREATE TABLE `xl_extension` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `extid` int(11) DEFAULT NULL COMMENT '用户推荐人的id',
  `goodsid` int(11) DEFAULT NULL,
  `conndate` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_extension
-- ----------------------------
INSERT INTO `xl_extension` VALUES ('62', '342', '509', '78', '1524393381');
INSERT INTO `xl_extension` VALUES ('61', '342', '508', '78', '1524393005');
INSERT INTO `xl_extension` VALUES ('60', '339', '366', '78', '1524216143');
INSERT INTO `xl_extension` VALUES ('59', '339', '346', '78', '1524209789');
INSERT INTO `xl_extension` VALUES ('58', '325', '329', '31', '1524135350');

-- ----------------------------
-- Table structure for xl_goods
-- ----------------------------
DROP TABLE IF EXISTS `xl_goods`;
CREATE TABLE `xl_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gname` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `message` varchar(255) DEFAULT NULL COMMENT '商品介绍',
  `price` decimal(11,2) DEFAULT NULL COMMENT '商品价格',
  `isshow` tinyint(4) DEFAULT NULL COMMENT '商品价格',
  `addtime` varchar(11) DEFAULT NULL COMMENT '添加时间',
  `giveIntegral` int(11) DEFAULT NULL COMMENT '积分',
  `commissionboss` decimal(11,2) DEFAULT NULL COMMENT '老板娘提成',
  `commissionsalesman` decimal(11,2) DEFAULT NULL COMMENT '业务员提成',
  `htmlmsg` text,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0 套餐  1商品  2积分商品',
  `icon` varchar(255) DEFAULT NULL,
  `buymessage` varchar(255) DEFAULT '0' COMMENT '购买秒速',
  `showType` int(11) DEFAULT NULL COMMENT '显示类型',
  `buyType` int(11) DEFAULT '1' COMMENT '1 购买一次  2 购买多次',
  `extsource` int(11) DEFAULT '0' COMMENT '推荐人积分',
  `commagent` decimal(11,2) DEFAULT '0.00' COMMENT '代理商的分成',
  `buynum` int(11) DEFAULT '0' COMMENT '购买总数量',
  `topicon` varchar(100) DEFAULT '0' COMMENT '首页图片',
  `agentid` int(11) DEFAULT '0' COMMENT '代理商编号',
  `typetop` tinyint(4) NOT NULL DEFAULT '0' COMMENT '同类型顶部',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goods
-- ----------------------------
INSERT INTO `xl_goods` VALUES ('22', '青柠檬鲜颜活肌原水', '青柠檬鲜颜活肌原水', '119.00', '0', '1510898169', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510907244488.jpg\"></p><p><img src=\"img/nx_1510907244862.jpg\"></p><p><img src=\"img/nx_1510907244648.jpg\"></p><p><img src=\"img/nx_1510907244818.jpg\"></p><p><img src=\"img/nx_1510907244244.jpg\"></p><p><img src=\"img/nx_1510907244647.jpg\"></p><p><img src=\"img/nx_1510907244621.jpg\"></p><p><img src=\"img/nx_1510907244416.jpg\"></p><p><br></p>', '1', 'img/20180327/nx_1522134648403.jpg', '', '3', '2', '0', '0.00', '42', 'img/20180327/nx_1522134648403.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('23', '科妍鲜颜洁面乳', '才木始科妍鲜颜洁面乳', '78.00', '0', '1510903955', '0', '0.00', '0.00', '<p><img src=\"img/20180327/nx_1522134760998.jpg\"></p>', '1', 'img/nx_1510903955333.jpg', '', '3', '2', '0', '0.00', '12', 'img/nx_1510903955333.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('24', '科妍鲜颜酵活水', '才木始科妍鲜颜酵活水', '158.00', '0', '1510907757', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510907757814.jpg\"></p><p><img src=\"img/nx_1510907757937.jpg\"></p><p><img src=\"img/nx_1510907757907.jpg\"></p><p><img src=\"img/nx_1510907757355.jpg\"></p><p><img src=\"img/nx_1510907757461.jpg\"></p><p><img src=\"img/nx_1510907757720.jpg\"></p><p><img src=\"img/nx_1510907757865.jpg\"></p>', '0', 'img/nx_1510907757654.jpg', '鲜活发酵护肤，令皮肤基底真正的吃饱喝足！', '2', '1', '0', '0.10', '0', 'img/nx_1510907757654.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('25', '科妍鲜颜酵醒乳', '才木始科妍鲜颜酵醒乳', '188.00', '0', '1510908277', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510908277864.jpg\"></p><p><img src=\"img/nx_1510908277345.jpg\"></p><p><img src=\"img/nx_1510908277846.jpg\"></p><p><img src=\"img/nx_1510908277469.jpg\"></p><p><img src=\"img/nx_1510908277201.jpg\"></p>', '1', 'img/nx_1510908277397.jpg', '高营养的鲜活小分子，令肌肤欲罢不能的吃起来！', '2', '1', '0', '0.10', '0', 'img/nx_1510908277397.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('26', '科妍鲜颜酵美霜', '折煞从古至今的会美之人', '10.00', '0', '1510909708', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510909708750.jpg\"></p><p><img src=\"img/nx_1510909708548.jpg\"></p><p><img src=\"img/nx_1510909708577.jpg\"></p><p><img src=\"img/nx_1510909708823.jpg\"></p><p><img src=\"img/nx_1510909708475.jpg\"></p><p><br></p>', '2', 'img/nx_1510909708178.jpg', '', '3', '2', '0', '0.10', '0', 'img/nx_1510909708178.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('79', '玫瑰密酿酵活⽔水', '玫瑰一发酵，容颜就发笑', '198.00', '1', '1524195427', '0', '0.00', '0.00', '<p class=\"ql-align-center\"><img src=\"img/20180420/nx_1524198410904.jpg\"><img src=\"img/20180420/nx_1524198410955.jpg\"><img src=\"img/20180420/nx_1524198410763.jpg\"><img src=\"img/20180420/nx_1524198410901.jpg\"><img src=\"img/20180420/nx_1524198410655.jpg\"><img src=\"img/20180420/nx_1524198410165.jpg\"><img src=\"img/20180420/nx_1524198410182.jpg\"><img src=\"img/20180420/nx_1524198410444.jpg\"><img src=\"img/20180420/nx_1524198410832.jpg\"><img src=\"img/20180420/nx_1524198410934.jpg\"></p>', '0', 'img/20180420/nx_1524195427699.jpg', '', '2', '2', '0', '0.00', '0', '', '0', '0');
INSERT INTO `xl_goods` VALUES ('28', '玫瑰密酿酵活水', '才木始玫瑰密酿酵活水', '198.00', '0', '1510911858', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510911858355.jpg\"></p><p><img src=\"img/nx_1510911858492.jpg\"></p><p><img src=\"img/nx_1510911858106.jpg\"></p><p><img src=\"img/nx_1510911858716.jpg\"></p><p><img src=\"img/nx_1510911858482.jpg\"></p>', '2', 'img/nx_1510911858554.jpg', '', '2', '2', '0', '0.10', '0', 'img/nx_1510911858554.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('29', '科妍谷物舒颜酵醒面膜贴', '肌肤之美在于体验', '140.00', '0', '1510912228', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510912228370.jpg\"></p><p><img src=\"img/nx_1510912228828.jpg\"></p><p><img src=\"img/nx_1510912228353.jpg\"></p><p><img src=\"img/nx_1510912228155.jpg\"></p><p><br></p>', '2', 'img/nx_1510912228594.jpg', '早在几百年前，古代女子常常把米糠磨碎后装在布袋里浸泡在水中，每天早晚用米糠水来洗脸，长期坚持下来，肌肤变得水嫩白净。', '3', '2', '0', '0.10', '0', 'img/nx_1510912228594.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('30', '密酿补水原浆发酵面膜贴', '美白淡斑 补水保湿', '195.00', '0', '1510912724', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510912724620.jpg\"></p><p><img src=\"img/nx_1510912724947.jpg\"></p><p><img src=\"img/nx_1510912724148.jpg\"></p><p><img src=\"img/nx_1510912724149.jpg\"></p>', '2', 'img/nx_1510912724274.jpg', '', '2', '2', '0', '0.10', '0', 'img/nx_1510912724274.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('31', '密酿靓肌原浆发酵面膜贴', '紧致肌肤 恢复弹性', '0.10', '0', '1510913076', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510913076544.jpg\"></p><p><img src=\"img/nx_1510913076662.jpg\"></p><p><img src=\"img/nx_1510913076868.jpg\"></p>', '1', 'img/nx_1510913076478.jpg', '', '2', '2', '10', '0.30', '20', 'img/nx_1510913076478.jpg', '326', '0');
INSERT INTO `xl_goods` VALUES ('32', '密酿鲜颜活肌原浆面霜', '不稀释，无添加', '289.00', '0', '1510913431', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510913431169.jpg\"></p><p><img src=\"img/nx_1510913431185.jpg\"></p><p><img src=\"img/nx_1510913431713.jpg\"></p><p><img src=\"img/nx_1510913431245.jpg\"></p><p><img src=\"img/nx_1510913431901.jpg\"></p><p><img src=\"img/nx_1510913431477.jpg\"></p><p><img src=\"img/nx_1510913431436.jpg\"></p>', '2', 'img/nx_1510913431349.jpg', '', '2', '2', '0', '0.10', '0', 'img/nx_1510913431349.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('33', '积分商品', '积分商品特殊', '10.00', '0', '1520736674', '2', '0.00', '0.00', '<p class=\"ql-indent-1 ql-align-center\">无敌的积分。积分是多么寂寞</p><p class=\"ql-indent-1 ql-align-center\"><img src=\"img/20180311/nx_1520736674249.png\"></p><p class=\"ql-indent-1 ql-align-center\"><img src=\"img/20180311/nx_1520736674176.png\"></p>', '2', 'img/20180311/nx_1520736674903.png', '积分商品', '2', '2', '2', '0.10', '0', '0', '0', '0');
INSERT INTO `xl_goods` VALUES ('37', '198元塑时代瘦身卡', '女人需要拿的出手的身材', '198.00', '0', '1521869927', '0', '0.00', '0.00', '<p><img src=\"img/20180324/nx_1521880764186.png\"></p>', '1', 'img/20180324/nx_1521880764758.png', '立即获得塑时代产品体验券2张', '1', '1', '0', '0.65', '2', 'img/20180324/nx_1521880764758.png', '0', '0');
INSERT INTO `xl_goods` VALUES ('39', '9.9元推广卡', '逦妍国际', '100.00', '0', '1522048712', '20', '0.00', '0.00', '<p><img src=\"img/20180327/nx_1522114784576.png\"></p><p><img src=\"img/20180327/nx_1522114784860.jpg\"></p>', '1', 'img/20180327/nx_1522114784291.png', '', '1', '1', '0', '0.00', '33', 'img/20180327/nx_1522114784291.png', '0', '0');
INSERT INTO `xl_goods` VALUES ('78', '克丽缇娜推广卡', '克丽缇娜（光复西路店）', '19.90', '1', '1524169045', '0', '1.00', '0.00', '<p><img src=\"img/20180422/nx_1524364206711.png\"></p><p><img src=\"img/20180420/nx_1524169654156.png\"></p><p><img src=\"img/20180420/nx_1524169783534.png\"></p><p><img src=\"img/20180420/nx_1524187814120.png\"></p>', '10', 'img/20180420/nx_1524170066820.jpg', '', '1', '1', '0', '0.00', '8', 'img/20180420/nx_1524170066820.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('81', '发酵玻尿酸补水面膜', '深沉补水，长效锁水', '100.00', '1', '1524197810', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524203435919.jpg\"></p>', '1', 'img/20180420/nx_1524197810593.jpg', '深沉补水，长效锁水', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524197810593.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('82', '活性炭清肤净颜鲜肌面膜', '跟黑头、白头说BYEBYE!', '119.00', '1', '1524197978', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524203393663.jpg\"></p>', '1', 'img/20180420/nx_1524205021962.jpg', '跟黑头、白头说BYEBYE!', '1', '2', '0', '0.00', '0', 'img/20180420/nx_1524203998177.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('83', '精萃恒效水嫩鲜肌面膜', '长期缺水肌的救星', '139.00', '1', '1524198091', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524203341465.jpg\"></p>', '1', 'img/20180420/nx_1524204989538.jpg', '长期缺水肌的救星', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524203926806.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('84', '科妍⾕谷物舒颜酵醒⾯面膜贴 ', '全方位密集改善,遇见最美的自己', '140.00', '1', '1524198166', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524198219269.jpg\"></p>', '0', 'img/20180420/nx_1524202031251.jpg', '全方位密集改善,遇见最美的自己', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524202031856.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('85', '科妍鲜颜洁⾯面乳', '让肌肤倍显水嫩的植物精粹', '78.00', '1', '1524198250', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524203293264.jpg\"></p>', '1', 'img/20180420/nx_1524204947708.jpg', '让肌肤倍显水嫩的植物精粹', '3', '2', '0', '0.00', '0', 'img/20180420/nx_1524204055131.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('87', '科妍鲜颜酵醒乳', '拯救肌肤之饿', '188.00', '1', '1524198467', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524203265973.jpg\"></p>', '1', 'img/20180420/nx_1524198467707.jpg', '拯救肌肤之饿', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524198467707.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('88', '玫瑰发酵鲜颜活肌精华液', '从未改变的美丽承若', '299.00', '1', '1524198584', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524198613451.jpg\"></p>', '0', 'img/20180420/nx_1524202082990.jpg', '从未改变的美丽承若', '3', '2', '0', '0.00', '0', 'img/20180420/nx_1524202082558.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('89', '科妍鲜颜酵美霜', '点滴承诺 极简既奢', '198.00', '1', '1524198642', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524203196994.jpg\"></p>', '1', 'img/20180420/nx_1524198642352.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524198642352.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('93', '密酿靓肌原浆面膜贴', '擦亮肌肤，击退暗沉元凶', '195.00', '1', '1524203226', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524203226362.jpg\"></p>', '2', 'img/20180420/nx_1524203226884.jpg', '擦亮肌肤，击退暗沉元凶', '3', '2', '0', '0.00', '0', '', '0', '0');
INSERT INTO `xl_goods` VALUES ('91', '密酿补⽔水原浆发酵⾯面膜贴', '挡不住的水诱惑！密酿补水原浆面膜贴', '195.00', '1', '1524198912', '0', '0.00', '0.00', '<p><img src=\"img/20180422/nx_1524377644288.jpg\"></p>', '1', 'img/20180420/nx_1524198912479.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524206543827.jpg', '0', '0');
INSERT INTO `xl_goods` VALUES ('94', '密酿鲜颜活肌原浆乳液', '密酿鲜颜活肌原浆乳液.没有一滴外来水', '239.00', '1', '1524203611', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524203611456.jpg\"></p>', '2', 'img/20180420/nx_1524203611431.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524203790630.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('95', '密酿鲜颜活肌原浆⾯面霜', '没有一滴外来水，成分首位即精华，解密肌肤冻龄密码', '289.00', '1', '1524204246', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524205210329.jpg\"></p>', '2', 'img/20180420/nx_1524205210151.jpg', '没有一滴外来水，成分首位即精华，解密肌肤冻龄密码', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524205210912.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('96', '⾃自然美肌⽓气垫保护霜', '不可抗拒的气垫保护霜，白天阻断黑，晚上代谢黑', '168.00', '1', '1524204541', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524204541354.jpg\"></p>', '2', 'img/20180420/nx_1524204541753.jpg', '不可抗拒的气垫保护霜，白天阻断黑，晚上代谢黑', '3', '2', '0', '0.00', '0', 'img/20180420/nx_1524204541589.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('97', '科妍致盈优养精华油', '焕醒生肌，质感美丽', '288.00', '1', '1524205847', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524205847639.jpg\"></p>', '2', 'img/20180420/nx_1524205846250.jpg', '焕醒生肌，质感美丽', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524205846545.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('98', '还诱明眸酵醒眼霜', '活性植物精粹.深入基底修护，绽放双眸迷人光彩', '298.00', '1', '1524206258', '0', '0.90', '0.00', '<p><img src=\"img/20180420/nx_1524206258237.jpg\"></p>', '2', 'img/20180420/nx_1524206258200.jpg', '活性植物精粹.深入基底修护，绽放双眸迷人光彩', '3', '2', '0', '0.00', '0', 'img/20180420/nx_1524206258877.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('86', '科妍鲜颜酵活⽔水', '点滴承认。即简即奢', '158.00', '1', '1524198328', '0', '0.00', '0.00', '<p><img src=\"img/20180420/nx_1524198359397.jpg\"></p>', '0', 'img/20180420/nx_1524202397584.jpg', '点滴承认。即简即奢', '2', '2', '0', '0.00', '0', 'img/20180420/nx_1524202397663.jpg', '0', '1');

-- ----------------------------
-- Table structure for xl_goodsimage
-- ----------------------------
DROP TABLE IF EXISTS `xl_goodsimage`;
CREATE TABLE `xl_goodsimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goodsid` int(11) DEFAULT NULL COMMENT '商品编号',
  `types` int(11) DEFAULT NULL COMMENT '图片类型（0商品简介 1商品详细信息）',
  `iconurl` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `rank` int(11) DEFAULT NULL COMMENT '商品介绍的时候图片顺序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=454 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsimage
-- ----------------------------
INSERT INTO `xl_goodsimage` VALUES ('246', '22', '1', 'img/20180327/nx_1522134648228.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('248', '23', '1', 'img/nx_1510904922810.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('247', '23', '1', 'img/nx_1510904922794.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('381', '24', '1', 'img/nx_1510907757342.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('380', '24', '1', 'img/nx_1510907757811.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('260', '25', '1', 'img/nx_1510908277331.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('259', '25', '1', 'img/nx_1510908277536.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('252', '26', '1', 'img/nx_1510909708421.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('251', '26', '1', 'img/nx_1510909708155.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('68', '28', '1', 'img/nx_1510911858990.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('67', '28', '1', 'img/nx_1510911858740.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('262', '29', '1', 'img/nx_1510912228650.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('261', '29', '1', 'img/nx_1510912228476.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('258', '30', '1', 'img/nx_1510912724970.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('257', '30', '1', 'img/nx_1510912724401.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('238', '31', '1', 'img/nx_1510913076883.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('237', '31', '1', 'img/nx_1510913076779.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('146', '32', '1', 'img/nx_1510913431214.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('145', '32', '1', 'img/nx_1510913431781.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('148', '33', '1', 'img/20180311/nx_1520736674176.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('147', '33', '1', 'img/20180311/nx_1520736674249.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('334', '37', '1', 'img/20180324/nx_1521880764498.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('333', '39', '1', 'img/20180327/nx_1522114784623.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('452', '78', '1', 'img/20180420/nx_1524170066617.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('426', '79', '1', 'img/20180420/nx_1524197458176.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('373', '80', '1', 'img/20180420/nx_1524197779283.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('372', '80', '1', 'img/20180420/nx_1524197958615.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('436', '81', '1', 'img/20180420/nx_1524203435571.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('434', '82', '1', 'img/20180420/nx_1524203393140.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('435', '83', '1', 'img/20180420/nx_1524203341543.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('420', '84', '1', 'img/20180420/nx_1524198179817.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('433', '85', '1', 'img/20180420/nx_1524203293209.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('418', '86', '1', 'img/20180420/nx_1524198359514.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('421', '87', '1', 'img/20180420/nx_1524203265796.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('428', '94', '1', 'img/20180420/nx_1524203611220.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('430', '88', '1', 'img/20180420/nx_1524198584115.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('429', '88', '1', 'img/20180420/nx_1524198613862.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('450', '93', '1', 'img/20180420/nx_1524203226304.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('423', '89', '1', 'img/20180420/nx_1524203196630.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('422', '89', '1', 'img/20180420/nx_1524198642759.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('453', '91', '1', 'img/20180420/nx_1524206543333.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('449', '95', '1', 'img/20180420/nx_1524205210639.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('448', '96', '1', 'img/20180420/nx_1524204541775.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('447', '97', '1', 'img/20180420/nx_1524205846745.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('446', '98', '1', 'img/20180420/nx_1524206258407.jpg', '0');

-- ----------------------------
-- Table structure for xl_goodsuse
-- ----------------------------
DROP TABLE IF EXISTS `xl_goodsuse`;
CREATE TABLE `xl_goodsuse` (
  `ids` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bossid` int(11) NOT NULL DEFAULT '0' COMMENT '商户编号',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '用户编号',
  `goodsid` int(11) NOT NULL DEFAULT '0' COMMENT '商品编号',
  `usetime` varchar(11) NOT NULL DEFAULT '0' COMMENT '使用时间',
  `buyid` int(11) DEFAULT '0' COMMENT '商品购买编号',
  PRIMARY KEY (`ids`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsuse
-- ----------------------------
INSERT INTO `xl_goodsuse` VALUES ('50', '339', '368', '78', '1524224706', '290');
INSERT INTO `xl_goodsuse` VALUES ('49', '325', '329', '39', '1524134527', '280');
INSERT INTO `xl_goodsuse` VALUES ('48', '325', '329', '31', '1524134362', '279');
INSERT INTO `xl_goodsuse` VALUES ('47', '325', '329', '31', '1524134279', '274');
INSERT INTO `xl_goodsuse` VALUES ('46', '325', '328', '39', '1524133889', '277');
INSERT INTO `xl_goodsuse` VALUES ('45', '325', '328', '31', '1524133677', '278');
INSERT INTO `xl_goodsuse` VALUES ('43', '325', '328', '31', '1524129562', '269');
INSERT INTO `xl_goodsuse` VALUES ('44', '325', '328', '31', '1524129737', '271');
INSERT INTO `xl_goodsuse` VALUES ('51', '339', '359', '78', '1524224818', '291');
INSERT INTO `xl_goodsuse` VALUES ('52', '339', '509', '78', '1524394718', '294');

-- ----------------------------
-- Table structure for xl_goodsusemsg
-- ----------------------------
DROP TABLE IF EXISTS `xl_goodsusemsg`;
CREATE TABLE `xl_goodsusemsg` (
  `ids` int(11) NOT NULL AUTO_INCREMENT,
  `usetype` int(11) NOT NULL DEFAULT '1' COMMENT '1获得积分分成  2获得现金分成',
  `useid` int(11) NOT NULL COMMENT 'xl_goodsuse 朱编号',
  `userid` int(11) NOT NULL COMMENT '用户编号',
  `nums` decimal(11,2) NOT NULL COMMENT '数量',
  `opdate` varchar(11) NOT NULL COMMENT '时间',
  `userrole` int(11) NOT NULL DEFAULT '1' COMMENT '角色',
  PRIMARY KEY (`ids`)
) ENGINE=MyISAM AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsusemsg
-- ----------------------------
INSERT INTO `xl_goodsusemsg` VALUES ('205', '1', '52', '509', '0.00', '1524394718', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('204', '2', '52', '339', '19.90', '1524394718', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('203', '1', '51', '359', '0.00', '1524224818', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('202', '2', '51', '339', '100.00', '1524224818', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('201', '1', '50', '368', '0.00', '1524224706', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('200', '2', '50', '339', '100.00', '1524224706', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('199', '3', '0', '325', '-1.00', '1524192514', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('198', '3', '0', '325', '-100.00', '1524191404', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('197', '3', '0', '325', '-1.00', '1524191304', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('196', '3', '0', '325', '-100.00', '1524191281', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('195', '3', '0', '325', '-1.00', '1524191152', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('194', '3', '0', '325', '-100.00', '1524134633', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('193', '1', '49', '329', '20.00', '1524134527', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('192', '2', '49', '325', '10.00', '1524134527', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('191', '1', '48', '329', '0.00', '1524134362', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('190', '2', '48', '325', '0.03', '1524134362', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('189', '2', '48', '326', '0.03', '1524134362', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('188', '1', '47', '329', '0.00', '1524134279', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('187', '2', '47', '325', '0.03', '1524134279', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('186', '2', '47', '326', '0.03', '1524134279', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('185', '1', '46', '328', '0.00', '1524133889', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('184', '2', '46', '325', '0.99', '1524133889', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('183', '1', '45', '328', '0.00', '1524133677', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('182', '2', '45', '325', '0.03', '1524133677', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('181', '2', '45', '326', '0.03', '1524133677', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('180', '3', '0', '325', '-100.00', '1524132026', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('179', '3', '0', '325', '-101.00', '1524130111', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('178', '1', '44', '328', '0.00', '1524129737', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('177', '2', '44', '325', '30.00', '1524129737', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('176', '2', '44', '329', '15.00', '1524129737', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('175', '2', '44', '326', '15.00', '1524129737', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('174', '1', '43', '328', '0.00', '1524129562', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('173', '2', '43', '325', '30.00', '1524129562', '2');

-- ----------------------------
-- Table structure for xl_inoutcomelist
-- ----------------------------
DROP TABLE IF EXISTS `xl_inoutcomelist`;
CREATE TABLE `xl_inoutcomelist` (
  `listid` int(11) NOT NULL AUTO_INCREMENT,
  `usera` int(11) NOT NULL,
  `userb` int(11) DEFAULT '-1',
  `userc` int(11) DEFAULT '-1',
  `sum` decimal(11,2) NOT NULL,
  `opdate` varchar(15) NOT NULL,
  `notes` varchar(3000) DEFAULT '',
  `goodsid` int(11) DEFAULT '0',
  PRIMARY KEY (`listid`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_inoutcomelist
-- ----------------------------

-- ----------------------------
-- Table structure for xl_msgcode
-- ----------------------------
DROP TABLE IF EXISTS `xl_msgcode`;
CREATE TABLE `xl_msgcode` (
  `codeid` int(11) NOT NULL AUTO_INCREMENT,
  `requestid` varchar(50) NOT NULL,
  `codeval` varchar(4) NOT NULL,
  `userid` varchar(30) NOT NULL,
  `rqstamp` varchar(15) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `states` int(11) NOT NULL DEFAULT '0' COMMENT '状态 0 其他  1 登陆',
  PRIMARY KEY (`codeid`)
) ENGINE=MyISAM AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_msgcode
-- ----------------------------
INSERT INTO `xl_msgcode` VALUES ('18', '1F458B61-DC68-4073-81BF-44EE22A9C960', '5041', '18', '1509380869', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('19', '68048BEA-6864-4FA3-A28B-E04E14839962', '6988', '19', '1509380889', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('20', '49F6B311-C527-4997-ACAC-B923CEB1DC7A', '2326', '26', '1509421375', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('21', 'CB1C80B8-F1AB-4F31-9581-34F043143398', '3026', '27', '1509422176', '13795292286', '0');
INSERT INTO `xl_msgcode` VALUES ('22', '39660E1C-195C-4879-B602-5F981064D10C', '2006', '28', '1509422736', '14782372952', '0');
INSERT INTO `xl_msgcode` VALUES ('23', '0FC992DE-561A-413E-8BBE-4D4FDFFB84C7', '9922', '20', '1511231605', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('24', '5C3AF44F-1E9C-413A-A6FE-43582895E701', '2986', '24', '1509457190', '17717030378', '0');
INSERT INTO `xl_msgcode` VALUES ('25', '382E3100-6297-445B-8E44-FAFFAC77FB2D', '5277', '31', '1509459024', '15001998531', '0');
INSERT INTO `xl_msgcode` VALUES ('26', '3A5EF7DF-5D8E-4FEE-9FD1-49C5689716E0', '4811', '54', '1510987014', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('27', '37768AEC-1B7E-4C65-B545-FCA983ECD404', '6859', '33', '1510987418', '17602122145', '0');
INSERT INTO `xl_msgcode` VALUES ('28', 'E8F744B0-20FB-402E-B50E-FA36BDF2A76B', '6784', '21', '1517921573', '13641759653', '0');
INSERT INTO `xl_msgcode` VALUES ('29', 'AB7A695C-22A5-40EA-A8FD-4CE84A9206DE', '2994', '59', '1510994323', '17698307534', '0');
INSERT INTO `xl_msgcode` VALUES ('30', '1552F529-8277-4D10-87DA-08C9E05B49D1', '8305', '23', '1510999713', '18017647536', '0');
INSERT INTO `xl_msgcode` VALUES ('31', '217E479B-9AE7-4E61-A1B5-3A5942B015DC', '4900', '64', '1511067658', '15026538970', '0');
INSERT INTO `xl_msgcode` VALUES ('32', '916A46CF-B336-4FA0-A2BD-7897CB05B1CE', '4145', '65', '1511070230', '17778781225', '0');
INSERT INTO `xl_msgcode` VALUES ('33', 'B322891D-7370-4A25-97AF-E8C531EEACCE', '1814', '66', '1511071062', '18776998762', '0');
INSERT INTO `xl_msgcode` VALUES ('34', '0E85AC18-CE69-4423-A185-72FCFC65C3B4', '8640', '67', '1511071283', '13472477299', '0');
INSERT INTO `xl_msgcode` VALUES ('35', '0E37884F-003F-4EBE-8641-FF5876E64186', '6842', '68', '1511072257', '17621540614', '0');
INSERT INTO `xl_msgcode` VALUES ('36', 'B5CEA650-A1C0-4910-8376-436F61B65DD7', '9729', '70', '1511074146', '15939418162', '0');
INSERT INTO `xl_msgcode` VALUES ('37', '60FD3589-510F-419C-BFD8-FFEC0445959B', '6117', '71', '1511075056', '18326016021', '0');
INSERT INTO `xl_msgcode` VALUES ('38', '791A3972-68EF-4660-9740-486BF2CC38FE', '8580', '72', '1511075549', '17621990310', '0');
INSERT INTO `xl_msgcode` VALUES ('39', 'D521075F-E806-4E42-A01F-E3388D4F8355', '7393', '73', '1511075661', '15538822250', '0');
INSERT INTO `xl_msgcode` VALUES ('40', '0D4786A0-30C9-4C58-B102-3CC3E8E91E04', '5077', '74', '1511075928', '15900492103', '0');
INSERT INTO `xl_msgcode` VALUES ('41', 'A5917096-7CA9-44F3-8FCC-985C79A8F288', '1748', '75', '1511077038', '17317612793', '0');
INSERT INTO `xl_msgcode` VALUES ('42', '8A1F7599-E07E-4A2F-A8F8-C32457787382', '6616', '76', '1511077273', '18521354336', '0');
INSERT INTO `xl_msgcode` VALUES ('43', '485E689A-6F8B-4F9C-B19D-52BB7AEA191E', '3109', '77', '1511077447', '15800555740', '0');
INSERT INTO `xl_msgcode` VALUES ('44', '437A3A44-E16C-4C86-8B95-BB5648269820', '8861', '79', '1511077473', '17601535694', '0');
INSERT INTO `xl_msgcode` VALUES ('45', '3A066AFD-7F79-4272-9FEC-7011A3B3A392', '4789', '78', '1511077500', '18739400631', '0');
INSERT INTO `xl_msgcode` VALUES ('46', 'C3321EB1-2879-4626-971C-A0C1D66CE6A1', '9783', '80', '1511078304', '15294984709', '0');
INSERT INTO `xl_msgcode` VALUES ('47', 'EB0A2858-86D9-43F9-B4C6-8348F7E694D7', '4272', '81', '1511098475', '17839429635', '0');
INSERT INTO `xl_msgcode` VALUES ('48', '55944AF4-A128-4FFD-80EC-624EDBF49A77', '8258', '95', '1512527899', '18639995288', '0');
INSERT INTO `xl_msgcode` VALUES ('49', '3D78C2B4-25C6-4EB0-8DD6-DC43F276ABA0', '8732', '103', '1514020640', '13482804640', '0');
INSERT INTO `xl_msgcode` VALUES ('50', '22844814-C860-40C0-9008-0B747582EABC', '2636', '90', '1515405554', '15168697540', '0');
INSERT INTO `xl_msgcode` VALUES ('51', 'AE886DB4-46DC-4520-AE8D-F4C0F1A708EE', '3700', '136', '1520746502', '13641759653', '0');
INSERT INTO `xl_msgcode` VALUES ('52', '7276EFED-86F4-498B-8130-782DCECF728A', '7687', '137', '1520746530', '17602122145', '0');
INSERT INTO `xl_msgcode` VALUES ('53', '45AF401C-7E38-4C58-B795-5CD2AE0F2002', '8424', '138', '1520746548', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('54', 'B92CCA15-C37A-4BC4-B043-E79E6C67F6F4', '9800', '140', '1520746587', '15129588988', '0');
INSERT INTO `xl_msgcode` VALUES ('55', 'A96A06B0-9E7C-48D3-82CC-90E627E575E7', '5815', '139', '1520746653', '14782372952', '0');
INSERT INTO `xl_msgcode` VALUES ('56', '3A4AD9BD-BA2F-47E0-B586-69223266C6D0', '7733', '141', '1520747245', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('57', '78BABB74-74E7-47E0-9F03-C540DCF74E86', '9711', '142', '1520826085', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('58', '52007A6A-5450-4CD0-A52C-F2AA3CEBEA51', '1825', '145', '1520846398', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('59', '0200684D-7050-4312-B0A5-F72C2EEAFB7C', '8378', '146', '1520846411', '17602122145', '0');
INSERT INTO `xl_msgcode` VALUES ('60', '1ED0F2E2-6FC4-40F9-9263-73EC2E3B51DB', '5769', '143', '1520846422', '13641759653', '0');
INSERT INTO `xl_msgcode` VALUES ('61', '79D525A0-29B6-4FE7-996F-0DD84C2E6EAD', '5866', '147', '1520846427', '15129588988', '0');
INSERT INTO `xl_msgcode` VALUES ('62', 'E69C6879-0F10-4101-8DD1-6F6ACA76C7FF', '3668', '148', '1520846436', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('63', '61BC4470-733C-45FF-93B0-46582E9AF564', '9967', '144', '1520846445', '14782372952', '0');
INSERT INTO `xl_msgcode` VALUES ('64', 'D407DA42-146A-4EA3-A275-C4DF457189EB', '9210', '149', '1520846468', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('65', 'E37D3AF9-38EB-498D-9592-43AC28956B0E', '5255', '150', '1520847312', '13795292286', '0');
INSERT INTO `xl_msgcode` VALUES ('66', '92BB46ED-8C97-4F3D-AC9D-B38078C7B0F7', '6108', '154', '1520847812', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('67', '18138176-6076-4EA7-9E8A-E6E59264C412', '6607', '153', '1520847818', '15129588988', '0');
INSERT INTO `xl_msgcode` VALUES ('68', '285D9F80-3E81-45A6-8477-4CBB9F79B6BE', '6788', '152', '1521100946', '13641759653', '0');
INSERT INTO `xl_msgcode` VALUES ('69', '2C517BBB-66FA-4B71-944E-B748AD27699D', '5900', '151', '1520847821', '17602122145', '0');
INSERT INTO `xl_msgcode` VALUES ('70', '54C5A241-CBF0-49E5-9D72-5F1CBCE40809', '9113', '155', '1520847851', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('71', 'AFDD9C13-EB40-4FEE-BE30-3CEA44517E22', '5381', '156', '1520848047', '14782372952', '0');
INSERT INTO `xl_msgcode` VALUES ('72', 'A83BCA2F-45F4-4987-B163-72B02E0E49F9', '8255', '157', '1520848046', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('73', '15268B71-87F3-4735-86C0-54F1EDDCB23C', '9256', '161', '1521106829', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('74', '9C9DD2B0-B2A4-4D6E-A6AB-15B5969929E0', '5510', '159', '1521106953', '13641759653', '0');
INSERT INTO `xl_msgcode` VALUES ('75', '1C643057-0A9E-4C82-889E-BFD4C5BF4D2A', '1391', '160', '1521106958', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('76', 'F7BD6EE7-3B2F-4693-8401-454E0E410F24', '2825', '170', '1521194875', '15129588988', '0');
INSERT INTO `xl_msgcode` VALUES ('77', 'A754CE18-3B8C-4CA5-88BF-CDEF22DBF974', '8149', '169', '1521172872', '15829866845', '0');
INSERT INTO `xl_msgcode` VALUES ('78', 'E457BE40-B49D-481C-AE02-5463612F49B2', '1329', '166', '1521172959', '18019055587', '0');
INSERT INTO `xl_msgcode` VALUES ('79', '6A50BE77-35C1-4CC7-A9C2-10BDE605B200', '4537', '165', '1521172976', '13795292286', '0');
INSERT INTO `xl_msgcode` VALUES ('80', 'CBB734D5-835A-4300-8668-74E37F71E9E9', '2128', '168', '1521174003', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('81', '94A8165F-541D-4C00-98EB-65A457E28FA0', '1939', '172', '1521174504', '18317182509', '0');
INSERT INTO `xl_msgcode` VALUES ('82', '2C557ACB-CB7A-4BD3-8543-CA06C3787FE1', '4437', '177', '1521251751', '15300816822', '0');
INSERT INTO `xl_msgcode` VALUES ('83', 'ED19ABA2-543C-41EA-BF01-8E2B091CCF36', '2718', '173', '1521252085', '18019188776', '0');
INSERT INTO `xl_msgcode` VALUES ('84', 'EBC80A6E-A79F-4A87-A81B-0FB9C90C894C', '8881', '182', '1521254157', '13795292286', '0');
INSERT INTO `xl_msgcode` VALUES ('85', '20DE6BF8-0ED1-40DD-AB0F-23DFF880C41B', '1623', '178', '1521254165', '18019188776', '0');
INSERT INTO `xl_msgcode` VALUES ('86', '86A4DDD9-4F08-41F9-82D0-FD0A4622D4D4', '2880', '181', '1521254174', '15300816822', '0');
INSERT INTO `xl_msgcode` VALUES ('87', 'B9DF6501-4198-4FA4-BFD0-C6ED6B354456', '4462', '180', '1521254183', '15829866845', '0');
INSERT INTO `xl_msgcode` VALUES ('88', '6715CF09-E94E-49DE-A0D8-7B4563D35C27', '7504', '183', '1521254186', '14782372952', '0');
INSERT INTO `xl_msgcode` VALUES ('89', '570C3795-E843-4600-9ADC-BDF92529B7C8', '5144', '184', '1521254224', '15129588988', '0');
INSERT INTO `xl_msgcode` VALUES ('90', '7A1A27BC-9698-4921-909F-14B18B07E080', '5416', '185', '1521254227', '18317182509', '0');
INSERT INTO `xl_msgcode` VALUES ('91', 'A2523537-845E-4090-831B-89B75CF1F31A', '5920', '187', '1521254255', '18019055587', '0');
INSERT INTO `xl_msgcode` VALUES ('92', 'FDBCDAC1-F24D-4CF3-AB0C-539151D7DE71', '3789', '179', '1521254321', '17602122145', '0');
INSERT INTO `xl_msgcode` VALUES ('93', '79560407-EE5F-4F61-840A-92B325DD7457', '3053', '190', '1521276878', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('94', 'BC4BA007-ECEE-4DF2-8845-B82088EA475E', '4722', '189', '1521277498', '13641759653', '0');
INSERT INTO `xl_msgcode` VALUES ('95', '44925DCB-9B1F-4571-8CB3-4B2FE9F4EC3B', '6914', '186', '1522124455', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('96', '6ED14D0C-2530-422B-B2C2-D237FCA6BDDB', '6280', '209', '1522126576', '13661669664', '0');
INSERT INTO `xl_msgcode` VALUES ('97', '7664DAE4-F600-4E4F-867C-BCA634C15059', '3512', '212', '1522127504', '13801902745', '0');
INSERT INTO `xl_msgcode` VALUES ('98', 'AC6F2196-06BB-457F-A81B-33E124F72874', '4919', '214', '1522127927', '13601744624', '0');
INSERT INTO `xl_msgcode` VALUES ('99', 'C795D413-705E-441A-A80D-8EC90EF6251D', '4323', '215', '1522128433', '13311819088', '0');
INSERT INTO `xl_msgcode` VALUES ('100', '402D1FE8-0D19-49A1-96E9-07D42493FF41', '1778', '216', '1522129219', '15618864853', '0');
INSERT INTO `xl_msgcode` VALUES ('101', '2B85459C-CCA0-42BF-B5D9-41EB874FD531', '9735', '219', '1522134541', '13566709756', '0');
INSERT INTO `xl_msgcode` VALUES ('102', '175D7884-D359-4470-9EC0-C74E5D6C3353', '1589', '199', '1522138034', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('103', 'E38FD3CC-CA4F-4858-BBE5-604234E9DD6F', '6595', '222', '1522141839', '18217449089', '0');
INSERT INTO `xl_msgcode` VALUES ('104', '92792184-3DF4-405B-8A95-A2D6C1D2A67B', '3931', '224', '1522142938', '15121081174', '0');
INSERT INTO `xl_msgcode` VALUES ('105', 'E8036F76-7F59-437B-A6F1-AB3702F3F1B5', '7593', '241', '1522216378', '13916956206', '0');
INSERT INTO `xl_msgcode` VALUES ('106', '971FB631-9B2E-47ED-9623-BFFE190660C6', '8620', '249', '1522224959', '15221938208', '0');
INSERT INTO `xl_msgcode` VALUES ('107', 'C905019B-94FD-4763-80EA-097FE2D02541', '9509', '250', '1522225220', '13641782237', '0');
INSERT INTO `xl_msgcode` VALUES ('108', '1067EE87-292F-4196-8773-40EB51D71C98', '1828', '253', '1522232881', '13661683086', '0');
INSERT INTO `xl_msgcode` VALUES ('109', '41E352B1-CFF8-4834-9209-AD6DF6F41CFA', '7043', '252', '1522233480', '13818739108', '0');
INSERT INTO `xl_msgcode` VALUES ('110', 'C5904CE5-1F31-4949-AEF0-85D1F5DB2234', '3328', '206', '1522233613', '15000855273', '0');
INSERT INTO `xl_msgcode` VALUES ('111', 'CD966B63-A9EC-405F-AF34-6C587138FCE5', '6193', '254', '1522234884', '15000814320', '0');
INSERT INTO `xl_msgcode` VALUES ('112', '57FE6238-DA16-4543-BF8F-0AB8F18C514A', '2934', '257', '1522308298', '15900524302', '0');
INSERT INTO `xl_msgcode` VALUES ('113', '22E191B8-1D86-4A9D-BC6E-B6CA716E8F5D', '6044', '258', '1522309993', '13564530361', '0');
INSERT INTO `xl_msgcode` VALUES ('114', 'E2C81650-E9F3-42BC-BC3B-B7DBB1FACB08', '5195', '259', '1522314105', '13501641091', '0');
INSERT INTO `xl_msgcode` VALUES ('115', 'CC0DA4B6-0268-4067-B3CA-66DAAF19E55A', '8772', '260', '1522316278', '13818206050', '0');
INSERT INTO `xl_msgcode` VALUES ('116', '51655732-3FC3-4CD4-8398-EE680959CE81', '3468', '277', '1522558627', '18616540341', '0');
INSERT INTO `xl_msgcode` VALUES ('117', '2349A0DA-DD87-48B0-9DC8-5CB3E605F66E', '9899', '278', '1522558941', '13701655703', '0');
INSERT INTO `xl_msgcode` VALUES ('118', '7D941D7D-C6AE-4ADD-8BAE-D463B4110F33', '2004', '279', '1522559513', '18818101395', '0');
INSERT INTO `xl_msgcode` VALUES ('119', 'FFC2BAF8-487C-4A82-B74B-E4A810265808', '6589', '280', '1522562160', '18321988348', '0');
INSERT INTO `xl_msgcode` VALUES ('120', 'D8CB2F26-3565-4632-A86C-4AFACC8FA168', '5668', '281', '1522562377', '18286079783', '0');
INSERT INTO `xl_msgcode` VALUES ('121', '4EB7A4D0-CDF6-45F0-AA74-EFAFDB61D588', '5816', '282', '1522562522', '15630185887', '0');
INSERT INTO `xl_msgcode` VALUES ('122', '959DA3A0-8DB0-4218-A1FF-A56E5DF2256F', '8654', '283', '1522562848', '15800487942', '0');
INSERT INTO `xl_msgcode` VALUES ('123', '314B7F5E-070A-4054-A5E5-DEB1CD24B0E6', '9801', '284', '1522563031', '17095163199', '0');
INSERT INTO `xl_msgcode` VALUES ('124', 'F46A8B32-32A2-497F-ACE5-24A2ABBC8FD2', '3260', '285', '1522563089', '15618331831', '0');
INSERT INTO `xl_msgcode` VALUES ('125', '990C10B7-0E88-4D90-AA46-1D9A1708DF2F', '3760', '290', '1522567037', '13916279468', '0');
INSERT INTO `xl_msgcode` VALUES ('126', '2B53F229-DD52-45C4-BA78-3A6DA835648F', '3262', '291', '1522570246', '13433553697', '0');
INSERT INTO `xl_msgcode` VALUES ('127', 'B87F495E-C863-4B34-B2C1-4452D05E3FF6', '8028', '293', '1522570673', '13818442358', '0');
INSERT INTO `xl_msgcode` VALUES ('128', 'A7A9999E-46CF-4FDF-AE02-5D85F90C3E02', '4078', '294', '1522571154', '13671639463', '0');
INSERT INTO `xl_msgcode` VALUES ('129', '567F9539-B5F7-439E-B2D4-F8BD753A3F03', '1884', '295', '1522573626', '17701806573', '0');
INSERT INTO `xl_msgcode` VALUES ('130', 'A66F5453-2034-4D7B-9A74-B024BDD647D4', '7666', '296', '1522573800', '18116295689', '0');
INSERT INTO `xl_msgcode` VALUES ('131', '5A4D3059-136B-4026-A72A-98E4668E10B2', '1678', '297', '1522573992', '15821050335', '0');
INSERT INTO `xl_msgcode` VALUES ('132', 'C803A4B2-DE8B-424B-AA2C-D155C18D8920', '3310', '298', '1522995272', '13641759653', '0');
INSERT INTO `xl_msgcode` VALUES ('133', 'F404E256-816A-4186-8531-76895DD3F6CC', '1764', '298', '1524282835', '13641759653', '1');
INSERT INTO `xl_msgcode` VALUES ('134', '2A18102E-3EE4-4426-A1B0-B7691A88BDB6', '3528', '0', '1524322079', '13916403296', '1');
INSERT INTO `xl_msgcode` VALUES ('135', '3E80FC95-AE3C-41B1-9A50-6AEA70324FC5', '1486', '0', '1524303895', '17798690890', '1');
INSERT INTO `xl_msgcode` VALUES ('136', '95414A1D-A80A-4D7B-BA71-FDAF77F103BC', '5190', '0', '1524170459', '13916199451', '1');
INSERT INTO `xl_msgcode` VALUES ('137', '615FBB4F-12E1-4661-89B8-D86414EFFE6E', '9881', '0', '1524146666', '15821066252', '1');
INSERT INTO `xl_msgcode` VALUES ('138', '3A841D79-BA01-473D-BD6E-71CAC367DF94', '5588', '0', '1524955668', '13685475265', '1');
INSERT INTO `xl_msgcode` VALUES ('139', '3A841D79-BA01-473D-BD6E-71CAC367DF94', '5588', '0', '1525955668', '13654785698', '1');
INSERT INTO `xl_msgcode` VALUES ('140', '8A043B27-3105-4F05-A366-3BCD51F0811E', '7154', '0', '1524140915', '15001998531', '1');
INSERT INTO `xl_msgcode` VALUES ('141', '63295723-8E09-4D92-BC4D-203C6AF0C8AB', '7520', '0', '1524196276', '15800599806', '1');
INSERT INTO `xl_msgcode` VALUES ('142', 'AF35A127-0FD1-47C4-BE36-942A6E70FB71', '3382', '0', '1524369461', '13764654808', '1');
INSERT INTO `xl_msgcode` VALUES ('143', '3AB0E733-496D-4916-B72E-5C77737FD2A2', '2203', '0', '1524196285', '18521348382', '1');
INSERT INTO `xl_msgcode` VALUES ('144', '538444B0-95D8-42CC-B557-5FB46946FF63', '2668', '0', '1524198966', '17602122145', '1');
INSERT INTO `xl_msgcode` VALUES ('145', '866AD54F-81B5-4C1E-848F-A4043355D522', '9543', '0', '1524381147', '13524448098', '1');
INSERT INTO `xl_msgcode` VALUES ('146', '5ACDA7C3-8292-4B55-A610-E3940E5FC03A', '8866', '0', '1524209462', '17821127060', '1');
INSERT INTO `xl_msgcode` VALUES ('147', '1A787D63-1D70-4724-9CE9-A27DB33E4A93', '6105', '0', '1524209498', '17601218082', '1');
INSERT INTO `xl_msgcode` VALUES ('148', '2F6034FE-8B81-4144-B62A-C0783C3BEABC', '3890', '0', '1524209745', '18221051043', '1');
INSERT INTO `xl_msgcode` VALUES ('149', '7C728F0D-F24B-434A-8E9C-E367FF5ED79A', '6802', '0', '1524213784', '18616377070', '1');
INSERT INTO `xl_msgcode` VALUES ('150', '7A767AD8-282D-473F-A516-4447F6464B34', '5724', '0', '1524216099', '13816118330', '1');
INSERT INTO `xl_msgcode` VALUES ('151', '7F0B5618-36A9-48D6-B036-F48C0C55B279', '8620', '0', '1524218182', '13817535441', '1');
INSERT INTO `xl_msgcode` VALUES ('152', '503173AB-4858-41BB-ABCF-505AD209B8C5', '2403', '0', '1524219154', '13816735783', '1');
INSERT INTO `xl_msgcode` VALUES ('153', 'D6B5C0E0-7740-48C6-A908-4BC285E4BA79', '2008', '0', '1524221494', '18521555172', '1');
INSERT INTO `xl_msgcode` VALUES ('154', '3A37676E-B37E-4119-9C75-2DCFC05B3155', '2947', '0', '1524221513', '13661434174', '1');
INSERT INTO `xl_msgcode` VALUES ('155', '99981C0B-1A02-46C3-8C27-FDC5C1A01CA1', '8928', '0', '1524281408', '18917029580', '1');
INSERT INTO `xl_msgcode` VALUES ('156', '24E87611-9377-4F49-8B25-96E2647A73E5', '3099', '0', '1524369934', '13166933493', '1');
INSERT INTO `xl_msgcode` VALUES ('157', '274ACECB-C9DD-42EB-B2C4-7D31D7A2CE51', '2661', '0', '1524392858', '18839682310', '1');
INSERT INTO `xl_msgcode` VALUES ('158', '97DFB668-F0DA-4F16-A9CF-1E6E0C7E88B6', '7582', '0', '1524393355', '15900950260', '1');

-- ----------------------------
-- Table structure for xl_sourceorder
-- ----------------------------
DROP TABLE IF EXISTS `xl_sourceorder`;
CREATE TABLE `xl_sourceorder` (
  `oid` varchar(15) NOT NULL,
  `userid` int(11) NOT NULL,
  `goodsid` int(11) NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '花费积分',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '订单状态',
  `times` varchar(11) NOT NULL COMMENT '订单时间',
  `nums` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `bossid` int(11) NOT NULL DEFAULT '0' COMMENT '在哪里使用的',
  `usetime` varchar(11) NOT NULL DEFAULT '' COMMENT '使用时间',
  PRIMARY KEY (`oid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_sourceorder
-- ----------------------------
INSERT INTO `xl_sourceorder` VALUES ('5adadde478cb7', '329', '98', '298', '1', '1524293092', '1', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5adadde079fb3', '329', '98', '298', '1', '1524293088', '1', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5adadb7259ba1', '329', '98', '298', '1', '1524292466', '1', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5ad8a2e4e57d9', '329', '28', '198', '1', '1524146916', '1', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5adade1535419', '329', '94', '956', '1', '1524293141', '4', '0', '');

-- ----------------------------
-- Table structure for xl_uselog
-- ----------------------------
DROP TABLE IF EXISTS `xl_uselog`;
CREATE TABLE `xl_uselog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `useid` int(11) DEFAULT NULL COMMENT '操作人',
  `usemsg` varchar(255) DEFAULT NULL COMMENT '使用介绍',
  `usetm` varchar(255) DEFAULT NULL COMMENT '使用时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_uselog
-- ----------------------------
INSERT INTO `xl_uselog` VALUES ('1', '1', '设置管理员-28-业务员', '1510900206');
INSERT INTO `xl_uselog` VALUES ('2', '1', '设置管理员-59-商户', '1510994474');
INSERT INTO `xl_uselog` VALUES ('3', '1', '设置管理员-20-代理商', '1520746192');
INSERT INTO `xl_uselog` VALUES ('4', '1', '设置管理员-136-代理商', '1520746551');
INSERT INTO `xl_uselog` VALUES ('5', '1', '设置管理员-136-客户', '1520746573');
INSERT INTO `xl_uselog` VALUES ('6', '1', '设置管理员-140-代理商', '1520746925');
INSERT INTO `xl_uselog` VALUES ('7', '1', '设置管理员-137-代理商', '1520844801');
INSERT INTO `xl_uselog` VALUES ('8', '1', '设置管理员-146-代理商', '1520846441');
INSERT INTO `xl_uselog` VALUES ('9', '1', '设置管理员-151-代理商', '1520847760');
INSERT INTO `xl_uselog` VALUES ('10', '1', '设置管理员-170-代理商', '1521173019');
INSERT INTO `xl_uselog` VALUES ('11', '1', '设置管理员-165-商户', '1521174477');
INSERT INTO `xl_uselog` VALUES ('12', '1', '设置管理员-166-客户', '1521252290');
INSERT INTO `xl_uselog` VALUES ('13', '1', '设置管理员-166-客户', '1521252398');
INSERT INTO `xl_uselog` VALUES ('14', '1', '设置管理员-182-代理商', '1521254236');
INSERT INTO `xl_uselog` VALUES ('15', '1', '设置管理员-189-客户', '1521281031');
INSERT INTO `xl_uselog` VALUES ('16', '1', '设置管理员-330-代理商', '1524166479');
INSERT INTO `xl_uselog` VALUES ('17', '1', '设置管理员-330-代理商', '1524166488');

-- ----------------------------
-- Table structure for xl_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `xl_userinfo`;
CREATE TABLE `xl_userinfo` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `userpwd` varchar(30) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `chname` varchar(50) DEFAULT NULL COMMENT '中文名字',
  `role` int(11) DEFAULT '1',
  `accounts` decimal(11,2) DEFAULT '0.00' COMMENT '余额或积分',
  `extrapwd` varchar(50) DEFAULT NULL COMMENT '提现密码',
  `notes` mediumtext COMMENT '备注',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信openid',
  `headimgurl` varchar(150) DEFAULT NULL COMMENT '头像地址',
  `regTime` varchar(20) DEFAULT NULL,
  `sex` int(1) DEFAULT '0' COMMENT '性别(0女，1男）',
  `tid` int(11) DEFAULT '0' COMMENT '推荐人id',
  `source` int(255) DEFAULT '0' COMMENT '积分',
  `issystem` int(11) DEFAULT '0',
  `salescommission` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '业务或者美导提成',
  `remarks` varchar(100) NOT NULL DEFAULT '' COMMENT '用户备注',
  `wxopenid` varchar(50) NOT NULL COMMENT '微信openid',
  `wxopenidkey` varchar(50) NOT NULL COMMENT 'openid加密',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=512 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xl_userinfo
-- ----------------------------
INSERT INTO `xl_userinfo` VALUES ('339', '13524448098', null, '13524448098', null, '2', '219.90', null, null, '089a19f8033fb0e39ff9cfa4acdd7d4d', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524205237', '1', '0', '0', '0', '0.00', '', 'olXx5wQTrRurM1lhtPQvmIuSyLt4', '527b80d05accce621dd40330f6c3401d');
INSERT INTO `xl_userinfo` VALUES ('340', '', null, null, null, '1', '0.00', null, null, '', '', '1524190910', '0', '0', '0', '0', '0.00', '', 'olXx5wfrSoyTLwZVhMUyyWPMil24', '40a2d127c52d4263c33e99c418a6ea09');
INSERT INTO `xl_userinfo` VALUES ('337', '', null, null, null, '1', '0.00', null, null, '', '', '1524185064', '0', '0', '0', '0', '0.00', '', 'olXx5wbsmVvvZuXEe5XpaMMTSe24', '5979f8cf565a902358d7fb7a9ea6c4c8');
INSERT INTO `xl_userinfo` VALUES ('338', '17601218082', null, '17601218082', null, '1', '0.00', null, null, '1334832d47e703309e391d13233d0d88', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524209510', '1', '0', '0', '0', '0.00', '', 'olXx5wcFBloN2cFMUh5FOFRuMIkQ', '2e8f6745c3a720328ea7a577c3aceb15');
INSERT INTO `xl_userinfo` VALUES ('336', '', null, null, null, '1', '0.00', null, null, '', '', '1524157485', '0', '0', '0', '0', '0.00', '', 'olXx5wd9eVvzp5qR7VhdhJmlqtwI', '44de76f8f59eec31dc72bb3a293dee5d');
INSERT INTO `xl_userinfo` VALUES ('335', '17602122145', null, '17602122145', null, '3', '0.00', null, null, '14a7b8c1694a27291a80bed256331caf', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524198976', '1', '0', '0', '0', '0.00', '', 'olXx5wZzrjVlYfj2X2iFSh4h5XQI', '43ae8d67e52a1772d0b40b5fe6d69dac');
INSERT INTO `xl_userinfo` VALUES ('334', '', null, null, null, '1', '0.00', null, null, '', '', '1524144750', '0', '0', '0', '0', '0.00', '', 'olXx5waoNYWyBfrqwZPVDcSfK99o', 'b60485fe262a2f151534408afbf5b075');
INSERT INTO `xl_userinfo` VALUES ('333', '15001998531', null, '15001998531', null, '1', '0.00', null, null, '94345f3b2682e31ce5ddc546fe2386c3', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524140932', '1', '0', '0', '0', '0.00', '', 'olXx5wXIVFs9go11zb9qhLE7BzGg', 'cc822b187d68e6bb2a6b83104b48a001');
INSERT INTO `xl_userinfo` VALUES ('331', '', null, null, null, '1', '0.00', null, null, '', '', '1524132326', '0', '0', '0', '0', '0.00', '', 'olXx5wfl_J4FaW2L_WF07EppUQ7Y', 'd79778de36606e29e5358f502a332829');
INSERT INTO `xl_userinfo` VALUES ('332', '', null, null, null, '1', '0.00', null, null, '', '', '1524140231', '0', '0', '0', '0', '0.00', '', 'olXx5wULrXY5Xo84Ubji_cn0leos', '9b7e4432c0ec3acdb817c4411cbbbb74');
INSERT INTO `xl_userinfo` VALUES ('330', '13916199451', null, '13916199451', null, '5', '0.00', null, null, '56732450b957349b9f7d7ea68b2ab86a', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524166367', '1', '0', '0', '1', '0.00', '', 'olXx5wc0kVGu6jZI1Rjwkk3q-LxM', '1d6ee5859fa02cc61091b23c23dae056');
INSERT INTO `xl_userinfo` VALUES ('329', '哈哈哈???? ', null, '13916403296', null, '1', '1500.00', null, null, '4305cabf1248bf826cfbd7060018cf25', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524129034', '1', '329', '7951', '0', '0.00', '', 'olXx5wUZLt41E-Ul_PWwGqsUfJm0', '7d741ad8d96841454794d3d704b68fb1');
INSERT INTO `xl_userinfo` VALUES ('326', '17798690890', null, '17798690890', null, '1', '0.00', null, null, '8a26f5278b0ef7c700e552abdbf90af0', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524303905', '1', '0', '0', '0', '0.00', '', '', '');
INSERT INTO `xl_userinfo` VALUES ('327', '业务员', null, '13688686698', null, '1', '0.00', null, null, '85cxmkapa5de5wrh5', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524128590', '0', '0', '0', '0', '0.00', '', '', '');
INSERT INTO `xl_userinfo` VALUES ('328', '15821066259', null, '15821066259', null, '1', '0.00', null, null, '07b618bebc3ccda50a2c203d2c337916', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524129362', '1', '0', '0', '0', '0.00', '', '', '');
INSERT INTO `xl_userinfo` VALUES ('325', '咋咋', null, '13641759653', null, '2', '1608.08', '5c041969cd90b7f100c738ea581e6c14', null, 'ab200317dddb158b95036e2252793862', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524129193', '1', '0', '999', '0', '0.00', '', 'olXx5wd4-x6BhfMoqkK_Fsb10tyY', 'd040c946f889f3118f55f812427f3f03');
INSERT INTO `xl_userinfo` VALUES ('341', '', null, null, null, '1', '0.00', null, null, '', '', '1524192962', '0', '0', '0', '0', '0.00', '', 'olXx5wTuPRfZSKvWqEB1IcUYdQ74', '81674e41ecaa351a08592c7e79fba8f4');
INSERT INTO `xl_userinfo` VALUES ('342', '13764654808', null, '13764654808', null, '1', '0.00', null, null, 'd55f077932da851b29cc002c5ece9f59', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524196288', '1', '0', '0', '0', '0.00', '', 'olXx5wbRwOprdjGgigy0xThzJ49M', '87283cacb5e9431947327a4bd0ed6e31');
INSERT INTO `xl_userinfo` VALUES ('343', '18521348382', null, '18521348382', null, '1', '0.00', null, null, 'd246a1262b6817e93d0dbfd3a494d06f', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524196295', '1', '0', '0', '0', '0.00', '', 'olXx5wVO3ehnkxblvRtzDhFX27ao', 'd2eca9c3bbf2137c917c9994352d938d');
INSERT INTO `xl_userinfo` VALUES ('344', '15800599806', null, '15800599806', null, '1', '0.00', null, null, 'd7e12ed00a3aa47b6bcbf6192411c7b9', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524196284', '1', '0', '0', '0', '0.00', '', 'olXx5waIIpx6lMtM14Yhgx_-IKqQ', '7a45da44638ecfb52fc1981898c6b5a4');
INSERT INTO `xl_userinfo` VALUES ('345', '17821127060', null, '17821127060', null, '1', '0.00', null, null, 'c4f2ef9014e478f5cc6020aa713dfa56', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524209469', '1', '0', '0', '0', '0.00', '', 'olXx5wSxlGEwNUbdGfkXqkBVywoA', '9056d99a94ea6ebc0a102a998a290b8c');
INSERT INTO `xl_userinfo` VALUES ('346', '18221051043', null, '18221051043', null, '1', '0.00', null, null, 'c4e1f1c32cf2d9ee04f5f3b8ba92e3c7', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524209757', '1', '339', '0', '0', '0.00', '', 'olXx5wf4qaRVwOXHRY_WdCSAYEYo', '8f99ce4fd296a73433a1f4b02df3e60a');
INSERT INTO `xl_userinfo` VALUES ('347', '', null, null, null, '1', '0.00', null, null, '', '', '1524210014', '0', '0', '0', '0', '0.00', '', 'olXx5wZvx4Gmjai0b9CTU6kzpdrs', '715fa7d0324bf2c1b928b360f8cbe4a5');
INSERT INTO `xl_userinfo` VALUES ('348', '', null, null, null, '1', '0.00', null, null, '', '', '1524210121', '0', '0', '0', '0', '0.00', '', 'olXx5wVvsbtCxi52lS7M_z69dgbU', '91293926c013b9dda9f0a5f17b76e482');
INSERT INTO `xl_userinfo` VALUES ('349', '', null, null, null, '1', '0.00', null, null, '', '', '1524210272', '0', '0', '0', '0', '0.00', '', 'olXx5wQCxgmllVmzCwY6dLK_jnW0', '3351de5d854396d8da164752d590a339');
INSERT INTO `xl_userinfo` VALUES ('350', '', null, null, null, '1', '0.00', null, null, '', '', '1524210408', '0', '0', '0', '0', '0.00', '', 'olXx5wdsA_JId6tjxqjsZBQhydXE', 'c292808b001e2a4b5c6986d02cc4691f');
INSERT INTO `xl_userinfo` VALUES ('351', '', null, null, null, '1', '0.00', null, null, '', '', '1524210416', '0', '0', '0', '0', '0.00', '', 'olXx5wf4tlm3fed2Y8FiUBVSVELU', 'f1aae62b175c39975374ec0d991b2585');
INSERT INTO `xl_userinfo` VALUES ('352', '', null, null, null, '1', '0.00', null, null, '', '', '1524210467', '0', '0', '0', '0', '0.00', '', 'olXx5wQ7n5pepj5ybXJpLDNVLLO8', 'f9237e1ca907cc88550a9c10a555b8f7');
INSERT INTO `xl_userinfo` VALUES ('353', '', null, null, null, '1', '0.00', null, null, '', '', '1524210492', '0', '0', '0', '0', '0.00', '', 'olXx5wTwyNzB5z1Gvaw_iK36-D1U', 'ea5aaf93c2e3c0f5122ba7d79f3ef012');
INSERT INTO `xl_userinfo` VALUES ('354', '', null, null, null, '1', '0.00', null, null, '', '', '1524210503', '0', '0', '0', '0', '0.00', '', 'olXx5wSuuKH2-nGBpv_TL5FvEUFE', '2b7da368b624b4e5663e58def6b96171');
INSERT INTO `xl_userinfo` VALUES ('355', '', null, null, null, '1', '0.00', null, null, '', '', '1524210639', '0', '0', '0', '0', '0.00', '', 'olXx5wZIq3UzTz_qxSEygfWSznJk', '5382894e7c1f28c5f7829b8a3bb44895');
INSERT INTO `xl_userinfo` VALUES ('356', '', null, null, null, '1', '0.00', null, null, '', '', '1524210671', '0', '0', '0', '0', '0.00', '', 'olXx5wfr7gVAcQjGthC6dX7NGTg0', '2d9896584929232bbf667cb6f67dad3f');
INSERT INTO `xl_userinfo` VALUES ('357', '', null, null, null, '1', '0.00', null, null, '', '', '1524210766', '0', '0', '0', '0', '0.00', '', 'olXx5wYkGI29gUTXpQlS2lKNpHEI', '55a684c39266f28f0c06e9a40737afd7');
INSERT INTO `xl_userinfo` VALUES ('358', '', null, null, null, '1', '0.00', null, null, '', '', '1524210771', '0', '0', '0', '0', '0.00', '', 'olXx5wU6QXlHdbx20ozTZjkVl_6A', '8dd0f783f2a0756c72a8ee775ed23d70');
INSERT INTO `xl_userinfo` VALUES ('359', '13661434174', null, '13661434174', null, '1', '0.00', null, null, '8372a94d17c076ae4f666da3143fdae9', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524221525', '1', '0', '0', '0', '0.00', '', 'olXx5wbiE7Tmwuk9deLbsbHXCAYM', '8468af157f778c1ec11983e7555a1182');
INSERT INTO `xl_userinfo` VALUES ('360', '', null, null, null, '1', '0.00', null, null, '', '', '1524210962', '0', '0', '0', '0', '0.00', '', 'olXx5wdBQVSVnJ1Hp1IyxyZFErt4', 'c5231061623adcea7b4447ce4df6d6e0');
INSERT INTO `xl_userinfo` VALUES ('361', '', null, null, null, '1', '0.00', null, null, '', '', '1524210982', '0', '0', '0', '0', '0.00', '', 'olXx5wa6ao_n3CMz_QEmD3K09a34', 'f2aba7ec1a5f91a20644090e6dc829b1');
INSERT INTO `xl_userinfo` VALUES ('362', '', null, null, null, '1', '0.00', null, null, '', '', '1524211212', '0', '0', '0', '0', '0.00', '', 'olXx5wYRQ6GLSwAghVeeV3Bstzvw', 'f197283f2ec0a9ca380846c6ddd4ac23');
INSERT INTO `xl_userinfo` VALUES ('363', '', null, null, null, '1', '0.00', null, null, '', '', '1524211898', '0', '0', '0', '0', '0.00', '', 'olXx5wa2_Dx3kb0vd4gUd9CzJ0_A', '27d41e35faed0487b5853023775fc6dc');
INSERT INTO `xl_userinfo` VALUES ('364', '', null, null, null, '1', '0.00', null, null, '', '', '1524211931', '0', '0', '0', '0', '0.00', '', 'olXx5wYGSz7ap0ada2TFTNw58bYY', '1a396b755015d457a65f509765812edf');
INSERT INTO `xl_userinfo` VALUES ('365', '', null, null, null, '1', '0.00', null, null, '', '', '1524212390', '0', '0', '0', '0', '0.00', '', 'olXx5wf86Z2dYdXoNsr9mGRJqnOA', 'dd3907a04a55370ae5447adafd9b0047');
INSERT INTO `xl_userinfo` VALUES ('366', '13816118330', null, '13816118330', null, '1', '0.00', null, null, 'c126e834389c8750c48d35ea157bfd40', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524216112', '1', '339', '0', '0', '0.00', '', 'olXx5wSt3Hh_seXkYqGRcsKB8G4g', 'e9eb2469f4c177dd32162479d8f16621');
INSERT INTO `xl_userinfo` VALUES ('367', '', null, null, null, '1', '0.00', null, null, '', '', '1524212550', '0', '0', '0', '0', '0.00', '', 'olXx5weVswUL6edu1nongX2BI1WA', '535532be5cfedcb85cec79448739556b');
INSERT INTO `xl_userinfo` VALUES ('368', '18521555172', null, '18521555172', null, '1', '0.00', null, null, 'fe78dd20fab08353b3bf11f98b260131', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524221543', '1', '0', '0', '0', '0.00', '', 'olXx5wYmrOeqOAYJVPRjLqz_tZSQ', 'ad641d75be253d27c8578c324490d492');
INSERT INTO `xl_userinfo` VALUES ('369', '', null, null, null, '1', '0.00', null, null, '', '', '1524212890', '0', '0', '0', '0', '0.00', '', 'olXx5wapfZjyqLlz69S0xhbbD0gc', '491d79018a3b14ad24a545df6d9d64fd');
INSERT INTO `xl_userinfo` VALUES ('370', '', null, null, null, '1', '0.00', null, null, '', '', '1524212913', '0', '0', '0', '0', '0.00', '', 'olXx5wWtpL_TE6qGnSSpz-6FdEro', '222d4523457072560a0136caa883bfda');
INSERT INTO `xl_userinfo` VALUES ('371', '', null, null, null, '1', '0.00', null, null, '', '', '1524212916', '0', '0', '0', '0', '0.00', '', 'olXx5wVtxesNjW-uayI0oR7xrNEs', '92e9c9db4ec6d9620a8cd0d5e6f5a2cb');
INSERT INTO `xl_userinfo` VALUES ('372', '', null, null, null, '1', '0.00', null, null, '', '', '1524212983', '0', '0', '0', '0', '0.00', '', 'olXx5wfMidAmCdJRPvooQKiFBb_I', '6bb51dec7a9e22c973f1531a91973fd7');
INSERT INTO `xl_userinfo` VALUES ('373', '', null, null, null, '1', '0.00', null, null, '', '', '1524212983', '0', '0', '0', '0', '0.00', '', 'olXx5wUleIQEMq4a2ZbSDG3xXduU', 'b533229edb524fccce6247e7fec13673');
INSERT INTO `xl_userinfo` VALUES ('374', '', null, null, null, '1', '0.00', null, null, '', '', '1524212997', '0', '0', '0', '0', '0.00', '', 'olXx5wTwt3iPPgoy_W30cVopfRCk', 'a93250c924d3cac59559fcbcc706d605');
INSERT INTO `xl_userinfo` VALUES ('375', '', null, null, null, '1', '0.00', null, null, '', '', '1524213039', '0', '0', '0', '0', '0.00', '', 'olXx5wd372lflBJ3QtEh-WX2_EGQ', '26ada11898ea6e746f79ab633ba7592f');
INSERT INTO `xl_userinfo` VALUES ('376', '', null, null, null, '1', '0.00', null, null, '', '', '1524213122', '0', '0', '0', '0', '0.00', '', 'olXx5wUSyS5fZnbH6Nj_I9d6t9CI', '1c5a567340628e1c808bf058af76e4e3');
INSERT INTO `xl_userinfo` VALUES ('377', '', null, null, null, '1', '0.00', null, null, '', '', '1524213227', '0', '0', '0', '0', '0.00', '', 'olXx5wUKkG1sYmgQi4XcauxF1V1U', 'e6de3a9bbadf6e2f66276ddada4b85ab');
INSERT INTO `xl_userinfo` VALUES ('378', '', null, null, null, '1', '0.00', null, null, '', '', '1524213253', '0', '0', '0', '0', '0.00', '', 'olXx5wcI91b3OyRhLYUJtzzaVxRM', '1e9aec41c945f035a4c079d505992da1');
INSERT INTO `xl_userinfo` VALUES ('379', '', null, null, null, '1', '0.00', null, null, '', '', '1524213275', '0', '0', '0', '0', '0.00', '', 'olXx5weqokkKyDZt1kJWGc1Yb86A', '8f019fd08855ddc941fafeb4b5a8608e');
INSERT INTO `xl_userinfo` VALUES ('380', '', null, null, null, '1', '0.00', null, null, '', '', '1524213553', '0', '0', '0', '0', '0.00', '', 'olXx5wf4DF6PDKzd-bjWLTg7uL4A', '1d893372daf416c89b53a79448dfcecf');
INSERT INTO `xl_userinfo` VALUES ('381', '', null, null, null, '1', '0.00', null, null, '', '', '1524213568', '0', '0', '0', '0', '0.00', '', 'olXx5wSyhiWy43kFlqFQyPAM_d9w', '3533a0254c684cb7159c1d6a9d2ecbc8');
INSERT INTO `xl_userinfo` VALUES ('382', '', null, null, null, '1', '0.00', null, null, '', '', '1524213597', '0', '0', '0', '0', '0.00', '', 'olXx5wWVyBcUqz_KPqQbjIaxCMCA', '6a48eb1733b1e78ccbd9a708ef7a3a46');
INSERT INTO `xl_userinfo` VALUES ('383', '', null, null, null, '1', '0.00', null, null, '', '', '1524213734', '0', '0', '0', '0', '0.00', '', 'olXx5wSb_fdkFNnd45CXk0XieuW8', 'fd8f10e6e2721a76440277a7dd5818db');
INSERT INTO `xl_userinfo` VALUES ('384', '18616377070', null, '18616377070', null, '1', '0.00', null, null, 'e4e1b5ef80127ec27effda3c9f7082ff', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524213792', '1', '0', '0', '0', '0.00', '', 'olXx5wclYyL1Lw3OtNjf9xvH_BUA', '5e9965dc9b814c67219e3782a8b6f7cf');
INSERT INTO `xl_userinfo` VALUES ('385', '', null, null, null, '1', '0.00', null, null, '', '', '1524213863', '0', '0', '0', '0', '0.00', '', 'olXx5wfyv7cvrsH8LxK2vQrtYkOk', '63ab5838f64eed1a912ade09497d1458');
INSERT INTO `xl_userinfo` VALUES ('386', '', null, null, null, '1', '0.00', null, null, '', '', '1524213896', '0', '0', '0', '0', '0.00', '', 'olXx5wcWoyACoY7Yobs4oCVJo4zw', '4f954bb8321ea826ad4898bf64e0f03d');
INSERT INTO `xl_userinfo` VALUES ('387', '', null, null, null, '1', '0.00', null, null, '', '', '1524214200', '0', '0', '0', '0', '0.00', '', 'olXx5wTxCXmU3515bRS7MTDXal3I', 'fe7a6a0faea7644a6637242f1f31fdf9');
INSERT INTO `xl_userinfo` VALUES ('388', '', null, null, null, '1', '0.00', null, null, '', '', '1524214225', '0', '0', '0', '0', '0.00', '', 'olXx5wWezdBbnw2-PxQbEGw26HCs', '71176ffb364028cbdbbe711d0c1a3083');
INSERT INTO `xl_userinfo` VALUES ('389', '', null, null, null, '1', '0.00', null, null, '', '', '1524214229', '0', '0', '0', '0', '0.00', '', 'olXx5wYm1lZPDJLwlDm7qQl71-mE', '0531b2edb81ecd784dd30c3f4deecc95');
INSERT INTO `xl_userinfo` VALUES ('390', '', null, null, null, '1', '0.00', null, null, '', '', '1524214323', '0', '0', '0', '0', '0.00', '', 'olXx5wb9-kE4eSt6rb111rW5V9no', '565f988cc1c617d5d75d4db9c543a2ca');
INSERT INTO `xl_userinfo` VALUES ('391', '', null, null, null, '1', '0.00', null, null, '', '', '1524214328', '0', '0', '0', '0', '0.00', '', 'olXx5wbehITRpu5PlBR0eV9TNOc4', '4d6957c9cb3e18c88206613f2413e405');
INSERT INTO `xl_userinfo` VALUES ('392', '', null, null, null, '1', '0.00', null, null, '', '', '1524214333', '0', '0', '0', '0', '0.00', '', 'olXx5wSg6gx3uvM2cfskuHesCEyI', '52958f567d14b98615cb2ccff86df4fc');
INSERT INTO `xl_userinfo` VALUES ('393', '', null, null, null, '1', '0.00', null, null, '', '', '1524214394', '0', '0', '0', '0', '0.00', '', 'olXx5wUW9s86R5S1QvQcJ7gMZTtc', '79f809797b0e2cc15e02b81c258cd6b5');
INSERT INTO `xl_userinfo` VALUES ('394', '', null, null, null, '1', '0.00', null, null, '', '', '1524214433', '0', '0', '0', '0', '0.00', '', 'olXx5wWMVkR5m8C2KQdnhUwclBgQ', 'cddc3c6a184791dd89fa040964195a30');
INSERT INTO `xl_userinfo` VALUES ('395', '', null, null, null, '1', '0.00', null, null, '', '', '1524214443', '0', '0', '0', '0', '0.00', '', 'olXx5wSlUqsfcgJOE3jIDvqLQTVk', '73f418159ede7d01718cf3dd43e693ef');
INSERT INTO `xl_userinfo` VALUES ('396', '', null, null, null, '1', '0.00', null, null, '', '', '1524214488', '0', '0', '0', '0', '0.00', '', 'olXx5wdE5P_9WmmvWyzf_M_Ecsv0', '9fd6f0712e71f6b776b6c8951c999488');
INSERT INTO `xl_userinfo` VALUES ('397', '', null, null, null, '1', '0.00', null, null, '', '', '1524214554', '0', '0', '0', '0', '0.00', '', 'olXx5wZy8vbM8nj4JhVmxLOcJbnU', '45b647568b5f782d34270eece4307f5e');
INSERT INTO `xl_userinfo` VALUES ('398', '', null, null, null, '1', '0.00', null, null, '', '', '1524214674', '0', '0', '0', '0', '0.00', '', 'olXx5wVU2eiFutkL1_Ck5pnRbEao', 'cb99b25770ecdcf938ea1bf5e73a2a07');
INSERT INTO `xl_userinfo` VALUES ('399', '', null, null, null, '1', '0.00', null, null, '', '', '1524214756', '0', '0', '0', '0', '0.00', '', 'olXx5wZvm6ifQbDeoQfsuGUevdC8', 'ab550fa9552b1b49c224a4aec279754a');
INSERT INTO `xl_userinfo` VALUES ('400', '', null, null, null, '1', '0.00', null, null, '', '', '1524214761', '0', '0', '0', '0', '0.00', '', 'olXx5wXLxMkWS0V7OfXipCK5J7ak', 'fa42a4df660950735231495614ffc620');
INSERT INTO `xl_userinfo` VALUES ('401', '', null, null, null, '1', '0.00', null, null, '', '', '1524214826', '0', '0', '0', '0', '0.00', '', 'olXx5wWqwZ77TnY4DjjV3SLMEZxI', 'c643cfd7c05d5b68b40cb06efcca8ad4');
INSERT INTO `xl_userinfo` VALUES ('402', '', null, null, null, '1', '0.00', null, null, '', '', '1524214833', '0', '0', '0', '0', '0.00', '', 'olXx5wZ3csmBNKUxA48ZwuTfsGJc', '9a7798ce0a0c50b5aacd5484628f6aa7');
INSERT INTO `xl_userinfo` VALUES ('403', '', null, null, null, '1', '0.00', null, null, '', '', '1524214958', '0', '0', '0', '0', '0.00', '', 'olXx5wXuAf4NTBJ_BjuIOAh32qdE', '5950d59ed96d4f5764d1c682f2de96d6');
INSERT INTO `xl_userinfo` VALUES ('404', '', null, null, null, '1', '0.00', null, null, '', '', '1524214966', '0', '0', '0', '0', '0.00', '', 'olXx5wfKAErtoakyip98Fu1eOA_I', '619bdc7ae88c80cfce1fd01c6f4862d3');
INSERT INTO `xl_userinfo` VALUES ('405', '', null, null, null, '1', '0.00', null, null, '', '', '1524215019', '0', '0', '0', '0', '0.00', '', 'olXx5wVsNXRe6KKp62JNRnsXm6f4', 'd34c22f5578d13c043fc884b66935c32');
INSERT INTO `xl_userinfo` VALUES ('406', '', null, null, null, '1', '0.00', null, null, '', '', '1524215026', '0', '0', '0', '0', '0.00', '', 'olXx5waPn95flRu-YQKZZb_guMRU', '4d851c47a157a00800ebb180be9bcebf');
INSERT INTO `xl_userinfo` VALUES ('407', '', null, null, null, '1', '0.00', null, null, '', '', '1524215116', '0', '0', '0', '0', '0.00', '', 'olXx5wSaiZps4jeSl6zl6pg6bL4A', '8083f5873b818b1b2ea37e1928b21996');
INSERT INTO `xl_userinfo` VALUES ('408', '', null, null, null, '1', '0.00', null, null, '', '', '1524215239', '0', '0', '0', '0', '0.00', '', 'olXx5wW7Lh4aS-kOiBD2JsGwKdtQ', '9a15d319ccc37402ce63b54fc97d03a9');
INSERT INTO `xl_userinfo` VALUES ('409', '', null, null, null, '1', '0.00', null, null, '', '', '1524215256', '0', '0', '0', '0', '0.00', '', 'olXx5wWZJU-vq7HBWF53UCvorq6A', '5a265cac3535e5b48bfe330163a4a172');
INSERT INTO `xl_userinfo` VALUES ('410', '', null, null, null, '1', '0.00', null, null, '', '', '1524215336', '0', '0', '0', '0', '0.00', '', 'olXx5wenFw1UG4EhVcq7U03FZYoc', '398e09c87214ac5f24a950bb24466b16');
INSERT INTO `xl_userinfo` VALUES ('411', '', null, null, null, '1', '0.00', null, null, '', '', '1524215360', '0', '0', '0', '0', '0.00', '', 'olXx5wUVBoldN64PGhH0TFpUzRl8', 'aa997e57cc96e545271ceac5327952e6');
INSERT INTO `xl_userinfo` VALUES ('412', '', null, null, null, '1', '0.00', null, null, '', '', '1524215378', '0', '0', '0', '0', '0.00', '', 'olXx5wbLKeN15qprRfy6PU0RJ3ok', 'db37cd6e6684294c03c2872f81b9edb7');
INSERT INTO `xl_userinfo` VALUES ('413', '', null, null, null, '1', '0.00', null, null, '', '', '1524215536', '0', '0', '0', '0', '0.00', '', 'olXx5wYtvZvYK5_6cnhuBhRlaHJE', '816226765a5c75466aefe2798e074659');
INSERT INTO `xl_userinfo` VALUES ('414', '', null, null, null, '1', '0.00', null, null, '', '', '1524215579', '0', '0', '0', '0', '0.00', '', 'olXx5weu0eIlQSXqe9INTe3y_Yc8', '59a4fb213591c657b4ef383c45a5c253');
INSERT INTO `xl_userinfo` VALUES ('415', '', null, null, null, '1', '0.00', null, null, '', '', '1524215592', '0', '0', '0', '0', '0.00', '', 'olXx5wTn_pLRSh2st5kK0v7GUdNU', '2cec1589135110a103c4c3ce79baf7f9');
INSERT INTO `xl_userinfo` VALUES ('416', '', null, null, null, '1', '0.00', null, null, '', '', '1524215654', '0', '0', '0', '0', '0.00', '', 'olXx5waUxFTigBcgRgBMIVCyBPx4', '0ef311a1c3c0ddd915b2bb8a8a23ac3d');
INSERT INTO `xl_userinfo` VALUES ('417', '', null, null, null, '1', '0.00', null, null, '', '', '1524215722', '0', '0', '0', '0', '0.00', '', 'olXx5wXLyY4qvdsWOP99WeGrZads', 'd949e9a6303a425d95da6ed6664f01de');
INSERT INTO `xl_userinfo` VALUES ('418', '', null, null, null, '1', '0.00', null, null, '', '', '1524215731', '0', '0', '0', '0', '0.00', '', 'olXx5wYqjBDgbbddqZdgPagvxcFs', 'bb8161f5536b3d07efa116ad8d7841d2');
INSERT INTO `xl_userinfo` VALUES ('419', '', null, null, null, '1', '0.00', null, null, '', '', '1524215735', '0', '0', '0', '0', '0.00', '', 'olXx5wRcDjZJqGFUAFqgND7dg_xU', '01f68fe0d99c8e8a4f2d175a57d1c045');
INSERT INTO `xl_userinfo` VALUES ('420', '', null, null, null, '1', '0.00', null, null, '', '', '1524215751', '0', '0', '0', '0', '0.00', '', 'olXx5wS4hpoNOgb-EkrvWeGOsZOE', '45c3ec6998acaece8a43765e9acbcdee');
INSERT INTO `xl_userinfo` VALUES ('421', '', null, null, null, '1', '0.00', null, null, '', '', '1524215777', '0', '0', '0', '0', '0.00', '', 'olXx5wQnGkFNHYmMK935srkH4MUQ', '934d84aa501a0c0f0d1c6b5ff795d89d');
INSERT INTO `xl_userinfo` VALUES ('422', '', null, null, null, '1', '0.00', null, null, '', '', '1524215860', '0', '0', '0', '0', '0.00', '', 'olXx5wcSiH24zTFrIxniH4qvs8Kg', '5c742679c2675a43f6d28dc9a7991a5b');
INSERT INTO `xl_userinfo` VALUES ('423', '', null, null, null, '1', '0.00', null, null, '', '', '1524215872', '0', '0', '0', '0', '0.00', '', 'olXx5wXmJNMSJ_reEUmpYlGnpmuM', '1a7dd8d022fa1bfc360b8e4cb9c245f3');
INSERT INTO `xl_userinfo` VALUES ('424', '', null, null, null, '1', '0.00', null, null, '', '', '1524215931', '0', '0', '0', '0', '0.00', '', 'olXx5wREtyj1akdK2hTAFnzCPnIM', 'f9893975be774f860d1da8df4234b303');
INSERT INTO `xl_userinfo` VALUES ('425', '', null, null, null, '1', '0.00', null, null, '', '', '1524215947', '0', '0', '0', '0', '0.00', '', 'olXx5waQiV3dzvObvbtLSgLq4gUQ', 'bfaed662bf035ee3404f9fd47a6c92db');
INSERT INTO `xl_userinfo` VALUES ('426', '', null, null, null, '1', '0.00', null, null, '', '', '1524215953', '0', '0', '0', '0', '0.00', '', 'olXx5wbKcax6tHiy5POO9xrztv6c', '7074f7a05e2afa44b0c13f1073894def');
INSERT INTO `xl_userinfo` VALUES ('427', '', null, null, null, '1', '0.00', null, null, '', '', '1524215958', '0', '0', '0', '0', '0.00', '', 'olXx5wXFSyqMjn14T-2NatJ_bly0', 'cbc3d1dde7e371e4bfb6aaa0949c087b');
INSERT INTO `xl_userinfo` VALUES ('428', '', null, null, null, '1', '0.00', null, null, '', '', '1524216024', '0', '0', '0', '0', '0.00', '', 'olXx5wSZHHCVDrbiFHN0Ky8egK94', '56b1b6d04a48c6d2aba0a9ae771ca237');
INSERT INTO `xl_userinfo` VALUES ('429', '', null, null, null, '1', '0.00', null, null, '', '', '1524216120', '0', '0', '0', '0', '0.00', '', 'olXx5wUxk0WrPNZReZlbrNp4CjKs', 'f5ae47f474d8545d3946103b3f3f1bf4');
INSERT INTO `xl_userinfo` VALUES ('430', '', null, null, null, '1', '0.00', null, null, '', '', '1524216160', '0', '0', '0', '0', '0.00', '', 'olXx5wRbbfJVQecHNG3QWeBhnMvw', '67bbc10813b052991c7e63f36f5ea9e8');
INSERT INTO `xl_userinfo` VALUES ('431', '', null, null, null, '1', '0.00', null, null, '', '', '1524216200', '0', '0', '0', '0', '0.00', '', 'olXx5wVD2bOSUc1D9tigc5-hEfds', '28caf3124242d1d07cc8232cab2751a2');
INSERT INTO `xl_userinfo` VALUES ('432', '', null, null, null, '1', '0.00', null, null, '', '', '1524216244', '0', '0', '0', '0', '0.00', '', 'olXx5wfg0mjd9zVLv8RS_1FnUOfM', 'b4a91ecb624415d517e6fcf8b3bc73b2');
INSERT INTO `xl_userinfo` VALUES ('433', '', null, null, null, '1', '0.00', null, null, '', '', '1524216385', '0', '0', '0', '0', '0.00', '', 'olXx5wccFx-6KFuwfn7HfrGiAjNA', '9be176c20e96dcbc219427da39f57579');
INSERT INTO `xl_userinfo` VALUES ('434', '', null, null, null, '1', '0.00', null, null, '', '', '1524216386', '0', '0', '0', '0', '0.00', '', 'olXx5wfVQ76Mu-z0uxdmSvM6oHJo', 'a34340bd967d52cb600738e5a22994b8');
INSERT INTO `xl_userinfo` VALUES ('435', '', null, null, null, '1', '0.00', null, null, '', '', '1524216404', '0', '0', '0', '0', '0.00', '', 'olXx5wayNXkIV_n2jVvQvKHHNKPM', '30021aa3fa910d0829a26dac11b817dc');
INSERT INTO `xl_userinfo` VALUES ('436', '', null, null, null, '1', '0.00', null, null, '', '', '1524216454', '0', '0', '0', '0', '0.00', '', 'olXx5wQuXCKv2Fg52VHuOwVCByM4', '74a1a3839bb8f760f1c2d3c8443500b8');
INSERT INTO `xl_userinfo` VALUES ('437', '', null, null, null, '1', '0.00', null, null, '', '', '1524216456', '0', '0', '0', '0', '0.00', '', 'olXx5wcMnLykS1Cud8ZHvVroaBqw', '1c380c8ca32f2f5f44dfbb313ebb83dd');
INSERT INTO `xl_userinfo` VALUES ('438', '', null, null, null, '1', '0.00', null, null, '', '', '1524216647', '0', '0', '0', '0', '0.00', '', 'olXx5wVxwiDdsXEtAKCdcXuwpNOA', '3b3c2bea560262d28d8f62bd847f8555');
INSERT INTO `xl_userinfo` VALUES ('439', '', null, null, null, '1', '0.00', null, null, '', '', '1524216722', '0', '0', '0', '0', '0.00', '', 'olXx5wZnek8qCLNo5f4TZwM3F_Rg', 'eaa3bde7db1d471c91e8d5a821f0c5c6');
INSERT INTO `xl_userinfo` VALUES ('440', '', null, null, null, '1', '0.00', null, null, '', '', '1524216737', '0', '0', '0', '0', '0.00', '', 'olXx5wZkAHEAMvL90ECqsM9F-89U', '0ac9139fc51f1671dd359cf191abccf0');
INSERT INTO `xl_userinfo` VALUES ('441', '', null, null, null, '1', '0.00', null, null, '', '', '1524216764', '0', '0', '0', '0', '0.00', '', 'olXx5wWYIGkSpxLkYdDrviBAVwMw', 'a9215e0155b8d65fc820f89e1f690387');
INSERT INTO `xl_userinfo` VALUES ('442', '', null, null, null, '1', '0.00', null, null, '', '', '1524216769', '0', '0', '0', '0', '0.00', '', 'olXx5wZLG7ldWfBc2kMxFJ3DsdG4', '898275737a262f4d8d69188bfc0ae55c');
INSERT INTO `xl_userinfo` VALUES ('443', '', null, null, null, '1', '0.00', null, null, '', '', '1524216958', '0', '0', '0', '0', '0.00', '', 'olXx5wWHQuXKjiHHDmDPRZkhi4AM', 'fe8edb6b4f642152f9d09fa1d0580e9b');
INSERT INTO `xl_userinfo` VALUES ('444', '', null, null, null, '1', '0.00', null, null, '', '', '1524217057', '0', '0', '0', '0', '0.00', '', 'olXx5wXstc9NSiQlOPtfABP5b3sM', '5d41229374d6ee1f5c9248d3e17b6044');
INSERT INTO `xl_userinfo` VALUES ('445', '', null, null, null, '1', '0.00', null, null, '', '', '1524217158', '0', '0', '0', '0', '0.00', '', 'olXx5wV2HJ4Jw4NeRg0n5GrafWjQ', '7d03b0ef16a5afb5930e3e1d69b33917');
INSERT INTO `xl_userinfo` VALUES ('446', '', null, null, null, '1', '0.00', null, null, '', '', '1524217257', '0', '0', '0', '0', '0.00', '', 'olXx5wYTa0BF6XOAMrns5CElF-1k', 'c67e44f4fc95993e7f6e3499fbd0450f');
INSERT INTO `xl_userinfo` VALUES ('447', '', null, null, null, '1', '0.00', null, null, '', '', '1524217867', '0', '0', '0', '0', '0.00', '', 'olXx5wftdsj5ppprfBOGnig6GmWM', 'ecb2f7c0b5585c769910497438f90ca7');
INSERT INTO `xl_userinfo` VALUES ('448', '', null, null, null, '1', '0.00', null, null, '', '', '1524217939', '0', '0', '0', '0', '0.00', '', 'olXx5wQJ9p2NLV9j9v6GwVUKIB2w', 'fd46351e7f2e974b24e3ff57f50f12a9');
INSERT INTO `xl_userinfo` VALUES ('449', '', null, null, null, '1', '0.00', null, null, '', '', '1524218063', '0', '0', '0', '0', '0.00', '', 'olXx5wUZ1xXvvdvfUKBtyrxhvQ5Y', 'b4914509919598ac840a91a2c293a17a');
INSERT INTO `xl_userinfo` VALUES ('450', '13817535441', null, '13817535441', null, '1', '0.00', null, null, 'f54d6f3890af30298a5a3233b5bd42ac', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524218192', '1', '0', '0', '0', '0.00', '', 'olXx5wVIqibdAZ3p9YYSbBIthkqU', 'b64ad84e3e36ca0155ea96755858016c');
INSERT INTO `xl_userinfo` VALUES ('451', '', null, null, null, '1', '0.00', null, null, '', '', '1524218169', '0', '0', '0', '0', '0.00', '', 'olXx5wcolVojGPQnGZB4aYWvt0Bk', '9a3aa889807212fb4ecac0e268ae8fdb');
INSERT INTO `xl_userinfo` VALUES ('452', '', null, null, null, '1', '0.00', null, null, '', '', '1524218500', '0', '0', '0', '0', '0.00', '', 'olXx5wbN0nqAfkBMipyCUnudgh5g', '643bf3e083f3a8f0e48696a2834ef30e');
INSERT INTO `xl_userinfo` VALUES ('453', '', null, null, null, '1', '0.00', null, null, '', '', '1524218578', '0', '0', '0', '0', '0.00', '', 'olXx5wShp_tkKr1xV2b8bSNUhK5Q', '0bc8d4e5e5b45f30db4674dd8a4d8abd');
INSERT INTO `xl_userinfo` VALUES ('454', '', null, null, null, '1', '0.00', null, null, '', '', '1524218596', '0', '0', '0', '0', '0.00', '', 'olXx5wWILKWngR_PY37y1w_PDSEM', '0bf1017887e369c68ecbd817e71188db');
INSERT INTO `xl_userinfo` VALUES ('455', '', null, null, null, '1', '0.00', null, null, '', '', '1524218649', '0', '0', '0', '0', '0.00', '', 'olXx5wQoHu0DgiCJZMT9GkSYVvOY', '4549e09e48e5c75217a85ff85b9def32');
INSERT INTO `xl_userinfo` VALUES ('456', '', null, null, null, '1', '0.00', null, null, '', '', '1524218724', '0', '0', '0', '0', '0.00', '', 'olXx5weNa2r8trcZI4Z-7PpGC0jE', '7df67715ebe7b562d103948e2a1be691');
INSERT INTO `xl_userinfo` VALUES ('457', '', null, null, null, '1', '0.00', null, null, '', '', '1524218725', '0', '0', '0', '0', '0.00', '', 'olXx5wRkJYHJiUtt5TTodEbiMBKw', '13157c57f38b423be4f61922ad1a277a');
INSERT INTO `xl_userinfo` VALUES ('458', '', null, null, null, '1', '0.00', null, null, '', '', '1524218860', '0', '0', '0', '0', '0.00', '', 'olXx5weYdMpB4ekfGySButPvWYIk', 'c8ebeff23150ca8b9468a55ee9587477');
INSERT INTO `xl_userinfo` VALUES ('459', '', null, null, null, '1', '0.00', null, null, '', '', '1524218995', '0', '0', '0', '0', '0.00', '', 'olXx5wbxG9xMwRUNKEXryZTlRP-0', '1c385bad2122449631d30c7d87311ee0');
INSERT INTO `xl_userinfo` VALUES ('460', '13816735783', null, '13816735783', null, '1', '0.00', null, null, '47bd188d397cfc17e4a111b37bb157fb', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524219163', '1', '0', '0', '0', '0.00', '', 'olXx5wU1ZoXVMxL7ccx-LIY2OhLA', '38ad0f4769532ff0ccb7cb68370e0127');
INSERT INTO `xl_userinfo` VALUES ('461', '', null, null, null, '1', '0.00', null, null, '', '', '1524219470', '0', '0', '0', '0', '0.00', '', 'olXx5wb0i6KZIQJhYQ4l8L1334pc', '753e21b39d2119660cffbc75095b0040');
INSERT INTO `xl_userinfo` VALUES ('462', '', null, null, null, '1', '0.00', null, null, '', '', '1524219560', '0', '0', '0', '0', '0.00', '', 'olXx5wXqOvEg-SeeQwYOrXG-uafQ', 'c34411a05f122f66f947cc8fb6778b6a');
INSERT INTO `xl_userinfo` VALUES ('463', '', null, null, null, '1', '0.00', null, null, '', '', '1524219588', '0', '0', '0', '0', '0.00', '', 'olXx5wd8fStxw2vfJarpPIJU5Kf4', '5c6e426f705e9d6cb28c237e4e3c4b72');
INSERT INTO `xl_userinfo` VALUES ('464', '', null, null, null, '1', '0.00', null, null, '', '', '1524220395', '0', '0', '0', '0', '0.00', '', 'olXx5wWOWwajhcHbyxeWjpdZYkmI', 'd4caec46cbd5ce8284ee3c0adfce71ef');
INSERT INTO `xl_userinfo` VALUES ('465', '', null, null, null, '1', '0.00', null, null, '', '', '1524220595', '0', '0', '0', '0', '0.00', '', 'olXx5wftfw--FjU_mBdSn_Qj1W98', 'c2469130911a5a0661a568f1efa9ccf1');
INSERT INTO `xl_userinfo` VALUES ('466', '', null, null, null, '1', '0.00', null, null, '', '', '1524220754', '0', '0', '0', '0', '0.00', '', 'olXx5wYsoe3QgF_kZgzfSWwBnHag', 'bb292436cce589c8ba6c2f52141ee022');
INSERT INTO `xl_userinfo` VALUES ('467', '', null, null, null, '1', '0.00', null, null, '', '', '1524221149', '0', '0', '0', '0', '0.00', '', 'olXx5wfgY6APa5c3kojhjKudTvqA', '7b86566fa74d3fc524439d4fbcd79458');
INSERT INTO `xl_userinfo` VALUES ('468', '', null, null, null, '1', '0.00', null, null, '', '', '1524221228', '0', '0', '0', '0', '0.00', '', 'olXx5wbhdmPft2LaOx2BKiGdwg3A', 'de27c49396754cc70ba34ebbcb6421c2');
INSERT INTO `xl_userinfo` VALUES ('469', '', null, null, null, '1', '0.00', null, null, '', '', '1524221363', '0', '0', '0', '0', '0.00', '', 'olXx5wcnPNd105B5z5CjVW0zC5lE', 'f7eff685dc4b94f0b89b2b353a90ded9');
INSERT INTO `xl_userinfo` VALUES ('470', '', null, null, null, '1', '0.00', null, null, '', '', '1524222455', '0', '0', '0', '0', '0.00', '', 'olXx5wWBtBem2uL1QAG8teGRNEpM', 'a5b2a2dba98b7b53212db98e5e43a519');
INSERT INTO `xl_userinfo` VALUES ('471', '', null, null, null, '1', '0.00', null, null, '', '', '1524222776', '0', '0', '0', '0', '0.00', '', 'olXx5wdPe1KpGV5ZPSE5SNT7jL2A', 'f0376ba24ab446bc91148d9a744fb22b');
INSERT INTO `xl_userinfo` VALUES ('472', '', null, null, null, '1', '0.00', null, null, '', '', '1524223654', '0', '0', '0', '0', '0.00', '', 'olXx5waIGtkHeDrk_P-5dOcme7y4', '9d4b96826403e60b33ca5c78750bcb1c');
INSERT INTO `xl_userinfo` VALUES ('473', '', null, null, null, '1', '0.00', null, null, '', '', '1524223872', '0', '0', '0', '0', '0.00', '', 'olXx5wRYX3olWirdDhb7KLWwsGW8', 'af8731c0ba97996ac79ca97a7e45d5b8');
INSERT INTO `xl_userinfo` VALUES ('474', '', null, null, null, '1', '0.00', null, null, '', '', '1524223902', '0', '0', '0', '0', '0.00', '', 'olXx5wdcqRxh37x14bzsmEBh2e3k', 'ce64666fb0f536838db1fdb6d9bff3bb');
INSERT INTO `xl_userinfo` VALUES ('475', '', null, null, null, '1', '0.00', null, null, '', '', '1524225122', '0', '0', '0', '0', '0.00', '', 'olXx5wRHgm40_uPPY2PyfYX2XkOI', 'c953f5e5f479f740d376fe3a71487f41');
INSERT INTO `xl_userinfo` VALUES ('476', '', null, null, null, '1', '0.00', null, null, '', '', '1524225470', '0', '0', '0', '0', '0.00', '', 'olXx5wTVKGHAgTwmiH_iFyscgsKk', '9f6ca17ebe6d3f43add63bfab751df1e');
INSERT INTO `xl_userinfo` VALUES ('477', '', null, null, null, '1', '0.00', null, null, '', '', '1524225509', '0', '0', '0', '0', '0.00', '', 'olXx5wW4TJiHuvYnDeBreDDeP2iY', '37199b1581e7cfc77533ccf92be3950e');
INSERT INTO `xl_userinfo` VALUES ('478', '', null, null, null, '1', '0.00', null, null, '', '', '1524225741', '0', '0', '0', '0', '0.00', '', 'olXx5wU1ec9SJ0aWhuVRfiOFJTGo', '0c13915e8bac0546ee574591aff75a5c');
INSERT INTO `xl_userinfo` VALUES ('479', '', null, null, null, '1', '0.00', null, null, '', '', '1524226364', '0', '0', '0', '0', '0.00', '', 'olXx5wekkcRN7GR35PK0WvnzJVIM', '04c1257b7092b2375e2f67e18f447cf9');
INSERT INTO `xl_userinfo` VALUES ('480', '', null, null, null, '1', '0.00', null, null, '', '', '1524227583', '0', '0', '0', '0', '0.00', '', 'olXx5wZJAWHRDRCBTxCN3Px8tkLU', '743acd5f2bb6f292ce8909ef4d57ffbf');
INSERT INTO `xl_userinfo` VALUES ('481', '', null, null, null, '1', '0.00', null, null, '', '', '1524228153', '0', '0', '0', '0', '0.00', '', 'olXx5we0xbD3qZTas1-Am--AP5xA', 'f7f0fb4608ad22f39ae54a9ab15ce590');
INSERT INTO `xl_userinfo` VALUES ('482', '', null, null, null, '1', '0.00', null, null, '', '', '1524228706', '0', '0', '0', '0', '0.00', '', 'olXx5wRV0G0gYnAoXPSnzyRwQKz4', '02950851ab2a8423bf1d7f97fb254677');
INSERT INTO `xl_userinfo` VALUES ('483', '', null, null, null, '1', '0.00', null, null, '', '', '1524229248', '0', '0', '0', '0', '0.00', '', 'olXx5weCu-N-me38xvwG38krZJxE', '535a26415a87ec31f1172c4f8acde186');
INSERT INTO `xl_userinfo` VALUES ('484', '', null, null, null, '1', '0.00', null, null, '', '', '1524229386', '0', '0', '0', '0', '0.00', '', 'olXx5wQX6vbjMvsKeEn3SnFUVnSU', '02c3ef7a504931a23390aebd6bc1652e');
INSERT INTO `xl_userinfo` VALUES ('485', '', null, null, null, '1', '0.00', null, null, '', '', '1524229929', '0', '0', '0', '0', '0.00', '', 'olXx5wf1RqhsdMcjCE1TngSgR8Lg', 'bf91bdf378a1051ab9b99ac8b4805613');
INSERT INTO `xl_userinfo` VALUES ('486', '', null, null, null, '1', '0.00', null, null, '', '', '1524231035', '0', '0', '0', '0', '0.00', '', 'olXx5wT02QZzMVWm26U3yTOOTY8s', 'c260782a9b50f34ce902276d5d4bc9a8');
INSERT INTO `xl_userinfo` VALUES ('487', '', null, null, null, '1', '0.00', null, null, '', '', '1524231231', '0', '0', '0', '0', '0.00', '', 'olXx5wVukRJvY3lEFhf7DlbYoZE8', '8bb045a6d97775a310ea33b15bd2e25f');
INSERT INTO `xl_userinfo` VALUES ('488', '', null, null, null, '1', '0.00', null, null, '', '', '1524233664', '0', '0', '0', '0', '0.00', '', 'olXx5wT9qK9WAI3gK67mIEc5xBF0', 'fcc3e755737753145abbc7ab3d0ad138');
INSERT INTO `xl_userinfo` VALUES ('489', '', null, null, null, '1', '0.00', null, null, '', '', '1524233760', '0', '0', '0', '0', '0.00', '', 'olXx5wZPci0elsBFCfhx38P6xayY', '364f949ea26cd265b81e3bd86060ad2b');
INSERT INTO `xl_userinfo` VALUES ('490', '', null, null, null, '1', '0.00', null, null, '', '', '1524237199', '0', '0', '0', '0', '0.00', '', 'olXx5wQZDdLge4j14V_r5lKDHrrQ', '70f418d8a160ea86e8b4b6b7fef3283f');
INSERT INTO `xl_userinfo` VALUES ('491', '', null, null, null, '1', '0.00', null, null, '', '', '1524240184', '0', '0', '0', '0', '0.00', '', 'olXx5wSfpDz3HtLqtv9dunDG5Mwk', 'e04bedf8eb1db4c379d8a84c238deaa8');
INSERT INTO `xl_userinfo` VALUES ('492', '', null, null, null, '1', '0.00', null, null, '', '', '1524263759', '0', '0', '0', '0', '0.00', '', 'olXx5wUzH6f4Mt5UwdBD0YQZAUO0', '7b4e5810bf95bb0aff02a25d63a97154');
INSERT INTO `xl_userinfo` VALUES ('493', '', null, null, null, '1', '0.00', null, null, '', '', '1524265889', '0', '0', '0', '0', '0.00', '', 'olXx5wfTqXifIdjhEVqNENuy27-s', 'f38686959553548c7f6ff8827d5d9d15');
INSERT INTO `xl_userinfo` VALUES ('494', '', null, null, null, '1', '0.00', null, null, '', '', '1524278113', '0', '0', '0', '0', '0.00', '', 'olXx5wQieekN33YC3Bt8HhnnkHVU', '04fff2828be4cbd1548f1ded73f07b9a');
INSERT INTO `xl_userinfo` VALUES ('495', '', null, null, null, '1', '0.00', null, null, '', '', '1524278945', '0', '0', '0', '0', '0.00', '', 'olXx5wRhGcrrtTu_k14rlYz8ZY2g', 'c36bd5a5d8631a56449379e1aad7e144');
INSERT INTO `xl_userinfo` VALUES ('496', '', null, null, null, '1', '0.00', null, null, '', '', '1524279405', '0', '0', '0', '0', '0.00', '', 'olXx5wQsVAxDsbOuFbI4mDwpwCFQ', '1cd28ff628a759b597e7ad9cf548e1ab');
INSERT INTO `xl_userinfo` VALUES ('497', '', null, null, null, '1', '0.00', null, null, '', '', '1524279893', '0', '0', '0', '0', '0.00', '', 'olXx5wevnu9IxJ9CR_pgZVBzY1qM', '927f800ce4f53e5cc19a164b4abd86e5');
INSERT INTO `xl_userinfo` VALUES ('498', '', null, null, null, '1', '0.00', null, null, '', '', '1524279902', '0', '0', '0', '0', '0.00', '', 'olXx5wcDdAWvQSlQ0Aoc7QAjNZ30', '01ac9c86646e8bd840e084977bd456a9');
INSERT INTO `xl_userinfo` VALUES ('499', '', null, null, null, '1', '0.00', null, null, '', '', '1524280618', '0', '0', '0', '0', '0.00', '', 'olXx5weDNXPbRb2-diBW2Or_EQtI', '2ab148fe8b02d66ad25103ab3f21b664');
INSERT INTO `xl_userinfo` VALUES ('500', '18917029580', null, '18917029580', null, '1', '0.00', null, null, '7fca0b0513f5a77749511e3e61eed306', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524281423', '1', '0', '0', '0', '0.00', '', 'olXx5weBUnQtWyOr3bIvBTZZm1Sk', 'af1024e591f0cba6c7b4142ebce98f97');
INSERT INTO `xl_userinfo` VALUES ('501', '', null, null, null, '1', '0.00', null, null, '', '', '1524281504', '0', '0', '0', '0', '0.00', '', 'olXx5wbT_wZm3m7qUb-iO2VCcyy8', 'a4b57d74e97d9b3009186788eb51efb0');
INSERT INTO `xl_userinfo` VALUES ('502', '', null, null, null, '1', '0.00', null, null, '', '', '1524282495', '0', '0', '0', '0', '0.00', '', 'olXx5wRDHuLHW90GpbxCa1AQXByg', '721abd23687105c7e1e9d67b857f5832');
INSERT INTO `xl_userinfo` VALUES ('503', '', null, null, null, '1', '0.00', null, null, '', '', '1524284639', '0', '0', '0', '0', '0.00', '', 'olXx5wfkLSHcucKSctmvPYUT7ERc', 'd100c9fd1b6dd79110e35af097bfa8c4');
INSERT INTO `xl_userinfo` VALUES ('504', '', null, null, null, '1', '0.00', null, null, '', '', '1524300565', '0', '0', '0', '0', '0.00', '', 'olXx5wVlJLCiMfeUMyu8UZm0JSi8', 'bd017f78d8d09ba7494f3279b51bf3cf');
INSERT INTO `xl_userinfo` VALUES ('505', '', null, null, null, '1', '0.00', null, null, '', '', '1524321780', '0', '0', '0', '0', '0.00', '', 'olXx5wdHCBmMbcrqGXrI1mmHbZcY', '9b540d0caedeeb3a872888636dbbde7e');
INSERT INTO `xl_userinfo` VALUES ('506', '13166933493', null, '13166933493', null, '1', '0.00', null, null, 'ffc10aeb171eb2bb6df58e80c44815b3', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524369943', '1', '0', '0', '0', '0.00', '', 'olXx5wYM9G9SHwtR5UT_82gzxRyU', '0234d927e9d8f81df3ae6cc92f61b297');
INSERT INTO `xl_userinfo` VALUES ('507', '', null, null, null, '1', '0.00', null, null, '', '', '1524388688', '0', '0', '0', '0', '0.00', '', 'olXx5weFKY3U2H_bht3te-w6RKqg', '426a42108c39d60eab52a3a2cbd07191');
INSERT INTO `xl_userinfo` VALUES ('508', '18839682310', null, '18839682310', null, '1', '0.00', null, null, '5a327493b0e98c32a13ef74c831abae6', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524392870', '1', '342', '0', '0', '0.00', '', 'olXx5wQmEEZz3SyyyOmj2y5gFLmY', '4936ed6bf3de709276cb37ae8816ed33');
INSERT INTO `xl_userinfo` VALUES ('509', '15900950260', null, '15900950260', null, '1', '0.00', null, null, '805c225d43a70058c0e4f37555515894', 'http://www.jubenxiong.com/aml2/img/headimg/aml_logo.png', '1524393363', '1', '342', '0', '0', '0.00', '', 'olXx5wZTn-nkyWOx9NppWp6wztHw', '473dea329bc6408642c6b68107a3ca3c');
INSERT INTO `xl_userinfo` VALUES ('510', '', null, null, null, '1', '0.00', null, null, '', '', '1524460436', '0', '0', '0', '0', '0.00', '', 'olXx5wWGBhfpJEi1-VjCpnL3z3hM', '741b80c4be7b9135d5e6dad077d4cb19');
INSERT INTO `xl_userinfo` VALUES ('511', '', null, null, null, '1', '0.00', null, null, '', '', '1524580579', '0', '0', '0', '0', '0.00', '', 'olXx5wcUAMECkIaCig2rZTp9uc18', '2e468ca78114900ac44ae1606289e773');

-- ----------------------------
-- Table structure for xl_userrole
-- ----------------------------
DROP TABLE IF EXISTS `xl_userrole`;
CREATE TABLE `xl_userrole` (
  `roleid` int(11) NOT NULL DEFAULT '1' COMMENT '角色编号',
  `rolename` varchar(11) NOT NULL DEFAULT '' COMMENT '角色名字',
  `buyfun` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可以购买',
  `fallInto` tinyint(1) NOT NULL DEFAULT '1' COMMENT '分成方法',
  `togetherfallrole` int(11) NOT NULL DEFAULT '0' COMMENT '一起分成的roleid',
  PRIMARY KEY (`roleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_userrole
-- ----------------------------
INSERT INTO `xl_userrole` VALUES ('1', '客户', '1', '0', '0');
INSERT INTO `xl_userrole` VALUES ('2', '商家', '1', '1', '0');
INSERT INTO `xl_userrole` VALUES ('3', '业务', '0', '1', '4');
INSERT INTO `xl_userrole` VALUES ('4', '美导', '0', '0', '0');
INSERT INTO `xl_userrole` VALUES ('5', '代理商', '0', '1', '0');

-- ----------------------------
-- Table structure for xl_withdrawlist
-- ----------------------------
DROP TABLE IF EXISTS `xl_withdrawlist`;
CREATE TABLE `xl_withdrawlist` (
  `drawid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `drawdate` int(15) NOT NULL,
  `sum` decimal(11,2) DEFAULT '0.00',
  `operator` varchar(120) DEFAULT '',
  `status` int(11) DEFAULT '0',
  `notes` text,
  PRIMARY KEY (`drawid`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_withdrawlist
-- ----------------------------
INSERT INTO `xl_withdrawlist` VALUES ('57', '325', '1524191404', '100.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('55', '325', '1524191281', '100.00', '', '0', null);
