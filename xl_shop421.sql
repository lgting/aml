/*
Navicat MySQL Data Transfer

Source Server         : self2
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : xl_shop

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2018-04-21 09:55:57
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminuser
-- ----------------------------
INSERT INTO `adminuser` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '', '3', '');
INSERT INTO `adminuser` VALUES ('2', 'admin2', 'e10adc3949ba59abbe56e057f20f883e', '0', '2', '');
INSERT INTO `adminuser` VALUES ('3', 'admin3', 'e10adc3949ba59abbe56e057f20f883e', '0', '2', '1520328311');
INSERT INTO `adminuser` VALUES ('4', 'admin4', 'e10adc3949ba59abbe56e057f20f883e', '0', '3', '1520328330');

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
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_agentuser
-- ----------------------------
INSERT INTO `xl_agentuser` VALUES ('117', '182', '190', '1521277865');
INSERT INTO `xl_agentuser` VALUES ('115', '182', '179', '1521255017');
INSERT INTO `xl_agentuser` VALUES ('114', '182', '183', '1521254861');
INSERT INTO `xl_agentuser` VALUES ('113', '182', '180', '1521254476');
INSERT INTO `xl_agentuser` VALUES ('116', '182', '184', '1521255324');
INSERT INTO `xl_agentuser` VALUES ('111', '182', '187', '1521254436');
INSERT INTO `xl_agentuser` VALUES ('110', '182', '178', '1521254331');
INSERT INTO `xl_agentuser` VALUES ('109', '182', '185', '1521254315');
INSERT INTO `xl_agentuser` VALUES ('108', '182', '181', '1521254276');
INSERT INTO `xl_agentuser` VALUES ('118', '182', '189', '1521777782');
INSERT INTO `xl_agentuser` VALUES ('119', '182', '186', '1522124530');
INSERT INTO `xl_agentuser` VALUES ('120', '182', '209', '1522126614');
INSERT INTO `xl_agentuser` VALUES ('122', '182', '199', '1522397173');

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
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_bankinfos
-- ----------------------------
INSERT INTO `xl_bankinfos` VALUES ('12', '22', '中国工商银行', 'ICBC', '6222021001005520781', '孙成培');
INSERT INTO `xl_bankinfos` VALUES ('13', '21', '中国农业银行', 'ABC', '6228480038536623978', '123456');
INSERT INTO `xl_bankinfos` VALUES ('14', '156', '中国工商银行', 'ICBC', '6222021001100330775', '陈雪丽');
INSERT INTO `xl_bankinfos` VALUES ('15', '157', '中国工商银行', 'ICBC', '6222021001100330775', '陈雪丽');
INSERT INTO `xl_bankinfos` VALUES ('16', '153', '中国工商银行', 'ICBC', '6222021001100330775', '陈雪丽');

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
) ENGINE=MyISAM AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_buylist
-- ----------------------------
INSERT INTO `xl_buylist` VALUES ('207', '4200000083201803170208916926', '380元体验套餐', '1521254804', '6', '1', '0', 'buy', '183', '10000.00', '19', '0', '1', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('208', '4200000084201803170195267633', '380元体验套餐', '1521255286', '6', '1', '0', 'buy', '184', '10000.00', '19', '0', '1', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('209', '4200000094201803170443656701', '青柠檬鲜颜活肌原水', '1521276985', '1', '0', '0', 'buy', '190', '100.00', '22', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('210', '4200000083201803170425574964', '青柠檬鲜颜活肌原水', '1521277557', '0', '0', '0', 'buy', '189', '100.00', '22', '0', '2', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('211', '4200000094201803170521895477', '青柠檬鲜颜活肌原水', '1521280727', '1', '0', '0', 'buy', '190', '1.00', '22', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('212', '4200000085201803170460004088', '青柠檬鲜颜活肌原水', '1521280806', '1', '0', '0', 'buy', '190', '1.00', '22', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('213', '4200000092201803170420141750', '青柠檬鲜颜活肌原水', '1521281050', '0', '0', '0', 'buy', '189', '1.00', '22', '0', '2', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('214', '4200000091201803170478732011', '青柠檬鲜颜活肌原水', '1521281352', '0', '0', '0', 'buy', '189', '1.00', '22', '0', '2', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('206', '4200000090201803170168756033', '380元体验套餐', '1521254783', '6', '1', '0', 'buy', '179', '10000.00', '19', '0', '1', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('215', '4200000092201803244710179032', '科妍鲜颜洁面乳', '1521879553', '0', '0', '0', 'buy', '189', '100.00', '23', '0', '2', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('216', '4200000088201803244920343574', '青柠檬鲜颜活肌原水', '1521897463', '0', '0', '0', 'buy', '189', '100.00', '22', '0', '2', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('217', '4200000095201803276434889661', '9.9元推广卡', '1522115575', '1', '2', '0', 'buy', '179', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('218', '4200000084201803276422085866', '9.9元推广卡', '1522115642', '1', '2', '0', 'buy', '183', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('219', '4200000089201803276534476847', '9.9元推广卡', '1522127548', '1', '2', '0', 'buy', '212', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('220', '4200000096201803276538248399', '9.9元推广卡', '1522127954', '1', '2', '0', 'buy', '214', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('221', '4200000099201803276507558097', '9.9元推广卡', '1522128481', '1', '2', '0', 'buy', '215', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('222', '4200000094201803276583808900', '9.9元推广卡', '1522129260', '1', '2', '0', 'buy', '216', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('223', '4200000099201803276598912802', '9.9元推广卡', '1522134589', '1', '2', '0', 'buy', '219', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('224', '4200000082201803276600485441', '青柠檬鲜颜活肌原水', '1522138076', '0', '0', '0', 'buy', '199', '10.00', '22', '0', '2', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('225', '4200000090201803276717388441', '9.9元推广卡', '1522141867', '1', '2', '0', 'buy', '222', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('226', '4200000089201803276664134491', '9.9元推广卡', '1522143026', '1', '2', '0', 'buy', '224', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('227', '4200000082201803286542938109', '9.9元推广卡', '1522216419', '1', '2', '0', 'buy', '241', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('228', '4200000096201803287230893693', '9.9元推广卡', '1522224981', '1', '2', '0', 'buy', '249', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('229', '4200000093201803287341665008', '9.9元推广卡', '1522232987', '1', '2', '0', 'buy', '253', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('230', '4200000098201803287374105761', '9.9元推广卡', '1522233515', '1', '2', '0', 'buy', '252', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('231', '4200000091201803287288956178', '9.9元推广卡', '1522234904', '1', '2', '0', 'buy', '254', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('232', '4200000083201803297573073501', '198元塑时代瘦身卡', '1522253103', '0', '0', '0', 'buy', '183', '19800.00', '37', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('233', '4200000094201803297827786136', '9.9元推广卡', '1522308327', '1', '2', '0', 'buy', '257', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('234', '4200000095201803297823365185', '9.9元推广卡', '1522310098', '1', '2', '0', 'buy', '258', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('235', '4200000097201803297918484825', '9.9元推广卡', '1522314207', '1', '2', '0', 'buy', '259', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('236', '4200000098201803297904956530', '9.9元推广卡', '1522316300', '1', '2', '0', 'buy', '260', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('237', '4200000099201803308553973137', '9.9元推广卡', '1522396828', '1', '1', '0', 'buy', '189', '100.00', '39', '0', '1', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('238', '4200000086201803308499799901', '1元抢购', '1522397028', '1', '2', '0', 'buy', '199', '100.00', '21', '0', '1', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('239', '4200000099201804019812694557', '9.9元推广卡', '1522562238', '1', '2', '0', 'buy', '280', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('240', '4200000090201804019879786494', '9.9元推广卡', '1522562565', '1', '2', '0', 'buy', '282', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('241', '4200000085201804019897511069', '9.9元推广卡', '1522562919', '1', '2', '0', 'buy', '283', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('242', '4200000099201804019861556819', '9.9元推广卡', '1522563064', '1', '2', '0', 'buy', '284', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('243', '4200000088201804019823943430', '9.9元推广卡', '1522563121', '1', '2', '0', 'buy', '285', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('244', '4200000086201804019829192164', '科妍鲜颜洁面乳', '1522566464', '1', '0', '0', 'buy', '183', '7800.00', '23', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('245', '4200000093201804019875742807', '9.9元推广卡', '1522567114', '1', '2', '0', 'buy', '290', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('246', '4200000097201804019963747339', '9.9元推广卡', '1522570272', '1', '2', '0', 'buy', '291', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('247', '4200000084201804019990867322', '9.9元推广卡', '1522570724', '1', '2', '0', 'buy', '293', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('248', '4200000085201804019902893254', '9.9元推广卡', '1522571198', '1', '2', '0', 'buy', '294', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('249', '4200000096201804019920143666', '9.9元推广卡', '1522573755', '1', '2', '0', 'buy', '295', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('250', '4200000099201804010073006026', '9.9元推广卡', '1522573830', '1', '2', '0', 'buy', '296', '990.00', '39', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('251', '4200000093201804019973532334', '9.9元推广卡', '1522574050', '1', '2', '0', 'buy', '297', '990.00', '39', '0', '0', '0', '0', '1', '');

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
) ENGINE=MyISAM AUTO_INCREMENT=215 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_clientslist
-- ----------------------------
INSERT INTO `xl_clientslist` VALUES ('204', '183', '187', '1521254861', '182');
INSERT INTO `xl_clientslist` VALUES ('205', '179', '180', '1521255017', '182');
INSERT INTO `xl_clientslist` VALUES ('201', '180', '185', '1521254520', '182');
INSERT INTO `xl_clientslist` VALUES ('203', '187', '178', '1521254543', '182');
INSERT INTO `xl_clientslist` VALUES ('200', '180', '181', '1521254476', '182');
INSERT INTO `xl_clientslist` VALUES ('199', '180', '182', '1521254476', '182');
INSERT INTO `xl_clientslist` VALUES ('196', '187', '182', '1521254436', '182');
INSERT INTO `xl_clientslist` VALUES ('197', '187', '181', '1521254436', '182');
INSERT INTO `xl_clientslist` VALUES ('206', '184', '187', '1521255324', '182');
INSERT INTO `xl_clientslist` VALUES ('207', '190', '182', '1521277865', '182');
INSERT INTO `xl_clientslist` VALUES ('208', '190', '181', '1521277865', '182');
INSERT INTO `xl_clientslist` VALUES ('195', '178', '182', '1521254331', '182');
INSERT INTO `xl_clientslist` VALUES ('194', '185', '182', '1521254315', '182');
INSERT INTO `xl_clientslist` VALUES ('193', '181', '182', '1521254276', '182');
INSERT INTO `xl_clientslist` VALUES ('209', '189', '190', '1521777782', '182');
INSERT INTO `xl_clientslist` VALUES ('210', '186', '182', '1522124530', '182');
INSERT INTO `xl_clientslist` VALUES ('211', '209', '182', '1522126614', '182');
INSERT INTO `xl_clientslist` VALUES ('212', '209', '186', '1522126614', '182');
INSERT INTO `xl_clientslist` VALUES ('214', '199', '190', '1522397173', '182');

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
) ENGINE=MyISAM AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_consumelist
-- ----------------------------
INSERT INTO `xl_consumelist` VALUES ('80', '10', '1', '179', '1521255017', '', '179', '19', '206', '180');
INSERT INTO `xl_consumelist` VALUES ('81', '11', '1', '184', '1521255324', '', '184', '19', '208', '187');
INSERT INTO `xl_consumelist` VALUES ('79', '11', '1', '183', '1521254861', '', '183', '19', '207', '187');
INSERT INTO `xl_consumelist` VALUES ('82', '9', '1', '189', '1521777782', '', '189', '22', '214', '190');
INSERT INTO `xl_consumelist` VALUES ('83', '9', '1', '189', '1521777817', '', '189', '22', '213', '190');
INSERT INTO `xl_consumelist` VALUES ('84', '9', '1', '189', '1521777848', '', '189', '22', '210', '190');
INSERT INTO `xl_consumelist` VALUES ('85', '9', '1', '189', '1522052571', '', '189', '22', '216', '190');
INSERT INTO `xl_consumelist` VALUES ('86', '9', '1', '199', '1522138104', '', '199', '22', '224', '190');
INSERT INTO `xl_consumelist` VALUES ('87', '4', '1', '199', '1522397173', '', '199', '21', '238', '190');
INSERT INTO `xl_consumelist` VALUES ('88', '23', '1', '189', '1522745832', '', '189', '39', '237', '190');
INSERT INTO `xl_consumelist` VALUES ('89', '7', '1', '189', '1522745989', '', '189', '23', '215', '190');

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
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_coupon
-- ----------------------------
INSERT INTO `xl_coupon` VALUES ('4', '面膜券', '发酵玻尿酸补水面膜', 'img/goods1.jpg', '1', '100', '0', '2592000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('5', '精华液券', '枸杞灵芝原浆鲜颜活肌精华液', 'img/goods2.jpg', '1', '100', '0', '2592000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('6', '美霜券', '科妍鲜颜酵美霜', 'img/goods3.jpg', '1', '100', '0', '5184000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('7', '醒乳券', '科妍鲜颜酵醒乳', 'img/goods4.jpg', '1', '100', '0', '7776000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('8', '面霜券', '密酿鲜颜活肌原浆面霜', 'img/goods5.jpg', '1', '100', '0', '10368000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('9', '肌原水券', '青柠檬鲜颜活肌原水', 'img/goods6.jpg', '1', '100', '0', '12960000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('10', '丰胸券', '3d丰胸，立马变大', 'img/icon3.jpg', '2', '1000', '0', '15552000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('11', '瘦身券', '立体瘦身，婀罗多姿', 'img/icon4.jpg', '2', '2000', '0', '18144000', '1509084780');
INSERT INTO `xl_coupon` VALUES ('17', '艾灸券｜美丽故事', '凭此券可至美丽故事美容美甲SPA会所享受艾灸一次', 'img/coupon/nx_1510907158420.jpg', '2', null, '0', '3456000', '1510907158');
INSERT INTO `xl_coupon` VALUES ('14', '美甲券｜美丽故事', '凭此券可至美丽故事美容美甲SPA会所享受美甲一次', 'img/coupon/nx_1510906569163.jpg', '1', null, '0', '3456000', '1510904948');
INSERT INTO `xl_coupon` VALUES ('18', '拔罐券｜美丽故事', '凭此券可至美丽故事美容美甲SPA会所享受拔罐一次', 'img/coupon/nx_1510907537293.jpg', '2', null, '0', '3456000', '1510907537');
INSERT INTO `xl_coupon` VALUES ('21', '材木始科研洁面乳', '', 'img/coupon/20180327/nx_1522115074405.png', '1', null, '0', '2592000', '1522115074');
INSERT INTO `xl_coupon` VALUES ('22', '逦妍国际面部七合一护理', '', 'img/coupon/20180327/nx_1522115137249.png', '2', null, '0', '2592000', '1522115137');
INSERT INTO `xl_coupon` VALUES ('23', '逦妍国际背部病理性调理', '', 'img/coupon/20180327/nx_1522115220940.png', '2', null, '0', '2592000', '1522115220');

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
) ENGINE=MyISAM AUTO_INCREMENT=1114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_couponlist
-- ----------------------------
INSERT INTO `xl_couponlist` VALUES ('1016', '22', '179', '1522115575', '1524707575', '1', '39', '217');
INSERT INTO `xl_couponlist` VALUES ('1015', '23', '179', '1522115575', '1524707575', '1', '39', '217');
INSERT INTO `xl_couponlist` VALUES ('1010', '9', '190', '1521280806', '1534240806', '1', '22', '212');
INSERT INTO `xl_couponlist` VALUES ('1009', '9', '190', '1521280727', '1534240727', '1', '22', '211');
INSERT INTO `xl_couponlist` VALUES ('1007', '9', '190', '1521276985', '1534236985', '1', '22', '209');
INSERT INTO `xl_couponlist` VALUES ('1005', '10', '184', '1521255286', '1536807286', '1', '19', '208');
INSERT INTO `xl_couponlist` VALUES ('1004', '9', '184', '1521255286', '1534215286', '1', '19', '208');
INSERT INTO `xl_couponlist` VALUES ('1003', '8', '184', '1521255286', '1531623286', '1', '19', '208');
INSERT INTO `xl_couponlist` VALUES ('1000', '5', '184', '1521255286', '1523847286', '1', '19', '208');
INSERT INTO `xl_couponlist` VALUES ('1001', '6', '184', '1521255286', '1526439286', '1', '19', '208');
INSERT INTO `xl_couponlist` VALUES ('1002', '7', '184', '1521255286', '1529031286', '1', '19', '208');
INSERT INTO `xl_couponlist` VALUES ('997', '10', '183', '1521254804', '1536806804', '1', '19', '207');
INSERT INTO `xl_couponlist` VALUES ('996', '9', '183', '1521254804', '1534214804', '1', '19', '207');
INSERT INTO `xl_couponlist` VALUES ('995', '8', '183', '1521254804', '1531622804', '1', '19', '207');
INSERT INTO `xl_couponlist` VALUES ('994', '7', '183', '1521254804', '1529030804', '1', '19', '207');
INSERT INTO `xl_couponlist` VALUES ('993', '6', '183', '1521254804', '1526438804', '1', '19', '207');
INSERT INTO `xl_couponlist` VALUES ('992', '5', '183', '1521254804', '1523846804', '1', '19', '207');
INSERT INTO `xl_couponlist` VALUES ('991', '4', '183', '1521254804', '1523846804', '1', '19', '207');
INSERT INTO `xl_couponlist` VALUES ('990', '11', '179', '1521254783', '1539398783', '1', '19', '206');
INSERT INTO `xl_couponlist` VALUES ('999', '4', '184', '1521255286', '1523847286', '1', '19', '208');
INSERT INTO `xl_couponlist` VALUES ('988', '9', '179', '1521254783', '1534214783', '1', '19', '206');
INSERT INTO `xl_couponlist` VALUES ('987', '8', '179', '1521254783', '1531622783', '1', '19', '206');
INSERT INTO `xl_couponlist` VALUES ('986', '7', '179', '1521254783', '1529030783', '1', '19', '206');
INSERT INTO `xl_couponlist` VALUES ('985', '6', '179', '1521254783', '1526438783', '1', '19', '206');
INSERT INTO `xl_couponlist` VALUES ('984', '5', '179', '1521254783', '1523846783', '1', '19', '206');
INSERT INTO `xl_couponlist` VALUES ('983', '4', '179', '1521254783', '1523846783', '1', '19', '206');
INSERT INTO `xl_couponlist` VALUES ('1017', '21', '179', '1522115575', '1524707575', '1', '39', '217');
INSERT INTO `xl_couponlist` VALUES ('1018', '23', '183', '1522115642', '1524707642', '1', '39', '218');
INSERT INTO `xl_couponlist` VALUES ('1019', '22', '183', '1522115642', '1524707642', '1', '39', '218');
INSERT INTO `xl_couponlist` VALUES ('1020', '21', '183', '1522115642', '1524707642', '1', '39', '218');
INSERT INTO `xl_couponlist` VALUES ('1021', '23', '212', '1522127548', '1524719548', '1', '39', '219');
INSERT INTO `xl_couponlist` VALUES ('1022', '22', '212', '1522127548', '1524719548', '1', '39', '219');
INSERT INTO `xl_couponlist` VALUES ('1023', '21', '212', '1522127548', '1524719548', '1', '39', '219');
INSERT INTO `xl_couponlist` VALUES ('1024', '23', '214', '1522127954', '1524719954', '1', '39', '220');
INSERT INTO `xl_couponlist` VALUES ('1025', '22', '214', '1522127954', '1524719954', '1', '39', '220');
INSERT INTO `xl_couponlist` VALUES ('1026', '21', '214', '1522127954', '1524719954', '1', '39', '220');
INSERT INTO `xl_couponlist` VALUES ('1027', '23', '215', '1522128481', '1524720481', '1', '39', '221');
INSERT INTO `xl_couponlist` VALUES ('1028', '22', '215', '1522128481', '1524720481', '1', '39', '221');
INSERT INTO `xl_couponlist` VALUES ('1029', '21', '215', '1522128481', '1524720481', '1', '39', '221');
INSERT INTO `xl_couponlist` VALUES ('1030', '23', '216', '1522129260', '1524721260', '1', '39', '222');
INSERT INTO `xl_couponlist` VALUES ('1031', '22', '216', '1522129260', '1524721260', '1', '39', '222');
INSERT INTO `xl_couponlist` VALUES ('1032', '21', '216', '1522129260', '1524721260', '1', '39', '222');
INSERT INTO `xl_couponlist` VALUES ('1033', '23', '219', '1522134589', '1524726589', '1', '39', '223');
INSERT INTO `xl_couponlist` VALUES ('1034', '22', '219', '1522134589', '1524726589', '1', '39', '223');
INSERT INTO `xl_couponlist` VALUES ('1035', '21', '219', '1522134589', '1524726589', '1', '39', '223');
INSERT INTO `xl_couponlist` VALUES ('1037', '23', '222', '1522141867', '1524733867', '1', '39', '225');
INSERT INTO `xl_couponlist` VALUES ('1038', '22', '222', '1522141867', '1524733867', '1', '39', '225');
INSERT INTO `xl_couponlist` VALUES ('1039', '21', '222', '1522141867', '1524733867', '1', '39', '225');
INSERT INTO `xl_couponlist` VALUES ('1040', '23', '224', '1522143026', '1524735026', '1', '39', '226');
INSERT INTO `xl_couponlist` VALUES ('1041', '22', '224', '1522143026', '1524735026', '1', '39', '226');
INSERT INTO `xl_couponlist` VALUES ('1042', '21', '224', '1522143026', '1524735026', '1', '39', '226');
INSERT INTO `xl_couponlist` VALUES ('1043', '23', '241', '1522216419', '1524808419', '1', '39', '227');
INSERT INTO `xl_couponlist` VALUES ('1044', '22', '241', '1522216419', '1524808419', '1', '39', '227');
INSERT INTO `xl_couponlist` VALUES ('1045', '21', '241', '1522216419', '1524808419', '1', '39', '227');
INSERT INTO `xl_couponlist` VALUES ('1046', '23', '249', '1522224981', '1524816981', '1', '39', '228');
INSERT INTO `xl_couponlist` VALUES ('1047', '22', '249', '1522224981', '1524816981', '1', '39', '228');
INSERT INTO `xl_couponlist` VALUES ('1048', '21', '249', '1522224981', '1524816981', '1', '39', '228');
INSERT INTO `xl_couponlist` VALUES ('1049', '23', '253', '1522232987', '1524824987', '1', '39', '229');
INSERT INTO `xl_couponlist` VALUES ('1050', '22', '253', '1522232987', '1524824987', '1', '39', '229');
INSERT INTO `xl_couponlist` VALUES ('1051', '21', '253', '1522232987', '1524824987', '1', '39', '229');
INSERT INTO `xl_couponlist` VALUES ('1052', '23', '252', '1522233515', '1524825515', '1', '39', '230');
INSERT INTO `xl_couponlist` VALUES ('1053', '22', '252', '1522233515', '1524825515', '1', '39', '230');
INSERT INTO `xl_couponlist` VALUES ('1054', '21', '252', '1522233515', '1524825515', '1', '39', '230');
INSERT INTO `xl_couponlist` VALUES ('1055', '23', '254', '1522234904', '1524826904', '1', '39', '231');
INSERT INTO `xl_couponlist` VALUES ('1056', '22', '254', '1522234904', '1524826904', '1', '39', '231');
INSERT INTO `xl_couponlist` VALUES ('1057', '21', '254', '1522234904', '1524826904', '1', '39', '231');
INSERT INTO `xl_couponlist` VALUES ('1058', '23', '257', '1522308327', '1524900327', '1', '39', '233');
INSERT INTO `xl_couponlist` VALUES ('1059', '22', '257', '1522308327', '1524900327', '1', '39', '233');
INSERT INTO `xl_couponlist` VALUES ('1060', '21', '257', '1522308327', '1524900327', '1', '39', '233');
INSERT INTO `xl_couponlist` VALUES ('1061', '23', '258', '1522310098', '1524902098', '1', '39', '234');
INSERT INTO `xl_couponlist` VALUES ('1062', '22', '258', '1522310098', '1524902098', '1', '39', '234');
INSERT INTO `xl_couponlist` VALUES ('1063', '21', '258', '1522310098', '1524902098', '1', '39', '234');
INSERT INTO `xl_couponlist` VALUES ('1064', '23', '259', '1522314207', '1524906207', '1', '39', '235');
INSERT INTO `xl_couponlist` VALUES ('1065', '22', '259', '1522314207', '1524906207', '1', '39', '235');
INSERT INTO `xl_couponlist` VALUES ('1066', '21', '259', '1522314207', '1524906207', '1', '39', '235');
INSERT INTO `xl_couponlist` VALUES ('1067', '23', '260', '1522316300', '1524908300', '1', '39', '236');
INSERT INTO `xl_couponlist` VALUES ('1068', '22', '260', '1522316300', '1524908300', '1', '39', '236');
INSERT INTO `xl_couponlist` VALUES ('1069', '21', '260', '1522316300', '1524908300', '1', '39', '236');
INSERT INTO `xl_couponlist` VALUES ('1071', '22', '189', '1522396828', '1524988828', '1', '39', '237');
INSERT INTO `xl_couponlist` VALUES ('1072', '21', '189', '1522396828', '1524988828', '1', '39', '237');
INSERT INTO `xl_couponlist` VALUES ('1077', '23', '280', '1522562238', '1525154238', '1', '39', '239');
INSERT INTO `xl_couponlist` VALUES ('1074', '17', '199', '1522397028', '1525853028', '1', '21', '238');
INSERT INTO `xl_couponlist` VALUES ('1075', '14', '199', '1522397028', '1525853028', '1', '21', '238');
INSERT INTO `xl_couponlist` VALUES ('1076', '18', '199', '1522397028', '1525853028', '1', '21', '238');
INSERT INTO `xl_couponlist` VALUES ('1078', '22', '280', '1522562238', '1525154238', '1', '39', '239');
INSERT INTO `xl_couponlist` VALUES ('1079', '21', '280', '1522562238', '1525154238', '1', '39', '239');
INSERT INTO `xl_couponlist` VALUES ('1080', '23', '282', '1522562565', '1525154565', '1', '39', '240');
INSERT INTO `xl_couponlist` VALUES ('1081', '22', '282', '1522562565', '1525154565', '1', '39', '240');
INSERT INTO `xl_couponlist` VALUES ('1082', '21', '282', '1522562565', '1525154565', '1', '39', '240');
INSERT INTO `xl_couponlist` VALUES ('1083', '23', '283', '1522562919', '1525154919', '1', '39', '241');
INSERT INTO `xl_couponlist` VALUES ('1084', '22', '283', '1522562919', '1525154919', '1', '39', '241');
INSERT INTO `xl_couponlist` VALUES ('1085', '21', '283', '1522562919', '1525154919', '1', '39', '241');
INSERT INTO `xl_couponlist` VALUES ('1086', '23', '284', '1522563064', '1525155064', '1', '39', '242');
INSERT INTO `xl_couponlist` VALUES ('1087', '22', '284', '1522563064', '1525155064', '1', '39', '242');
INSERT INTO `xl_couponlist` VALUES ('1088', '21', '284', '1522563064', '1525155064', '1', '39', '242');
INSERT INTO `xl_couponlist` VALUES ('1089', '23', '285', '1522563121', '1525155121', '1', '39', '243');
INSERT INTO `xl_couponlist` VALUES ('1090', '22', '285', '1522563121', '1525155121', '1', '39', '243');
INSERT INTO `xl_couponlist` VALUES ('1091', '21', '285', '1522563121', '1525155121', '1', '39', '243');
INSERT INTO `xl_couponlist` VALUES ('1092', '7', '183', '1522566464', '1530342464', '1', '23', '244');
INSERT INTO `xl_couponlist` VALUES ('1093', '23', '290', '1522567114', '1525159114', '1', '39', '245');
INSERT INTO `xl_couponlist` VALUES ('1094', '22', '290', '1522567114', '1525159114', '1', '39', '245');
INSERT INTO `xl_couponlist` VALUES ('1095', '21', '290', '1522567114', '1525159114', '1', '39', '245');
INSERT INTO `xl_couponlist` VALUES ('1096', '23', '291', '1522570272', '1525162272', '1', '39', '246');
INSERT INTO `xl_couponlist` VALUES ('1097', '22', '291', '1522570272', '1525162272', '1', '39', '246');
INSERT INTO `xl_couponlist` VALUES ('1098', '21', '291', '1522570272', '1525162272', '1', '39', '246');
INSERT INTO `xl_couponlist` VALUES ('1099', '23', '293', '1522570724', '1525162724', '1', '39', '247');
INSERT INTO `xl_couponlist` VALUES ('1100', '22', '293', '1522570724', '1525162724', '1', '39', '247');
INSERT INTO `xl_couponlist` VALUES ('1101', '21', '293', '1522570724', '1525162724', '1', '39', '247');
INSERT INTO `xl_couponlist` VALUES ('1102', '23', '294', '1522571198', '1525163198', '1', '39', '248');
INSERT INTO `xl_couponlist` VALUES ('1103', '22', '294', '1522571198', '1525163198', '1', '39', '248');
INSERT INTO `xl_couponlist` VALUES ('1104', '21', '294', '1522571198', '1525163198', '1', '39', '248');
INSERT INTO `xl_couponlist` VALUES ('1105', '23', '295', '1522573755', '1525165755', '1', '39', '249');
INSERT INTO `xl_couponlist` VALUES ('1106', '22', '295', '1522573755', '1525165755', '1', '39', '249');
INSERT INTO `xl_couponlist` VALUES ('1107', '21', '295', '1522573755', '1525165755', '1', '39', '249');
INSERT INTO `xl_couponlist` VALUES ('1108', '23', '296', '1522573830', '1525165830', '1', '39', '250');
INSERT INTO `xl_couponlist` VALUES ('1109', '22', '296', '1522573830', '1525165830', '1', '39', '250');
INSERT INTO `xl_couponlist` VALUES ('1110', '21', '296', '1522573830', '1525165830', '1', '39', '250');
INSERT INTO `xl_couponlist` VALUES ('1111', '23', '297', '1522574050', '1525166050', '1', '39', '251');
INSERT INTO `xl_couponlist` VALUES ('1112', '22', '297', '1522574050', '1525166050', '1', '39', '251');
INSERT INTO `xl_couponlist` VALUES ('1113', '21', '297', '1522574050', '1525166050', '1', '39', '251');

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
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_coupontogoods
-- ----------------------------
INSERT INTO `xl_coupontogoods` VALUES ('9', '19', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('10', '19', '5', '1');
INSERT INTO `xl_coupontogoods` VALUES ('11', '19', '6', '1');
INSERT INTO `xl_coupontogoods` VALUES ('12', '19', '7', '1');
INSERT INTO `xl_coupontogoods` VALUES ('13', '19', '8', '1');
INSERT INTO `xl_coupontogoods` VALUES ('14', '19', '9', '1');
INSERT INTO `xl_coupontogoods` VALUES ('15', '19', '10', '1');
INSERT INTO `xl_coupontogoods` VALUES ('16', '19', '11', '1');
INSERT INTO `xl_coupontogoods` VALUES ('17', '20', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('18', '20', '5', '1');
INSERT INTO `xl_coupontogoods` VALUES ('19', '20', '6', '1');
INSERT INTO `xl_coupontogoods` VALUES ('20', '20', '7', '1');
INSERT INTO `xl_coupontogoods` VALUES ('21', '20', '10', '1');
INSERT INTO `xl_coupontogoods` VALUES ('22', '21', '4', '1');
INSERT INTO `xl_coupontogoods` VALUES ('23', '27', '14', '1');
INSERT INTO `xl_coupontogoods` VALUES ('24', '27', '17', '1');
INSERT INTO `xl_coupontogoods` VALUES ('25', '27', '18', '1');
INSERT INTO `xl_coupontogoods` VALUES ('26', '27', '4', '1');
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
INSERT INTO `xl_coupontogoods` VALUES ('37', '21', '17', '1');
INSERT INTO `xl_coupontogoods` VALUES ('38', '21', '14', '1');
INSERT INTO `xl_coupontogoods` VALUES ('39', '21', '18', '1');
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
INSERT INTO `xl_deposit` VALUES ('2', '1', '0.01', '押金');

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
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_depositlist
-- ----------------------------
INSERT INTO `xl_depositlist` VALUES ('39', '190', '181', '1', '1521277865', '4200000095201803170392736411', '押金', '1');
INSERT INTO `xl_depositlist` VALUES ('37', '187', '181', '1', '1521254436', '4200000081201803170148759414', '押金', '1');
INSERT INTO `xl_depositlist` VALUES ('38', '180', '181', '1', '1521254476', '4200000090201803170255169693', '押金', '1');
INSERT INTO `xl_depositlist` VALUES ('40', '209', '186', '1', '1522126614', '4200000086201803276579365883', '押金', '1');

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
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_drawrecord
-- ----------------------------

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
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_extension
-- ----------------------------
INSERT INTO `xl_extension` VALUES ('23', '183', '184', '19', '1521255286');
INSERT INTO `xl_extension` VALUES ('24', '179', '183', '39', '1522115642');
INSERT INTO `xl_extension` VALUES ('25', '207', '212', '39', '1522127548');
INSERT INTO `xl_extension` VALUES ('26', '207', '214', '39', '1522127954');
INSERT INTO `xl_extension` VALUES ('27', '207', '215', '39', '1522128481');
INSERT INTO `xl_extension` VALUES ('28', '207', '216', '39', '1522129260');
INSERT INTO `xl_extension` VALUES ('29', '207', '219', '39', '1522134589');
INSERT INTO `xl_extension` VALUES ('30', '189', '199', '22', '1522138076');
INSERT INTO `xl_extension` VALUES ('31', '207', '222', '39', '1522141867');
INSERT INTO `xl_extension` VALUES ('32', '207', '241', '39', '1522216419');
INSERT INTO `xl_extension` VALUES ('33', '207', '249', '39', '1522224981');
INSERT INTO `xl_extension` VALUES ('34', '206', '253', '39', '1522232987');
INSERT INTO `xl_extension` VALUES ('35', '206', '252', '39', '1522233515');
INSERT INTO `xl_extension` VALUES ('36', '206', '254', '39', '1522234904');
INSERT INTO `xl_extension` VALUES ('37', '256', '257', '39', '1522308327');
INSERT INTO `xl_extension` VALUES ('38', '207', '258', '39', '1522310098');
INSERT INTO `xl_extension` VALUES ('39', '256', '259', '39', '1522314207');
INSERT INTO `xl_extension` VALUES ('40', '207', '260', '39', '1522316300');
INSERT INTO `xl_extension` VALUES ('41', '278', '280', '39', '1522562238');
INSERT INTO `xl_extension` VALUES ('42', '278', '282', '39', '1522562565');
INSERT INTO `xl_extension` VALUES ('43', '279', '283', '39', '1522562919');
INSERT INTO `xl_extension` VALUES ('44', '277', '284', '39', '1522563064');
INSERT INTO `xl_extension` VALUES ('45', '278', '285', '39', '1522563121');
INSERT INTO `xl_extension` VALUES ('46', '278', '290', '39', '1522567114');
INSERT INTO `xl_extension` VALUES ('47', '279', '291', '39', '1522570272');
INSERT INTO `xl_extension` VALUES ('48', '278', '293', '39', '1522570724');
INSERT INTO `xl_extension` VALUES ('49', '279', '294', '39', '1522571198');
INSERT INTO `xl_extension` VALUES ('50', '277', '295', '39', '1522573755');
INSERT INTO `xl_extension` VALUES ('51', '278', '296', '39', '1522573830');
INSERT INTO `xl_extension` VALUES ('52', '279', '297', '39', '1522574050');

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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goods
-- ----------------------------
INSERT INTO `xl_goods` VALUES ('19', '380元体验套餐', '做体验项目领免费礼品', '380.00', '1', '1509084780', '0', '0.30', '0.00', '<h1><img src=\"img/20180324/nx_1521884077197.png\"></h1>', '0', 'img/20180324/nx_1521880828988.png', '立即获得礼品券6张和塑时代产品体验券2张', '1', '1', '0', '0.65', '39', 'img/nx_1515661463680.png', '182');
INSERT INTO `xl_goods` VALUES ('20', '38妇女节套餐', '女王节就要过的像女王～', '3.00', '0', '1509085009', '38', '0.30', '0.00', '<p><img src=\"img/nx_1515345102449.png\"></p><p><img src=\"img/nx_1515740418670.png\"></p>', '0', 'img/nx_1515342389209.png', '38元即可享受380元塑时代胸臀淋巴项目任选一个项目', '1', '1', '8', '0.50', '3', 'img/nx_1515342389209.png', '182');
INSERT INTO `xl_goods` VALUES ('21', '1元抢购', '一元出手,面膜到手', '1.00', '1', '1509369345', '10', '0.30', '0.00', '<h2>仅售10元，价值712元体验礼包</h2><p><br></p><h2>礼包内容：</h2><h2>美丽故事艾灸一次，价值198元</h2><h2>美丽故事拔罐一次，价值 88元</h2><h2>美丽故事美甲一次，价值128元</h2><h2>精美礼品面膜一盒，价值298元</h2><h2>总价值：712元</h2><p><img src=\"img/nx_1510931088930.jpg\"></p><p><img src=\"img/nx_1510931088692.jpg\"></p><p><img src=\"img/nx_1510931088703.jpg\"></p><p><img src=\"img/nx_1510931088515.jpg\"></p><p><img src=\"img/nx_1510931088594.jpg\"></p><p><img src=\"img/nx_1510931088944.jpg\"></p><p><br></p><h3>地址：嘉定区云屏路1515弄6号102室</h3><h3>电话：13818677701/17698307534</h3>', '0', 'img/nx_1511069433475.jpg', '', '1', '1', '10', '0.50', '1', 'img/nx_1511069433475.jpg', '0');
INSERT INTO `xl_goods` VALUES ('22', '青柠檬鲜颜活肌原水', '青柠檬鲜颜活肌原水', '119.00', '1', '1510898169', '0', '0.30', '0.00', '<p><img src=\"img/nx_1510907244488.jpg\"></p><p><img src=\"img/nx_1510907244862.jpg\"></p><p><img src=\"img/nx_1510907244648.jpg\"></p><p><img src=\"img/nx_1510907244818.jpg\"></p><p><img src=\"img/nx_1510907244244.jpg\"></p><p><img src=\"img/nx_1510907244647.jpg\"></p><p><img src=\"img/nx_1510907244621.jpg\"></p><p><img src=\"img/nx_1510907244416.jpg\"></p><p><br></p>', '1', 'img/20180327/nx_1522134648403.jpg', '', '2', '2', '0', '0.00', '42', 'img/nx_1510898169616.jpg', '0');
INSERT INTO `xl_goods` VALUES ('23', '科妍鲜颜洁面乳', '才木始科妍鲜颜洁面乳', '78.00', '1', '1510903955', '0', '0.30', '0.00', '<p><img src=\"img/20180327/nx_1522134760998.jpg\"></p>', '1', 'img/nx_1510903955333.jpg', '', '2', '2', '0', '0.00', '12', 'img/nx_1510903955333.jpg', '0');
INSERT INTO `xl_goods` VALUES ('24', '科妍鲜颜酵活水', '才木始科妍鲜颜酵活水', '158.00', '1', '1510907757', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510907757814.jpg\"></p><p><img src=\"img/nx_1510907757937.jpg\"></p><p><img src=\"img/nx_1510907757907.jpg\"></p><p><img src=\"img/nx_1510907757355.jpg\"></p><p><img src=\"img/nx_1510907757461.jpg\"></p><p><img src=\"img/nx_1510907757720.jpg\"></p><p><img src=\"img/nx_1510907757865.jpg\"></p>', '1', 'img/nx_1510907757654.jpg', '鲜活发酵护肤，令皮肤基底真正的吃饱喝足！', '2', '1', '0', '0.10', '0', 'img/nx_1510907757654.jpg', '0');
INSERT INTO `xl_goods` VALUES ('25', '科妍鲜颜酵醒乳', '才木始科妍鲜颜酵醒乳', '188.00', '1', '1510908277', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510908277864.jpg\"></p><p><img src=\"img/nx_1510908277345.jpg\"></p><p><img src=\"img/nx_1510908277846.jpg\"></p><p><img src=\"img/nx_1510908277469.jpg\"></p><p><img src=\"img/nx_1510908277201.jpg\"></p>', '1', 'img/nx_1510908277397.jpg', '高营养的鲜活小分子，令肌肤欲罢不能的吃起来！', '2', '1', '0', '0.10', '0', 'img/nx_1510908277397.jpg', '0');
INSERT INTO `xl_goods` VALUES ('26', '科妍鲜颜酵美霜', '折煞从古至今的会美之人', '10.00', '1', '1510909708', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510909708750.jpg\"></p><p><img src=\"img/nx_1510909708548.jpg\"></p><p><img src=\"img/nx_1510909708577.jpg\"></p><p><img src=\"img/nx_1510909708823.jpg\"></p><p><img src=\"img/nx_1510909708475.jpg\"></p><p><br></p>', '2', 'img/nx_1510909708178.jpg', '', '2', '2', '0', '0.10', '0', 'img/nx_1510909708178.jpg', '0');
INSERT INTO `xl_goods` VALUES ('27', '10元套餐', '美丽故事美容SPA会所', '10.00', '0', '1510910391', '0', '0.30', '0.05', '<h2>仅售10元，价值712元体验礼包</h2><p><br></p><h2>礼包内容：</h2><h2>美丽故事艾灸一次，价值198元</h2><h2>美丽故事拔罐一次，价值  88元</h2><h2>美丽故事美甲一次，价值128元</h2><h2>精美礼品面膜一盒，价值298元</h2><h2>总价值：712元</h2><p><img src=\"img/nx_1510931088930.jpg\"></p><p><img src=\"img/nx_1510931088692.jpg\"></p><p><img src=\"img/nx_1510931088703.jpg\"></p><p><img src=\"img/nx_1510931088515.jpg\"></p><p><img src=\"img/nx_1510931088594.jpg\"></p><p><img src=\"img/nx_1510931088944.jpg\"></p><p><br></p><h2>地址：嘉定区云屏路1515弄6号102室</h2><h2>电话：13818677701/17698307534</h2>', '2', 'img/nx_1510988536165.jpg', '', '2', '2', '0', '0.10', '0', 'img/nx_1510988536165.jpg', '0');
INSERT INTO `xl_goods` VALUES ('28', '玫瑰密酿酵活水', '才木始玫瑰密酿酵活水', '198.00', '1', '1510911858', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510911858355.jpg\"></p><p><img src=\"img/nx_1510911858492.jpg\"></p><p><img src=\"img/nx_1510911858106.jpg\"></p><p><img src=\"img/nx_1510911858716.jpg\"></p><p><img src=\"img/nx_1510911858482.jpg\"></p>', '2', 'img/nx_1510911858554.jpg', '', '2', '2', '0', '0.10', '0', 'img/nx_1510911858554.jpg', '0');
INSERT INTO `xl_goods` VALUES ('29', '科妍谷物舒颜酵醒面膜贴', '肌肤之美在于体验', '140.00', '1', '1510912228', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510912228370.jpg\"></p><p><img src=\"img/nx_1510912228828.jpg\"></p><p><img src=\"img/nx_1510912228353.jpg\"></p><p><img src=\"img/nx_1510912228155.jpg\"></p><p><br></p>', '2', 'img/nx_1510912228594.jpg', '早在几百年前，古代女子常常把米糠磨碎后装在布袋里浸泡在水中，每天早晚用米糠水来洗脸，长期坚持下来，肌肤变得水嫩白净。', '2', '2', '0', '0.10', '0', 'img/nx_1510912228594.jpg', '0');
INSERT INTO `xl_goods` VALUES ('30', '密酿补水原浆发酵面膜贴', '美白淡斑 补水保湿', '195.00', '1', '1510912724', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510912724620.jpg\"></p><p><img src=\"img/nx_1510912724947.jpg\"></p><p><img src=\"img/nx_1510912724148.jpg\"></p><p><img src=\"img/nx_1510912724149.jpg\"></p>', '2', 'img/nx_1510912724274.jpg', '', '3', '2', '0', '0.10', '0', 'img/nx_1510912724274.jpg', '0');
INSERT INTO `xl_goods` VALUES ('31', '密酿靓肌原浆发酵面膜贴', '紧致肌肤 恢复弹性', '1.00', '1', '1510913076', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510913076544.jpg\"></p><p><img src=\"img/nx_1510913076662.jpg\"></p><p><img src=\"img/nx_1510913076868.jpg\"></p>', '3', 'img/nx_1510913076478.jpg', '', '3', '2', '0', '0.10', '6', 'img/nx_1510913076478.jpg', '0');
INSERT INTO `xl_goods` VALUES ('32', '密酿鲜颜活肌原浆面霜', '不稀释，无添加', '289.00', '1', '1510913431', '0', '0.00', '0.00', '<p><img src=\"img/nx_1510913431169.jpg\"></p><p><img src=\"img/nx_1510913431185.jpg\"></p><p><img src=\"img/nx_1510913431713.jpg\"></p><p><img src=\"img/nx_1510913431245.jpg\"></p><p><img src=\"img/nx_1510913431901.jpg\"></p><p><img src=\"img/nx_1510913431477.jpg\"></p><p><img src=\"img/nx_1510913431436.jpg\"></p>', '2', 'img/nx_1510913431349.jpg', '', '2', '2', '0', '0.10', '0', 'img/nx_1510913431349.jpg', '182');
INSERT INTO `xl_goods` VALUES ('33', '积分商品', '积分商品特殊', '10.00', '0', '1520736674', '2', '0.00', '0.00', '<p class=\"ql-indent-1 ql-align-center\">无敌的积分。积分是多么寂寞</p><p class=\"ql-indent-1 ql-align-center\"><img src=\"img/20180311/nx_1520736674249.png\"></p><p class=\"ql-indent-1 ql-align-center\"><img src=\"img/20180311/nx_1520736674176.png\"></p>', '2', 'img/20180311/nx_1520736674903.png', '积分商品', '2', '2', '2', '0.10', '0', '0', '0');
INSERT INTO `xl_goods` VALUES ('36', '测试3', 'AAS', '0.00', '0', '1521273938', '2', '4.00', '5.00', '<p><img src=\"img/20180324/nx_1521877809398.png\"></p>', '0', 'img/20180324/nx_1521877467588.jpg', '2121', '2', '2', '3', '6.00', '0', '0', '189');
INSERT INTO `xl_goods` VALUES ('37', '198元塑时代瘦身卡', '女人需要拿的出手的身材', '198.00', '1', '1521869927', '0', '0.30', '0.00', '<p><img src=\"img/20180324/nx_1521880764186.png\"></p>', '0', 'img/20180324/nx_1521880764758.png', '立即获得塑时代产品体验券2张', '1', '1', '0', '0.65', '1', '0', '182');
INSERT INTO `xl_goods` VALUES ('39', '9.9元推广卡', '逦妍国际', '9.90', '1', '1522048712', '0', '0.00', '0.00', '<p><img src=\"img/20180327/nx_1522114784576.png\"></p><p><img src=\"img/20180327/nx_1522114784860.jpg\"></p>', '0', 'img/20180327/nx_1522114784291.png', '', '1', '1', '0', '0.00', '31', '0', '182');

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
) ENGINE=MyISAM AUTO_INCREMENT=195 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsimage
-- ----------------------------
INSERT INTO `xl_goodsimage` VALUES ('167', '19', '1', 'img/20180324/nx_1521880828892.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('150', '20', '1', 'img/nx_1515345102554.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('176', '21', '1', 'img/nx_1511069433281.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('170', '22', '1', 'img/20180327/nx_1522134648228.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('172', '23', '1', 'img/nx_1510904922794.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('171', '23', '1', 'img/nx_1510904922810.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('138', '24', '1', 'img/nx_1510907757811.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('137', '24', '1', 'img/nx_1510907757342.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('140', '25', '1', 'img/nx_1510908277331.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('139', '25', '1', 'img/nx_1510908277536.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('49', '26', '1', 'img/nx_1510909708155.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('50', '26', '1', 'img/nx_1510909708421.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('68', '28', '1', 'img/nx_1510911858990.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('67', '28', '1', 'img/nx_1510911858740.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('70', '29', '1', 'img/nx_1510912228476.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('69', '29', '1', 'img/nx_1510912228650.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('62', '30', '1', 'img/nx_1510912724401.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('61', '30', '1', 'img/nx_1510912724970.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('63', '31', '1', 'img/nx_1510913076779.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('64', '31', '1', 'img/nx_1510913076883.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('146', '32', '1', 'img/nx_1510913431214.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('145', '32', '1', 'img/nx_1510913431781.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('144', '27', '1', 'img/nx_1510988536879.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('148', '33', '1', 'img/20180311/nx_1520736674176.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('147', '33', '1', 'img/20180311/nx_1520736674249.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('166', '37', '1', 'img/20180324/nx_1521880764498.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('169', '39', '1', 'img/20180327/nx_1522114784623.png', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsuse
-- ----------------------------
INSERT INTO `xl_goodsuse` VALUES ('33', '187', '184', '19', '1521255324', '208');
INSERT INTO `xl_goodsuse` VALUES ('32', '180', '179', '19', '1521255017', '206');
INSERT INTO `xl_goodsuse` VALUES ('31', '187', '183', '19', '1521254861', '207');
INSERT INTO `xl_goodsuse` VALUES ('34', '190', '189', '22', '1521777782', '214');
INSERT INTO `xl_goodsuse` VALUES ('35', '190', '189', '22', '1521777817', '213');
INSERT INTO `xl_goodsuse` VALUES ('36', '190', '189', '22', '1521777848', '210');
INSERT INTO `xl_goodsuse` VALUES ('37', '190', '189', '22', '1522052571', '216');
INSERT INTO `xl_goodsuse` VALUES ('38', '190', '199', '22', '1522138104', '224');
INSERT INTO `xl_goodsuse` VALUES ('39', '190', '199', '21', '1522397173', '238');
INSERT INTO `xl_goodsuse` VALUES ('40', '190', '189', '39', '1522745832', '237');
INSERT INTO `xl_goodsuse` VALUES ('41', '190', '189', '23', '1522745989', '215');

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
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsusemsg
-- ----------------------------
INSERT INTO `xl_goodsusemsg` VALUES ('133', '2', '33', '184', '0.00', '1521255324', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('132', '2', '33', '187', '30.00', '1521255324', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('131', '2', '33', '182', '45.00', '1521255324', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('130', '2', '33', '178', '3.00', '1521255324', '4');
INSERT INTO `xl_goodsusemsg` VALUES ('129', '2', '33', '181', '3.00', '1521255324', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('128', '2', '32', '179', '0.00', '1521255017', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('127', '2', '32', '180', '30.00', '1521255017', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('126', '2', '32', '182', '45.00', '1521255017', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('125', '2', '32', '185', '3.00', '1521255017', '4');
INSERT INTO `xl_goodsusemsg` VALUES ('124', '2', '32', '181', '3.00', '1521255017', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('123', '2', '31', '183', '0.00', '1521254861', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('122', '2', '31', '187', '30.00', '1521254861', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('121', '2', '31', '182', '45.00', '1521254861', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('120', '2', '31', '178', '3.00', '1521254861', '4');
INSERT INTO `xl_goodsusemsg` VALUES ('119', '2', '31', '181', '3.00', '1521254861', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('134', '2', '34', '181', '0.00', '1521777782', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('135', '2', '34', '182', '0.00', '1521777782', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('136', '2', '34', '190', '0.00', '1521777782', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('137', '2', '34', '189', '0.00', '1521777782', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('138', '2', '35', '181', '0.00', '1521777817', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('139', '2', '35', '182', '0.00', '1521777817', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('140', '2', '35', '190', '0.00', '1521777817', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('141', '2', '35', '189', '0.00', '1521777817', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('142', '2', '36', '181', '0.00', '1521777848', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('143', '2', '36', '182', '0.00', '1521777848', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('144', '2', '36', '190', '0.00', '1521777848', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('145', '2', '36', '189', '0.00', '1521777848', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('146', '2', '37', '181', '0.01', '1522052571', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('147', '2', '37', '182', '0.19', '1522052571', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('148', '2', '37', '190', '0.30', '1522052571', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('149', '2', '37', '189', '0.00', '1522052571', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('150', '2', '38', '181', '0.00', '1522138104', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('151', '2', '38', '182', '0.00', '1522138104', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('152', '2', '38', '190', '35.70', '1522138104', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('153', '2', '38', '199', '0.00', '1522138104', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('154', '2', '39', '181', '0.03', '1522397173', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('155', '2', '39', '182', '0.48', '1522397173', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('156', '2', '39', '190', '0.30', '1522397173', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('157', '2', '39', '199', '0.00', '1522397173', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('158', '2', '40', '181', '0.00', '1522745832', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('159', '2', '40', '182', '0.00', '1522745832', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('160', '2', '40', '190', '0.00', '1522745832', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('161', '1', '40', '189', '0.00', '1522745832', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('162', '2', '41', '181', '0.00', '1522745989', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('163', '2', '41', '182', '0.00', '1522745989', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('164', '2', '41', '190', '23.40', '1522745989', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('165', '1', '41', '189', '0.00', '1522745989', '1');

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
  PRIMARY KEY (`codeid`)
) ENGINE=MyISAM AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_msgcode
-- ----------------------------
INSERT INTO `xl_msgcode` VALUES ('18', '1F458B61-DC68-4073-81BF-44EE22A9C960', '5041', '18', '1509380869', '13916403296');
INSERT INTO `xl_msgcode` VALUES ('19', '68048BEA-6864-4FA3-A28B-E04E14839962', '6988', '19', '1509380889', '15821066252');
INSERT INTO `xl_msgcode` VALUES ('20', '49F6B311-C527-4997-ACAC-B923CEB1DC7A', '2326', '26', '1509421375', '13916199451');
INSERT INTO `xl_msgcode` VALUES ('21', 'CB1C80B8-F1AB-4F31-9581-34F043143398', '3026', '27', '1509422176', '13795292286');
INSERT INTO `xl_msgcode` VALUES ('22', '39660E1C-195C-4879-B602-5F981064D10C', '2006', '28', '1509422736', '14782372952');
INSERT INTO `xl_msgcode` VALUES ('23', '0FC992DE-561A-413E-8BBE-4D4FDFFB84C7', '9922', '20', '1511231605', '13916403296');
INSERT INTO `xl_msgcode` VALUES ('24', '5C3AF44F-1E9C-413A-A6FE-43582895E701', '2986', '24', '1509457190', '17717030378');
INSERT INTO `xl_msgcode` VALUES ('25', '382E3100-6297-445B-8E44-FAFFAC77FB2D', '5277', '31', '1509459024', '15001998531');
INSERT INTO `xl_msgcode` VALUES ('26', '3A5EF7DF-5D8E-4FEE-9FD1-49C5689716E0', '4811', '54', '1510987014', '15821066252');
INSERT INTO `xl_msgcode` VALUES ('27', '37768AEC-1B7E-4C65-B545-FCA983ECD404', '6859', '33', '1510987418', '17602122145');
INSERT INTO `xl_msgcode` VALUES ('28', 'E8F744B0-20FB-402E-B50E-FA36BDF2A76B', '6784', '21', '1517921573', '13641759653');
INSERT INTO `xl_msgcode` VALUES ('29', 'AB7A695C-22A5-40EA-A8FD-4CE84A9206DE', '2994', '59', '1510994323', '17698307534');
INSERT INTO `xl_msgcode` VALUES ('30', '1552F529-8277-4D10-87DA-08C9E05B49D1', '8305', '23', '1510999713', '18017647536');
INSERT INTO `xl_msgcode` VALUES ('31', '217E479B-9AE7-4E61-A1B5-3A5942B015DC', '4900', '64', '1511067658', '15026538970');
INSERT INTO `xl_msgcode` VALUES ('32', '916A46CF-B336-4FA0-A2BD-7897CB05B1CE', '4145', '65', '1511070230', '17778781225');
INSERT INTO `xl_msgcode` VALUES ('33', 'B322891D-7370-4A25-97AF-E8C531EEACCE', '1814', '66', '1511071062', '18776998762');
INSERT INTO `xl_msgcode` VALUES ('34', '0E85AC18-CE69-4423-A185-72FCFC65C3B4', '8640', '67', '1511071283', '13472477299');
INSERT INTO `xl_msgcode` VALUES ('35', '0E37884F-003F-4EBE-8641-FF5876E64186', '6842', '68', '1511072257', '17621540614');
INSERT INTO `xl_msgcode` VALUES ('36', 'B5CEA650-A1C0-4910-8376-436F61B65DD7', '9729', '70', '1511074146', '15939418162');
INSERT INTO `xl_msgcode` VALUES ('37', '60FD3589-510F-419C-BFD8-FFEC0445959B', '6117', '71', '1511075056', '18326016021');
INSERT INTO `xl_msgcode` VALUES ('38', '791A3972-68EF-4660-9740-486BF2CC38FE', '8580', '72', '1511075549', '17621990310');
INSERT INTO `xl_msgcode` VALUES ('39', 'D521075F-E806-4E42-A01F-E3388D4F8355', '7393', '73', '1511075661', '15538822250');
INSERT INTO `xl_msgcode` VALUES ('40', '0D4786A0-30C9-4C58-B102-3CC3E8E91E04', '5077', '74', '1511075928', '15900492103');
INSERT INTO `xl_msgcode` VALUES ('41', 'A5917096-7CA9-44F3-8FCC-985C79A8F288', '1748', '75', '1511077038', '17317612793');
INSERT INTO `xl_msgcode` VALUES ('42', '8A1F7599-E07E-4A2F-A8F8-C32457787382', '6616', '76', '1511077273', '18521354336');
INSERT INTO `xl_msgcode` VALUES ('43', '485E689A-6F8B-4F9C-B19D-52BB7AEA191E', '3109', '77', '1511077447', '15800555740');
INSERT INTO `xl_msgcode` VALUES ('44', '437A3A44-E16C-4C86-8B95-BB5648269820', '8861', '79', '1511077473', '17601535694');
INSERT INTO `xl_msgcode` VALUES ('45', '3A066AFD-7F79-4272-9FEC-7011A3B3A392', '4789', '78', '1511077500', '18739400631');
INSERT INTO `xl_msgcode` VALUES ('46', 'C3321EB1-2879-4626-971C-A0C1D66CE6A1', '9783', '80', '1511078304', '15294984709');
INSERT INTO `xl_msgcode` VALUES ('47', 'EB0A2858-86D9-43F9-B4C6-8348F7E694D7', '4272', '81', '1511098475', '17839429635');
INSERT INTO `xl_msgcode` VALUES ('48', '55944AF4-A128-4FFD-80EC-624EDBF49A77', '8258', '95', '1512527899', '18639995288');
INSERT INTO `xl_msgcode` VALUES ('49', '3D78C2B4-25C6-4EB0-8DD6-DC43F276ABA0', '8732', '103', '1514020640', '13482804640');
INSERT INTO `xl_msgcode` VALUES ('50', '22844814-C860-40C0-9008-0B747582EABC', '2636', '90', '1515405554', '15168697540');
INSERT INTO `xl_msgcode` VALUES ('51', 'AE886DB4-46DC-4520-AE8D-F4C0F1A708EE', '3700', '136', '1520746502', '13641759653');
INSERT INTO `xl_msgcode` VALUES ('52', '7276EFED-86F4-498B-8130-782DCECF728A', '7687', '137', '1520746530', '17602122145');
INSERT INTO `xl_msgcode` VALUES ('53', '45AF401C-7E38-4C58-B795-5CD2AE0F2002', '8424', '138', '1520746548', '13916403296');
INSERT INTO `xl_msgcode` VALUES ('54', 'B92CCA15-C37A-4BC4-B043-E79E6C67F6F4', '9800', '140', '1520746587', '15129588988');
INSERT INTO `xl_msgcode` VALUES ('55', 'A96A06B0-9E7C-48D3-82CC-90E627E575E7', '5815', '139', '1520746653', '14782372952');
INSERT INTO `xl_msgcode` VALUES ('56', '3A4AD9BD-BA2F-47E0-B586-69223266C6D0', '7733', '141', '1520747245', '15821066252');
INSERT INTO `xl_msgcode` VALUES ('57', '78BABB74-74E7-47E0-9F03-C540DCF74E86', '9711', '142', '1520826085', '13916199451');
INSERT INTO `xl_msgcode` VALUES ('58', '52007A6A-5450-4CD0-A52C-F2AA3CEBEA51', '1825', '145', '1520846398', '15821066252');
INSERT INTO `xl_msgcode` VALUES ('59', '0200684D-7050-4312-B0A5-F72C2EEAFB7C', '8378', '146', '1520846411', '17602122145');
INSERT INTO `xl_msgcode` VALUES ('60', '1ED0F2E2-6FC4-40F9-9263-73EC2E3B51DB', '5769', '143', '1520846422', '13641759653');
INSERT INTO `xl_msgcode` VALUES ('61', '79D525A0-29B6-4FE7-996F-0DD84C2E6EAD', '5866', '147', '1520846427', '15129588988');
INSERT INTO `xl_msgcode` VALUES ('62', 'E69C6879-0F10-4101-8DD1-6F6ACA76C7FF', '3668', '148', '1520846436', '13916199451');
INSERT INTO `xl_msgcode` VALUES ('63', '61BC4470-733C-45FF-93B0-46582E9AF564', '9967', '144', '1520846445', '14782372952');
INSERT INTO `xl_msgcode` VALUES ('64', 'D407DA42-146A-4EA3-A275-C4DF457189EB', '9210', '149', '1520846468', '13916403296');
INSERT INTO `xl_msgcode` VALUES ('65', 'E37D3AF9-38EB-498D-9592-43AC28956B0E', '5255', '150', '1520847312', '13795292286');
INSERT INTO `xl_msgcode` VALUES ('66', '92BB46ED-8C97-4F3D-AC9D-B38078C7B0F7', '6108', '154', '1520847812', '15821066252');
INSERT INTO `xl_msgcode` VALUES ('67', '18138176-6076-4EA7-9E8A-E6E59264C412', '6607', '153', '1520847818', '15129588988');
INSERT INTO `xl_msgcode` VALUES ('68', '285D9F80-3E81-45A6-8477-4CBB9F79B6BE', '6788', '152', '1521100946', '13641759653');
INSERT INTO `xl_msgcode` VALUES ('69', '2C517BBB-66FA-4B71-944E-B748AD27699D', '5900', '151', '1520847821', '17602122145');
INSERT INTO `xl_msgcode` VALUES ('70', '54C5A241-CBF0-49E5-9D72-5F1CBCE40809', '9113', '155', '1520847851', '13916403296');
INSERT INTO `xl_msgcode` VALUES ('71', 'AFDD9C13-EB40-4FEE-BE30-3CEA44517E22', '5381', '156', '1520848047', '14782372952');
INSERT INTO `xl_msgcode` VALUES ('72', 'A83BCA2F-45F4-4987-B163-72B02E0E49F9', '8255', '157', '1520848046', '13916199451');
INSERT INTO `xl_msgcode` VALUES ('73', '15268B71-87F3-4735-86C0-54F1EDDCB23C', '9256', '161', '1521106829', '13916403296');
INSERT INTO `xl_msgcode` VALUES ('74', '9C9DD2B0-B2A4-4D6E-A6AB-15B5969929E0', '5510', '159', '1521106953', '13641759653');
INSERT INTO `xl_msgcode` VALUES ('75', '1C643057-0A9E-4C82-889E-BFD4C5BF4D2A', '1391', '160', '1521106958', '15821066252');
INSERT INTO `xl_msgcode` VALUES ('76', 'F7BD6EE7-3B2F-4693-8401-454E0E410F24', '2825', '170', '1521194875', '15129588988');
INSERT INTO `xl_msgcode` VALUES ('77', 'A754CE18-3B8C-4CA5-88BF-CDEF22DBF974', '8149', '169', '1521172872', '15829866845');
INSERT INTO `xl_msgcode` VALUES ('78', 'E457BE40-B49D-481C-AE02-5463612F49B2', '1329', '166', '1521172959', '18019055587');
INSERT INTO `xl_msgcode` VALUES ('79', '6A50BE77-35C1-4CC7-A9C2-10BDE605B200', '4537', '165', '1521172976', '13795292286');
INSERT INTO `xl_msgcode` VALUES ('80', 'CBB734D5-835A-4300-8668-74E37F71E9E9', '2128', '168', '1521174003', '13916199451');
INSERT INTO `xl_msgcode` VALUES ('81', '94A8165F-541D-4C00-98EB-65A457E28FA0', '1939', '172', '1521174504', '18317182509');
INSERT INTO `xl_msgcode` VALUES ('82', '2C557ACB-CB7A-4BD3-8543-CA06C3787FE1', '4437', '177', '1521251751', '15300816822');
INSERT INTO `xl_msgcode` VALUES ('83', 'ED19ABA2-543C-41EA-BF01-8E2B091CCF36', '2718', '173', '1521252085', '18019188776');
INSERT INTO `xl_msgcode` VALUES ('84', 'EBC80A6E-A79F-4A87-A81B-0FB9C90C894C', '8881', '182', '1521254157', '13795292286');
INSERT INTO `xl_msgcode` VALUES ('85', '20DE6BF8-0ED1-40DD-AB0F-23DFF880C41B', '1623', '178', '1521254165', '18019188776');
INSERT INTO `xl_msgcode` VALUES ('86', '86A4DDD9-4F08-41F9-82D0-FD0A4622D4D4', '2880', '181', '1521254174', '15300816822');
INSERT INTO `xl_msgcode` VALUES ('87', 'B9DF6501-4198-4FA4-BFD0-C6ED6B354456', '4462', '180', '1521254183', '15829866845');
INSERT INTO `xl_msgcode` VALUES ('88', '6715CF09-E94E-49DE-A0D8-7B4563D35C27', '7504', '183', '1521254186', '14782372952');
INSERT INTO `xl_msgcode` VALUES ('89', '570C3795-E843-4600-9ADC-BDF92529B7C8', '5144', '184', '1521254224', '15129588988');
INSERT INTO `xl_msgcode` VALUES ('90', '7A1A27BC-9698-4921-909F-14B18B07E080', '5416', '185', '1521254227', '18317182509');
INSERT INTO `xl_msgcode` VALUES ('91', 'A2523537-845E-4090-831B-89B75CF1F31A', '5920', '187', '1521254255', '18019055587');
INSERT INTO `xl_msgcode` VALUES ('92', 'FDBCDAC1-F24D-4CF3-AB0C-539151D7DE71', '3789', '179', '1521254321', '17602122145');
INSERT INTO `xl_msgcode` VALUES ('93', 'F58A6772-16A4-4BA8-9703-7C758177910E', '5791', '190', '1523266464', '13916403296');
INSERT INTO `xl_msgcode` VALUES ('94', 'BC4BA007-ECEE-4DF2-8845-B82088EA475E', '4722', '189', '1521277498', '13641759653');
INSERT INTO `xl_msgcode` VALUES ('95', '44925DCB-9B1F-4571-8CB3-4B2FE9F4EC3B', '6914', '186', '1522124455', '13916199451');
INSERT INTO `xl_msgcode` VALUES ('96', '6ED14D0C-2530-422B-B2C2-D237FCA6BDDB', '6280', '209', '1522126576', '13661669664');
INSERT INTO `xl_msgcode` VALUES ('97', '7664DAE4-F600-4E4F-867C-BCA634C15059', '3512', '212', '1522127504', '13801902745');
INSERT INTO `xl_msgcode` VALUES ('98', 'AC6F2196-06BB-457F-A81B-33E124F72874', '4919', '214', '1522127927', '13601744624');
INSERT INTO `xl_msgcode` VALUES ('99', 'C795D413-705E-441A-A80D-8EC90EF6251D', '4323', '215', '1522128433', '13311819088');
INSERT INTO `xl_msgcode` VALUES ('100', '402D1FE8-0D19-49A1-96E9-07D42493FF41', '1778', '216', '1522129219', '15618864853');
INSERT INTO `xl_msgcode` VALUES ('101', '2B85459C-CCA0-42BF-B5D9-41EB874FD531', '9735', '219', '1522134541', '13566709756');
INSERT INTO `xl_msgcode` VALUES ('102', '175D7884-D359-4470-9EC0-C74E5D6C3353', '1589', '199', '1522138034', '15821066252');
INSERT INTO `xl_msgcode` VALUES ('103', 'E38FD3CC-CA4F-4858-BBE5-604234E9DD6F', '6595', '222', '1522141839', '18217449089');
INSERT INTO `xl_msgcode` VALUES ('104', '92792184-3DF4-405B-8A95-A2D6C1D2A67B', '3931', '224', '1522142938', '15121081174');
INSERT INTO `xl_msgcode` VALUES ('105', 'E8036F76-7F59-437B-A6F1-AB3702F3F1B5', '7593', '241', '1522216378', '13916956206');
INSERT INTO `xl_msgcode` VALUES ('106', '971FB631-9B2E-47ED-9623-BFFE190660C6', '8620', '249', '1522224959', '15221938208');
INSERT INTO `xl_msgcode` VALUES ('107', 'C905019B-94FD-4763-80EA-097FE2D02541', '9509', '250', '1522225220', '13641782237');
INSERT INTO `xl_msgcode` VALUES ('108', '1067EE87-292F-4196-8773-40EB51D71C98', '1828', '253', '1522232881', '13661683086');
INSERT INTO `xl_msgcode` VALUES ('109', '41E352B1-CFF8-4834-9209-AD6DF6F41CFA', '7043', '252', '1522233480', '13818739108');
INSERT INTO `xl_msgcode` VALUES ('110', 'C5904CE5-1F31-4949-AEF0-85D1F5DB2234', '3328', '206', '1522233613', '15000855273');
INSERT INTO `xl_msgcode` VALUES ('111', 'CD966B63-A9EC-405F-AF34-6C587138FCE5', '6193', '254', '1522234884', '15000814320');
INSERT INTO `xl_msgcode` VALUES ('112', '57FE6238-DA16-4543-BF8F-0AB8F18C514A', '2934', '257', '1522308298', '15900524302');
INSERT INTO `xl_msgcode` VALUES ('113', '22E191B8-1D86-4A9D-BC6E-B6CA716E8F5D', '6044', '258', '1522309993', '13564530361');
INSERT INTO `xl_msgcode` VALUES ('114', 'E2C81650-E9F3-42BC-BC3B-B7DBB1FACB08', '5195', '259', '1522314105', '13501641091');
INSERT INTO `xl_msgcode` VALUES ('115', 'CC0DA4B6-0268-4067-B3CA-66DAAF19E55A', '8772', '260', '1522316278', '13818206050');
INSERT INTO `xl_msgcode` VALUES ('116', '51655732-3FC3-4CD4-8398-EE680959CE81', '3468', '277', '1522558627', '18616540341');
INSERT INTO `xl_msgcode` VALUES ('117', '2349A0DA-DD87-48B0-9DC8-5CB3E605F66E', '9899', '278', '1522558941', '13701655703');
INSERT INTO `xl_msgcode` VALUES ('118', '7D941D7D-C6AE-4ADD-8BAE-D463B4110F33', '2004', '279', '1522559513', '18818101395');
INSERT INTO `xl_msgcode` VALUES ('119', 'FFC2BAF8-487C-4A82-B74B-E4A810265808', '6589', '280', '1522562160', '18321988348');
INSERT INTO `xl_msgcode` VALUES ('120', 'D8CB2F26-3565-4632-A86C-4AFACC8FA168', '5668', '281', '1522562377', '18286079783');
INSERT INTO `xl_msgcode` VALUES ('121', '4EB7A4D0-CDF6-45F0-AA74-EFAFDB61D588', '5816', '282', '1522562522', '15630185887');
INSERT INTO `xl_msgcode` VALUES ('122', '959DA3A0-8DB0-4218-A1FF-A56E5DF2256F', '8654', '283', '1522562848', '15800487942');
INSERT INTO `xl_msgcode` VALUES ('123', '314B7F5E-070A-4054-A5E5-DEB1CD24B0E6', '9801', '284', '1522563031', '17095163199');
INSERT INTO `xl_msgcode` VALUES ('124', 'F46A8B32-32A2-497F-ACE5-24A2ABBC8FD2', '3260', '285', '1522563089', '15618331831');
INSERT INTO `xl_msgcode` VALUES ('125', '990C10B7-0E88-4D90-AA46-1D9A1708DF2F', '3760', '290', '1522567037', '13916279468');
INSERT INTO `xl_msgcode` VALUES ('126', '2B53F229-DD52-45C4-BA78-3A6DA835648F', '3262', '291', '1522570246', '13433553697');
INSERT INTO `xl_msgcode` VALUES ('127', 'B87F495E-C863-4B34-B2C1-4452D05E3FF6', '8028', '293', '1522570673', '13818442358');
INSERT INTO `xl_msgcode` VALUES ('128', 'A7A9999E-46CF-4FDF-AE02-5D85F90C3E02', '4078', '294', '1522571154', '13671639463');
INSERT INTO `xl_msgcode` VALUES ('129', '567F9539-B5F7-439E-B2D4-F8BD753A3F03', '1884', '295', '1522573626', '17701806573');
INSERT INTO `xl_msgcode` VALUES ('130', 'A66F5453-2034-4D7B-9A74-B024BDD647D4', '7666', '296', '1522573800', '18116295689');
INSERT INTO `xl_msgcode` VALUES ('131', '5A4D3059-136B-4026-A72A-98E4668E10B2', '1678', '297', '1522573992', '15821050335');
INSERT INTO `xl_msgcode` VALUES ('132', '3F5186C5-C9DC-4EE6-A204-3C3B199C00D4', '6361', '325', '1524030025', '13482804640');

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
INSERT INTO `xl_sourceorder` VALUES ('5aae17071a663', '189', '26', '10', '1', '1521358599', '1', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5aae1702c2eba', '189', '33', '10', '1', '1521358594', '1', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5aadd61ca8838', '189', '26', '20', '1', '1521341980', '2', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5aadd612cb0cd', '189', '33', '10', '1', '1521341970', '1', '0', '');

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
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

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
INSERT INTO `xl_uselog` VALUES ('16', '1', '设置管理员-179-代理商', '1522976757');

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
  `extrapwd` varchar(30) DEFAULT NULL COMMENT '提现密码',
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
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=329 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xl_userinfo
-- ----------------------------
INSERT INTO `xl_userinfo` VALUES ('178', 'CiCi', null, '18019188776', null, '4', '5.00', null, null, 'oW5_rji8ICoTDLeeX3ghvb___nt4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eooIMTAVXCQfP7E5qsNykjZRODna0lib86mINuICEAX6APr4TnnqLeA4BTNzUvtsNIW7ROH934cccw/132', '1521254043', '2', '183', '0', '0', '0.05', '');
INSERT INTO `xl_userinfo` VALUES ('179', 'Monday周老师', null, '17602122145', null, '5', '0.00', null, null, 'oW5_rjpL3A39AFWn_bqIix-hhvTc', 'http://thirdwx.qlogo.cn/mmopen/vi_32/tUJa4yicv8cKX4Fm3weGhic2avrlLs2ThxaGh3jA2CibgoicJr0dBChD3iaRgI6BViaBx45aYHJzx94MtTAnr3Y7nPFQ/132', '1521254087', '1', '0', '100', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('180', 'AAA   美业 -敏', null, '15829866845', null, '2', '30.00', null, null, 'oW5_rjmPkj9EWngVj-NBijw1IEGg', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKRKfIfaPknhSDXF7kphAQa0BSExWAY9MM9pvZuamHrL3uwqUmr6dyDFSgarbJaIOeVw5wAmPvVpw/132', '1521254094', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('181', '静香1号', null, '15300816822', null, '3', '7.57', null, null, 'oW5_rjmqz12JC1H5BPxQ6lm4ALCI', 'http://thirdwx.qlogo.cn/mmopen/vi_32/scicTJMk4LaMoNvKHm6IAuG8DWskGBHbe68DZUz3Lib4hfhScVCnBUT6FfhBymd6IkzjyR9jh5P00U4kmicSTd4dQ/132', '1521254100', '2', '0', '0', '0', '0.05', '');
INSERT INTO `xl_userinfo` VALUES ('182', 'A00000-霖湫美业、苗苗', null, '13795292286', null, '5', '136.23', null, null, 'oW5_rjoawO8UbpGChHZNmG_KFKLg', 'http://thirdwx.qlogo.cn/mmopen/vi_32/uz1fTfVDsO31G6fu6mOtcsrJ9fO0CKxctKOj43eDMjImuwsK6x3hl3tiauo3j3KUmcQ9zFPIswIMgSOTuTpaM3w/132', '1521254114', '1', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('183', '霖湫-【塑时代】胸-臀-淋巴-陈总', null, '14782372952', null, '1', '0.00', null, null, 'oW5_rjhppKz1e4rzMqVcnDxAGFH4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/fZ11rha76wKGEd7TiaIiaHbTzF80hUg2JkiaXibWhu6HnK1EjKfV0MUvZQsF8ibZA9iaDLGv8pxgBiaEego4lclInSXxw/132', '1521254117', '2', '0', '150', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('184', 'Shirley陈', null, '15129588988', null, '1', '0.00', null, null, 'oW5_rjjSEgxpDdoyItjY6OltPZ4Q', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJRvoNhpL7ElrhB3mCCJtmEcjydAn4B9YY13sscq1GXpF4fG8DWsy3ggI5icfUfqhXNN09ia3BbmmCw/132', '1521254148', '2', '0', '100', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('185', '美业～萍萍', null, '18317182509', null, '4', '2.50', null, null, 'oW5_rjsV2SZdDEQxoxIpJRuOLFBQ', 'http://thirdwx.qlogo.cn/mmopen/vi_32/WymMp1dqib5JbjYGlOCu7SbwtdQCeAicasbHL4jW3LmCsvN81RQfw8U7ekWgPbKxy0MJcgALRuKAtW4zVfa7Uabg/132', '1521254183', '2', '0', '0', '0', '0.05', '');
INSERT INTO `xl_userinfo` VALUES ('186', 'Monday', null, '13916199451', null, '3', '0.00', null, null, 'oW5_rjgV6TUddbJOmfE1r2CmNmu0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKmReghf9syFwABaGBH4PiaMqGPibJNEmoSnrhyowgemd2jSwYdOPW1DibsbWIMaZiaibGNsmOCWLAkz1w/132', '1521254195', '1', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('187', '霖湫：商务支持部', null, '18019055587', null, '2', '60.00', null, null, 'oW5_rjuFnH6510a3zXLJQqRK2bKM', 'http://thirdwx.qlogo.cn/mmopen/vi_32/LuqUrjBnYCS9JGsjqngsCLe6HJpficAb9BRDlBhftib2Xay3Ka1NVIia8rm6Z0iaH3s0XIVRO3rIbeK1iabOUK4jmQQ/132', '1521254205', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('190', '谭鹏雄', null, '13916403296', null, '2', '60.60', null, null, 'oW5_rjgzFsyld7rRa7BTjVQefJtA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKAvnBlxtIfFqdicrwdqDLiaicOhU7lianY8fLT7IcwbgceIcrO96tZSPvqGGRaQ00QanfCiaqRRBqpDaQ/132', '1521254523', '1', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('189', '大小', null, '13641759653', null, '1', '0.00', null, null, 'oW5_rjuz7jzseHht4WqpLMR53tX8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLMWwaVUYIocAt6g890RDWHSlsIIVPIbuVzibkLMGfGgBAguAFXIib1aHdxzvU2YXGaBibLib3M9cyTzA/132', '1521254387', '1', '183', '62', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('197', '霖湫【塑时代】胸臀淋巴AIMI石姐', null, null, null, '1', '0.00', null, null, 'oW5_rjpH5T-tnxzt-ct_-vtB0oco', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83erSh54dTvql2gxrxY6aaCtlicegelibSXoyAqfzaesBNBPQ5fITAbdsdohmqdlD8dVJYXHOD6pTWNfQ/132', '1521279799', '2', '174', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('198', '长甲弓之不动明王尊', null, null, null, '1', '0.00', null, null, 'oW5_rjn9MQ2DjtVPvQ6y-Aiu7NtU', 'http://thirdwx.qlogo.cn/mmopen/vi_32/bNeicz5XJ4oQibGAJY7Hv6GTN8lU3RTBR4Fr7ctPian980A6ZJaTHpe6tHl6ffH3EicQbdbXy6BKiaXzxsPic30fW0SA/132', '1521731442', '1', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('199', 'Pei', null, '15821066252', null, '1', '0.00', null, null, 'oW5_rjvdHr8kPpc_qHcwIQkf52eA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqDqGW8nFywP4RJPgibTiccDiaNmQAuLyogEa2KlpibNBanick17sZB89ibAVcFyYdBibeicxibtCFYr67rBuQ/132', '1521807610', '1', '189', '10', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('204', '钟情', null, null, null, '1', '0.00', null, null, 'oW5_rjkBtPBMxIyVxZUp0MmevqIE', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLrib75GH9U6hIt6lSVZ7vzhHKIjbCB4d6FKgQOemYuFJ7h6hCe2kaSgep67a6XjVEStawcE7CAgmA/132', '1521950507', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('200', '闫超～13817582525', null, null, null, '1', '0.00', null, null, 'oW5_rjuS9x9VEOQeF3EkE1Nj6tsc', 'http://thirdwx.qlogo.cn/mmopen/vi_32/1TZNkQltxyuy1Y1oYR432WReWOQFGS5ZibUsJfAlrW7fsf5tvQ4GervWzxVraLL8JmpolHyhlAOVjtRVbgM0mkg/132', '1521881376', '1', '179', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('201', '医妍萃嫩肤~塑时代胸臀淋巴~王娜', null, null, null, '1', '0.00', null, null, 'oW5_rjnfU3n-fcTqu03OGAAhBTRw', 'http://thirdwx.qlogo.cn/mmopen/vi_32/nichhjbDOiczaObl6HHxw1EvT36icBTuRyaovtvKhSqjyYt6W8CE7ULOibAicyibwT4BeCZJlT9w7cf1WfNMB81NSUcA/132', '1521881531', '2', '179', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('202', 'Sam-Balmainhair', null, null, null, '1', '0.00', null, null, 'oW5_rjtqgnPloppnbZXq43OK65ro', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoQezUgHer60meySf8Bq8ZGwSsrby5y2IKO6KmylcSRBoCm7FnuJwYE1K7d5FL7ueg2uFYpYUXd5g/132', '1521881676', '1', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('203', '大小', null, null, null, '1', '0.00', null, null, 'olXx5wd4-x6BhfMoqkK_Fsb10tyY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKKvbCNxkmIMW9xSx9oJYj6OUfibvqWmPF91Zd67GgEKmoicc8sFRPN7AVUjQSiaIicFia5lhXM1Yibuwzw/132', '1521894173', '1', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('216', '墨离殇', null, '15618864853', null, '1', '0.00', null, null, 'oW5_rjod4aj5iuide4_SAxvYrYoY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJHa2HdD2MZ7UgYmAuicRRUUh8JG3pGRKr5bApG36iagXbetE1fO4QbElNHL2u7dEHzBrKWCrsliczQw/132', '1522129175', '1', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('205', 'helen', null, null, null, '1', '0.00', null, null, 'oW5_rjrAmsoHHgbWgv1kgnQ8jWL0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLzQTSarT3ctLVVt37eANhVOOeCmvr4dgTqvvzOiaIcanrPxCd9p89veyDW2IibTIYYEZQKmic5B7edQ/132', '1522117715', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('206', 'MMMMMMMMMM', null, '15000855273', null, '1', '0.00', null, null, 'oW5_rjuGP1HDggILq9vCYNT-OJI4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIDX3BMTshjB9OxlKiaLdRKwpvhI1FpFI9ic3XwnLIDJHWibPVpLTZoDKAdXzTAbW4JJMKibBNK6fhaLw/132', '1522125904', '1', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('209', '兔宝宝', null, '13661669664', null, '2', '0.00', null, null, 'oW5_rjpYazqbFSe6aiTI0-w2Yd4c', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJZhRbt9iagLTlaLokN45zfbu63KhQcnLaecaLXibRuPrv4VzE1zXqFibDPXfKn33VWj7eRAboGibLUmQ/132', '1522126556', '2', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('207', 'nnn', null, null, null, '1', '0.00', null, null, 'oW5_rjnm0TiLM7OsM139lDNtVVIE', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJR4UjhFsPia75uFK7LgP5rsniceeThsB4QUfHEeWe5oh4oUcqtEarjoYh8vKnKbOyf829SOMUysibQA/132', '1522125916', '2', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('240', 'A@  txf', null, null, null, '1', '0.00', null, null, 'oW5_rjvM1LUGFIfAkMCaKr5m46e8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/R4DicBy8rqekwWRlyIhCfPyHyA6LSl40icZFSug6BgibP5ialeoaJt60jhVsux7Hmdx9TTTXPxNoFjVR9tRpccXhbQ/132', '1522212515', '2', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('208', '请输入用户名', null, null, null, '1', '0.00', null, null, 'oW5_rjvs3etP03zIyLZRjIpeOII0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epwwYxqhTLeNMyIV4zquxdJKGicYNnfewwgIt5mIjwmic3zwDZDMXELXZDWFw1LYFS2OvEXvNOvH0gw/132', '1522125917', '2', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('210', '八月桂花香', null, null, null, '1', '0.00', null, null, 'oW5_rjtLrBNZ9oZjO4WqocfoA7Cw', 'http://thirdwx.qlogo.cn/mmopen/vi_32/tD2jytib4AmNpfppdCcFVzpTu9bSiaia3SDMfTMCrSia1gc5ARXNClzz3QW9ibAAU5yVfrnbDf9VZOC5hb0v0RibcGAQ/132', '1522126681', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('211', 'Shiny', null, null, null, '1', '0.00', null, null, 'oW5_rjiEu5iwhlF5rcvsODL6epKA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJSCiaic9J9Hp9xsRMvggCWLB0DME0phDO1aibd00PViaicnnxeOPmcPCXPId6icp36qmLoy1tcubggcQKg/132', '1522126859', '2', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('212', '萍水相逢（崔益萍）', null, '13801902745', null, '1', '0.00', null, null, 'oW5_rjrjsxqWqBdupezxQL7Z5VVE', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTInjShjHZicPeAB8VYsUiaRJLC3SQ3ibEXz6EuYZzQBzP3W4BCFjNibUKSK7acpcvmDPgEk1F6xvwzGSQ/132', '1522127432', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('213', 'incense', null, null, null, '1', '0.00', null, null, 'oW5_rjtk7_2HJYPiz_VCq9HtOTDo', 'http://thirdwx.qlogo.cn/mmopen/vi_32/sSUVgSa6mm5dXp9Mrak8qTfFhaBeMBicexesEw5u0JCDlVRCkeyvxW8QUuYMzicnVGXoI9C1b5JY2nszTm70RsFw/132', '1522127556', '2', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('214', '阿華13601744624', null, '13601744624', null, '1', '0.00', null, null, 'oW5_rjkHma68vyGsu5qecyXfNHpo', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI75M8BCHnJhtXcAMbX9ubnEXPA7OrEmsKgibrvrsyDwjiaactIaNnKjY4ibPdOMEiaK55iaYdbNmUcCHg/132', '1522127838', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('215', '心如止水', null, '13311819088', null, '1', '0.00', null, null, 'oW5_rjgbDD4l-fcrOMtk0VEznLG8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIFvBgXKYSqLCJ9hJERsKrd4ubShCgbyaOHiciaGEo1zP4NXclg8IUWww3xj04Y5uHb5ZLZouFP0G5A/132', '1522128181', '0', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('217', 'crush', null, null, null, '1', '0.00', null, null, 'oW5_rjtNPaXd5DBGCsaHzhQjbBx8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI1IGHurebH8YNQ3OibrosxXYONibxFePH8EzJ4mzqYpmX6jzKt21qk2fXLTZZ4by8rARloL9bZwp4A/132', '1522131670', '2', '213', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('218', '阿y.', null, null, null, '1', '0.00', null, null, 'oW5_rjvpCqDJLfC3gbgjmbbjUY1U', 'http://thirdwx.qlogo.cn/mmopen/vi_32/reg4EGst9IKFC6ib6k1Sjjib2l4DOuoeT1riaQ9q6SYgTb3yRZ544BBt480Zgxmp4TzFPRaN14Wx1EGQqNXQrDezw/132', '1522132157', '2', '213', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('219', '汇尚艺～章智琴 17621360604', null, '13566709756', null, '1', '0.00', null, null, 'oW5_rjjMLBfDFhrWy9HPQGa4MCL0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/BtZiajqIzDdkibAeZxefQok9FchGejWhibImDkK6wjs4cC7fxN1UqBrBMeYic9f1FzQtpVoFyOd0OEClQquw2tCl4A/132', '1522134501', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('220', '秀艺造型', null, null, null, '1', '0.00', null, null, 'oW5_rjl4WZ0UrZcLTabdZCevOqlw', 'http://thirdwx.qlogo.cn/mmopen/vi_32/5d0wBjEKZYOL0ZMjyCvfSXmDs8vvpiclUswA6bSOGKFKMCwVuemKxnD0cnVick1yJm9e3RSibdAFNeXNRVZ2Mroicw/132', '1522138970', '1', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('221', '先容', null, null, null, '1', '0.00', null, null, 'oW5_rjnxRvVFw4qrtMhrG9xNU0tE', 'http://thirdwx.qlogo.cn/mmopen/vi_32/kd8ru9FGvQlojm5XlmibpNT8kOhCeWlUl9QEWBWMsxCAIGpWkZcgticQ3Q3zEPa1CEZ4m1pjWJnv53JicWtEp2BMw/132', '1522140513', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('222', 'A丹尼', null, '18217449089', null, '1', '0.00', null, null, 'oW5_rjuuSEUK5E0x96K2RYaa6RN8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/QVf2jvM3VzAVviaBPE1sSdLGygLDHvc7QacuKZGclicoYfwAhWUpqQ5YhU3jkrCrolSicTj45LyzoKELhJX9lh9mQ/132', '1522141799', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('223', '猫seven', null, null, null, '1', '0.00', null, null, 'oW5_rjsIVT2F4ZFmrVNGwpyoGpro', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epszPn6NtVrKbuwSib2iaR5yhgaRIp7felZma5oHl0f8x1ZDyNicwvmdcSaAGdQakKLmWm4AmVWjtQ8g/132', '1522142587', '1', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('224', 'A、  陈', null, '15121081174', null, '1', '0.00', null, null, 'oW5_rjmjLgAqglc6SsJhEsZLIOZw', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIWDvv5wW12spMxXV9L2bPB2hUEaZGTREZRSRX35tfM1NPK8E6ZicxtOnepSCewe54zKCvgJ5Fgibtw/132', '1522142911', '1', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('225', 'ARTLST轻漾美熙皮肤管理', null, null, null, '1', '0.00', null, null, 'oW5_rjh4TrzZLlwa32HXbc0ZB8Ow', 'http://thirdwx.qlogo.cn/mmopen/vi_32/bBia1LLVBHncRlw2cPODia5UINnbXHW8FgTETQmkic3ZlJjdmIc5svDp1W9XCsaHicLjiak4aWWRh4NV5s8AThxnWTA/132', '1522143939', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('226', '明铭-抗衰老中心', null, null, null, '1', '0.00', null, null, 'oW5_rjrlda-iVZtcR2niEhJhL4nY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/IwxpzicFfzylK463apwRzaapUJDFicbLkW9sa0lNZLggDT1YdUloDAkVJf2SjRu9zQVfoMcDJjCunIiabHPhpKxXw/132', '1522144048', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('227', '李超', null, null, null, '1', '0.00', null, null, 'oW5_rjofFZo8YGXWsa9TBQrlfMEo', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Ct8bt215turRvkax0CP4kkVkRysSiciaPk1B3Cf8YrXGpp0MlicEiaDzDrKyaLqUXebn0xVSfu5Fz9LiaD9qX9No6Tw/132', '1522144151', '1', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('239', ' 宋宋4134', null, null, null, '1', '0.00', null, null, 'oW5_rjt4SsnlrVgk334Ty3y8D8hA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIWDvv5wW12snSQOJE9VBIe3ztBDjZg0ib2bv6gIjfhHmJ4lIq9sX3YNJ3eib0sGdicgaq6o9HWWH6ng/132', '1522159084', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('248', '设计先生护肤管理中心一张萍', null, null, null, '1', '0.00', null, null, 'oW5_rjlKTCk1NkJCszP7XCKTQ2U8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLcNq9Z5lABe9uQJGyRNwxtWFVz5u3koFyTMMof2tYdiblEkictXflPgxGNq1RVnicAbWQyVvuIK03DA/132', '1522223822', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('228', '芬尼陳彦伶', null, null, null, '1', '0.00', null, null, 'oW5_rjppYBlEmKKB8DArRqNYTV5s', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLfMpvC27N8R26t8sZPS4PAXnAOJ2ibF8icqY09MpRSic0xBj22P4A0LcCibLeUvS6ibSMt8icKfknR4Ticg/132', '1522144492', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('229', '苏小喵', null, null, null, '1', '0.00', null, null, 'oW5_rjr0AIv3bVVd_k050V78vwuo', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJvUHrqvILhZrKiczHQHBmymoON03nTIvwkl2FsbmMiaeib7F0PlUfa8Y8HHHvtr9yLz5N9fFpA3G9bA/132', '1522144665', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('230', '英伦玫瑰吴香芝', null, null, null, '1', '0.00', null, null, 'oW5_rjt8WUu--hcin970ffLqpkE4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKJZszebzPK3AAJ8LCKjpSlglsnnBqX1mGhaiafOibbPPocwVjWtCJ2GhcgDrlVPa0gFLymRJwicnhbQ/132', '1522145233', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('231', '拜伦斯 小雅13636478874', null, null, null, '1', '0.00', null, null, 'oW5_rjqRaN4_RwLnJhO2UbU6pPBk', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIgqSZIdVvIDewwlHyjvncf9Zp6lGrtMBQKEW21oVApHR7Dia44UzeKJf0MnCB7fmThibIDZAGPm7jg/132', '1522145264', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('232', 'Helen', null, null, null, '1', '0.00', null, null, 'oW5_rjgo0lLmr0PMGuaFxmkmn4UA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJlncdPZXTx2hxyvDW2IzUSWO8JBWoYJCKib8mArtKPznjgN0QtzJpTdrGt1EYzpCm8XQvmzM9cdUw/132', '1522145735', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('233', '敏敏', null, null, null, '1', '0.00', null, null, 'oW5_rjiSlasDI_BRuEtLUrTmHpoo', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLknksDZvB81ucDpFQq8yX1ZzIsB9r3d9KCAyD85Z2HOy5xGgib3aJ0JQYlTyVrjj25dEhdS2lWIvQ/132', '1522145810', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('234', '小张', null, null, null, '1', '0.00', null, null, 'oW5_rjsu3Wadb4dug57wNZAA6REQ', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLciaNuBUPibZNdwUmquFfg7B7WZK9YP73n8eNY1qNQnmcjic8e4WobvPh72iceGgeoAlkkiatVwuSAyvg/132', '1522146178', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('235', 'A 微笑', null, null, null, '1', '0.00', null, null, 'oW5_rjrBLjO6Mn7H6TBYp9SdXEY4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/kGo3dM1TJTeRxOMNw6Of3KNvnwpFvFPN5HK3Ib0EPMax9F84bywDQ4fWLTDzzIPhIrlXiaPU1vwDXvYUFxvVePg/132', '1522146263', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('236', 'Moontrail李悦悦', null, null, null, '1', '0.00', null, null, 'oW5_rjvrJfRc6-w5UFwlI6LH7dA0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/3Vjaiapy7Y9hbDlibrYS3lryPcReeJYsdBvQweqA885GT08goCv9J8qLjjmpkZOxZZdibmHVNujHtaQKtQ9uicDCpQ/132', '1522147797', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('237', '魏伊琳', null, null, null, '1', '0.00', null, null, 'oW5_rjtWJUPhNQ6FNVEU2HtRXC4M', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKssFp6vPUJRuzYG3BkfDAsu4kZHkDJqPzWgicC0o2BU7C064QX6Kwr7SDN38GldMtx1U7AVcqdNHQ/132', '1522148904', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('238', '海生', null, null, null, '1', '0.00', null, null, 'oW5_rjkhFjgeD1WGBn4lEDgExu58', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo22c7QO7MicBoibQgM59aKs8fnvthkk7qbnViaqAdthycK2JKPPFt2hUNFoBqmqNZ1dHAO0dbgicn4Yg/132', '1522154980', '1', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('241', 'Pere', null, '13916956206', null, '1', '0.00', null, null, 'oW5_rjinZ2WG0gNS0vGCIl_lnepY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83erufWaJTN2fxU4zmtN4Zmgsu3NNY8oMAp5bgWzAFViatjxBlRkSCiacb0cmS9RMo0NXKpcaCGSOWTxw/132', '1522216362', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('242', 'weiyan', null, null, null, '1', '0.00', null, null, 'oW5_rjuYtvzEt7-5FIaLVfChTCHY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epbZygibNr1B5qqRud4AgqUKb28fMd6gb5bH08ckeibYiaHCicBHVhK7uxicGibibZJoLWmhQgf8MPh0jPxg/132', '1522218339', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('255', '李鹏', null, null, null, '1', '0.00', null, null, 'oW5_rjudur9D5UoNQQjWED3Do9Bk', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJOtM4bIEmKEdShwtwqtcDCXj69qdrEk2iamforPjvJORGmibuQSszUV2licTVcQCLnlUbg7hpvNBNNw/132', '1522300918', '1', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('243', '蕙儿~兰瓷', null, null, null, '1', '0.00', null, null, 'oW5_rjoDxdGw7LbLGKYrAguw71Pg', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Xj7Mnghx6necyibxGGjkdTRNoXOBEag3eKOiapzA4JkUV0BkLeaP0vKaDP5EC7cIYOMoftTjSCZzpHeJ8iaRQ6aqw/132', '1522219337', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('244', 'Annie', null, null, null, '1', '0.00', null, null, 'oW5_rjnkyzLgEIkmN269HF41vuqY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI2bUaEW9seQjiaPoLYXhflq5p0MNxlHvsvRZgvjPo0xsAXicnNLQ3nugV2oG2jJ9MibVqASw7EDpuibw/132', '1522219367', '0', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('245', '王琳', null, null, null, '1', '0.00', null, null, 'oW5_rjiqmY1_3d-5YOsfPMyKvIb0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLVo0v75tV6ZmIe1yZgVmgy87icV9ZibIxdqMw9KGcDqic8JU4iap43B46XhCuzRVnoyck9icedLMVluRg/132', '1522219414', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('246', '秦海英', null, null, null, '1', '0.00', null, null, 'oW5_rjh43Hx63SgaKza4RRWo6sZ8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep87oGszh5yvsthrGJdHC8XBFW28ORSTUDbmrib0oFgicIFQH7CYuodSt7wd42nvmebc504grlibbmNw/132', '1522219638', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('247', '迷失的橘子', null, null, null, '1', '0.00', null, null, 'oW5_rjk7ZB2edU2NgCjSSLSMGKMY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/U2hSnycn7aChH0nkuu0KAfquTOSUODLGuibGhSNZmYNjZ474jhqHYo5ialw8nMZ1IUZxjic9F9moA6kwy968FR8dA/132', '1522220023', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('249', '妖D滟@兒tiamo', null, '15221938208', null, '1', '0.00', null, null, 'oW5_rjuXJkXbnwwpbQEvqGFzyUI0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJcyGISfgU3UzaQBvUWibaY18CG265hIa2rHgztFHOq6tQhN1ZsaO4pZib3OyrlZXibocibst9Kwib4Hicw/132', '1522224933', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('250', 'leen', null, '13641782237', null, '1', '0.00', null, null, 'oW5_rjju4lRDQSmGvnFWQrhxJXj4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/dbBKicjStlpcGJkp1jA0FTWOYClWFxChThR4VWrA4B7Mlk2aUzE4pPXwvt3ickLz1GFnsnSPD1aKFtic9nNPtZmoA/132', '1522225190', '1', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('251', '番茄', null, null, null, '1', '0.00', null, null, 'oW5_rjhtYJBgXAxyv8St4qmIpxWI', 'http://thirdwx.qlogo.cn/mmopen/vi_32/7QAdht481ibrgCStqrIibCofHzwicjALMmOw7unicFcY3MCyD6of9b9TbRcRJcH77ht5ibmT7n79D7J8fU6Gfbw1deg/132', '1522226182', '2', '206', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('252', '小顾', null, '13818739108', null, '1', '0.00', null, null, 'oW5_rjvaF1KYVo3Q55SQRRgq269o', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKDR17SzJTZIJx5EMQCZ96NwQc9hZ69BWbbtQm5sInd77ZHrDQt7ibsicGH5sFC3c5neI4jJzBYtuAw/132', '1522232458', '2', '206', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('253', '旺财财', null, '13661683086', null, '1', '0.00', null, null, 'oW5_rjk5J3zfIiFF596KIJX9Rd_4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJPwlTEzqhJUzaBVaXVbCaTnkQ0ibibyaTUMIC8RpyVvkFqPBu8LZ6Yvibkic4VLWoJ1J99y2lTicnibDlw/132', '1522232648', '1', '206', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('254', 'YUAN', null, '15000814320', null, '1', '0.00', null, null, 'oW5_rjp_S6rrdYETj0bhOnHudoEk', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIWibuicUMldu34gmMHkfvyxssu9L5B1JfVCEGXMDg0lx80lgXWMicTW7QHWWITHKdDtn6QSC7QWDTwA/132', '1522234791', '2', '206', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('256', 'A  江夫人', null, null, null, '1', '0.00', null, null, 'oW5_rjkL_Y5ezPAWDu-jYlY3B4I0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/cUIt1T7R4CM0vn6jOtaEGj0UPuShj6bK1tCy9ibfCFTxSGiakjxHmNDE5ERFURlSEKGrmIMVXsuibu9vAIoSVdtRQ/132', '1522306312', '2', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('257', '\'', null, '15900524302', null, '1', '0.00', null, null, 'oW5_rjnHhru7CP87qOgSuon1HSjY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKKx2PX5vKXRsVPuqbw9jRsHlIdzk4oUYn652TKCViaUUOoD8nsLYTJkEib5Ue4oojH8NpGrgUhnghA/132', '1522308263', '2', '256', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('258', ' 卢燕つつ', null, '13564530361', null, '1', '0.00', null, null, 'oW5_rjkjsx0KUGgphMHRWKGNrm_I', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJBwiapNSEHGvBVah6PNEqPa5H45v1ibEAWHwnvHICArDYUfwOGibOyM1k5SKTy9gW1hIaK6Cag7Jibwg/132', '1522309950', '2', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('259', '王彪', null, '13501641091', null, '1', '0.00', null, null, 'oW5_rju6qxkf61tE6DAwDLsrebC8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/jeAgLc5xVvHhZYoRfBGXPaUGTn3GOjMx0HDYF7Gdv7SPjW3ic1fzrKFLoRIqp316rySnGI4xafM44NGzwA1evsA/132', '1522314079', '0', '256', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('260', 'yao 瑶', null, '13818206050', null, '1', '0.00', null, null, 'oW5_rjuzHb2Vc7eR7R9dQ8J-YhZE', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epCtogK3SzicYNicvkG49ym0lh04VpsWicqOBhAKA0FA8x8uuVicE2UZgVmUKIibBjVUtfqKuc2STpFrSQ/132', '1522316256', '2', '207', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('261', '八戒', null, null, null, '1', '0.00', null, null, 'oW5_rjhh127y-A5VLKNM7sPPUEf0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIclcmOrtgicib3xaKL3RbicOicTib9icxjrG2ibpia2pkUrOdQhQdkwSYJgBibiaiaicuHuY6MrBN1ia5DuaQbmBQ/132', '1522324673', '1', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('262', 'Sara', null, null, null, '1', '0.00', null, null, 'oW5_rjlFHCPaGVkcRQeBUZtlXfd8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eonRt3lH1fdxwT1P02Ib0rFpxzhnI7mAjiammc3TcVhVlEgFzg8pVw5E4XvYAkQTl2D9rUhic5XNC5Q/132', '1522328589', '2', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('263', '英格丽', null, null, null, '1', '0.00', null, null, 'oW5_rjr_SR-Q-PzC7wjN_nbbcjcs', 'http://thirdwx.qlogo.cn/mmopen/vi_32/OicsDnyLWwANnPa5G64CtmrmKHt9OSd9c38j9CVOicZJbmbZXC4XLf8tGp10lJFugYU7EgDndYKs2BYrBCBrj05Q/132', '1522400086', '2', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('264', '丁丁', null, null, null, '1', '0.00', null, null, 'oW5_rjqDSrFwDgRlVXXXfP-YQd4E', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJmpFkdvxgI9G0V62VsAw7O1t6wt4zupJdfdu391GCCRuOd8cIias0UEwLIUNm5pibmPibtCnMApq2jA/132', '1522459595', '2', '235', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('265', '祎祎', null, null, null, '1', '0.00', null, null, 'oW5_rjnhNmB8i40meKae_jkcuSPs', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epor0tpYEEzQlDeZgIDQicP7My135o5ibOGIUH7qyzKZ9VH1DXttHsP2MqyKU8yVnDmYV3AFibEWCFYw/132', '1522460248', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('266', 'Clare钱来来', null, null, null, '1', '0.00', null, null, 'oW5_rjuM-opU2Oq9r9Tz3jxwmow4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKeQj8NaUBPGlicwRktb5sg0aibtU7hMkM8t73QY6ibzQvyk4LQ71YVicdRQLubP5JDKSSZXia5vuEbbkg/132', '1522460332', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('267', '蔡婷婷17621732833', null, null, null, '1', '0.00', null, null, 'oW5_rjiIOpDqon_bgQkM3mvGmdJY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJWe5KPgRkcGza86w4OEy7kxrOv5pGyo7nkZiaxEppMgGricjjoONiaRq1hTmKrlTCfBxFyc4mEsXGIw/132', '1522460465', '2', '178', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('268', 'BrilLiant', null, null, null, '1', '0.00', null, null, 'oW5_rjsoxzrLX-KRdcaFW2eUd6pU', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKQ8TWBia8Astoo9qa37jsSaPBcZctQUvFCG9YELMicqPxZNTKygwTOPWZOCtwRgfqRo4OQqfbA10dw/132', '1522460565', '1', '267', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('269', '平淡才是真···', null, null, null, '1', '0.00', null, null, 'oW5_rjqCzGjPYMG9Q0tyeeGEenfU', 'http://thirdwx.qlogo.cn/mmopen/vi_32/CNA9pSlFjtbJHjmvumtqLwYsfPHgKdUgp7xEI7axjzRibEChhymxqbceUyiciaaoicsY7Esm9Jc1TLhtgWFnrQYiaoQ/132', '1522461932', '2', '185', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('270', '新零售-邓怀玉', null, null, null, '1', '0.00', null, null, 'oW5_rji4qE25DTBq0-zz5AhLFKsI', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK0wrRBYiax6C6xibHEqNgImZRfkFyGQ3OHBkeGFezRkKpg9EQRibaOOZfa5u22C3y9R4XADY8nzOpLg/132', '1522462175', '2', '185', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('271', 'A美业达人宋严军', null, null, null, '1', '0.00', null, null, 'oW5_rjqXBlxF5pwGunxxI5ntmUHc', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJvQ05sVDJO9wdcwA3DwZTibMz1KLJmicjGHsIKe5DQna6pmXqaFxzvwF21qytWqrWaY80HAibRgooRA/132', '1522462636', '1', '185', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('272', '静香', null, null, null, '1', '0.00', null, null, 'oW5_rjrFv9Yu6Ogb9axsBXTG26s4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/HqmagxXoul6L45zAfkAj3IuoULFbkYNjdcgHrccpdkiayps4ezNvWxhexLWickSYQFWUZtjStPjCiblCTSbuBZdrA/132', '1522464831', '0', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('273', '皇嘉金殿黄娟', null, null, null, '1', '0.00', null, null, 'oW5_rjqhQKfD_5kCoskLVlNzzziQ', 'http://thirdwx.qlogo.cn/mmopen/vi_32/d6u3lpt8AlDNSuINn9DVEs089tgWV4Mv12Q25JTLQn0DGEgCua9X8UE0vcicXEr1mx7eYYat8FupLBoOK5TcbkQ/132', '1522481397', '2', '187', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('274', 'JOEJOES企業：金四', null, null, null, '1', '0.00', null, null, 'oW5_rjsuEpkWvVVJnqw1XI2avNm0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/EOYsicTeX8621dEVsdl4MRoEiccPhMb0JFydLuVrAcTjVicLBxheibYKibPQm4N2b4BqUnzAQsZKJejLFERhUcbdNOQ/132', '1522482777', '1', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('275', 'L  X', null, null, null, '1', '0.00', null, null, 'oW5_rjnRI9voXEFYecbH9q_xd4Lc', 'http://thirdwx.qlogo.cn/mmopen/vi_32/icxqfzm4YVW3kibLsMdMrShTUVm3KialVFTgibXsUdQvc2cERGFibDRVjiaVfhWZbbqmBV8D06RvXTDtPaZXRyba0Rvw/132', '1522485094', '2', '235', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('276', 'A 明月', null, null, null, '1', '0.00', null, null, 'oW5_rjqSFc8Zf_6Nrtc79i2JiWFw', 'http://thirdwx.qlogo.cn/mmopen/vi_32/RLzffiblH5h966ibXLhyX45O6XiaicRLNrOR2DtaGa22MS0fYoBjnaGicCsgM7SCMibtiaAMxUicsUmtFibLVTLO7LAABmw/132', '1522501581', '2', '178', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('277', '再也不见！', null, '18616540341', null, '1', '0.00', null, null, 'oW5_rjoP_7QTa68Jq3zf8QJ44-Lk', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLaCslt5Zg2g1XEEBoI6CmZmqm0rz2FoqweoCricfrNFXZQSssjNPjbooX5ttJCAhZNgWus5O9SHAg/132', '1522558392', '2', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('278', '谦和好礼.', null, '13701655703', null, '1', '0.00', null, null, 'oW5_rjm-zOUZV2sIjKjxkNP8dEtA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLtyLc2KH0icrKYGJ93FZQicQF6vBTr8Cmibffs0RJPgicgh3iahnn0wWsIvia3kicp6ll5qZJibiaJMxE3bJA/132', '1522558394', '2', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('279', '杨循', null, '18818101395', null, '1', '0.00', null, null, 'oW5_rjiuJXUUyNmN-7gRmg0lFgXY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKKV3BuNiaPV1BJ8MMB7T4DLT5DBiadrciaiczB89QqJeA5iasdIMd4q9xFO3UfFaYHR2TPgIz5S1ZmskQ/132', '1522559454', '2', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('280', '罗华家政服务、房屋租凭丶房屋托管', null, '18321988348', null, '1', '0.00', null, null, 'oW5_rjt3yW_tX0D_cnjb8JSnAl5k', 'http://thirdwx.qlogo.cn/mmopen/vi_32/yjiaDM1yKq7RhscibvZmvPqp4pLPicS1XB5L0TezIBXCavBgia8NxzTc1OS4Pkx1x5JZqGFYLBicDibrTlLhyiaaSNVaw/132', '1522562136', '2', '278', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('281', '罗真凤', null, '18286079783', null, '1', '0.00', null, null, 'oW5_rjoudeZNot4kv9GcuIEjmJSY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/cM8eXgC3r72ZuibJxtTsMDj207ic869qpJWeVvpJaALsqIJEE9HCGVWP2p5fn2uLeAwBcEegEFTEqlwc2LqA1W9g/132', '1522562288', '0', '279', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('282', '涵涵', null, '15630185887', null, '1', '0.00', null, null, 'oW5_rjhgOiQXg1t252c_wodAC73w', 'http://thirdwx.qlogo.cn/mmopen/vi_32/WqhLNM4iajNHgicp4K0R1SaAHQXTH1iakia4IBLCxf6GC0Wye7v2ialnicoGQvWwhLnFzecWibo3ia9KQDTbBfrBz0IUng/132', '1522562497', '2', '278', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('283', '珍惜友谊', null, '15800487942', null, '1', '0.00', null, null, 'oW5_rjh3t39A0U7PCTOhKxRFXDLM', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epKWH2aAA9R249nQKNnaJ4tSHpY8jic6ic3K3UYnHMibOKuRmX5AlAcMOvcbEibIQK9iaVURoM6EJIEc1Q/132', '1522562732', '1', '279', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('284', '守望', null, '17095163199', null, '1', '0.00', null, null, 'oW5_rjsYjUvwKfmZWlrzhHjVZwf8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/8yYibaJ5eVrOf1iaRltdbKxgajZgjNskhNtg46jx7zz0Bju9Ya5XEccOMHtxjGCfkCzagcNpdfkfiaB5sQbp5xXgw/132', '1522562982', '2', '277', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('285', '百事可乐', null, '15618331831', null, '1', '0.00', null, null, 'oW5_rjnEdvu3tHxlQTe5soX6irr8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/hMfKic1J7ejgYEksCfNIZicLWqlLjoTckBQfIXuBJpelqt4LhjQ7SxQxo9v5nUjzCdRtVNS1OHPCHFyfoQzaNYSw/132', '1522563060', '2', '278', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('286', 'A韩国慕色客服经理-will', null, null, null, '1', '0.00', null, null, 'oW5_rjvnnCUDANwrcNvQUsUgDlmU', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83erc6TL2ic66HAEiaLWIkwLBwjv6v32oxONb2pRJ4FrjzJ8ticNKRh4o8Fqv5PNQAwzCkibp7mBZFFkgAA/132', '1522564543', '1', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('287', 'Amy', null, null, null, '1', '0.00', null, null, 'oW5_rjji1aTUebcPkG31F_VXjRS8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/S4sD5eUXwuicGGRl8MFET5uenRWZSxXKOEqjFN0sxib0u0dVOicBt5maxUb1vcYsiaM6EJfcDqsyISzpWIibOGb3Kicw/132', '1522564824', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('288', '谭', null, null, null, '1', '0.00', null, null, 'oW5_rjrsAn8hD56PTz_KW0PDbU5I', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL6ibvATzI5FKYSOD6YqCQAz9I56RU8s7rBkygFxBOftsszYTDmbnibC82yoHL1gcXu92HYJpMyXeFw/132', '1522565659', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('289', '景帆', null, null, null, '1', '0.00', null, null, 'oW5_rjj75wnXsmlguDhL-BHGnqpQ', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI0vAkncIW7iaialyhOOw3ia1El7XcTckp7CibtUD6Dic6qaOfaiaeshDlVsdrqdBXOvTibia7BruwuWkExAw/132', '1522566338', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('290', '吴红丽', null, '13916279468', null, '1', '0.00', null, null, 'oW5_rjlJoxBHfcJwhIWTqafb47xY', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJdzQq1MmnHzJOQ3GgYy4IO9VoJq2zic9TOJtZD2JZ5gDz31dZ0ibloLUfwN7aibdxjuwCbjs3JRhtxA/132', '1522566945', '2', '278', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('291', 'Manbo⑅◡̈*.', null, '13433553697', null, '1', '0.00', null, null, 'oW5_rjnM3B4ijsRF1sE7CqZ0ZKGk', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJoEEjiaCuxMwo9ogEICtx0g5Zn317CkyGhWxy20DUoFPpQhFs3EVvIyTnjz1IaibKhwVEtBVTFfDOg/132', '1522570207', '2', '279', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('292', '顾丽萍', null, null, null, '1', '0.00', null, null, 'oW5_rjgz22fWSLR3GPsXWZHT-MFA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epyF9Q0OTp7FRZ5rOu0ibLrFibLH8ic7k7qYycLXgeSzRTO8oaoX8gBPnkw6GwdR0K7Ho0n79XkkTg2A/132', '1522570451', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('293', '（陶）开心就好', null, '13818442358', null, '1', '0.00', null, null, 'oW5_rjt8jOGD8GGiFhF01_0mEhHk', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI8mVy14cXUbV6vNreZObpN2CEicg94RwYkf9sdC904yxGyjEria4iagq8CEeP8JjjPoQj4wbjAPJAGQ/132', '1522570650', '2', '278', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('294', '陈景', null, '13671639463', null, '1', '0.00', null, null, 'oW5_rjqbm6PUKJ1zx6dNFfzT55Ks', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLgibn8eGsvJyZ8c3aDeLSViajf5WLZ2644RZMiaaI6Rce8gG9GtnjC5NMMfpyicPAc4YxwxFQN2icXnxA/132', '1522571132', '2', '279', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('295', 'z等待.......', null, '17701806573', null, '1', '0.00', null, null, 'oW5_rjrumKZnHpDyoANyvE4HCNXI', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Se7ibm4xAJgpRmZM7jjMUhicS4odY3TmXU6cO7cycrP7GqPAJqNESWEHISUmOa6bDiahuX301DV8SRdK9xV6kz3aw/132', '1522573481', '1', '277', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('296', '柠檬初夏', null, '18116295689', null, '1', '0.00', null, null, 'oW5_rjvD-dPM4uWbghjmdGdK-pt4', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKLhWwaY4SnlZWskMUMibwOWyx0KI5LJjEPyfqI4db4SkxvxSiasUtDZWKGIRXwrY4As1pyxaNhA8Bg/132', '1522573781', '2', '278', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('297', '飘', null, '15821050335', null, '1', '0.00', null, null, 'oW5_rjgiEQus-VIpT4vYVQw4Am5c', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLtZ5DwibTyCRx1sQXskouqPD7uFPgrU73DjCknic0xgNGHUE1SX3pXJAPnRdsL9NkgagHia0qwhtVGg/132', '1522573961', '2', '279', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('305', '君君', null, null, null, '1', '0.00', null, null, 'oW5_rjsI34V6yZvrjYD-JLG-50aI', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoGichkB5AE11W8eJ1ibQYL25TZk67GWrEFib5ouq80ASbaTr4aia00cKia1lXkCZrx3vKGBpjPBfu3RmA/132', '1522994478', '1', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('298', 'Amily＆溪～夏朵', null, null, null, '1', '0.00', null, null, 'oW5_rjiiOT7LZ1dlJZnxCDPvFgkE', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epvjovJRuKCB6LjUxLvzPHkW2bhibuNSevmphNSpTkRYnU6SBL0NEmc1xNSfiaao4JeT0R0OXqjHvDQ/132', '1522817948', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('299', '道', null, null, null, '1', '0.00', null, null, 'oW5_rjpmL7WkIRUJ4-H8Ut8Hx9qA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKd3rtTK2YKbgLVynzoR5G5jbiagNwMbLzsLZ3dibqiaseibRcrzcQia83zuBd0FfiaZZEpbWwNrppSYCmg/132', '1522823128', '1', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('300', 'Rita', null, null, null, '1', '0.00', null, null, 'oW5_rjgeArl-RWbNTOLdv0OfxJ0c', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKRQ7VAOIMhJzG1PvkDWEAtz0oAib5WqtmFhOwPACT38NgblicWIK3Kpocia39UCMerzEiczZKrPSs8aA/132', '1522850974', '2', '187', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('301', 'a徐柯love love', null, null, null, '1', '0.00', null, null, 'oW5_rjqtJttK_Jmxnxy7pT9z3tWs', 'http://thirdwx.qlogo.cn/mmopen/vi_32/ABV2HiavCONzPWz3IaFkv3nwwfW0PCPZicaXE6gW5Gkjcpxias82SfKDVqNovU4ibGUjOP94OSXe3JFNYiaP162xib1Q/132', '1522851038', '2', '187', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('302', 'Mad', null, null, null, '1', '0.00', null, null, 'oW5_rjt1ylfFXnzrdglApRgUHMfE', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83ersnAWOyfA1ZtGhbAvBur7VanNE6PNtCgrViccvurSwF3siaGyJJA4iacibCPCEjhZwO65rSbuCcqPXBw/132', '1522851688', '1', '187', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('303', 'LILy', null, null, null, '1', '0.00', null, null, 'oW5_rjuMSc5zc2Sa35zzXWyviPz8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLBrnvSlPzSaAibqQWdCaLRR0JayVGPBib3b05mBPSG9ib1DtibRV14lhpxgV5gdoyFLhzBcIhlXibrialA/132', '1522851822', '2', '187', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('304', '罗烨斐', null, null, null, '1', '0.00', null, null, 'oW5_rjh4rdVwV-AXrT6E-nGUrpd0', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJ1rRdmkPlLromfxkKL1hIzVpuGQia0ssLHk46fYuwbJvDOTBibNmhlqAicGT4qacWaricA4BWePlrRjA/132', '1522854256', '2', '187', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('312', 'AA吴果阳：你的美！由我来负责。。', null, null, null, '1', '0.00', null, null, 'oW5_rjjs2o9KGR7IsiHMLcuTXwaM', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIhpcHevRfuRhPEaFXlkTJco3Sq2KEia04IM5KkUqFkiaHXYoibTibLoR17VDN9r5BM0T8P8q0bWQKrRg/132', '1523775532', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('306', '你的竹子z_z（招靠谱代理）', null, null, null, '1', '0.00', null, null, 'oW5_rjgvI6NXIMHa1F9NYSVVYJPA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqNjECNI2qxvaP9icAqv6lX8PibuxPRZMf5sSy6GqHlQshYWeiaEZnYTTv0q8zOcS9outYKZO7C0o1Yw/132', '1522994641', '2', '1', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('307', '我很幸福', null, null, null, '1', '0.00', null, null, 'oW5_rjorfiBMGPQtKMvkmFW6Bu8I', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DuCtqpWo7WMHC0ZyjVKiaFnNHLuJwufJqic6d8gFictG26Pq0vicRUQiblgBoYNPxuibOeCSXlwCzG0m2IXadic1ia7Zdg/132', '1523067957', '2', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('308', '可爱又迷人的反派角色', null, null, null, '1', '0.00', null, null, 'oW5_rjr5SzKynaqMkXYZjV4XW7EI', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKQBotbJDGmn6utQ9jJjk7Dq96o9cyAgxjQe5H4CdOxydBfbQCW4CB7iaAddmicr8GStAxicpBMsu1Fg/132', '1523079785', '2', '187', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('309', '泠妍紫', null, null, null, '1', '0.00', null, null, 'oW5_rjtDcOfI_U3JQR__sYGJDi3k', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJZo9icqx6Vw9ibwicKNVn4q6VvNu1j8EV0oPBJmuQDOXX31DnJ32Mw1icmKhkzsG3xwgG1uuEsYBpBFA/132', '1523113738', '2', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('310', '洁', null, null, null, '1', '0.00', null, null, 'oW5_rjgnnzyE3dZsAUcPJJycbLe8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/PfBH9oYjBIIlQsQwMMERzetPeeLb1uDRL39DbW68EMkMTaVm8MkGcVoL7mWzujTc7iaLImxShKgqibIfII1MvmJg/132', '1523251304', '2', '179', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('311', '小太阳', null, null, null, '1', '0.00', null, null, 'oW5_rjrUzuVEx-Hpl34jL8Yg8mCc', 'http://thirdwx.qlogo.cn/mmopen/vi_32/ibnibklicJqGJ1OPKU0CTVl8FYFJFTcXIvBr64UMvmbXAeOSMHs23lZrdeQKgNkb4EA3ByVicZ4dELvreGjExdE8KA/132', '1523524163', '2', '187', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('313', 'HYZJ', null, null, null, '1', '0.00', null, null, 'oW5_rjkuJJo65QSG8OgMx-TzpRek', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLC7k9pto5rZc7hyOwjJsFco00vmlC3OE4uEb76tZTciboZFgQk5spuWKaydx47GBcr5CUNcKhOXfQ/132', '1523776152', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('314', '孙慧', null, null, null, '1', '0.00', null, null, 'oW5_rjut8KnasYQiV8kOELukQLWk', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqsYw4ToLvSbDh5NicMgZUOZwYnz6zXePrA3Gfu9wtkez76H7uV54jv0ID092DNlM7PgDc6nkDBzOQ/132', '1523776263', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('315', '幸福&人生～李佩蓉', null, null, null, '1', '0.00', null, null, 'oW5_rjneLy1vIyuW6QBzynPggJ7E', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLfUYyjCHrmEF6SCia3bokY62YmZib1phxgRZlvib3CFcdDcviaKQbqkvYdbHtx9Q6nS80ickNjic1k7Sag/132', '1523776568', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('316', 'Angel', null, null, null, '1', '0.00', null, null, 'oW5_rjvBH8pvjWinixoHVmG4C_rI', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIFjrnnXK0En5B5yffe3yvFwycdlmwOiaye3kTSzeErnZoS9Iw4jTu8j34qhJ5xGyUFaNImUNWErSA/132', '1523776571', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('317', '娟娟', null, null, null, '1', '0.00', null, null, 'oW5_rjmP2rID0xe1AecL56nuWlcA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL4R6hN3U4rTgTKibeXLFue0eGYeZLgsygIalC3mianCTRQOe9xeJFvsY09JzaaDCt7qjjUbL4ic0SMQ/132', '1523778279', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('318', '中研vicky13120503959', null, null, null, '1', '0.00', null, null, 'oW5_rjsugJpwK1xcQ9BA8W98LVKU', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI1ff6obJIopYMq3ic7KTB5L0BnIEY0Z0JyxJ7F1OO2oLUoFOjMFZyRyL0DdIQk8YOE735kqHUlm0Q/132', '1523788569', '2', '318', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('319', '中研塑美～罗涛', null, null, null, '1', '0.00', null, null, 'oW5_rjigQ8uWC1A-Xuo1eUqMRU9w', 'http://thirdwx.qlogo.cn/mmopen/vi_32/tpsEyGrvQ0uvIDwrrk1NOkaYBWibMZwE1Javbbiaiaz8TnSRuPJ3RByZrzib37UQOialzEs2POIS0FZ63671CTHKcGw/132', '1523791531', '1', '318', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('320', '中研-李彤', null, null, null, '1', '0.00', null, null, 'oW5_rjtaeGspR_BS8n5XU_HjKQSM', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL79qJCPSiaNVSIQXgibCPKhlUXdCSMK3KM84xhebo8jq0FD74LPqicp58SialcY5EkF4m3iaNmbKQebqQ/132', '1523802566', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('321', '御蓉颜〈梦〉', null, null, null, '1', '0.00', null, null, 'oW5_rjjZqn9HJS3_wcSPCp4wGXgA', 'http://thirdwx.qlogo.cn/mmopen/vi_32/mQyZ5BVZYcWoWy9jf17axUqSYrK4eeF26Htibfia95J6xNsD4wqqYqcKePsTFEr3GJJ1iaXzG6MUdWlMJaJ79F78w/132', '1523831813', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('322', '龙和媛', null, null, null, '1', '0.00', null, null, 'oW5_rjo4RQO1VpVCLENPkFCQVM8M', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKXmtfEm1rA4d4enyPzXmRQObQMq98rJzBPAgEWAjVPSCcqicQwicy4OxiagCVDiaLJq0LNLSAEjd3IJg/132', '1523861682', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('323', 'Judy', null, null, null, '1', '0.00', null, null, 'oW5_rjm-8tocBEV9x9sajdS0Tqpg', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIang00R9vkkhR4m4s5eJCneVD5GPGMJewQEyqaFooJ7EmMWBKAPQdYIXheVbEh05Tr7rwPerSUSA/132', '1523861689', '2', '312', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('324', 'Apple', null, null, null, '1', '0.00', null, null, 'oW5_rjqJZvGhjKa-FxZcho3FvoFw', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIuiaXqe0EWbnKaaxk6kMMNExupicjFblIpYVWOPyK2ZjS5QcnXFPZlT9iazyKRw1HgroqIM5ib24kS9Q/132', '1523930787', '2', '182', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('325', '你最珍贵', null, '13482804640', null, '1', '0.00', null, null, 'oW5_rjvkSH75lptGYqkrQ7C0A1B8', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoEMZ2189tDznibVfse3I0b8IZ62888d8OhY6bJ6utLXH5bLPNmFeklUqrcnuKMfrv6fg8VdhkvZmA/132', '1524029993', '1', '0', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('326', '苏韵美甲__  __ 陆舰 __  cium', null, null, null, '1', '0.00', null, null, 'oW5_rjn0z_Qh7rMQdB0oOa9FqGiw', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKibWjMJaDV8bEiaRKY9ib5yLIt1S06s4f0kfiaoxRA9coUYWnVjk0H8GCQHN2SSBlXlR7gHCHmV20jZg/132', '1524038086', '1', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('327', '努力拼搏', null, null, null, '1', '0.00', null, null, 'oW5_rjtb-pVFlY-iKVfKLIlDmnII', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqk9sXMCvhQ9gqAXR9O0OBezm5RD0kuBvSqHEwq9NCfGSpm6ZBeo1xWViaXQLd4Ln5pibpKQFqXa8LA/132', '1524038202', '2', '183', '0', '0', '0.00', '');
INSERT INTO `xl_userinfo` VALUES ('328', 'Jason＊奚', null, null, null, '1', '0.00', null, null, 'oW5_rjgri2bzyruxrwObU2PLLSKs', 'http://thirdwx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEJ38oQy0XxmvfrjtHBGox1Q1EiaycvGR0p3DgvMUsCOV8so34d1icjZf0zzMNkZcoxAlNujkwTuhh9g/132', '1524038821', '1', '183', '0', '0', '0.00', '');

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
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_withdrawlist
-- ----------------------------
