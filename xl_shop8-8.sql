/*
Navicat MySQL Data Transfer

Source Server         : loacal
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : xl_shop

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2018-08-08 18:31:36
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
) ENGINE=MyISAM AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_agentuser
-- ----------------------------
INSERT INTO `xl_agentuser` VALUES ('200', '514', '516', '1525318213');
INSERT INTO `xl_agentuser` VALUES ('250', '514', '512', '1532679975');
INSERT INTO `xl_agentuser` VALUES ('207', '550', '551', '1525340788');
INSERT INTO `xl_agentuser` VALUES ('253', '514', '513', '1533354786');
INSERT INTO `xl_agentuser` VALUES ('246', '514', '652', '1532505751');
INSERT INTO `xl_agentuser` VALUES ('231', '514', '780', '1528177865');
INSERT INTO `xl_agentuser` VALUES ('199', '514', '646', '1525317872');
INSERT INTO `xl_agentuser` VALUES ('201', '514', '649', '1525320461');
INSERT INTO `xl_agentuser` VALUES ('202', '514', '552', '1525324609');
INSERT INTO `xl_agentuser` VALUES ('203', '514', '547', '1525324616');
INSERT INTO `xl_agentuser` VALUES ('204', '514', '527', '1525324738');
INSERT INTO `xl_agentuser` VALUES ('205', '514', '657', '1525333638');
INSERT INTO `xl_agentuser` VALUES ('208', '514', '711', '1525424307');
INSERT INTO `xl_agentuser` VALUES ('209', '514', '702', '1525590178');
INSERT INTO `xl_agentuser` VALUES ('222', '514', '724', '1526721564');
INSERT INTO `xl_agentuser` VALUES ('252', '514', '850', '1532931439');
INSERT INTO `xl_agentuser` VALUES ('213', '514', '744', '1526365169');
INSERT INTO `xl_agentuser` VALUES ('220', '514', '747', '1526721169');
INSERT INTO `xl_agentuser` VALUES ('215', '514', '748', '1526617042');
INSERT INTO `xl_agentuser` VALUES ('218', '514', '750', '1526698876');
INSERT INTO `xl_agentuser` VALUES ('219', '514', '752', '1526713712');
INSERT INTO `xl_agentuser` VALUES ('223', '514', '753', '1526722300');
INSERT INTO `xl_agentuser` VALUES ('224', '514', '754', '1526796139');
INSERT INTO `xl_agentuser` VALUES ('225', '514', '757', '1526967377');
INSERT INTO `xl_agentuser` VALUES ('226', '514', '759', '1527051550');
INSERT INTO `xl_agentuser` VALUES ('227', '514', '764', '1527315799');
INSERT INTO `xl_agentuser` VALUES ('228', '514', '766', '1527395536');
INSERT INTO `xl_agentuser` VALUES ('229', '514', '767', '1527495113');
INSERT INTO `xl_agentuser` VALUES ('230', '514', '761', '1527563058');
INSERT INTO `xl_agentuser` VALUES ('233', '514', '781', '1528263926');
INSERT INTO `xl_agentuser` VALUES ('234', '514', '774', '1528274119');
INSERT INTO `xl_agentuser` VALUES ('235', '514', '782', '1528284552');
INSERT INTO `xl_agentuser` VALUES ('236', '514', '790', '1528961432');
INSERT INTO `xl_agentuser` VALUES ('237', '514', '777', '1529042104');
INSERT INTO `xl_agentuser` VALUES ('239', '514', '842', '1532498841');
INSERT INTO `xl_agentuser` VALUES ('245', '514', '538', '1532502631');
INSERT INTO `xl_agentuser` VALUES ('247', '514', '844', '1532512790');
INSERT INTO `xl_agentuser` VALUES ('248', '514', '730', '1532571999');
INSERT INTO `xl_agentuser` VALUES ('249', '514', '800', '1532667330');
INSERT INTO `xl_agentuser` VALUES ('251', '514', '775', '1532680990');
INSERT INTO `xl_agentuser` VALUES ('254', '514', '549', '1533354838');
INSERT INTO `xl_agentuser` VALUES ('255', '514', '772', '1533355010');
INSERT INTO `xl_agentuser` VALUES ('256', '514', '515', '1533355236');

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
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

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
INSERT INTO `xl_bankinfos` VALUES ('21', '775', '招商银行', 'CMB', '6214832131272671', '谭鹏雄');
INSERT INTO `xl_bankinfos` VALUES ('22', '550', '招商银行', 'CMB', '6214832131272671', '谭鹏雄');
INSERT INTO `xl_bankinfos` VALUES ('23', '512', '中国工商银行', 'ICBC', '6222021001005530784', '谭陶');
INSERT INTO `xl_bankinfos` VALUES ('24', '513', '招商银行', 'CMB', '6214830216003722', '周益');
INSERT INTO `xl_bankinfos` VALUES ('25', '551', '中国工商银行', 'ICBC', '6222021001005530777', '陈培');
INSERT INTO `xl_bankinfos` VALUES ('26', '549', '中国工商银行', 'ICBC', '6212261001089642232', '陈雪丽');

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
) ENGINE=MyISAM AUTO_INCREMENT=389 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_buylist
-- ----------------------------
INSERT INTO `xl_buylist` VALUES ('303', '4200000119201804309579621370', '塑时代品牌合作', '1525078007', '0', '0', '0', 'buy', '549', '100.00', '114', '0', '3', '0', '0', '1', '1525078882');
INSERT INTO `xl_buylist` VALUES ('304', '4200000113201804308782778677', '塑时代品牌合作', '1525078736', '0', '0', '0', 'buy', '549', '100.00', '114', '0', '3', '0', '0', '1', '1525078883');
INSERT INTO `xl_buylist` VALUES ('305', '4200000129201804309273869173', '塑时代品牌合作', '1525079063', '0', '0', '0', 'buy', '549', '100.00', '114', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('309', '4200000131201805020532564178', '塑时代品牌合作', '1525230817', '0', '0', '0', 'buy', '512', '1.00', '114', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('310', '4200000138201805020913861038', '塑时代品牌合作', '1525230856', '0', '0', '0', 'buy', '512', '1.00', '114', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('326', '4200000129201805021140448497', '塑时代品牌合作', '1525246436', '0', '0', '0', 'buy', '549', '100.00', '114', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('373', '4200000125201807231677136389', '380元体验套餐', '1532321081', '6', '2', '0', 'buy', '515', '38000.00', '107', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('380', '4200000114201807289389768011', '198元塑时代瘦身卡', '1532771631', '0', '2', '0', 'buy', '538', '100.00', '108', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('388', '4200000171201808057007197952', '净化调理体验套（淋巴）', '1533460826', '1', '0', '0', 'buy', '775', '1.00', '162', '0', '0', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('387', '4200000187201808043663159779', '商品测试', '1533355018', '0', '1', '0', 'buy', '515', '1000.00', '175', '0', '1', '0', '0', '1', '');
INSERT INTO `xl_buylist` VALUES ('386', '4200000160201808044490985984', '商品测试', '1533354879', '0', '0', '0', 'buy', '515', '1000.00', '175', '0', '0', '0', '0', '1', '');

-- ----------------------------
-- Table structure for xl_buy_agent_goods
-- ----------------------------
DROP TABLE IF EXISTS `xl_buy_agent_goods`;
CREATE TABLE `xl_buy_agent_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agentid` int(11) NOT NULL DEFAULT '0',
  `buyerid` int(11) NOT NULL DEFAULT '0' COMMENT '购买者编号',
  `buytime` int(11) NOT NULL DEFAULT '0' COMMENT '购买时间',
  `handletime` int(11) NOT NULL DEFAULT '0' COMMENT '处理上时间',
  `buyid` int(11) NOT NULL COMMENT '订单编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_buy_agent_goods
-- ----------------------------
INSERT INTO `xl_buy_agent_goods` VALUES ('1', '326', '512', '1524971398', '1525229855', '307');
INSERT INTO `xl_buy_agent_goods` VALUES ('2', '326', '512', '1525230656', '0', '308');
INSERT INTO `xl_buy_agent_goods` VALUES ('3', '514', '512', '1525230817', '0', '309');
INSERT INTO `xl_buy_agent_goods` VALUES ('4', '514', '512', '1525230856', '0', '310');
INSERT INTO `xl_buy_agent_goods` VALUES ('5', '550', '512', '1525232470', '1525232685', '311');
INSERT INTO `xl_buy_agent_goods` VALUES ('6', '550', '512', '1525232488', '1525232723', '312');
INSERT INTO `xl_buy_agent_goods` VALUES ('7', '550', '512', '1525232643', '1525232732', '313');
INSERT INTO `xl_buy_agent_goods` VALUES ('8', '550', '512', '1525232643', '1525232736', '314');
INSERT INTO `xl_buy_agent_goods` VALUES ('9', '550', '512', '1525232643', '1525232765', '315');
INSERT INTO `xl_buy_agent_goods` VALUES ('10', '550', '512', '1525232643', '1525246218', '316');
INSERT INTO `xl_buy_agent_goods` VALUES ('11', '550', '512', '1525232643', '0', '317');
INSERT INTO `xl_buy_agent_goods` VALUES ('12', '550', '512', '1525232643', '1525254762', '318');
INSERT INTO `xl_buy_agent_goods` VALUES ('13', '550', '512', '1525232643', '1525232902', '319');
INSERT INTO `xl_buy_agent_goods` VALUES ('14', '550', '512', '1525232643', '1525232892', '320');
INSERT INTO `xl_buy_agent_goods` VALUES ('15', '550', '512', '1525232643', '1525232858', '321');
INSERT INTO `xl_buy_agent_goods` VALUES ('16', '550', '512', '1525232643', '1525232888', '322');
INSERT INTO `xl_buy_agent_goods` VALUES ('17', '550', '512', '1525245883', '0', '323');
INSERT INTO `xl_buy_agent_goods` VALUES ('18', '550', '512', '1525245930', '1525246201', '324');
INSERT INTO `xl_buy_agent_goods` VALUES ('19', '550', '512', '1525245930', '1525246178', '325');
INSERT INTO `xl_buy_agent_goods` VALUES ('20', '514', '549', '1525246436', '0', '326');
INSERT INTO `xl_buy_agent_goods` VALUES ('21', '550', '549', '1525435667', '0', '336');
INSERT INTO `xl_buy_agent_goods` VALUES ('22', '550', '549', '1526136555', '0', '338');
INSERT INTO `xl_buy_agent_goods` VALUES ('23', '550', '549', '1526173641', '0', '339');
INSERT INTO `xl_buy_agent_goods` VALUES ('24', '550', '549', '1526173641', '0', '340');
INSERT INTO `xl_buy_agent_goods` VALUES ('25', '550', '549', '1526173641', '0', '341');
INSERT INTO `xl_buy_agent_goods` VALUES ('26', '550', '549', '1526173641', '0', '342');
INSERT INTO `xl_buy_agent_goods` VALUES ('27', '550', '549', '1526260633', '0', '343');
INSERT INTO `xl_buy_agent_goods` VALUES ('28', '550', '549', '1526990352', '0', '344');
INSERT INTO `xl_buy_agent_goods` VALUES ('29', '550', '512', '1527840384', '0', '345');
INSERT INTO `xl_buy_agent_goods` VALUES ('30', '514', '512', '1532240158', '0', '371');
INSERT INTO `xl_buy_agent_goods` VALUES ('31', '514', '515', '1532321081', '0', '373');
INSERT INTO `xl_buy_agent_goods` VALUES ('32', '514', '549', '1532606348', '0', '378');
INSERT INTO `xl_buy_agent_goods` VALUES ('33', '514', '515', '1533354879', '0', '386');
INSERT INTO `xl_buy_agent_goods` VALUES ('34', '514', '515', '1533355018', '0', '387');
INSERT INTO `xl_buy_agent_goods` VALUES ('35', '514', '775', '1533460826', '0', '388');

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
) ENGINE=MyISAM AUTO_INCREMENT=407 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_clientslist
-- ----------------------------
INSERT INTO `xl_clientslist` VALUES ('318', '516', '646', '1525318213', '514');
INSERT INTO `xl_clientslist` VALUES ('364', '646', '747', '1527663227', '514');
INSERT INTO `xl_clientslist` VALUES ('325', '551', '550', '1525340788', '550');
INSERT INTO `xl_clientslist` VALUES ('397', '512', '514', '1532679975', '514');
INSERT INTO `xl_clientslist` VALUES ('401', '513', '514', '1533354786', '514');
INSERT INTO `xl_clientslist` VALUES ('391', '844', '514', '1532512790', '514');
INSERT INTO `xl_clientslist` VALUES ('365', '780', '514', '1528177865', '514');
INSERT INTO `xl_clientslist` VALUES ('316', '646', '514', '1525317872', '514');
INSERT INTO `xl_clientslist` VALUES ('319', '649', '646', '1525320461', '514');
INSERT INTO `xl_clientslist` VALUES ('320', '552', '646', '1525324609', '514');
INSERT INTO `xl_clientslist` VALUES ('321', '547', '646', '1525324616', '514');
INSERT INTO `xl_clientslist` VALUES ('322', '527', '646', '1525324738', '514');
INSERT INTO `xl_clientslist` VALUES ('323', '657', '646', '1525333638', '514');
INSERT INTO `xl_clientslist` VALUES ('328', '711', '646', '1525424307', '514');
INSERT INTO `xl_clientslist` VALUES ('329', '702', '646', '1525590178', '514');
INSERT INTO `xl_clientslist` VALUES ('346', '724', '514', '1526721564', '514');
INSERT INTO `xl_clientslist` VALUES ('399', '850', '514', '1532931439', '514');
INSERT INTO `xl_clientslist` VALUES ('333', '744', '514', '1526365169', '514');
INSERT INTO `xl_clientslist` VALUES ('334', '744', '747', '1526365169', '514');
INSERT INTO `xl_clientslist` VALUES ('341', '750', '514', '1526698876', '514');
INSERT INTO `xl_clientslist` VALUES ('344', '747', '514', '1526721169', '514');
INSERT INTO `xl_clientslist` VALUES ('337', '748', '514', '1526617042', '514');
INSERT INTO `xl_clientslist` VALUES ('338', '748', '747', '1526617042', '514');
INSERT INTO `xl_clientslist` VALUES ('342', '752', '514', '1526713712', '514');
INSERT INTO `xl_clientslist` VALUES ('343', '752', '747', '1526713712', '514');
INSERT INTO `xl_clientslist` VALUES ('347', '724', '747', '1526721564', '514');
INSERT INTO `xl_clientslist` VALUES ('348', '753', '514', '1526722300', '514');
INSERT INTO `xl_clientslist` VALUES ('349', '753', '747', '1526722300', '514');
INSERT INTO `xl_clientslist` VALUES ('350', '754', '514', '1526796139', '514');
INSERT INTO `xl_clientslist` VALUES ('351', '754', '747', '1526796139', '514');
INSERT INTO `xl_clientslist` VALUES ('352', '757', '514', '1526967377', '514');
INSERT INTO `xl_clientslist` VALUES ('353', '757', '747', '1526967377', '514');
INSERT INTO `xl_clientslist` VALUES ('354', '759', '514', '1527051550', '514');
INSERT INTO `xl_clientslist` VALUES ('355', '759', '747', '1527051550', '514');
INSERT INTO `xl_clientslist` VALUES ('356', '764', '514', '1527315799', '514');
INSERT INTO `xl_clientslist` VALUES ('357', '764', '747', '1527315799', '514');
INSERT INTO `xl_clientslist` VALUES ('358', '766', '514', '1527395536', '514');
INSERT INTO `xl_clientslist` VALUES ('359', '766', '747', '1527395536', '514');
INSERT INTO `xl_clientslist` VALUES ('360', '767', '514', '1527495113', '514');
INSERT INTO `xl_clientslist` VALUES ('361', '767', '747', '1527495113', '514');
INSERT INTO `xl_clientslist` VALUES ('362', '761', '514', '1527563058', '514');
INSERT INTO `xl_clientslist` VALUES ('363', '761', '747', '1527563058', '514');
INSERT INTO `xl_clientslist` VALUES ('366', '780', '747', '1528177865', '514');
INSERT INTO `xl_clientslist` VALUES ('368', '781', '514', '1528263926', '514');
INSERT INTO `xl_clientslist` VALUES ('369', '781', '747', '1528263926', '514');
INSERT INTO `xl_clientslist` VALUES ('370', '774', '514', '1528274119', '514');
INSERT INTO `xl_clientslist` VALUES ('371', '774', '747', '1528274119', '514');
INSERT INTO `xl_clientslist` VALUES ('372', '782', '514', '1528284552', '514');
INSERT INTO `xl_clientslist` VALUES ('373', '790', '514', '1528961432', '514');
INSERT INTO `xl_clientslist` VALUES ('374', '790', '747', '1528961432', '514');
INSERT INTO `xl_clientslist` VALUES ('375', '777', '514', '1529042104', '514');
INSERT INTO `xl_clientslist` VALUES ('376', '777', '747', '1529042104', '514');
INSERT INTO `xl_clientslist` VALUES ('390', '652', '747', '1532505751', '514');
INSERT INTO `xl_clientslist` VALUES ('379', '842', '514', '1532498841', '514');
INSERT INTO `xl_clientslist` VALUES ('389', '652', '514', '1532505751', '514');
INSERT INTO `xl_clientslist` VALUES ('388', '538', '514', '1532502631', '514');
INSERT INTO `xl_clientslist` VALUES ('392', '844', '747', '1532512790', '514');
INSERT INTO `xl_clientslist` VALUES ('393', '730', '514', '1532571999', '514');
INSERT INTO `xl_clientslist` VALUES ('394', '730', '747', '1532571999', '514');
INSERT INTO `xl_clientslist` VALUES ('395', '800', '514', '1532667330', '514');
INSERT INTO `xl_clientslist` VALUES ('396', '800', '747', '1532667330', '514');
INSERT INTO `xl_clientslist` VALUES ('398', '775', '514', '1532680990', '514');
INSERT INTO `xl_clientslist` VALUES ('400', '850', '747', '1532931439', '514');
INSERT INTO `xl_clientslist` VALUES ('402', '549', '514', '1533354838', '514');
INSERT INTO `xl_clientslist` VALUES ('403', '549', '513', '1533354838', '514');
INSERT INTO `xl_clientslist` VALUES ('404', '772', '514', '1533355010', '514');
INSERT INTO `xl_clientslist` VALUES ('405', '549', '772', '1533355031', '514');
INSERT INTO `xl_clientslist` VALUES ('406', '515', '549', '1533355236', '514');

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
) ENGINE=MyISAM AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_consumelist
-- ----------------------------
INSERT INTO `xl_consumelist` VALUES ('121', '52', '1', '515', '1533355236', '', '515', '175', '387', '549');
INSERT INTO `xl_consumelist` VALUES ('120', '36', '1', '702', '1525590285', '', '702', '100', '334', '646');
INSERT INTO `xl_consumelist` VALUES ('119', '34', '1', '702', '1525590178', '', '702', '100', '334', '646');
INSERT INTO `xl_consumelist` VALUES ('118', '35', '1', '711', '1525424323', '', '711', '100', '335', '646');
INSERT INTO `xl_consumelist` VALUES ('117', '41', '1', '711', '1525424307', '', '711', '100', '335', '646');
INSERT INTO `xl_consumelist` VALUES ('116', '41', '1', '657', '1525333638', '', '657', '100', '333', '646');
INSERT INTO `xl_consumelist` VALUES ('115', '41', '1', '527', '1525324738', '', '527', '100', '331', '646');
INSERT INTO `xl_consumelist` VALUES ('114', '41', '1', '547', '1525324616', '', '547', '100', '330', '646');
INSERT INTO `xl_consumelist` VALUES ('113', '41', '1', '552', '1525324609', '', '552', '100', '329', '646');
INSERT INTO `xl_consumelist` VALUES ('112', '41', '1', '649', '1525320461', '', '649', '100', '328', '646');
INSERT INTO `xl_consumelist` VALUES ('111', '35', '1', '516', '1525318213', '', '516', '100', '327', '646');
INSERT INTO `xl_consumelist` VALUES ('110', '5', '1', '550', '1525084195', '', '550', '88', '302', '551');
INSERT INTO `xl_consumelist` VALUES ('109', '5', '1', '550', '1525082454', '', '550', '88', '306', '551');

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
) ENGINE=MyISAM AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_coupon
-- ----------------------------
INSERT INTO `xl_coupon` VALUES ('63', '娇香美臀调理套（臀疗）', '', 'img/coupon/20180801/nx_1533098662684.jpg', '1', null, '0', '5184000', '1533098662');
INSERT INTO `xl_coupon` VALUES ('64', '唤醒净化调理套（淋巴）', '', 'img/coupon/20180801/nx_1533098719102.jpg', '1', null, '0', '5184000', '1533098719');
INSERT INTO `xl_coupon` VALUES ('66', '美韵凝润调理套（丰挺）', '', 'img/coupon/20180801/nx_1533098852122.jpg', '1', null, '0', '5184000', '1533098852');
INSERT INTO `xl_coupon` VALUES ('67', '美韵润养调理套（紧致）', '', 'img/coupon/20180801/nx_1533098903635.jpg', '1', null, '0', '5184000', '1533098903');
INSERT INTO `xl_coupon` VALUES ('68', '美韵净化调理套（疏通）', '', 'img/coupon/20180801/nx_1533098948510.jpg', '1', null, '0', '5184000', '1533098948');
INSERT INTO `xl_coupon` VALUES ('69', '美韵唤醒调理套（激活）', '', 'img/coupon/20180801/nx_1533098988727.jpg', '1', null, '0', '5184000', '1533098988');
INSERT INTO `xl_coupon` VALUES ('70', '体雕玲珑修护套', '', 'img/coupon/20180801/nx_1533099956663.jpg', '1', null, '0', '5184000', '1533099956');
INSERT INTO `xl_coupon` VALUES ('71', '美韵唤醒体验套（激活）', '', 'img/coupon/20180801/nx_1533100414148.jpg', '1', null, '0', '5184000', '1533100414');
INSERT INTO `xl_coupon` VALUES ('72', '净化调理体验套（淋巴）', '', 'img/coupon/20180801/nx_1533100800367.jpg', '1', null, '0', '5184000', '1533100800');
INSERT INTO `xl_coupon` VALUES ('73', '霖湫玻尿酸原浆套', '', 'img/coupon/20180801/nx_1533101187276.jpg', '1', null, '0', '5184000', '1533101187');
INSERT INTO `xl_coupon` VALUES ('74', '霖湫玻尿酸原浆套', '', 'img/coupon/20180801/nx_1533101418992.jpg', '1', null, '0', '5184000', '1533101418');
INSERT INTO `xl_coupon` VALUES ('75', '发酵玻尿酸补水面膜（才木始）', '', 'img/coupon/20180801/nx_1533102906596.jpg', '1', null, '0', '5184000', '1533102906');
INSERT INTO `xl_coupon` VALUES ('76', '科妍洁面乳（才木始）', '', 'img/coupon/20180801/nx_1533103772582.jpg', '1', null, '0', '5184000', '1533103772');
INSERT INTO `xl_coupon` VALUES ('77', '塑时代调理药包', '', 'img/coupon/20180801/nx_1533105266777.jpg', '1', null, '0', '5184000', '1533105266');
INSERT INTO `xl_coupon` VALUES ('78', '美韵家居套', '', 'img/coupon/20180801/nx_1533117334115.jpg', '1', null, '0', '5184000', '1533117334');
INSERT INTO `xl_coupon` VALUES ('79', '温灸膏', '', 'img/coupon/20180801/nx_1533117841420.jpg', '1', null, '0', '5184000', '1533117841');
INSERT INTO `xl_coupon` VALUES ('80', '198元塑时代胸部激活卡', '', 'img/coupon/20180808/nx_1533714904743.jpg', '2', null, '0', '5184000', '1533714904');
INSERT INTO `xl_coupon` VALUES ('82', '198元塑时代淋巴净化卡', '', 'img/coupon/20180808/nx_1533715036953.jpg', '2', null, '0', '5184000', '1533715036');
INSERT INTO `xl_coupon` VALUES ('83', '198元塑时代娇香美臀卡', '', 'img/coupon/20180808/nx_1533715067224.jpg', '2', null, '0', '5184000', '1533715067');
INSERT INTO `xl_coupon` VALUES ('44', '380元塑时代礼品卡', '', 'img/coupon/20180429/nx_1524986359969.png', '2', null, '0', '5184000', '1524986359');
INSERT INTO `xl_coupon` VALUES ('45', '380元塑时代礼品卡', '', 'img/coupon/20180429/nx_1524986376698.png', '2', null, '0', '5184000', '1524986376');
INSERT INTO `xl_coupon` VALUES ('46', '380元塑时代礼品卡', '', 'img/coupon/20180429/nx_1524986395949.png', '1', null, '0', '5184000', '1524986395');
INSERT INTO `xl_coupon` VALUES ('47', '380元塑时代礼品卡', '', 'img/coupon/20180429/nx_1524986429798.png', '1', null, '0', '5184000', '1524986429');
INSERT INTO `xl_coupon` VALUES ('48', '380元塑时代礼品卡', '', 'img/coupon/20180429/nx_1524986448639.png', '1', null, '0', '5184000', '1524986448');
INSERT INTO `xl_coupon` VALUES ('49', '380元塑时代礼品卡', '', 'img/coupon/20180429/nx_1524986466942.png', '1', null, '0', '5184000', '1524986466');
INSERT INTO `xl_coupon` VALUES ('50', '380元塑时代礼品卡', '', 'img/coupon/20180429/nx_1524986482124.png', '1', null, '0', '5184000', '1524986482');
INSERT INTO `xl_coupon` VALUES ('51', '380元塑时代礼品卡', '', 'img/coupon/20180429/nx_1524986506840.png', '1', null, '0', '5184000', '1524986506');
INSERT INTO `xl_coupon` VALUES ('52', '198元塑时代瘦身卡', '', 'img/coupon/20180429/nx_1524986863613.png', '2', null, '0', '5184000', '1524986863');
INSERT INTO `xl_coupon` VALUES ('53', '198元塑时代瘦身卡', '', 'img/coupon/20180429/nx_1524986881754.png', '2', null, '0', '5184000', '1524986881');

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
) ENGINE=MyISAM AUTO_INCREMENT=1405 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_couponlist
-- ----------------------------
INSERT INTO `xl_couponlist` VALUES ('1268', '34', '516', '1525318165', '1527910165', '1', '100', '327');
INSERT INTO `xl_couponlist` VALUES ('1267', '36', '516', '1525318165', '1527910165', '1', '100', '327');
INSERT INTO `xl_couponlist` VALUES ('1273', '37', '649', '1525320357', '1527912357', '1', '100', '328');
INSERT INTO `xl_couponlist` VALUES ('1265', '37', '516', '1525318165', '1527910165', '1', '100', '327');
INSERT INTO `xl_couponlist` VALUES ('1264', '7', '512', '1525245930', '1533021930', '1', '23', '325');
INSERT INTO `xl_couponlist` VALUES ('1263', '7', '512', '1525245930', '1533021930', '1', '23', '324');
INSERT INTO `xl_couponlist` VALUES ('1262', '7', '512', '1525245883', '1533021883', '1', '23', '323');
INSERT INTO `xl_couponlist` VALUES ('1261', '7', '512', '1525232643', '1533008643', '1', '23', '322');
INSERT INTO `xl_couponlist` VALUES ('1260', '7', '512', '1525232643', '1533008643', '1', '23', '321');
INSERT INTO `xl_couponlist` VALUES ('1259', '7', '512', '1525232643', '1533008643', '1', '23', '320');
INSERT INTO `xl_couponlist` VALUES ('1258', '7', '512', '1525232643', '1533008643', '1', '23', '319');
INSERT INTO `xl_couponlist` VALUES ('1257', '7', '512', '1525232643', '1533008643', '1', '23', '318');
INSERT INTO `xl_couponlist` VALUES ('1256', '7', '512', '1525232643', '1533008643', '1', '23', '317');
INSERT INTO `xl_couponlist` VALUES ('1255', '7', '512', '1525232643', '1533008643', '1', '23', '316');
INSERT INTO `xl_couponlist` VALUES ('1254', '7', '512', '1525232643', '1533008643', '1', '23', '315');
INSERT INTO `xl_couponlist` VALUES ('1253', '7', '512', '1525232643', '1533008643', '1', '23', '314');
INSERT INTO `xl_couponlist` VALUES ('1252', '7', '512', '1525232643', '1533008643', '1', '23', '313');
INSERT INTO `xl_couponlist` VALUES ('1251', '9', '512', '1525232488', '1538192488', '1', '22', '312');
INSERT INTO `xl_couponlist` VALUES ('1250', '7', '512', '1525232470', '1533008470', '1', '23', '311');
INSERT INTO `xl_couponlist` VALUES ('1249', '4', '512', '1525230656', '1530414656', '1', '31', '308');
INSERT INTO `xl_couponlist` VALUES ('1248', '4', '512', '1525226203', '1530410203', '1', '31', '307');
INSERT INTO `xl_couponlist` VALUES ('1245', '43', '514', '1524971398', '1527563398', '1', '101', '301');
INSERT INTO `xl_couponlist` VALUES ('1244', '42', '514', '1524971398', '1530155398', '1', '101', '301');
INSERT INTO `xl_couponlist` VALUES ('1243', '5', '513', '1524965488', '1527557488', '1', '88', '300');
INSERT INTO `xl_couponlist` VALUES ('1242', '41', '533', '1524893918', '1527485918', '1', '100', '299');
INSERT INTO `xl_couponlist` VALUES ('1241', '40', '533', '1524893918', '1527485918', '1', '100', '299');
INSERT INTO `xl_couponlist` VALUES ('1240', '39', '533', '1524893918', '1527485918', '1', '100', '299');
INSERT INTO `xl_couponlist` VALUES ('1239', '38', '533', '1524893918', '1527485918', '1', '100', '299');
INSERT INTO `xl_couponlist` VALUES ('1238', '34', '533', '1524893918', '1527485918', '1', '100', '299');
INSERT INTO `xl_couponlist` VALUES ('1237', '36', '533', '1524893918', '1527485918', '1', '100', '299');
INSERT INTO `xl_couponlist` VALUES ('1236', '35', '533', '1524893918', '1527485918', '1', '100', '299');
INSERT INTO `xl_couponlist` VALUES ('1235', '37', '533', '1524893918', '1527485918', '1', '100', '299');
INSERT INTO `xl_couponlist` VALUES ('1234', '41', '514', '1524843000', '1527435000', '1', '100', '298');
INSERT INTO `xl_couponlist` VALUES ('1233', '40', '514', '1524843000', '1527435000', '1', '100', '298');
INSERT INTO `xl_couponlist` VALUES ('1232', '39', '514', '1524843000', '1527435000', '1', '100', '298');
INSERT INTO `xl_couponlist` VALUES ('1231', '38', '514', '1524843000', '1527435000', '1', '100', '298');
INSERT INTO `xl_couponlist` VALUES ('1230', '34', '514', '1524843000', '1527435000', '1', '100', '298');
INSERT INTO `xl_couponlist` VALUES ('1229', '36', '514', '1524843000', '1527435000', '1', '100', '298');
INSERT INTO `xl_couponlist` VALUES ('1228', '35', '514', '1524843000', '1527435000', '1', '100', '298');
INSERT INTO `xl_couponlist` VALUES ('1227', '37', '514', '1524843000', '1527435000', '1', '100', '298');
INSERT INTO `xl_couponlist` VALUES ('1226', '5', '513', '1524820544', '1527412544', '1', '88', '297');
INSERT INTO `xl_couponlist` VALUES ('1225', '5', '513', '1524651356', '1527243356', '1', '88', '296');
INSERT INTO `xl_couponlist` VALUES ('1224', '5', '512', '1524649129', '1527241129', '1', '88', '295');
INSERT INTO `xl_couponlist` VALUES ('1269', '38', '516', '1525318165', '1527910165', '1', '100', '327');
INSERT INTO `xl_couponlist` VALUES ('1270', '39', '516', '1525318165', '1527910165', '1', '100', '327');
INSERT INTO `xl_couponlist` VALUES ('1271', '40', '516', '1525318165', '1527910165', '1', '100', '327');
INSERT INTO `xl_couponlist` VALUES ('1272', '41', '516', '1525318165', '1527910165', '1', '100', '327');
INSERT INTO `xl_couponlist` VALUES ('1274', '35', '649', '1525320357', '1527912357', '1', '100', '328');
INSERT INTO `xl_couponlist` VALUES ('1275', '36', '649', '1525320357', '1527912357', '1', '100', '328');
INSERT INTO `xl_couponlist` VALUES ('1276', '34', '649', '1525320357', '1527912357', '1', '100', '328');
INSERT INTO `xl_couponlist` VALUES ('1277', '38', '649', '1525320357', '1527912357', '1', '100', '328');
INSERT INTO `xl_couponlist` VALUES ('1278', '39', '649', '1525320357', '1527912357', '1', '100', '328');
INSERT INTO `xl_couponlist` VALUES ('1279', '40', '649', '1525320357', '1527912357', '1', '100', '328');
INSERT INTO `xl_couponlist` VALUES ('1281', '37', '552', '1525324551', '1527916551', '1', '100', '329');
INSERT INTO `xl_couponlist` VALUES ('1282', '35', '552', '1525324551', '1527916551', '1', '100', '329');
INSERT INTO `xl_couponlist` VALUES ('1283', '36', '552', '1525324551', '1527916551', '1', '100', '329');
INSERT INTO `xl_couponlist` VALUES ('1284', '34', '552', '1525324551', '1527916551', '1', '100', '329');
INSERT INTO `xl_couponlist` VALUES ('1285', '38', '552', '1525324551', '1527916551', '1', '100', '329');
INSERT INTO `xl_couponlist` VALUES ('1286', '39', '552', '1525324551', '1527916551', '1', '100', '329');
INSERT INTO `xl_couponlist` VALUES ('1287', '40', '552', '1525324551', '1527916551', '1', '100', '329');
INSERT INTO `xl_couponlist` VALUES ('1307', '36', '520', '1525324839', '1527916839', '1', '100', '332');
INSERT INTO `xl_couponlist` VALUES ('1289', '37', '547', '1525324558', '1527916558', '1', '100', '330');
INSERT INTO `xl_couponlist` VALUES ('1290', '35', '547', '1525324558', '1527916558', '1', '100', '330');
INSERT INTO `xl_couponlist` VALUES ('1291', '36', '547', '1525324558', '1527916558', '1', '100', '330');
INSERT INTO `xl_couponlist` VALUES ('1292', '34', '547', '1525324558', '1527916558', '1', '100', '330');
INSERT INTO `xl_couponlist` VALUES ('1293', '38', '547', '1525324558', '1527916558', '1', '100', '330');
INSERT INTO `xl_couponlist` VALUES ('1294', '39', '547', '1525324558', '1527916558', '1', '100', '330');
INSERT INTO `xl_couponlist` VALUES ('1295', '40', '547', '1525324558', '1527916558', '1', '100', '330');
INSERT INTO `xl_couponlist` VALUES ('1306', '35', '520', '1525324839', '1527916839', '1', '100', '332');
INSERT INTO `xl_couponlist` VALUES ('1297', '37', '527', '1525324558', '1527916558', '1', '100', '331');
INSERT INTO `xl_couponlist` VALUES ('1298', '35', '527', '1525324558', '1527916558', '1', '100', '331');
INSERT INTO `xl_couponlist` VALUES ('1299', '36', '527', '1525324558', '1527916558', '1', '100', '331');
INSERT INTO `xl_couponlist` VALUES ('1300', '34', '527', '1525324558', '1527916558', '1', '100', '331');
INSERT INTO `xl_couponlist` VALUES ('1301', '38', '527', '1525324558', '1527916558', '1', '100', '331');
INSERT INTO `xl_couponlist` VALUES ('1302', '39', '527', '1525324558', '1527916558', '1', '100', '331');
INSERT INTO `xl_couponlist` VALUES ('1303', '40', '527', '1525324558', '1527916558', '1', '100', '331');
INSERT INTO `xl_couponlist` VALUES ('1305', '37', '520', '1525324839', '1527916839', '1', '100', '332');
INSERT INTO `xl_couponlist` VALUES ('1308', '34', '520', '1525324839', '1527916839', '1', '100', '332');
INSERT INTO `xl_couponlist` VALUES ('1309', '38', '520', '1525324839', '1527916839', '1', '100', '332');
INSERT INTO `xl_couponlist` VALUES ('1310', '39', '520', '1525324839', '1527916839', '1', '100', '332');
INSERT INTO `xl_couponlist` VALUES ('1311', '40', '520', '1525324839', '1527916839', '1', '100', '332');
INSERT INTO `xl_couponlist` VALUES ('1312', '41', '520', '1525324839', '1527916839', '1', '100', '332');
INSERT INTO `xl_couponlist` VALUES ('1313', '37', '657', '1525333400', '1527925400', '1', '100', '333');
INSERT INTO `xl_couponlist` VALUES ('1314', '35', '657', '1525333400', '1527925400', '1', '100', '333');
INSERT INTO `xl_couponlist` VALUES ('1315', '36', '657', '1525333400', '1527925400', '1', '100', '333');
INSERT INTO `xl_couponlist` VALUES ('1316', '34', '657', '1525333400', '1527925400', '1', '100', '333');
INSERT INTO `xl_couponlist` VALUES ('1317', '38', '657', '1525333400', '1527925400', '1', '100', '333');
INSERT INTO `xl_couponlist` VALUES ('1318', '39', '657', '1525333400', '1527925400', '1', '100', '333');
INSERT INTO `xl_couponlist` VALUES ('1319', '40', '657', '1525333400', '1527925400', '1', '100', '333');
INSERT INTO `xl_couponlist` VALUES ('1321', '37', '702', '1525391796', '1527983796', '1', '100', '334');
INSERT INTO `xl_couponlist` VALUES ('1322', '35', '702', '1525391796', '1527983796', '1', '100', '334');
INSERT INTO `xl_couponlist` VALUES ('1338', '37', '729', '1525794351', '1528386351', '1', '100', '337');
INSERT INTO `xl_couponlist` VALUES ('1339', '35', '729', '1525794351', '1528386351', '1', '100', '337');
INSERT INTO `xl_couponlist` VALUES ('1325', '38', '702', '1525391796', '1527983796', '1', '100', '334');
INSERT INTO `xl_couponlist` VALUES ('1326', '39', '702', '1525391796', '1527983796', '1', '100', '334');
INSERT INTO `xl_couponlist` VALUES ('1327', '40', '702', '1525391796', '1527983796', '1', '100', '334');
INSERT INTO `xl_couponlist` VALUES ('1328', '41', '702', '1525391796', '1527983796', '1', '100', '334');
INSERT INTO `xl_couponlist` VALUES ('1329', '37', '711', '1525424281', '1528016281', '1', '100', '335');
INSERT INTO `xl_couponlist` VALUES ('1337', '7', '549', '1525435667', '1533211667', '1', '23', '336');
INSERT INTO `xl_couponlist` VALUES ('1331', '36', '711', '1525424281', '1528016281', '1', '100', '335');
INSERT INTO `xl_couponlist` VALUES ('1332', '34', '711', '1525424281', '1528016281', '1', '100', '335');
INSERT INTO `xl_couponlist` VALUES ('1333', '38', '711', '1525424281', '1528016281', '1', '100', '335');
INSERT INTO `xl_couponlist` VALUES ('1334', '39', '711', '1525424281', '1528016281', '1', '100', '335');
INSERT INTO `xl_couponlist` VALUES ('1335', '40', '711', '1525424281', '1528016281', '1', '100', '335');
INSERT INTO `xl_couponlist` VALUES ('1340', '36', '729', '1525794351', '1528386351', '1', '100', '337');
INSERT INTO `xl_couponlist` VALUES ('1341', '34', '729', '1525794351', '1528386351', '1', '100', '337');
INSERT INTO `xl_couponlist` VALUES ('1342', '38', '729', '1525794351', '1528386351', '1', '100', '337');
INSERT INTO `xl_couponlist` VALUES ('1343', '39', '729', '1525794351', '1528386351', '1', '100', '337');
INSERT INTO `xl_couponlist` VALUES ('1344', '40', '729', '1525794351', '1528386351', '1', '100', '337');
INSERT INTO `xl_couponlist` VALUES ('1345', '41', '729', '1525794351', '1528386351', '1', '100', '337');
INSERT INTO `xl_couponlist` VALUES ('1346', '7', '549', '1526136555', '1533912555', '1', '23', '338');
INSERT INTO `xl_couponlist` VALUES ('1347', '7', '549', '1526173641', '1533949641', '1', '23', '339');
INSERT INTO `xl_couponlist` VALUES ('1348', '7', '549', '1526173641', '1533949641', '1', '23', '340');
INSERT INTO `xl_couponlist` VALUES ('1349', '7', '549', '1526173641', '1533949641', '1', '23', '341');
INSERT INTO `xl_couponlist` VALUES ('1350', '7', '549', '1526173641', '1533949641', '1', '23', '342');
INSERT INTO `xl_couponlist` VALUES ('1351', '7', '549', '1526260633', '1534036633', '1', '23', '343');
INSERT INTO `xl_couponlist` VALUES ('1352', '7', '549', '1526990352', '1534766352', '1', '23', '344');
INSERT INTO `xl_couponlist` VALUES ('1353', '7', '512', '1527840384', '1535616384', '1', '23', '345');
INSERT INTO `xl_couponlist` VALUES ('1354', '5', '772', '1530417085', '1533009085', '1', '88', '346');
INSERT INTO `xl_couponlist` VALUES ('1355', '5', '772', '1530498972', '1533090972', '1', '88', '347');
INSERT INTO `xl_couponlist` VALUES ('1356', '5', '772', '1530586925', '1533178925', '1', '88', '348');
INSERT INTO `xl_couponlist` VALUES ('1357', '5', '772', '1530670490', '1533262490', '1', '88', '349');
INSERT INTO `xl_couponlist` VALUES ('1358', '5', '772', '1530753099', '1533345099', '1', '88', '350');
INSERT INTO `xl_couponlist` VALUES ('1359', '5', '772', '1530839184', '1533431184', '1', '88', '351');
INSERT INTO `xl_couponlist` VALUES ('1360', '5', '772', '1530928244', '1533520244', '1', '88', '352');
INSERT INTO `xl_couponlist` VALUES ('1361', '5', '772', '1531013321', '1533605321', '1', '88', '353');
INSERT INTO `xl_couponlist` VALUES ('1362', '5', '772', '1531098847', '1533690847', '1', '88', '354');
INSERT INTO `xl_couponlist` VALUES ('1363', '5', '724', '1531099430', '1533691430', '1', '88', '355');
INSERT INTO `xl_couponlist` VALUES ('1364', '5', '772', '1531230508', '1533822508', '1', '88', '356');
INSERT INTO `xl_couponlist` VALUES ('1365', '5', '772', '1531270898', '1533862898', '1', '88', '357');
INSERT INTO `xl_couponlist` VALUES ('1366', '5', '772', '1531358454', '1533950454', '1', '88', '358');
INSERT INTO `xl_couponlist` VALUES ('1367', '5', '772', '1531437108', '1534029108', '1', '88', '359');
INSERT INTO `xl_couponlist` VALUES ('1368', '5', '772', '1531529583', '1534121583', '1', '88', '360');
INSERT INTO `xl_couponlist` VALUES ('1369', '5', '772', '1531629570', '1534221570', '1', '88', '361');
INSERT INTO `xl_couponlist` VALUES ('1370', '5', '772', '1531718514', '1534310514', '1', '88', '362');
INSERT INTO `xl_couponlist` VALUES ('1371', '5', '512', '1531729917', '1534321917', '1', '88', '363');
INSERT INTO `xl_couponlist` VALUES ('1372', '5', '513', '1531731576', '1534323576', '1', '88', '364');
INSERT INTO `xl_couponlist` VALUES ('1373', '5', '772', '1531798112', '1534390112', '1', '88', '365');
INSERT INTO `xl_couponlist` VALUES ('1374', '5', '772', '1531879328', '1534471328', '1', '88', '366');
INSERT INTO `xl_couponlist` VALUES ('1375', '5', '772', '1531962368', '1534554368', '1', '88', '367');
INSERT INTO `xl_couponlist` VALUES ('1376', '5', '772', '1532044196', '1534636196', '1', '88', '368');
INSERT INTO `xl_couponlist` VALUES ('1377', '5', '772', '1532143132', '1534735132', '1', '88', '369');
INSERT INTO `xl_couponlist` VALUES ('1378', '5', '772', '1532226812', '1534818812', '1', '88', '370');
INSERT INTO `xl_couponlist` VALUES ('1379', '54', '512', '1532240158', '1563344158', '1', '136', '371');
INSERT INTO `xl_couponlist` VALUES ('1380', '5', '772', '1532310292', '1534902292', '1', '88', '372');
INSERT INTO `xl_couponlist` VALUES ('1381', '51', '515', '1532321081', '1537505081', '1', '107', '373');
INSERT INTO `xl_couponlist` VALUES ('1382', '50', '515', '1532321081', '1537505081', '1', '107', '373');
INSERT INTO `xl_couponlist` VALUES ('1383', '49', '515', '1532321081', '1537505081', '1', '107', '373');
INSERT INTO `xl_couponlist` VALUES ('1384', '48', '515', '1532321081', '1537505081', '1', '107', '373');
INSERT INTO `xl_couponlist` VALUES ('1385', '47', '515', '1532321081', '1537505081', '1', '107', '373');
INSERT INTO `xl_couponlist` VALUES ('1386', '46', '515', '1532321081', '1537505081', '1', '107', '373');
INSERT INTO `xl_couponlist` VALUES ('1387', '45', '515', '1532321081', '1537505081', '1', '107', '373');
INSERT INTO `xl_couponlist` VALUES ('1388', '44', '515', '1532321081', '1537505081', '1', '107', '373');
INSERT INTO `xl_couponlist` VALUES ('1389', '5', '772', '1532396559', '1534988559', '1', '88', '374');
INSERT INTO `xl_couponlist` VALUES ('1390', '5', '772', '1532480573', '1535072573', '1', '88', '375');
INSERT INTO `xl_couponlist` VALUES ('1391', '5', '775', '1532502098', '1535094098', '1', '88', '376');
INSERT INTO `xl_couponlist` VALUES ('1392', '5', '772', '1532571145', '1535163145', '1', '88', '377');
INSERT INTO `xl_couponlist` VALUES ('1393', '55', '549', '1532606348', '1563710348', '1', '135', '378');
INSERT INTO `xl_couponlist` VALUES ('1394', '5', '772', '1532748482', '1535340482', '1', '88', '379');
INSERT INTO `xl_couponlist` VALUES ('1395', '52', '538', '1532771631', '1537955631', '1', '108', '380');
INSERT INTO `xl_couponlist` VALUES ('1396', '53', '538', '1532771631', '1537955631', '1', '108', '380');
INSERT INTO `xl_couponlist` VALUES ('1397', '5', '652', '1532829735', '1535421735', '1', '88', '381');
INSERT INTO `xl_couponlist` VALUES ('1398', '5', '513', '1532829885', '1535421885', '1', '88', '382');
INSERT INTO `xl_couponlist` VALUES ('1399', '5', '513', '1532830021', '1535422021', '1', '88', '383');
INSERT INTO `xl_couponlist` VALUES ('1400', '5', '772', '1532916483', '1535508483', '1', '88', '384');
INSERT INTO `xl_couponlist` VALUES ('1401', '5', '772', '1533016866', '1535608866', '1', '88', '385');
INSERT INTO `xl_couponlist` VALUES ('1404', '72', '775', '1533460826', '1538644826', '1', '162', '388');
INSERT INTO `xl_couponlist` VALUES ('1403', '53', '515', '1533355018', '1538539018', '1', '175', '387');

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
) ENGINE=MyISAM AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_coupontogoods
-- ----------------------------
INSERT INTO `xl_coupontogoods` VALUES ('114', '150', '63', '1');
INSERT INTO `xl_coupontogoods` VALUES ('125', '168', '77', '1');
INSERT INTO `xl_coupontogoods` VALUES ('126', '169', '78', '1');
INSERT INTO `xl_coupontogoods` VALUES ('133', '176', '82', '1');
INSERT INTO `xl_coupontogoods` VALUES ('134', '177', '83', '1');
INSERT INTO `xl_coupontogoods` VALUES ('124', '166', '76', '1');
INSERT INTO `xl_coupontogoods` VALUES ('130', '175', '52', '1');
INSERT INTO `xl_coupontogoods` VALUES ('127', '170', '79', '1');
INSERT INTO `xl_coupontogoods` VALUES ('96', '116', '0', '1');
INSERT INTO `xl_coupontogoods` VALUES ('122', '163', '73', '1');
INSERT INTO `xl_coupontogoods` VALUES ('121', '162', '72', '1');
INSERT INTO `xl_coupontogoods` VALUES ('120', '161', '71', '1');
INSERT INTO `xl_coupontogoods` VALUES ('119', '145', '69', '1');
INSERT INTO `xl_coupontogoods` VALUES ('118', '146', '68', '1');
INSERT INTO `xl_coupontogoods` VALUES ('117', '147', '67', '1');
INSERT INTO `xl_coupontogoods` VALUES ('116', '148', '66', '1');
INSERT INTO `xl_coupontogoods` VALUES ('129', '172', '75', '1');
INSERT INTO `xl_coupontogoods` VALUES ('115', '149', '64', '1');
INSERT INTO `xl_coupontogoods` VALUES ('131', '175', '53', '1');
INSERT INTO `xl_coupontogoods` VALUES ('86', '107', '51', '1');
INSERT INTO `xl_coupontogoods` VALUES ('87', '107', '50', '1');
INSERT INTO `xl_coupontogoods` VALUES ('88', '107', '49', '1');
INSERT INTO `xl_coupontogoods` VALUES ('89', '107', '48', '1');
INSERT INTO `xl_coupontogoods` VALUES ('90', '107', '47', '1');
INSERT INTO `xl_coupontogoods` VALUES ('91', '107', '46', '1');
INSERT INTO `xl_coupontogoods` VALUES ('92', '107', '45', '1');
INSERT INTO `xl_coupontogoods` VALUES ('93', '107', '44', '1');
INSERT INTO `xl_coupontogoods` VALUES ('94', '108', '52', '1');
INSERT INTO `xl_coupontogoods` VALUES ('95', '108', '53', '1');
INSERT INTO `xl_coupontogoods` VALUES ('132', '174', '80', '1');
INSERT INTO `xl_coupontogoods` VALUES ('123', '164', '75', '1');
INSERT INTO `xl_coupontogoods` VALUES ('128', '171', '76', '1');

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
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_depositlist
-- ----------------------------
INSERT INTO `xl_depositlist` VALUES ('51', '646', '515', '1', '1525317872', '4200000119201805031641952512', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('50', '549', '515', '1', '1525069555', '4200000136201804308979518482', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('52', '551', '512', '1', '1525340788', '4200000138201805031401275652', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('53', '744', '724', '1', '1526365169', '4200000110201805150241258995', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('54', '747', '724', '1', '1526544346', '4200000116201805171624251354', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('55', '748', '724', '1', '1526617042', '4200000118201805182032439710', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('56', '752', '747', '1', '1526713712', '4200000112201805193263273976', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('57', '724', '747', '1', '1526721564', '4200000127201805193271334627', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('58', '753', '747', '1', '1526722300', '4200000126201805193332662419', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('59', '754', '747', '1', '1526796139', '4200000137201805203783874258', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('60', '757', '747', '1', '1526967377', '4200000119201805221757038804', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('61', '759', '747', '1', '1527051550', '4200000121201805238629093682', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('62', '764', '747', '1', '1527315799', '4200000109201805264719852277', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('63', '766', '747', '1', '1527395536', '4200000134201805275653956902', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('64', '767', '747', '1', '1527495113', '4200000125201805288698148825', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('65', '761', '747', '1', '1527563058', '4200000120201805297617128248', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('66', '780', '747', '1', '1528177865', '4200000119201806058766640233', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('67', '781', '747', '1', '1528263926', '4200000110201806063204925014', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('68', '774', '747', '1', '1528274119', '4200000114201806068007960703', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('69', '790', '747', '1', '1528961432', '4200000124201806141986048883', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('70', '777', '747', '1', '1529042104', '4200000132201806153315563343', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('71', '538', '747', '1', '1532245760', '4200000118201807226670457705', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('72', '775', '512', '1', '1532500395', '4200000114201807251329316705', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('73', '775', '512', '1', '1532501909', '4200000120201807255933694169', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('74', '775', '512', '1', '1532502041', '4200000120201807256328494666', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('75', '652', '512', '1', '1532505751', '4200000111201807255090911561', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('76', '844', '512', '1', '1532512790', '4200000127201807251330082664', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('77', '730', '512', '1', '1532571999', '4200000133201807265209742246', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('78', '800', '512', '1', '1532667330', '4200000122201807276786673248', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('79', '850', '747', '1', '1532931439', '4200000120201807301946277389', '业务绑定商户押金', '1');
INSERT INTO `xl_depositlist` VALUES ('80', '549', '513', '1', '1533354838', '4200000177201808047239323388', '业务绑定商户押金', '1');

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
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_drawrecord
-- ----------------------------
INSERT INTO `xl_drawrecord` VALUES ('24', '775', '1533465644', '1533465644', '0.31', null);
INSERT INTO `xl_drawrecord` VALUES ('23', '550', '1533465477', '1533465477', '0.50', null);
INSERT INTO `xl_drawrecord` VALUES ('22', '512', '1533464777', '1533465215', '1.10', null);
INSERT INTO `xl_drawrecord` VALUES ('21', '512', '1533464921', '1533464921', '1.10', null);
INSERT INTO `xl_drawrecord` VALUES ('20', '512', '1533464808', '1533464808', '1.10', null);
INSERT INTO `xl_drawrecord` VALUES ('19', '775', '1533461470', '1533461470', '1.00', null);
INSERT INTO `xl_drawrecord` VALUES ('25', '512', '1533520560', '1533520560', '0.40', null);
INSERT INTO `xl_drawrecord` VALUES ('26', '551', '1533521271', '1533521271', '0.50', null);
INSERT INTO `xl_drawrecord` VALUES ('27', '513', '1533702341', '1533702341', '1.00', null);

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
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_extension
-- ----------------------------
INSERT INTO `xl_extension` VALUES ('66', '652', '513', '88', '1532829885');
INSERT INTO `xl_extension` VALUES ('65', '513', '538', '108', '1532771631');
INSERT INTO `xl_extension` VALUES ('64', '516', '702', '100', '1525391796');
INSERT INTO `xl_extension` VALUES ('63', '513', '514', '100', '1524843000');

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
) ENGINE=MyISAM AUTO_INCREMENT=179 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goods
-- ----------------------------
INSERT INTO `xl_goods` VALUES ('116', '私人定制拓客锁客', '多种拓客方式，针对不同情况店私人订制', '9800.00', '1', '1527825275', '0', '0.00', '0.05', '<p class=\"ql-align-center\">培训打造服务销售团队，扩大宣传社区影响力，增加新客户，锁客-留客-升客一体化服务，</p><p class=\"ql-align-center\"><br></p><p>拓客金额：9800元；&nbsp;返还产品：9800元（市值产品）</p><p><br></p><p>赠送产品：</p><p>1、胸部激活体验2套，可体验20次；市值价5980元</p><p>2、减肥局部套盒3套，可体验30次；市值价5040元</p><p>3、皮脂膜修复项目合作，打版10人；市值价5980元</p><p>4、臀疗淋巴套盒2套，可体验24次；市值价6560元</p><p>注：以上锁客产品赠送4选1</p><p><br></p><p>拓客老师安排：</p><p>拓客老师交通、食宿由店家承担；拓客卡每张奖励拓客老师10元</p><p><br></p><p><br></p><p class=\"ql-align-center\">拓客合作确认书</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">甲方：上海霖秋化妆品有限公司（以下简称甲方）</p><p class=\"ql-align-justify\">乙方：______________________（以下简称乙方）</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong>乙方已确认甲方所提供的《9800元拓客方案》的所有内容，并愿意与甲方进行合作，并于______年____月____日前打齐方案款9800元。</strong></p><p><br></p><p><strong>乙方在拓客过程中需按照甲方安排的拓客流程进行合作配合，如乙方未按照甲方安排的拓客流程进行合作配合，甲方有权收回对乙方的拓客承诺。</strong></p><p><br></p><p><strong>甲方对乙方拓客承诺：客户 30 人（少1人退款100元）</strong></p><p><br></p><p class=\"ql-align-justify\">甲方代表签字：____________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;乙方代表签字：____________</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">确认日期：</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><br></p>', '20', 'img/20180605/nx_1528207228217.jpg', '返还产品：9800元（市值产品）', '2', '2', '0', '0.95', '0', 'img/20180605/nx_1528207519256.jpg', '514', '0');
INSERT INTO `xl_goods` VALUES ('108', '198元塑时代瘦身卡', '女人需要拿的出手的身材', '198.00', '1', '1524986741', '0', '0.30', '0.00', '<p><img src=\"img/20180429/nx_1524986741689.png\"></p>', '10', 'img/20180808/nx_1533715598749.png', '', '1', '1', '0', '0.00', '1', 'img/20180808/nx_1533715598268.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('127', '商家首次体验版', '赠送10000市值产品，创造5-8万现金业绩', '1000.00', '1', '1531124018', '0', '0.00', '0.00', '<p>1000元新店推 案</p><p>案 额:<strong>1000</strong>元</p><p>公司 支持:</p><p>赠送市值产品，10000元</p><p> 赠送(港澳游/云南游， 选 )旅游卡 1张，价值4680元 </p><p>专业产品培训1场(专业知识、产品知识、操作 法) 测颜值活动 案1份</p><p>专业美导下店执 活动销售5-8天</p><p>店家支持:</p><p>配合公司展开活动，前期 告制作，前期线上线下推 活动内容 安排到店体验顾客，30人</p><p>活动当天4折结款，活动后定优惠配赠方案。</p><p><br></p><p>合作确认书甲 :上 霖秋化妆品有限公司(以下简称甲 )</p><p>:______________________(以下简称 ) 已确认甲 所提供的《1000元新店推 案》的内容，愿意与甲 进 合作，并于</p><p>_____________________前打 案款____________元。</p><p>甲 代表签字:_____________&nbsp;代表签字:_____________确认 期:</p>', '20', 'img/20180709/nx_1531124483633.jpg', '老顾客介绍2位新顾客，赠送10000市值产品。', '2', '1', '0', '0.00', '0', 'img/20180709/nx_1531124483597.jpg', '514', '1');
INSERT INTO `xl_goods` VALUES ('125', '「塑时代」免费送拓客', '拓客30人，业绩保障80000元', '39800.00', '1', '1528543217', '0', '0.00', '0.00', '<p><img src=\"img/20180609/nx_1528543217953.jpg\"></p>', '20', 'img/20180609/nx_1528544060550.jpg', '引进塑时代项目，赠送30人拓客，', '3', '2', '0', '0.00', '0', '', '514', '0');
INSERT INTO `xl_goods` VALUES ('107', '380元塑时代礼品卡', '', '380.00', '1', '1524986194', '0', '0.30', '0.00', '<p><img src=\"img/20180509/nx_1525809711689.png\"></p>', '10', 'img/20180429/nx_1524986193899.png', '', '1', '1', '0', '0.00', '1', 'img/20180429/nx_1524986193640.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('117', '测颜值惊喜活动', '颜值-大比拼-赢取大奖', '12800.00', '1', '1528204941', '0', '0.00', '0.00', '<p>霖湫<strong>520</strong>美容师节活动<strong> 方</strong>案<strong>&nbsp;</strong></p><p>案<strong> </strong>额<strong>:</strong>12800元 产品折扣<strong>:</strong>4折&nbsp;</p><p>终端活动<strong>:&nbsp;</strong></p><p>测颜值赢塑时代免费体验，您的颜值很值钱 活动期间，测颜值达到95分以上即可获得塑时代品牌项 体验1 次 胸部项 、臀疗项 、 巴项 、玻 酸原浆项 ，4选1体验(限 30份)&nbsp;</p><p>胸部激活体验，30个，价值8940元</p><p>巴疏通体验，30个，价值9840元</p><p>臀部 理疗体验，30个，价值9840元&nbsp;</p><p>面部玻尿酸拨筋体验，30个，价值5980元 5</p><p>局部塑形体验，30个，价值5040元</p><p>公司 支持:&nbsp;</p><p>公司提供给体验产品30份体验产品&nbsp;</p><p>公司提供美体师套盒奖励，成交 个套盒奖励20元&nbsp;</p><p>专业产品培训1场(专业知识、产品知识、操作 法) 专业美导下店销售5天&nbsp;</p><p>公司保障<strong>:&nbsp;</strong></p><p>包销业绩32000元 后期配送<strong>:&nbsp;</strong></p><p>单次打款10000元，配送5000元(市值产品)&nbsp;</p><p>合作确认书<strong>&nbsp;</strong></p><p>甲 :上 霖湫化妆品有限公司(以下简称甲 ) :______________________(以下简称 )&nbsp;</p><p>已确认甲 所提供的《霖湫 520美容师节活动 案》的内容，愿意与甲 进 合 作，并于______ ____ ___ 前打 案款__________元。&nbsp;</p><p><strong>&nbsp;</strong>在合作过程中需按照甲<strong> </strong>安排的流程进<strong> </strong>合作配合，如<strong>&nbsp;</strong>未按照甲<strong> </strong>安排的流</p><p>程进<strong> </strong>合作配合，甲<strong> </strong>有权收回对<strong>&nbsp;</strong>的保障承诺。</p><p>甲 代表签字:_____________ 代表签字:_____________ 确认&nbsp;</p><p>日期:&nbsp;</p>', '20', 'img/20180609/nx_1528545102887.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180609/nx_1528545102605.jpg', '0', '1');
INSERT INTO `xl_goods` VALUES ('119', '拓-锁-留-升-一站式服务', '拓客30-50人，业绩40000起', '19800.00', '1', '1528539805', '0', '0.00', '0.05', '<p><img src=\"img/20180609/nx_1528539805151.jpg\"></p>', '20', 'img/20180609/nx_1528544397118.jpg', '原价3.98万，新客优惠1.98万，仅此首单', '3', '1', '0', '0.95', '0', '', '514', '0');
INSERT INTO `xl_goods` VALUES ('123', '【塑时代】免费送养生仪器', '局部塑形，臀部理疗，操作轻松有效～', '12800.00', '1', '1528541849', '0', '0.00', '0.00', '<p><img src=\"img/20180609/nx_1528541849110.jpg\"><img src=\"img/20180609/nx_1528541849282.jpg\"></p>', '20', 'img/20180609/nx_1528542426452.jpg', '购买塑时代品牌产品1.28万，赠送一台温灸引流养生仪器，产品吸收效果更好，提升手法操作价值。', '3', '1', '0', '0.00', '0', 'img/20180609/nx_1528542426288.jpg', '514', '0');
INSERT INTO `xl_goods` VALUES ('126', '【塑时代】免费送美体师', '赠送1位美体师，业绩保障60000元', '29800.00', '1', '1528543770', '0', '0.00', '0.50', '<p><img src=\"img/20180609/nx_1528543770659.jpg\"></p>', '20', 'img/20180609/nx_1528544011315.jpg', '2.98万引进塑时代项目，赠送价值2000元一位美体师', '3', '2', '0', '0.95', '0', 'img/20180609/nx_1528544011174.jpg', '514', '0');
INSERT INTO `xl_goods` VALUES ('114', '塑时代胸部抗衰', '50岁年龄～～20岁胸龄', '50000.00', '1', '1524994645', '0', '0.00', '0.00', '<p><img src=\"img/20180609/nx_1528536834740.jpg\"></p><p><img src=\"img/20180609/nx_1528535119458.png\"></p><p><img src=\"img/20180609/nx_1528535119737.png\"></p><p><img src=\"img/20180609/nx_1528536834527.jpg\"></p><p><img src=\"img/20180609/nx_1528535119696.png\"></p><p><img src=\"img/20180609/nx_1528536834484.jpg\"></p><p><img src=\"img/20180609/nx_1528535119300.png\"></p><p><br></p><p><img src=\"img/20180609/nx_1528535119941.png\"></p><p><img src=\"img/20180609/nx_1528536834251.png\"></p>', '21', 'img/20180609/nx_1528535119670.png', '策划～培训～业绩10万起', '3', '2', '0', '0.00', '6', 'img/20180609/nx_1528535119120.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('166', '科妍洁面乳（才木始）', '', '600.00', '1', '1533103603', '0', '0.00', '0.00', '<p><img src=\"img/20180801/nx_1533103751106.png\"></p>', '2', 'img/20180801/nx_1533103603997.png', '', '2', '2', '0', '0.00', '0', 'img/20180801/nx_1533103603684.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('170', '温灸膏', '', '380.00', '1', '1533117778', '0', '0.60', '0.00', '', '0', 'img/20180801/nx_1533117778156.png', '', '3', '2', '0', '0.00', '0', 'img/20180801/nx_1533117778618.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('171', '科妍洁面乳（才木始）', '', '78.00', '1', '1533119152', '0', '0.60', '0.00', '<p><img src=\"img/20180801/nx_1533119152267.png\"></p>', '0', 'img/20180801/nx_1533119152977.png', '', '3', '2', '0', '0.00', '0', 'img/20180801/nx_1533119152268.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('172', '发酵玻尿酸补水面膜（才木始）', '', '100.00', '1', '1533119257', '0', '0.60', '0.00', '<p><img src=\"img/20180801/nx_1533119257254.png\"></p>', '0', 'img/20180801/nx_1533119257578.png', '', '3', '2', '0', '0.00', '0', 'img/20180801/nx_1533119257120.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('174', '198元塑时代胸部激活卡', '', '198.00', '1', '1533353697', '0', '0.30', '0.00', '', '10', 'img/20180808/nx_1533715564552.png', '', '1', '1', '0', '0.00', '0', 'img/20180808/nx_1533715564435.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('175', '商品测试', '', '10.00', '0', '1533354224', '0', '0.50', '0.00', '', '1', 'img/20180804/nx_1533354224374.jpg', '', '3', '2', '0', '0.50', '2', 'img/20180804/nx_1533354224483.jpg', '514', '0');
INSERT INTO `xl_goods` VALUES ('176', '198元塑时代淋巴净化卡', '', '198.00', '1', '1533701621', '0', '0.30', '0.00', '', '10', 'img/20180808/nx_1533715546196.png', '', '3', '1', '0', '0.00', '0', 'img/20180808/nx_1533715546442.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('177', '198元塑时代娇香美臀卡', '', '198.00', '1', '1533701981', '0', '0.30', '0.00', '', '10', 'img/20180808/nx_1533715519919.png', '', '3', '1', '0', '0.00', '0', 'img/20180808/nx_1533715519562.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('164', '发酵玻尿酸补水面膜（才木始）', '', '600.00', '1', '1533102350', '0', '0.00', '0.00', '<p><img src=\"img/20180801/nx_1533102859304.png\"></p>', '2', 'img/20180801/nx_1533102349896.png', '', '2', '2', '0', '0.00', '0', 'img/20180801/nx_1533102350543.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('168', '塑时代调理药包', '', '600.00', '1', '1533105166', '0', '0.00', '0.00', '', '2', 'img/20180801/nx_1533105166141.png', '', '2', '2', '0', '0.00', '0', 'img/20180801/nx_1533118569511.jpg', '514', '1');
INSERT INTO `xl_goods` VALUES ('169', '美韵家居套', '购买即可获得500积分', '1580.00', '1', '1533117281', '500', '0.60', '0.00', '<p><img src=\"img/20180801/nx_1533117281794.png\"></p>', '1', 'img/20180801/nx_1533117281982.png', '', '2', '2', '0', '0.00', '0', 'img/20180801/nx_1533117281145.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('161', '美韵唤醒体验套（激活）', '', '380.00', '1', '1533100365', '0', '0.60', '0.00', '<p><img src=\"img/20180801/nx_1533116338898.png\"></p>', '0', 'img/20180801/nx_1533100365311.png', '', '2', '2', '0', '0.00', '0', 'img/20180801/nx_1533100365519.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('162', '净化调理体验套（淋巴）', '', '680.00', '1', '1533100776', '0', '0.60', '0.00', '<p><img src=\"img/20180801/nx_1533116790742.png\"></p>', '0', 'img/20180801/nx_1533100776913.png', '', '2', '2', '0', '0.00', '1', 'img/20180801/nx_1533100776810.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('163', '霖湫玻尿酸原浆套', '购买即可获得1000积分', '5980.00', '1', '1533101161', '1000', '0.60', '0.00', '', '1', 'img/20180801/nx_1533101161378.png', '', '2', '2', '0', '0.00', '0', 'img/20180801/nx_1533101161715.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('160', '体雕玲珑修护套', '', '1980.00', '1', '1533099432', '0', '0.60', '0.00', '', '0', 'img/20180801/nx_1533099432662.png', '', '2', '2', '0', '0.00', '0', 'img/20180801/nx_1533099432640.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('146', '美韵净化调理套（疏通）', '购买即可获得1000积分', '3980.00', '1', '1533037270', '1000', '0.60', '0.00', '<p><img src=\"img/20180731/nx_1533037600709.png\"></p>', '1', 'img/20180731/nx_1533037600520.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180731/nx_1533037600477.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('145', '美韵唤醒调理套（激活）', '购买即可获得1000积分', '2980.00', '1', '1533036998', '1000', '0.60', '0.00', '<p><img src=\"img/20180731/nx_1533037965655.png\"></p>', '1', 'img/20180731/nx_1533037965584.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180731/nx_1533037965575.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('147', '美韵润养调理套（紧致）', '购买即可获得1000积分', '4980.00', '1', '1533037527', '1000', '0.60', '0.00', '<p><img src=\"img/20180731/nx_1533037892444.png\"></p>', '1', 'img/20180731/nx_1533037891144.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180731/nx_1533037891812.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('148', '美韵凝润调理套（丰挺）', '购买即可获得1000积分', '4980.00', '1', '1533037597', '1000', '0.60', '0.00', '<p><img src=\"img/20180731/nx_1533037809324.png\"></p>', '1', 'img/20180731/nx_1533037809713.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180731/nx_1533037809619.png', '514', '1');
INSERT INTO `xl_goods` VALUES ('149', '唤醒净化调理套（淋巴）', '购买即可获得1000积分', '3980.00', '1', '1533037814', '1000', '0.60', '0.00', '<p><img src=\"img/20180801/nx_1533116307796.png\"></p>', '1', 'img/20180731/nx_1533038088647.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180731/nx_1533038088330.png', '514', '0');
INSERT INTO `xl_goods` VALUES ('150', '娇香美臀调理套（臀疗）', '购买即可获得1000积分', '3980.00', '1', '1533037906', '1000', '0.60', '0.00', '<p><img src=\"img/20180801/nx_1533116269629.png\"></p>', '1', 'img/20180731/nx_1533038159528.jpg', '', '2', '2', '0', '0.00', '0', 'img/20180731/nx_1533038159598.png', '514', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=941 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsimage
-- ----------------------------
INSERT INTO `xl_goodsimage` VALUES ('821', '166', '1', 'img/20180801/nx_1533103603202.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('880', '168', '1', 'img/20180801/nx_1533118569618.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('881', '168', '1', 'img/20180801/nx_1533118569984.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('879', '168', '1', 'img/20180801/nx_1533118569476.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('820', '166', '1', 'img/20180801/nx_1533103603720.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('768', '160', '1', 'img/20180801/nx_1533099432235.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('769', '160', '1', 'img/20180801/nx_1533099432678.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('863', '161', '1', 'img/20180801/nx_1533100365584.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('862', '161', '1', 'img/20180801/nx_1533100365420.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('870', '162', '1', 'img/20180801/nx_1533100776414.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('871', '162', '1', 'img/20180801/nx_1533100776738.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('884', '172', '1', 'img/20180801/nx_1533119257303.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('889', '169', '1', 'img/20180801/nx_1533117281428.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('888', '169', '1', 'img/20180801/nx_1533117281483.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('876', '170', '1', 'img/20180801/nx_1533117778578.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('882', '171', '1', 'img/20180801/nx_1533119152458.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('883', '171', '1', 'img/20180801/nx_1533119152420.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('373', '80', '1', 'img/20180420/nx_1524197779283.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('372', '80', '1', 'img/20180420/nx_1524197958615.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('885', '172', '1', 'img/20180801/nx_1533119257716.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('935', '177', '1', 'img/20180808/nx_1533702104150.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('934', '177', '1', 'img/20180808/nx_1533702104335.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('939', '174', '1', 'img/20180804/nx_1533353855632.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('938', '174', '1', 'img/20180804/nx_1533353855843.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('937', '176', '1', 'img/20180808/nx_1533701895843.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('936', '176', '1', 'img/20180808/nx_1533701895809.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('932', '175', '1', 'img/20180804/nx_1533354224894.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('931', '175', '1', 'img/20180804/nx_1533354224808.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('930', '175', '1', 'img/20180804/nx_1533354224440.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('940', '108', '1', 'img/20180429/nx_1524986741988.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('767', '107', '1', 'img/20180429/nx_1524986193609.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('611', '117', '1', 'img/20180609/nx_1528545102960.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('608', '116', '1', 'img/20180605/nx_1528207229447.jpg', '0');
INSERT INTO `xl_goodsimage` VALUES ('811', '164', '1', 'img/20180801/nx_1533102350369.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('887', '163', '1', 'img/20180801/nx_1533101161743.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('886', '163', '1', 'img/20180801/nx_1533101161291.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('810', '164', '1', 'img/20180801/nx_1533102350382.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('588', '114', '1', 'img/20180609/nx_1528535119329.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('917', '146', '1', 'img/20180731/nx_1533037600441.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('916', '146', '1', 'img/20180731/nx_1533037600613.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('843', '148', '1', 'img/20180731/nx_1533037809458.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('842', '148', '1', 'img/20180731/nx_1533037809534.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('913', '147', '1', 'img/20180731/nx_1533037891151.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('912', '147', '1', 'img/20180731/nx_1533037891143.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('915', '145', '1', 'img/20180731/nx_1533037965257.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('914', '145', '1', 'img/20180731/nx_1533037965734.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('911', '149', '1', 'img/20180731/nx_1533038088822.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('910', '149', '1', 'img/20180731/nx_1533038088630.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('909', '150', '1', 'img/20180731/nx_1533038159308.png', '0');
INSERT INTO `xl_goodsimage` VALUES ('908', '150', '1', 'img/20180731/nx_1533038159833.png', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsuse
-- ----------------------------
INSERT INTO `xl_goodsuse` VALUES ('63', '549', '515', '175', '1533355236', '387');

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
) ENGINE=MyISAM AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_goodsusemsg
-- ----------------------------
INSERT INTO `xl_goodsusemsg` VALUES ('252', '3', '0', '550', '-0.50', '1533465476', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('251', '3', '0', '512', '-1.10', '1533464920', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('250', '3', '0', '512', '-1.10', '1533464807', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('249', '3', '0', '512', '-1.10', '1533464777', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('248', '3', '0', '512', '-1.10', '1533463745', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('247', '3', '0', '512', '-1.00', '1533463331', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('246', '3', '0', '512', '-2.00', '1533463275', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('245', '3', '0', '512', '-1.10', '1533463263', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('244', '3', '0', '512', '-1.00', '1533463012', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('243', '3', '0', '512', '-1.00', '1533462881', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('242', '3', '0', '512', '-1.00', '1533462820', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('226', '2', '63', '514', '3.00', '1533355236', '5');
INSERT INTO `xl_goodsusemsg` VALUES ('227', '2', '63', '513', '1.00', '1533355236', '3');
INSERT INTO `xl_goodsusemsg` VALUES ('228', '2', '63', '772', '1.00', '1533355236', '4');
INSERT INTO `xl_goodsusemsg` VALUES ('229', '2', '63', '549', '5.00', '1533355236', '2');
INSERT INTO `xl_goodsusemsg` VALUES ('230', '1', '63', '515', '0.00', '1533355236', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('231', '3', '0', '775', '-1.00', '1533458848', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('232', '3', '0', '775', '-1.00', '1533459597', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('233', '3', '0', '775', '-1.00', '1533461229', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('234', '3', '0', '775', '-1.00', '1533461469', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('235', '3', '0', '550', '-1.00', '1533462708', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('236', '3', '0', '550', '-1.00', '1533462712', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('237', '3', '0', '550', '-1.00', '1533462714', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('238', '3', '0', '550', '-1.00', '1533462725', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('239', '3', '0', '550', '-1.00', '1533462728', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('240', '3', '0', '512', '-1.00', '1533462817', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('241', '3', '0', '550', '-1.00', '1533462819', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('253', '3', '0', '775', '-0.31', '1533465643', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('254', '3', '0', '512', '-0.40', '1533520558', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('255', '3', '0', '551', '-0.50', '1533521270', '1');
INSERT INTO `xl_goodsusemsg` VALUES ('256', '3', '0', '513', '-1.00', '1533702340', '1');

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
  `requestid` varchar(100) NOT NULL,
  `codeval` varchar(4) NOT NULL,
  `userid` varchar(30) NOT NULL,
  `rqstamp` varchar(15) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `states` int(11) NOT NULL DEFAULT '0' COMMENT '状态 0 其他  1 登陆',
  PRIMARY KEY (`codeid`)
) ENGINE=MyISAM AUTO_INCREMENT=237 DEFAULT CHARSET=utf8;

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
INSERT INTO `xl_msgcode` VALUES ('211', '5AABC0AD-1C62-4ABB-AE84-B2A0609398A8', '5869', '0', '1533520829', '13641759653', '1');
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
INSERT INTO `xl_msgcode` VALUES ('212', 'D1B5B0A5-3BE8-4B05-B432-1A161402B68E', '3635', '0', '1533465486', '15250105938', '1');
INSERT INTO `xl_msgcode` VALUES ('52', '7276EFED-86F4-498B-8130-782DCECF728A', '7687', '137', '1520746530', '17602122145', '0');
INSERT INTO `xl_msgcode` VALUES ('53', '45AF401C-7E38-4C58-B795-5CD2AE0F2002', '8424', '138', '1520746548', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('54', 'B92CCA15-C37A-4BC4-B043-E79E6C67F6F4', '9800', '140', '1520746587', '15129588988', '0');
INSERT INTO `xl_msgcode` VALUES ('55', 'A96A06B0-9E7C-48D3-82CC-90E627E575E7', '5815', '139', '1520746653', '14782372952', '0');
INSERT INTO `xl_msgcode` VALUES ('56', '3A4AD9BD-BA2F-47E0-B586-69223266C6D0', '7733', '141', '1520747245', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('57', '78BABB74-74E7-47E0-9F03-C540DCF74E86', '9711', '142', '1520826085', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('58', '52007A6A-5450-4CD0-A52C-F2AA3CEBEA51', '1825', '145', '1520846398', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('59', '0200684D-7050-4312-B0A5-F72C2EEAFB7C', '8378', '146', '1520846411', '17602122145', '0');
INSERT INTO `xl_msgcode` VALUES ('61', '79D525A0-29B6-4FE7-996F-0DD84C2E6EAD', '5866', '147', '1520846427', '15129588988', '0');
INSERT INTO `xl_msgcode` VALUES ('62', 'E69C6879-0F10-4101-8DD1-6F6ACA76C7FF', '3668', '148', '1520846436', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('63', '61BC4470-733C-45FF-93B0-46582E9AF564', '9967', '144', '1520846445', '14782372952', '0');
INSERT INTO `xl_msgcode` VALUES ('64', 'D407DA42-146A-4EA3-A275-C4DF457189EB', '9210', '149', '1520846468', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('65', 'E37D3AF9-38EB-498D-9592-43AC28956B0E', '5255', '150', '1520847312', '13795292286', '0');
INSERT INTO `xl_msgcode` VALUES ('66', '92BB46ED-8C97-4F3D-AC9D-B38078C7B0F7', '6108', '154', '1520847812', '15821066252', '0');
INSERT INTO `xl_msgcode` VALUES ('67', '18138176-6076-4EA7-9E8A-E6E59264C412', '6607', '153', '1520847818', '15129588988', '0');
INSERT INTO `xl_msgcode` VALUES ('213', '03DA955C-F6F2-43C6-A361-091B2BB5C34D', '7504', '0', '1528009426', '13588530737', '1');
INSERT INTO `xl_msgcode` VALUES ('69', '2C517BBB-66FA-4B71-944E-B748AD27699D', '5900', '151', '1520847821', '17602122145', '0');
INSERT INTO `xl_msgcode` VALUES ('70', '54C5A241-CBF0-49E5-9D72-5F1CBCE40809', '9113', '155', '1520847851', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('71', 'AFDD9C13-EB40-4FEE-BE30-3CEA44517E22', '5381', '156', '1520848047', '14782372952', '0');
INSERT INTO `xl_msgcode` VALUES ('72', 'A83BCA2F-45F4-4987-B163-72B02E0E49F9', '8255', '157', '1520848046', '13916199451', '0');
INSERT INTO `xl_msgcode` VALUES ('73', '15268B71-87F3-4735-86C0-54F1EDDCB23C', '9256', '161', '1521106829', '13916403296', '0');
INSERT INTO `xl_msgcode` VALUES ('214', '37DD73F0-0606-4FDA-BBF9-1A1DF57C9A09', '1927', '0', '1528177666', '13774470223', '1');
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
INSERT INTO `xl_msgcode` VALUES ('215', '7E3420D5-7241-4158-846B-ED2920389F4E', '8104', '0', '1528263883', '17621357743', '1');
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
INSERT INTO `xl_msgcode` VALUES ('216', '2F705880-7CE6-43BC-8163-65561E7388FB', '1547', '0', '1528273995', '13761843596', '1');
INSERT INTO `xl_msgcode` VALUES ('217', '283CE53B-5911-4C6C-AA51-927077471F34', '5604', '0', '1528284525', '15201801099', '1');
INSERT INTO `xl_msgcode` VALUES ('134', 'F441301D-4620-4785-B7AD-E6A973BCBB33', '9842', '0', '1533462776', '13916403296', '1');
INSERT INTO `xl_msgcode` VALUES ('135', '3E80FC95-AE3C-41B1-9A50-6AEA70324FC5', '1486', '0', '1524303895', '17798690890', '1');
INSERT INTO `xl_msgcode` VALUES ('136', 'B146DBEE-F145-466F-86C5-905BEB1F22B6', '8831', '0', '1533354442', '13916199451', '1');
INSERT INTO `xl_msgcode` VALUES ('137', 'CD2F8E57-5251-4875-8A80-C5F94D336728', '1379', '0', '1529821632', '15821066252', '1');
INSERT INTO `xl_msgcode` VALUES ('138', '3A841D79-BA01-473D-BD6E-71CAC367DF94', '5588', '0', '1524955668', '13685475265', '1');
INSERT INTO `xl_msgcode` VALUES ('139', '3A841D79-BA01-473D-BD6E-71CAC367DF94', '5588', '0', '1525955668', '13654785698', '1');
INSERT INTO `xl_msgcode` VALUES ('140', '8A043B27-3105-4F05-A366-3BCD51F0811E', '7154', '0', '1524140915', '15001998531', '1');
INSERT INTO `xl_msgcode` VALUES ('141', '63295723-8E09-4D92-BC4D-203C6AF0C8AB', '7520', '0', '1524196276', '15800599806', '1');
INSERT INTO `xl_msgcode` VALUES ('142', 'AF35A127-0FD1-47C4-BE36-942A6E70FB71', '3382', '0', '1524369461', '13764654808', '1');
INSERT INTO `xl_msgcode` VALUES ('143', '3AB0E733-496D-4916-B72E-5C77737FD2A2', '2203', '0', '1524196285', '18521348382', '1');
INSERT INTO `xl_msgcode` VALUES ('144', '7FFDE4B9-339E-4C9B-A75B-EB50964A65FC', '7584', '0', '1533354766', '17602122145', '1');
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
INSERT INTO `xl_msgcode` VALUES ('159', '18663F84-6607-46C9-A065-CE3F03DBD74B', '3041', '0', '1527918418', '14782372952', '1');
INSERT INTO `xl_msgcode` VALUES ('160', '90FC5B72-B46C-4F06-BB5D-2656406DCCDC', '3772', '0', '1524893852', '18964318981', '1');
INSERT INTO `xl_msgcode` VALUES ('161', '39C308A9-2B01-4183-9DEB-D0B89D450361', '1487', '0', '1527918482', '15129588988', '1');
INSERT INTO `xl_msgcode` VALUES ('162', '21CB2461-286C-4E02-8513-991B8E136DED', '3434', '0', '1532502080', '13795292286', '1');
INSERT INTO `xl_msgcode` VALUES ('163', 'CF7E4355-609C-4034-B926-BC883DA9A029', '9240', '0', '1525007434', '15800813684', '1');
INSERT INTO `xl_msgcode` VALUES ('164', 'C8BEAF9A-7D06-4F03-8666-4CD161681D1F', '9315', '0', '1525167957', '13661730548', '1');
INSERT INTO `xl_msgcode` VALUES ('165', 'D1FB321B-4E89-415F-A388-F0C2EF2E2721', '9558', '0', '1527306088', '17721182160', '1');
INSERT INTO `xl_msgcode` VALUES ('166', '96332BD6-41F5-402F-9867-1FDF1721DC67', '9061', '0', '1525318110', '13817128292', '1');
INSERT INTO `xl_msgcode` VALUES ('167', 'F4330442-F8EB-4DFC-A60C-C7EA0F4A013C', '7849', '0', '1525319112', '17317395991', '1');
INSERT INTO `xl_msgcode` VALUES ('168', 'E13795AB-394B-4C33-A1B3-32C5BF271804', '6240', '0', '1525319540', '18817475573', '1');
INSERT INTO `xl_msgcode` VALUES ('169', '7E63E65C-FD0F-4967-B93E-42B4A038E7DB', '7438', '0', '1525324421', '15821276028', '1');
INSERT INTO `xl_msgcode` VALUES ('170', '9A543863-5AAB-4E41-BD71-235FF0957797', '1940', '0', '1525324706', '13602019549', '1');
INSERT INTO `xl_msgcode` VALUES ('171', '8A98CC19-1051-449D-A971-5E94EECE0889', '3610', '0', '1525324444', '18800681909', '1');
INSERT INTO `xl_msgcode` VALUES ('172', 'A3CD5C07-A6EC-45AC-B5CF-D35E0F9B1637', '5286', '0', '1525324802', '18019173620', '1');
INSERT INTO `xl_msgcode` VALUES ('173', '692F6F36-566D-4E53-B2BE-6C679D286C7B', '5420', '0', '1525333333', '13671629866', '1');
INSERT INTO `xl_msgcode` VALUES ('174', 'C988C99F-CC0B-4B3A-B893-8EA02B0065DE', '3235', '0', '1525335358', '15601859263', '1');
INSERT INTO `xl_msgcode` VALUES ('175', '590F6EA3-D58B-4215-9BB5-5DAF765BE73A', '2705', '0', '1525590152', '18101898871', '1');
INSERT INTO `xl_msgcode` VALUES ('176', 'B24E050A-0BBB-42D0-BCFB-59C39984765B', '9413', '0', '1525424225', '13524040153', '1');
INSERT INTO `xl_msgcode` VALUES ('177', 'DC1738F8-212B-46AE-858A-1354F0638EA8', '2588', '0', '1525484997', '13816618315', '1');
INSERT INTO `xl_msgcode` VALUES ('178', '1B7DC711-DC29-422E-8D95-E44B46DA4A62', '3462', '0', '1527271811', '13761937715', '1');
INSERT INTO `xl_msgcode` VALUES ('179', '746E7843-AD27-4E6D-8229-D1CEB6AE33B3', '6527', '0', '1527899115', '13409930757', '1');
INSERT INTO `xl_msgcode` VALUES ('180', 'E68AEDEB-EF5C-4BBA-93A3-C012A90AA386', '6105', '0', '1525680425', '18550231381', '1');
INSERT INTO `xl_msgcode` VALUES ('181', '75E512A2-310D-4981-945E-EC237D9B0CF3', '9212', '0', '1525794282', '18917856000', '1');
INSERT INTO `xl_msgcode` VALUES ('182', '0F50BB19-261C-4616-8284-A4CB67043EC0', '1457', '0', '1532571929', '18283989448', '1');
INSERT INTO `xl_msgcode` VALUES ('183', 'CB4A60BE-25D6-43AB-A731-E1B04A0BF9CF', '7813', '0', '1526365058', '18516275312', '1');
INSERT INTO `xl_msgcode` VALUES ('184', 'DE6D8DB3-46E9-4187-938B-7576118EC87E', '2189', '0', '1526364903', '18526175312', '1');
INSERT INTO `xl_msgcode` VALUES ('185', '69453A58-3FE4-43DE-BA45-B5A56E740BE7', '2753', '0', '1526364996', '18516275321', '1');
INSERT INTO `xl_msgcode` VALUES ('186', 'E50CE49E-E04D-475D-A104-AD226ABE5BB3', '5252', '0', '1529547431', '13585530737', '1');
INSERT INTO `xl_msgcode` VALUES ('187', 'CFB5A0B4-18EF-4468-BE09-C3493CA3B542', '8103', '0', '1526617015', '15921357580', '1');
INSERT INTO `xl_msgcode` VALUES ('188', '4C77A5FB-DD0D-41BA-BCA7-34844AA283FA', '7858', '0', '1526698505', '15128588988', '1');
INSERT INTO `xl_msgcode` VALUES ('189', 'CA2D7F39-6671-44E0-9EAB-55D5D37A7922', '2247', '0', '1526698264', '13262607535', '1');
INSERT INTO `xl_msgcode` VALUES ('190', 'FCC39758-F1C5-4F4C-9B0F-7D1AB06C5021', '6169', '0', '1526713611', '13564738726', '1');
INSERT INTO `xl_msgcode` VALUES ('191', 'BA5833CE-6DE9-45A8-AF50-07E4C121EA05', '9067', '0', '1526721734', '13818799724', '1');
INSERT INTO `xl_msgcode` VALUES ('192', '27BC04F6-32CC-47E6-960A-52661CBD240E', '5779', '0', '1526796084', '18964317368', '1');
INSERT INTO `xl_msgcode` VALUES ('193', '5C4F3AAB-9DC0-4776-8E32-8E52206B54FF', '8092', '0', '1526967255', '13162957789', '1');
INSERT INTO `xl_msgcode` VALUES ('194', 'DF6659ED-1BFD-44DD-BACD-3B916C1B9D6C', '3590', '0', '1527051480', '13621805151', '1');
INSERT INTO `xl_msgcode` VALUES ('195', '98D748B3-F251-4CE8-8105-68BE4F3F29A1', '6156', '0', '1527064079', '18918022169', '1');
INSERT INTO `xl_msgcode` VALUES ('196', '32848FC8-85C3-4D66-B77A-051C90C43224', '3225', '0', '1532571937', '15288881130', '1');
INSERT INTO `xl_msgcode` VALUES ('197', 'CE21D910-E3EB-4C7A-99B9-D284F50E779E', '8192', '0', '1532504379', '17612179132', '1');
INSERT INTO `xl_msgcode` VALUES ('198', '0F3A32AC-E0C3-4528-AB16-EC6CB3AC0F12', '5505', '0', '1527740426', '13761173859', '1');
INSERT INTO `xl_msgcode` VALUES ('199', '67856D82-46D8-456A-94B5-132F150D1E3A', '2119', '0', '1527315711', '15386284000', '1');
INSERT INTO `xl_msgcode` VALUES ('200', '6809F876-995F-40C0-8F8E-7E962789D4E5', '2726', '0', '1527493512', '13585530735', '1');
INSERT INTO `xl_msgcode` VALUES ('201', 'E5502304-29F4-4877-B7DE-23CE05EEEF62', '2273', '0', '1527395480', '15901866008', '1');
INSERT INTO `xl_msgcode` VALUES ('202', 'C14676C2-61A7-477C-9681-A33DCD38F6E8', '2411', '0', '1527495038', '15056526688', '1');
INSERT INTO `xl_msgcode` VALUES ('203', '233E4A7A-0127-452B-9768-2A0D65D490E9', '9408', '0', '1527564061', '15721559505', '1');
INSERT INTO `xl_msgcode` VALUES ('204', '276E7F89-BFB6-4D77-A3CB-246F175AEB3A', '6362', '0', '1528274069', '13761843496', '1');
INSERT INTO `xl_msgcode` VALUES ('205', '0E9FD8BF-E3DB-4C1E-A174-AA3A334B1EBF', '5933', '0', '1527922465', '18221679767', '1');
INSERT INTO `xl_msgcode` VALUES ('208', 'A39351AC-4673-4FA4-BDAE-7EAC296353A9', '5737', '0', '1527920204', '18217357362', '1');
INSERT INTO `xl_msgcode` VALUES ('209', '343C8C08-1FFD-4F39-8B5F-B8A9E364DC68', '9643', '0', '1527920824', '18221679797', '1');
INSERT INTO `xl_msgcode` VALUES ('210', '29E6B069-6E58-4D01-8737-BAE1A28B01CD', '6355', '0', '1527920826', '18222167976', '1');
INSERT INTO `xl_msgcode` VALUES ('218', '33A7B3DA-89CA-4934-BC17-12821734D3C7', '2554', '0', '1528961347', '18121015415', '1');
INSERT INTO `xl_msgcode` VALUES ('219', '633CB07B-C558-4702-804E-82EADECE2D46', '6508', '0', '1529042803', '18621107925', '1');
INSERT INTO `xl_msgcode` VALUES ('220', '1D6F56DF-007A-4A26-8547-CF5A1445165F', '6099', '0', '1529550517', '18271015101', '1');
INSERT INTO `xl_msgcode` VALUES ('221', '42A85D07-57A6-4E59-9CDE-0FDCDBAA5B75', '7744', '0', '1532502478', '18019055587', '1');
INSERT INTO `xl_msgcode` VALUES ('222', '83764953-21CA-44AC-B353-BE2F22412F5E', '6733', '0', '1531309616', '17630507319', '1');
INSERT INTO `xl_msgcode` VALUES ('223', '1BAAC70A-531F-48ED-8486-C374DE2797B2', '4320', '0', '1532325744', '13505670293', '1');
INSERT INTO `xl_msgcode` VALUES ('224', '92FC88B3-5CB7-4CAF-8535-04BBDF1F1A8E', '9149', '0', '1532325690', '18516410816', '1');
INSERT INTO `xl_msgcode` VALUES ('225', 'A60E3A17-D3F1-4432-A02F-453D5952808F', '9666', '0', '1532325700', '18770166630', '1');
INSERT INTO `xl_msgcode` VALUES ('226', '00B99274-982E-45ED-A591-7B186B1833A1', '5842', '0', '1532337003', '13166311214', '1');
INSERT INTO `xl_msgcode` VALUES ('227', 'A1205DD6-F181-4FF5-9DAE-9B699C51891F', '9243', '0', '1532341480', '15921164142', '1');
INSERT INTO `xl_msgcode` VALUES ('228', '9E1F6AB5-9A20-4706-B77B-0436AD0F11ED', '8211', '0', '1532501686', '18221660575', '1');
INSERT INTO `xl_msgcode` VALUES ('229', '2BFDFAF6-0D79-48B4-804E-6906B3FC675A', '1906', '0', '1532505680', '15829866845', '1');
INSERT INTO `xl_msgcode` VALUES ('230', 'AE1F8D0D-13F3-4689-BF6A-1ADACA1CB0D8', '8164', '0', '1532512752', '15901878442', '1');
INSERT INTO `xl_msgcode` VALUES ('231', '702D66BA-D569-49DF-9544-45881BB7605A', '8807', '0', '1532667282', '18012276444', '1');
INSERT INTO `xl_msgcode` VALUES ('232', '7696CA0C-90F2-4DF5-A03B-7FED4F43CA22', '6763', '0', '1532751867', '13155549114', '1');
INSERT INTO `xl_msgcode` VALUES ('233', '40A2B8F6-9076-4ABF-8FA2-A8FD37893D33', '7377', '0', '1532931362', '15921172406', '1');
INSERT INTO `xl_msgcode` VALUES ('234', '125EE67D-E39C-4665-B759-F1FEBA413B66', '5293', '0', '1533009869', '17717259758', '1');
INSERT INTO `xl_msgcode` VALUES ('235', '03E16BBD-D967-473C-9666-08952F0EDCCA', '6585', '0', '1533017101', '18221851508', '1');
INSERT INTO `xl_msgcode` VALUES ('236', 'D860FF8E-6AC3-4A31-9AB4-96C653F73B5B', '3527', '0', '1533460694', '15250105983', '1');

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
INSERT INTO `xl_sourceorder` VALUES ('5b66bdefa4983', '775', '164', '3000', '1', '1533459951', '5', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5b66bd8213c5d', '775', '164', '600', '1', '1533459842', '1', '0', '');
INSERT INTO `xl_sourceorder` VALUES ('5b5d20e4a7a08', '513', '143', '600', '1', '1532829924', '1', '0', '');

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
) ENGINE=MyISAM AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

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
INSERT INTO `xl_uselog` VALUES ('18', '1', '设置管理员-549-代理商', '1524974927');
INSERT INTO `xl_uselog` VALUES ('19', '1', '设置管理员-512-代理商', '1524983646');
INSERT INTO `xl_uselog` VALUES ('20', '1', '设置管理员-551-代理商', '1524987073');
INSERT INTO `xl_uselog` VALUES ('21', '1', '设置管理员-551-代理商', '1524987203');
INSERT INTO `xl_uselog` VALUES ('22', '1', '设置管理员-513-代理商', '1524988370');
INSERT INTO `xl_uselog` VALUES ('23', '1', '设置管理员-514-代理商', '1524988595');
INSERT INTO `xl_uselog` VALUES ('24', '1', '设置管理员-513-代理商', '1525061566');
INSERT INTO `xl_uselog` VALUES ('25', '1', '设置管理员-551-客户', '1525072852');
INSERT INTO `xl_uselog` VALUES ('26', '1', '设置管理员-551-客户', '1525075631');
INSERT INTO `xl_uselog` VALUES ('27', '1', '设置管理员-551-商户', '1525075670');
INSERT INTO `xl_uselog` VALUES ('28', '1', '设置管理员-512-代理商', '1525075813');
INSERT INTO `xl_uselog` VALUES ('29', '1', '设置管理员-512-客户', '1525075849');
INSERT INTO `xl_uselog` VALUES ('30', '1', '设置管理员-512-业务员', '1525078345');
INSERT INTO `xl_uselog` VALUES ('31', '1', '设置管理员-551-客户', '1525078607');
INSERT INTO `xl_uselog` VALUES ('32', '1', '设置管理员-512-客户', '1525078720');
INSERT INTO `xl_uselog` VALUES ('33', '1', '设置管理员-512-商户', '1525079005');
INSERT INTO `xl_uselog` VALUES ('34', '1', '设置管理员-512-客户', '1525079037');
INSERT INTO `xl_uselog` VALUES ('35', '1', '设置管理员-512-商户', '1525079299');
INSERT INTO `xl_uselog` VALUES ('36', '1', '设置管理员-512-客户', '1525079406');
INSERT INTO `xl_uselog` VALUES ('37', '1', '设置管理员-512-商户', '1525079518');
INSERT INTO `xl_uselog` VALUES ('38', '1', '设置管理员-512-客户', '1525079644');
INSERT INTO `xl_uselog` VALUES ('39', '1', '设置管理员-512-商户', '1525080186');
INSERT INTO `xl_uselog` VALUES ('40', '1', '设置管理员-512-客户', '1525080233');
INSERT INTO `xl_uselog` VALUES ('41', '1', '设置管理员-512-商户', '1525080344');
INSERT INTO `xl_uselog` VALUES ('42', '1', '设置管理员-550-客户', '1525080365');
INSERT INTO `xl_uselog` VALUES ('43', '1', '设置管理员-512-客户', '1525080644');
INSERT INTO `xl_uselog` VALUES ('44', '1', '设置管理员-512-商户', '1525080652');
INSERT INTO `xl_uselog` VALUES ('45', '1', '设置管理员-512-商户', '1525080823');
INSERT INTO `xl_uselog` VALUES ('46', '1', '设置管理员-512-商户', '1525080826');
INSERT INTO `xl_uselog` VALUES ('47', '1', '设置管理员-512-商户', '1525080828');
INSERT INTO `xl_uselog` VALUES ('48', '1', '设置管理员-512-商户', '1525080828');
INSERT INTO `xl_uselog` VALUES ('49', '1', '设置管理员-512-商户', '1525080829');
INSERT INTO `xl_uselog` VALUES ('50', '1', '设置管理员-512-客户', '1525080847');
INSERT INTO `xl_uselog` VALUES ('51', '1', '设置管理员-512-业务员', '1525080881');
INSERT INTO `xl_uselog` VALUES ('52', '1', '设置管理员-512-客户', '1525081067');
INSERT INTO `xl_uselog` VALUES ('53', '1', '设置管理员-512-代理商', '1525082028');
INSERT INTO `xl_uselog` VALUES ('54', '1', '设置管理员-551-商户', '1525082046');
INSERT INTO `xl_uselog` VALUES ('55', '1', '设置管理员-512-客户', '1525083640');
INSERT INTO `xl_uselog` VALUES ('56', '1', '设置管理员-549-商户', '1525083793');
INSERT INTO `xl_uselog` VALUES ('57', '1', '设置管理员-551-客户', '1525083878');
INSERT INTO `xl_uselog` VALUES ('58', '1', '设置管理员-512-代理商', '1525083901');
INSERT INTO `xl_uselog` VALUES ('59', '1', '设置管理员-551-商户', '1525083911');
INSERT INTO `xl_uselog` VALUES ('60', '1', '设置管理员-551-商户', '1525083928');
INSERT INTO `xl_uselog` VALUES ('61', '1', '设置管理员-512-客户', '1525084506');
INSERT INTO `xl_uselog` VALUES ('62', '1', '设置管理员-512-代理商', '1525084581');
INSERT INTO `xl_uselog` VALUES ('63', '1', '设置管理员-512-商户', '1525223314');
INSERT INTO `xl_uselog` VALUES ('64', '1', '设置管理员-550-客户', '1525231613');
INSERT INTO `xl_uselog` VALUES ('65', '1', '设置管理员-550-代理商', '1525231682');
INSERT INTO `xl_uselog` VALUES ('66', '1', '设置管理员-514-代理商', '1525232242');
INSERT INTO `xl_uselog` VALUES ('67', '1', '设置管理员-551-客户', '1525340512');
INSERT INTO `xl_uselog` VALUES ('68', '1', '设置管理员-512-客户', '1525340592');
INSERT INTO `xl_uselog` VALUES ('69', '1', '设置管理员-513-商户', '1526267572');
INSERT INTO `xl_uselog` VALUES ('70', '1', '设置管理员-512-商户', '1526269963');
INSERT INTO `xl_uselog` VALUES ('71', '1', '设置管理员-747-业务员', '1526695085');
INSERT INTO `xl_uselog` VALUES ('72', '1', '设置管理员-747-业务员', '1526695119');
INSERT INTO `xl_uselog` VALUES ('73', '1', '设置管理员-747-业务员', '1526721169');
INSERT INTO `xl_uselog` VALUES ('74', '1', '设置管理员-724-业务员', '1526721214');
INSERT INTO `xl_uselog` VALUES ('75', '1', '设置管理员-763-代理商', '1527740284');
INSERT INTO `xl_uselog` VALUES ('76', '1', '设置管理员-512-客户', '1532499906');
INSERT INTO `xl_uselog` VALUES ('77', '1', '设置管理员-512-商户', '1532499915');
INSERT INTO `xl_uselog` VALUES ('78', '1', '设置管理员-512-业务员', '1532500136');
INSERT INTO `xl_uselog` VALUES ('79', '1', '设置管理员-538-客户', '1532500576');
INSERT INTO `xl_uselog` VALUES ('80', '1', '设置管理员-538-客户', '1532500583');
INSERT INTO `xl_uselog` VALUES ('81', '1', '设置管理员-775-客户', '1532500952');
INSERT INTO `xl_uselog` VALUES ('82', '1', '设置管理员-775-客户', '1532501966');
INSERT INTO `xl_uselog` VALUES ('83', '1', '设置管理员-775-客户', '1532502170');
INSERT INTO `xl_uselog` VALUES ('84', '1', '设置管理员-538-商户', '1532502631');
INSERT INTO `xl_uselog` VALUES ('85', '1', '设置管理员-512-客户', '1532679967');
INSERT INTO `xl_uselog` VALUES ('86', '1', '设置管理员-512-商户', '1532679975');
INSERT INTO `xl_uselog` VALUES ('87', '1', '设置管理员-775-商户', '1532680990');
INSERT INTO `xl_uselog` VALUES ('88', '1', '设置管理员-513-客户', '1532789265');
INSERT INTO `xl_uselog` VALUES ('89', '1', '设置管理员-549-客户', '1533354500');
INSERT INTO `xl_uselog` VALUES ('90', '1', '设置管理员-514-代理商', '1533458695');

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
  `loginkey` varchar(50) NOT NULL DEFAULT '' COMMENT '登陆key',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=867 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xl_userinfo
-- ----------------------------
INSERT INTO `xl_userinfo` VALUES ('512', '店', null, '13641759653', null, '2', '0.20', 'e10adc3949ba59abbe56e057f20f883e', null, '1fa06db56281819d05c2ebc54adfefce', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527922003', '1', '0', '0', '0', '0.12', '陶亮', 'oJj3g09sX7Z9x6EBjR8cDry-cJjU', 'aad46c84f455fc6d42fda9d5e6f422a9!!', 'db2f7b40280a0e3ad46f63b703e7efeb');
INSERT INTO `xl_userinfo` VALUES ('513', 'MondayZhou', null, '13916199451', null, '3', '0.00', '86b8eb14fcbed436723a09e9a913328b', null, 'fc2e4444f299c10b77e9b3dccf1ddcf7', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1524651337', '1', '0', '400', '1', '0.20', '', 'oJj3g0xJpy9CWiN67kk3JgR6dY7Y', '6faf575424eda7466d276cb7e45f54ee', 'c815caa6693f1190d8d9226afd79b36e');
INSERT INTO `xl_userinfo` VALUES ('514', '14782372952', null, '14782372952', null, '5', '3.00', null, null, '2c2cf94e03ddab23c03e33de49b00bb0', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1524840831', '1', '0', '0', '1', '0.00', '陈总', 'oJj3g04T7UJ1co5-qa0UZw2u5ttQ', 'b77f5c8039acb18c09a5e8c4595baa83', '899f8a1e3c79738fa39712ca986c88e7');
INSERT INTO `xl_userinfo` VALUES ('515', 'MondayZ', null, '17602122145', null, '1', '0.00', null, null, '813aa217c1925e8d5f6ddf5d2ef8f969', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525061334', '1', '0', '0', '0', '0.00', '', 'oJj3g0wmP-C7UIrPeqOeEYeoGgfE', 'fc4e9368a0bbe8305c126d90c30e0843', '7a2ac9f6daa0be2dabbb91b65ed33179');
INSERT INTO `xl_userinfo` VALUES ('516', '13817128292', null, '13817128292', null, '1', '0.00', null, null, 'b0a6906b43d27838e31108a6750dfecc', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525318120', '1', '0', '0', '0', '0.00', '', 'oJj3g0-JvH9Pg6ojxOC3tBuQJOSk', '2c98ef5a3c5a3b298cf3b0f53dc1d3a3', '');
INSERT INTO `xl_userinfo` VALUES ('549', '雪奈尔美容养生馆', null, '15129588988', null, '2', '5.00', '35fd19fbe470f0cb5581884fa700610f', null, 'c5de69913d5673800dfbdd3062388d37', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1524974886', '1', '0', '0', '1', '0.00', '', 'oJj3g0ww5GepBXthjhNDBWV1GQe8', '868bb7c43bfb40240df07e6a5677bad3', '5070fa3ac499dd8b520aa8442027edb5');
INSERT INTO `xl_userinfo` VALUES ('517', '', null, null, null, '1', '0.00', null, null, '', '', '1524841242', '0', '0', '0', '0', '0.00', '', 'oJj3g0_gWUQhNiwcxiCvQ1LxKiKM', '6c089daeae8e44b54ed2635f3778fec3', '');
INSERT INTO `xl_userinfo` VALUES ('518', '', null, null, null, '1', '0.00', null, null, '', '', '1524841393', '0', '0', '0', '0', '0.00', '', 'oJj3g0-xp63lFDV9kYAfHDw6Vo6E', '3de289fd48afdfca3f30f7b77e6790ef', '');
INSERT INTO `xl_userinfo` VALUES ('519', '', null, null, null, '1', '0.00', null, null, '', '', '1524841479', '0', '0', '0', '0', '0.00', '', 'oJj3g00gG_3dZMRyTjrbKZf1ZOhU', 'ef806142075276d6ee7d852b68bf2cf9', '');
INSERT INTO `xl_userinfo` VALUES ('520', '18019173620', null, '18019173620', null, '1', '0.00', null, null, 'd245735820e27558eae1008aca160552', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525324822', '1', '0', '0', '0', '0.00', '', 'oJj3g0wmYR0PzBHUSOGZ83joOjPI', 'e6169e66587b1fa32497865336d3356c', '');
INSERT INTO `xl_userinfo` VALUES ('521', '', null, null, null, '1', '0.00', null, null, '', '', '1524842003', '0', '0', '0', '0', '0.00', '', 'oJj3g0zfgP8G0-dN0i47uYWYpTv4', 'a3fa9b550b98e30fb66d47f9b275114e', '');
INSERT INTO `xl_userinfo` VALUES ('522', '', null, null, null, '1', '0.00', null, null, '', '', '1524842029', '0', '0', '0', '0', '0.00', '', 'oJj3g08OBjb2BdPh69CXwwfrWynM', '218b6a280d7bc16f83f2aef5ad89d9b2', '');
INSERT INTO `xl_userinfo` VALUES ('523', '', null, null, null, '1', '0.00', null, null, '', '', '1524842378', '0', '0', '0', '0', '0.00', '', 'oJj3g00FjJm-NfMA1quZqjxP4G2k', '3ff01cec64c4c1c366db77cd873f128a', '');
INSERT INTO `xl_userinfo` VALUES ('524', '', null, null, null, '1', '0.00', null, null, '', '', '1524842683', '0', '0', '0', '0', '0.00', '', 'oJj3g07oOqEVw2y_7mbmD3nTYBQ0', 'dbf2a5170b89f903c119d10aeb75ff29', '');
INSERT INTO `xl_userinfo` VALUES ('525', '', null, null, null, '1', '0.00', null, null, '', '', '1524842970', '0', '0', '0', '0', '0.00', '', 'oJj3g0xXYVt8AD3cQVVg8Gg_KCms', '51fe50cf9646158953c3808577f7b294', '');
INSERT INTO `xl_userinfo` VALUES ('526', '', null, null, null, '1', '0.00', null, null, '', '', '1524843068', '0', '0', '0', '0', '0.00', '', 'oJj3g0zCgxJjVCabzGSu9vwDoaHo', '255d21a33d1a94c9f906b21049795da5', '');
INSERT INTO `xl_userinfo` VALUES ('527', '13602019549', null, '13602019549', null, '1', '0.00', null, null, 'f68d3d1bf25ec385f1a09654dcfd3486', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525324434', '1', '0', '0', '0', '0.00', '', 'oJj3g0yBtQcBlHBb4XWa57i9CSr4', '6520cfda1bf60a7b70915041df2d30ac', '');
INSERT INTO `xl_userinfo` VALUES ('528', '', null, null, null, '1', '0.00', null, null, '', '', '1524843956', '0', '0', '0', '0', '0.00', '', 'oJj3g0z875WUuum8GufPRf43G2Wk', '8bdbd81612fc5da63fd7fd73b231c569', '');
INSERT INTO `xl_userinfo` VALUES ('529', '', null, null, null, '1', '0.00', null, null, '', '', '1524847305', '0', '0', '0', '0', '0.00', '', 'oJj3g042tvcimI8wu0FL06J6Jsv8', '4203fe71f51f4d4c54479567ca4513cd', '');
INSERT INTO `xl_userinfo` VALUES ('530', '', null, null, null, '1', '0.00', null, null, '', '', '1524848281', '0', '0', '0', '0', '0.00', '', 'oJj3g07X6WvMBC2cr9JaG-w--n04', 'c7296de43a30c93924971f22c4bda6b7', '');
INSERT INTO `xl_userinfo` VALUES ('531', '', null, null, null, '1', '0.00', null, null, '', '', '1524850354', '0', '0', '0', '0', '0.00', '', 'oJj3g06LCp3iz-b-OsuugpfTtcdM', '607af9f47949c537dfb8dd2f996ea74a', '');
INSERT INTO `xl_userinfo` VALUES ('532', '', null, null, null, '1', '0.00', null, null, '', '', '1524851837', '0', '0', '0', '0', '0.00', '', 'oJj3g0833KulXxGSSKn3JEQEr2Bg', '760f25a7b51ae571fb8c87ca69e3f6a3', '');
INSERT INTO `xl_userinfo` VALUES ('533', '18964318981', null, '18964318981', null, '1', '0.00', null, null, 'bd5451e43163d3f9dbc1fcf805051eea', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1524893870', '1', '0', '0', '0', '0.00', '', 'oJj3g059LBX5Li-STQ9Faa0ZB9Yg', '58f5ddc4ac5599f76df044bd81e11516', '');
INSERT INTO `xl_userinfo` VALUES ('534', '', null, null, null, '1', '0.00', null, null, '', '', '1524867128', '0', '0', '0', '0', '0.00', '', 'oJj3g0-mQM1oDLT6AA_h0ChPUYe0', '5fe6ea3897a3202cf0d4f5f3076f11db', '');
INSERT INTO `xl_userinfo` VALUES ('535', '', null, null, null, '1', '0.00', null, null, '', '', '1524869074', '0', '0', '0', '0', '0.00', '', 'oJj3g083FLmNTi-_PuLGwmVwZ76E', '3682d089f81bfc9a5a5b81a064760a08', '');
INSERT INTO `xl_userinfo` VALUES ('536', '', null, null, null, '1', '0.00', null, null, '', '', '1524869134', '0', '0', '0', '0', '0.00', '', 'oJj3g05ryNdTSE-tMyIOwLE2fhPQ', '2d36af33f81ebe2b94dc4a5c90bde69e', '');
INSERT INTO `xl_userinfo` VALUES ('537', '', null, null, null, '1', '0.00', null, null, '', '', '1524871605', '0', '0', '0', '0', '0.00', '', 'oJj3g01zuiWPmz04_oDDarMA8MnU', '3ee06e3039cd63c0d1cc793e0298306a', '');
INSERT INTO `xl_userinfo` VALUES ('538', 'JM丶', null, '13795292286', null, '2', '0.00', null, null, 'a9e4ac695999ef1f6435ec2cd614772e', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1524974900', '1', '513', '0', '0', '0.00', '', 'oJj3g0_kbLegM3XtCaUgu5nAXsHY', '2a138149b082bd1c29d75486d03f7a1c', 'eaafe73df04c62f5dbfd8a43017acdab');
INSERT INTO `xl_userinfo` VALUES ('539', '', null, null, null, '1', '0.00', null, null, '', '', '1524875660', '0', '0', '0', '0', '0.00', '', 'oJj3g00pxCmKECpLT2DGhZ0kxQuI', '3dff074deb64e532fec79d6be76051c4', '');
INSERT INTO `xl_userinfo` VALUES ('540', '', null, null, null, '1', '0.00', null, null, '', '', '1524877050', '0', '0', '0', '0', '0.00', '', 'oJj3g079m0vxQJoWM0nIWdMrXBo0', 'eb205728859ebed2354b9145cfdbe8f1', '');
INSERT INTO `xl_userinfo` VALUES ('541', '', null, null, null, '1', '0.00', null, null, '', '', '1524878403', '0', '0', '0', '0', '0.00', '', 'oJj3g041tDABUjaKnLAr1Aaf5_oA', '2cc7e1323ff6c5d2a73ab9915d6307d1', '');
INSERT INTO `xl_userinfo` VALUES ('542', '', null, null, null, '1', '0.00', null, null, '', '', '1524891706', '0', '0', '0', '0', '0.00', '', 'oJj3g0wp2MxPvdzcNoVn75q6wv4A', 'a2fe28712ce7c99c456fd6bffdb638b9', '');
INSERT INTO `xl_userinfo` VALUES ('543', '', null, null, null, '1', '0.00', null, null, '', '', '1524898975', '0', '0', '0', '0', '0.00', '', 'oJj3g0_78SMJX0pp4l3iSXdQz_uA', 'bb8649292ed6d65e82326652f88036db', '');
INSERT INTO `xl_userinfo` VALUES ('544', '', null, null, null, '1', '0.00', null, null, '', '', '1524905810', '0', '0', '0', '0', '0.00', '', 'oJj3g0wsLMhOdH2zfIF0D7RTxJpw', '2e6d471d5830e802b912d68ac611c5bc', '');
INSERT INTO `xl_userinfo` VALUES ('545', '', null, null, null, '1', '0.00', null, null, '', '', '1524909739', '0', '0', '0', '0', '0.00', '', 'oJj3g03jfz0Oo6zab86u1HVgEpPM', '4f6b3cabe12264fa20f99b94a8a0ca56', '');
INSERT INTO `xl_userinfo` VALUES ('546', '', null, null, null, '1', '0.00', null, null, '', '', '1524924868', '0', '0', '0', '0', '0.00', '', 'oJj3g0_iWtN-hyFYaq_jmzMxUVbA', '2c672744d68b36a9bef71960a0bb8afe', '');
INSERT INTO `xl_userinfo` VALUES ('547', '18800681909', null, '18800681909', null, '1', '0.00', null, null, 'd6410c63554e85702b600c052b493ffb', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525324467', '1', '0', '0', '0', '0.00', '', 'oJj3g00L0_jrA8vJXyseDSkjObRc', '5bbb9d814e79bc38e68f474e31d32209', '');
INSERT INTO `xl_userinfo` VALUES ('548', '', null, null, null, '1', '0.00', null, null, '', '', '1524928425', '0', '0', '0', '0', '0.00', '', 'oJj3g0yX6s0Iaezd-TAmJM6Enscc', 'ff94be065e7fd796eecf1098e3004c53', '');
INSERT INTO `xl_userinfo` VALUES ('550', '123', null, '13916403296', null, '5', '3.50', 'e10adc3949ba59abbe56e057f20f883e', null, '8719db407e8c7e25810c78688747f517', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1524984329', '1', '0', '0', '0', '0.00', '雄雄', 'oJj3g0-g1EE2pcIhr0Z05GJmxBSo', 'a90cd8a47842e23688eb793ffc7d1283', '8ec41a3e649625a55ceafc35f6fa45e8');
INSERT INTO `xl_userinfo` VALUES ('551', '神', null, '15821066252', null, '2', '4.50', 'e10adc3949ba59abbe56e057f20f883e', null, '8b528d17ce45c17e88815a9fb5134868', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1524984996', '1', '0', '0', '1', '0.00', '培', 'oJj3g061SwO3cuqyFlMInfcyGrA4', '384337d1587ae95b54dee05c361d7122', 'cfe9d26390606405f1a2d2095a8fea96');
INSERT INTO `xl_userinfo` VALUES ('552', '15821276028', null, '15821276028', null, '1', '0.00', null, null, '41fce9e46a862c2e9405386dec4028ce', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525324438', '1', '0', '0', '0', '0.00', '', 'oJj3g09NaN4pyJfte08tmHhvPh1M', 'c7389edcc8654191b7fbb21867967239', '');
INSERT INTO `xl_userinfo` VALUES ('553', '', null, null, null, '1', '0.00', null, null, '', '', '1525000208', '0', '0', '0', '0', '0.00', '', 'oJj3g00j87IbV3FpuPyLEvqV1-Hs', '2a86db746790af721f8b8c3996873c8a', '');
INSERT INTO `xl_userinfo` VALUES ('554', '', null, null, null, '1', '0.00', null, null, '', '', '1525000353', '0', '0', '0', '0', '0.00', '', 'oJj3g0zLRPiaD4UN2FgqBZKXIi0U', '7248e59f5971005df1e5047768084308', '');
INSERT INTO `xl_userinfo` VALUES ('555', '', null, null, null, '1', '0.00', null, null, '', '', '1525000685', '0', '0', '0', '0', '0.00', '', 'oJj3g048x_Y4I4Y5gyuKqg2_MVO8', '4fda287fccf925124d375978e17e550f', '');
INSERT INTO `xl_userinfo` VALUES ('556', '', null, null, null, '1', '0.00', null, null, '', '', '1525002075', '0', '0', '0', '0', '0.00', '', 'oJj3g03cenCXutYWMesMZyisQUMQ', 'e50b9072a8fc9d153bd24f75430149d5', '');
INSERT INTO `xl_userinfo` VALUES ('557', '', null, null, null, '1', '0.00', null, null, '', '', '1525002634', '0', '0', '0', '0', '0.00', '', 'oJj3g0-bZsB4wAVXBwp_4Jz9iTcM', '390eada089929502f94ad9495b4a8d35', '');
INSERT INTO `xl_userinfo` VALUES ('558', '', null, null, null, '1', '0.00', null, null, '', '', '1525002993', '0', '0', '0', '0', '0.00', '', 'oJj3g02qG_NpCP5eHg8zGwg7v_eE', '71a991ae3598a1d6895352587382a3e9', '');
INSERT INTO `xl_userinfo` VALUES ('559', '', null, null, null, '1', '0.00', null, null, '', '', '1525003311', '0', '0', '0', '0', '0.00', '', 'oJj3g04AHaOCYmIr7_XHkS9KjilU', '5986969f42ca72f4ab0bcc387f3c3341', '');
INSERT INTO `xl_userinfo` VALUES ('560', '', null, null, null, '1', '0.00', null, null, '', '', '1525003339', '0', '0', '0', '0', '0.00', '', 'oJj3g08QcuEoCS9B5VCyffxGDf8U', '7b8a118241df737d362a37f54406a2bb', '');
INSERT INTO `xl_userinfo` VALUES ('561', '', null, null, null, '1', '0.00', null, null, '', '', '1525003346', '0', '0', '0', '0', '0.00', '', 'oJj3g03hlcOevNL-Rl8MOPltla8w', '517ddfbee8a5333635790e6d8642358d', '');
INSERT INTO `xl_userinfo` VALUES ('562', '', null, null, null, '1', '0.00', null, null, '', '', '1525003450', '0', '0', '0', '0', '0.00', '', 'oJj3g01n5_TwY0MJrwCkzWjgQg_U', '5459c45e8591435d5b923a338efd977e', '');
INSERT INTO `xl_userinfo` VALUES ('563', '', null, null, null, '1', '0.00', null, null, '', '', '1525003661', '0', '0', '0', '0', '0.00', '', 'oJj3g0280_PptXWKWqtkxqK-p5PE', 'c240d711398fd1aa493ae6222930fab6', '');
INSERT INTO `xl_userinfo` VALUES ('564', '', null, null, null, '1', '0.00', null, null, '', '', '1525003794', '0', '0', '0', '0', '0.00', '', 'oJj3g08XJhKvTzPSOIzkno3IqM8g', '13338cf505d8239aa9e7da5528df9bbc', '');
INSERT INTO `xl_userinfo` VALUES ('565', '', null, null, null, '1', '0.00', null, null, '', '', '1525004172', '0', '0', '0', '0', '0.00', '', 'oJj3g03gsXKI3sTpDAf9FJAMzccg', '5f7bc3e95dbe2aefb2eb617b6f0ce1fc', '');
INSERT INTO `xl_userinfo` VALUES ('566', '', null, null, null, '1', '0.00', null, null, '', '', '1525004299', '0', '0', '0', '0', '0.00', '', 'oJj3g06VIL-xp_zo4vndrDmOxrZw', '53b5ba19b5fb917a33f96746360cc88f', '');
INSERT INTO `xl_userinfo` VALUES ('567', '', null, null, null, '1', '0.00', null, null, '', '', '1525004372', '0', '0', '0', '0', '0.00', '', 'oJj3g0w-U5f76OMCpm-UAlpqXJ5U', '3d8c0cd9320712d7f3968e05b866dacc', '');
INSERT INTO `xl_userinfo` VALUES ('568', '', null, null, null, '1', '0.00', null, null, '', '', '1525004378', '0', '0', '0', '0', '0.00', '', 'oJj3g0w-IcBItv1BXt8cw0n_Ra5c', '3d876cd2e154785459b9bb193bd01570', '');
INSERT INTO `xl_userinfo` VALUES ('569', '', null, null, null, '1', '0.00', null, null, '', '', '1525004414', '0', '0', '0', '0', '0.00', '', 'oJj3g0-WoNySokjteOssEuCgdYLo', '440f4b42cd62c70f69bebebaef3d77b9', '');
INSERT INTO `xl_userinfo` VALUES ('570', '', null, null, null, '1', '0.00', null, null, '', '', '1525004592', '0', '0', '0', '0', '0.00', '', 'oJj3g05D56qWo-q6EPXI-eMMz0BE', 'e4183933f1b5e494a85bff7b9d3f89ed', '');
INSERT INTO `xl_userinfo` VALUES ('571', '', null, null, null, '1', '0.00', null, null, '', '', '1525004602', '0', '0', '0', '0', '0.00', '', 'oJj3g0waE46zU37sDjXy57O2gjz4', '2d1780fb8ff58b4fb7a1b30a22453232', '');
INSERT INTO `xl_userinfo` VALUES ('572', '', null, null, null, '1', '0.00', null, null, '', '', '1525004649', '0', '0', '0', '0', '0.00', '', 'oJj3g08CuQDzknemUI2nC6TFg7j4', 'af7d491cd2ee49d9c7233402ac2c2764', '');
INSERT INTO `xl_userinfo` VALUES ('573', '', null, null, null, '1', '0.00', null, null, '', '', '1525004748', '0', '0', '0', '0', '0.00', '', 'oJj3g03QiExrfrmlP4BXIbkRUjso', 'bd31d1270f55737352e5ed1cc5bef4f5', '');
INSERT INTO `xl_userinfo` VALUES ('574', '', null, null, null, '1', '0.00', null, null, '', '', '1525004825', '0', '0', '0', '0', '0.00', '', 'oJj3g0_fnr2bjJ9hrlUcgCunGdmM', 'b2419618ebaf21756275a3292ae82f3d', '');
INSERT INTO `xl_userinfo` VALUES ('575', '', null, null, null, '1', '0.00', null, null, '', '', '1525004868', '0', '0', '0', '0', '0.00', '', 'oJj3g07U3xlEiAIH6I-Znf5JVHvg', '472ff928515c87ddb206960fdbca8cb9', '');
INSERT INTO `xl_userinfo` VALUES ('576', '', null, null, null, '1', '0.00', null, null, '', '', '1525004910', '0', '0', '0', '0', '0.00', '', 'oJj3g07_3QCdCFh9F7qcxWmEWOOA', 'a193c5d73e2c787c150fe0d1a18cbe50', '');
INSERT INTO `xl_userinfo` VALUES ('577', '', null, null, null, '1', '0.00', null, null, '', '', '1525005141', '0', '0', '0', '0', '0.00', '', 'oJj3g06lD3PEs2wEBW0nc4BraheQ', 'c010b8913a5ce1a2137dfb9c39389589', '');
INSERT INTO `xl_userinfo` VALUES ('578', '', null, null, null, '1', '0.00', null, null, '', '', '1525005215', '0', '0', '0', '0', '0.00', '', 'oJj3g0y6zNIiDZpN1S7wiSL4kEdk', '9ddc16b8cbcbca6e060628fe6b80804e', '');
INSERT INTO `xl_userinfo` VALUES ('579', '', null, null, null, '1', '0.00', null, null, '', '', '1525005239', '0', '0', '0', '0', '0.00', '', 'oJj3g05nC3F1xrssPk3RHRLcXqB0', 'b85baf9759b1a0ebf2554ca0b0030210', '');
INSERT INTO `xl_userinfo` VALUES ('580', '', null, null, null, '1', '0.00', null, null, '', '', '1525005363', '0', '0', '0', '0', '0.00', '', 'oJj3g07zwnodQ9d7HSpby7G-PsOU', 'c19087e8a89c79e858922597afa81849', '');
INSERT INTO `xl_userinfo` VALUES ('581', '', null, null, null, '1', '0.00', null, null, '', '', '1525005488', '0', '0', '0', '0', '0.00', '', 'oJj3g0xffFzpz-qwb8rM1hjT5V1s', '699908434ccf547f553ffac390482cf1', '');
INSERT INTO `xl_userinfo` VALUES ('582', '', null, null, null, '1', '0.00', null, null, '', '', '1525005578', '0', '0', '0', '0', '0.00', '', 'oJj3g0-NwQcXJvG-reXM5r00y0rw', 'ac180e04a12cec2f33492f5b81646989', '');
INSERT INTO `xl_userinfo` VALUES ('583', '', null, null, null, '1', '0.00', null, null, '', '', '1525005589', '0', '0', '0', '0', '0.00', '', 'oJj3g09VnOZlP-ldjILiQKm5NgpI', 'aff9c7f06af30fdf550537581dac0b71', '');
INSERT INTO `xl_userinfo` VALUES ('584', '', null, null, null, '1', '0.00', null, null, '', '', '1525005654', '0', '0', '0', '0', '0.00', '', 'oJj3g007eAeZlK9sm9fCdVGWrbRc', 'd7373a1a313bd33ebfa2505623402141', '');
INSERT INTO `xl_userinfo` VALUES ('585', '', null, null, null, '1', '0.00', null, null, '', '', '1525005728', '0', '0', '0', '0', '0.00', '', 'oJj3g0_DWOIiz9uvTiSfu078EJ7g', '58cef7ac0d8df085c5d028956cb773d7', '');
INSERT INTO `xl_userinfo` VALUES ('586', '', null, null, null, '1', '0.00', null, null, '', '', '1525006088', '0', '0', '0', '0', '0.00', '', 'oJj3g06dit6WZS6UaC3z_rBs7b14', '0cb319ec74b322bcc50b925a1ec40f02', '');
INSERT INTO `xl_userinfo` VALUES ('587', '', null, null, null, '1', '0.00', null, null, '', '', '1525006429', '0', '0', '0', '0', '0.00', '', 'oJj3g06H5EZPrD4n4Jg4uAIsvWos', '381bce6ae8d334a3a4acfc7b920d841a', '');
INSERT INTO `xl_userinfo` VALUES ('588', '', null, null, null, '1', '0.00', null, null, '', '', '1525006535', '0', '0', '0', '0', '0.00', '', 'oJj3g0xA0Xe-iekr3E1QmdKwncHY', 'dc406b57192cbe440168a0549a091bb8', '');
INSERT INTO `xl_userinfo` VALUES ('589', '', null, null, null, '1', '0.00', null, null, '', '', '1525006631', '0', '0', '0', '0', '0.00', '', 'oJj3g0yIvcnJV41XDhQxoKsGE9TU', '226f5c362a2a1c398b10e1ca80f34c9c', '');
INSERT INTO `xl_userinfo` VALUES ('590', '', null, null, null, '1', '0.00', null, null, '', '', '1525006657', '0', '0', '0', '0', '0.00', '', 'oJj3g0wcLgvMAMsYhkIXv9S8-a84', '0284af945ac056757134b5283d1962cf', '');
INSERT INTO `xl_userinfo` VALUES ('591', '', null, null, null, '1', '0.00', null, null, '', '', '1525006787', '0', '0', '0', '0', '0.00', '', 'oJj3g030F3PnKiB9udJptZxeJcUk', '8f6d5292645272b2f2a894c2ac2f4109', '');
INSERT INTO `xl_userinfo` VALUES ('592', '', null, null, null, '1', '0.00', null, null, '', '', '1525007264', '0', '0', '0', '0', '0.00', '', 'oJj3g0_6DdkZQfFhLswH1zVy5cNU', '154e5a5b099614712ec5cec276224a0c', '');
INSERT INTO `xl_userinfo` VALUES ('593', '15800813684', null, '15800813684', null, '1', '0.00', null, null, '67c733d3064df577c01dc32e776cb754', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525007442', '1', '0', '0', '0', '0.00', '', 'oJj3g0wUQsIeY2c2dxLEdP2v299k', 'df14e7ded5b2e837281ed32e617d2322', '');
INSERT INTO `xl_userinfo` VALUES ('594', '', null, null, null, '1', '0.00', null, null, '', '', '1525007774', '0', '0', '0', '0', '0.00', '', 'oJj3g0zNjzjMb1BnucTfDt4td0FE', '8950beb8c4ce3f6455b81290d061a868', '');
INSERT INTO `xl_userinfo` VALUES ('595', '', null, null, null, '1', '0.00', null, null, '', '', '1525008392', '0', '0', '0', '0', '0.00', '', 'oJj3g02ecCoiYsNOM7OMOBgEEmcU', 'e50e51ea399b451af9d4b0dbbb605f86', '');
INSERT INTO `xl_userinfo` VALUES ('596', '', null, null, null, '1', '0.00', null, null, '', '', '1525008856', '0', '0', '0', '0', '0.00', '', 'oJj3g05TAWSybO06hOANvS7Nv420', 'afbb8d683772c21984e7bbe7268ab76a', '');
INSERT INTO `xl_userinfo` VALUES ('597', '', null, null, null, '1', '0.00', null, null, '', '', '1525008921', '0', '0', '0', '0', '0.00', '', 'oJj3g0_5JxhiSqCW74ZGyn7DwmY8', '210d6b6774214f076db9c57db9b87de4', '');
INSERT INTO `xl_userinfo` VALUES ('598', '', null, null, null, '1', '0.00', null, null, '', '', '1525009011', '0', '0', '0', '0', '0.00', '', 'oJj3g0_CTET-uj5FA6Abk8zcNIBE', 'a7fd96ea391118cbc94eccb43655a87e', '');
INSERT INTO `xl_userinfo` VALUES ('599', '', null, null, null, '1', '0.00', null, null, '', '', '1525009223', '0', '0', '0', '0', '0.00', '', 'oJj3g08rq4x6wTg5RfVQ2Q_ANlX8', '0a9e53c6b76bc29d0738aae5eea0cc5a', '');
INSERT INTO `xl_userinfo` VALUES ('600', '', null, null, null, '1', '0.00', null, null, '', '', '1525009571', '0', '0', '0', '0', '0.00', '', 'oJj3g0zcxwZJv4uVKgQ2lBRc5IuA', 'c81280efe82510f1e6476cbca43e5e75', '');
INSERT INTO `xl_userinfo` VALUES ('601', '', null, null, null, '1', '0.00', null, null, '', '', '1525009848', '0', '0', '0', '0', '0.00', '', 'oJj3g07mGRLBcnlMm1No4-bx-Eu0', 'a1eeae122b92b92f153af90089deec2b', '');
INSERT INTO `xl_userinfo` VALUES ('602', '', null, null, null, '1', '0.00', null, null, '', '', '1525010087', '0', '0', '0', '0', '0.00', '', 'oJj3g09N60bjtHo1pIx6upraWhuE', 'f36b31af887b47c7c67a33eca5236127', '');
INSERT INTO `xl_userinfo` VALUES ('603', '', null, null, null, '1', '0.00', null, null, '', '', '1525010203', '0', '0', '0', '0', '0.00', '', 'oJj3g06eVpthK51lxCM0LEiWkubU', '38d5012453c8905713868629e24f9120', '');
INSERT INTO `xl_userinfo` VALUES ('604', '', null, null, null, '1', '0.00', null, null, '', '', '1525011160', '0', '0', '0', '0', '0.00', '', 'oJj3g0wk2HrbSq2gWJGrpM2wKkA8', '65f8061a49129caaccc813e8fb709a69', '');
INSERT INTO `xl_userinfo` VALUES ('605', '', null, null, null, '1', '0.00', null, null, '', '', '1525011503', '0', '0', '0', '0', '0.00', '', 'oJj3g01Nmx9nRgkXgR2IYbZA_Bls', 'f83ae8c6b51108d259427d38493070c4', '');
INSERT INTO `xl_userinfo` VALUES ('606', '', null, null, null, '1', '0.00', null, null, '', '', '1525012046', '0', '0', '0', '0', '0.00', '', 'oJj3g09drqorgK0FOLX_aZz9UFd0', '630df9c41396509b7e88c27b3b7e3751', '');
INSERT INTO `xl_userinfo` VALUES ('607', '', null, null, null, '1', '0.00', null, null, '', '', '1525012306', '0', '0', '0', '0', '0.00', '', 'oJj3g00aK1JbNUh4-oniG9Yu_DSA', 'e73370a2bab92067929c3fce0255bff7', '');
INSERT INTO `xl_userinfo` VALUES ('608', '', null, null, null, '1', '0.00', null, null, '', '', '1525012565', '0', '0', '0', '0', '0.00', '', 'oJj3g04gOwk8qhrEKwp37944R3yQ', 'a235900eadc1e34beba641b97622cd06', '');
INSERT INTO `xl_userinfo` VALUES ('609', '', null, null, null, '1', '0.00', null, null, '', '', '1525012589', '0', '0', '0', '0', '0.00', '', 'oJj3g01IvPGLX3AQEV-5qHatzbz0', 'cb90f964bafc3dffa4f34277eac01d86', '');
INSERT INTO `xl_userinfo` VALUES ('610', '', null, null, null, '1', '0.00', null, null, '', '', '1525012676', '0', '0', '0', '0', '0.00', '', 'oJj3g08yulLXie2iUgvYY0Vvw0WI', '67ec5e0251efd76f2d97dae3423cc4ef', '');
INSERT INTO `xl_userinfo` VALUES ('611', '', null, null, null, '1', '0.00', null, null, '', '', '1525012877', '0', '0', '0', '0', '0.00', '', 'oJj3g0yGCphKGJb3Tg_-9lHr1wnE', '3368393887105030f664f5ea28b55be5', '');
INSERT INTO `xl_userinfo` VALUES ('612', '', null, null, null, '1', '0.00', null, null, '', '', '1525012927', '0', '0', '0', '0', '0.00', '', 'oJj3g087wsK9NKdsbN8t1E55Juhs', '6a91bd8e9708a1b3a3b1f7886136df5b', '');
INSERT INTO `xl_userinfo` VALUES ('613', '', null, null, null, '1', '0.00', null, null, '', '', '1525014261', '0', '0', '0', '0', '0.00', '', 'oJj3g03XBE9IOKS0M94x-HDsMYKU', '4362e5d8b719fe5f3b8ad514d20825e9', '');
INSERT INTO `xl_userinfo` VALUES ('614', '', null, null, null, '1', '0.00', null, null, '', '', '1525015064', '0', '0', '0', '0', '0.00', '', 'oJj3g00DyA0fKFGqAH-933DaCj34', 'e31ef5aae25bc1deeabf4ba0861bb08b', '');
INSERT INTO `xl_userinfo` VALUES ('615', '', null, null, null, '1', '0.00', null, null, '', '', '1525015402', '0', '0', '0', '0', '0.00', '', 'oJj3g0zi0IBXhcKS5CGd-CI4UxEo', 'f4aa43837070f9c2b2ca09714d3e1fb2', '');
INSERT INTO `xl_userinfo` VALUES ('616', '', null, null, null, '1', '0.00', null, null, '', '', '1525015922', '0', '0', '0', '0', '0.00', '', 'oJj3g00sVFGMocc9nmQ1ch0QMATs', '436ade64a27f737f27688068945a5619', '');
INSERT INTO `xl_userinfo` VALUES ('617', '', null, null, null, '1', '0.00', null, null, '', '', '1525018038', '0', '0', '0', '0', '0.00', '', 'oJj3g02FoSmwe6WNRHXaTddd6XIM', '3f03cde9969ffac1da621eb016f1dd23', '');
INSERT INTO `xl_userinfo` VALUES ('618', '', null, null, null, '1', '0.00', null, null, '', '', '1525019320', '0', '0', '0', '0', '0.00', '', 'oJj3g01ORpMhxJBJ3kKgY9A48p0g', '588f2ddb25ec862d72329e39a633f0ce', '');
INSERT INTO `xl_userinfo` VALUES ('619', '', null, null, null, '1', '0.00', null, null, '', '', '1525022910', '0', '0', '0', '0', '0.00', '', 'oJj3g01sAVOf6vJI3n4XbVwaB1WI', '17ae5845a022153cfb9e782eb72d4d1d', '');
INSERT INTO `xl_userinfo` VALUES ('620', '', null, null, null, '1', '0.00', null, null, '', '', '1525026445', '0', '0', '0', '0', '0.00', '', 'oJj3g0_gFoh-X_veBB2lYNUckl60', 'b85def626df243902cc686a04fafd35e', '');
INSERT INTO `xl_userinfo` VALUES ('621', '', null, null, null, '1', '0.00', null, null, '', '', '1525038286', '0', '0', '0', '0', '0.00', '', 'oJj3g0z0PgN-SDyrcuk2c08np4Rc', 'a9b2a67636461f2ed2d2664e308032b2', '');
INSERT INTO `xl_userinfo` VALUES ('622', '', null, null, null, '1', '0.00', null, null, '', '', '1525038625', '0', '0', '0', '0', '0.00', '', 'oJj3g0z9tBqsFsA_0S3dXXv8MQXE', 'eb2387233b781faf3a333e49031a4557', '');
INSERT INTO `xl_userinfo` VALUES ('623', '', null, null, null, '1', '0.00', null, null, '', '', '1525041447', '0', '0', '0', '0', '0.00', '', 'oJj3g02nwZOuFPmrMKRvIdZm0jt4', '64ab05da55abc063c47cb9bfb428d219', '');
INSERT INTO `xl_userinfo` VALUES ('624', '', null, null, null, '1', '0.00', null, null, '', '', '1525041491', '0', '0', '0', '0', '0.00', '', 'oJj3g0zxK6jmUBKMStx04OpHF7tA', 'ce443d8af03acba520201f2ada89a143', '');
INSERT INTO `xl_userinfo` VALUES ('625', '', null, null, null, '1', '0.00', null, null, '', '', '1525044013', '0', '0', '0', '0', '0.00', '', 'oJj3g09unOj0Z-74_dpWIOCbwQs8', '64e69a8fb5830f5913a40b8dcc905bc9', '');
INSERT INTO `xl_userinfo` VALUES ('626', '', null, null, null, '1', '0.00', null, null, '', '', '1525044835', '0', '0', '0', '0', '0.00', '', 'oJj3g03wT25YbP796duwvvl_TDks', 'c9661953023407c11ca6df2fa2ebdeb2', '');
INSERT INTO `xl_userinfo` VALUES ('627', '', null, null, null, '1', '0.00', null, null, '', '', '1525046331', '0', '0', '0', '0', '0.00', '', 'oJj3g05UZ-QR-L8UgE_X5fCZAtcU', 'edac6c37c13285a1f731f87f8c9f78a2', '');
INSERT INTO `xl_userinfo` VALUES ('628', '', null, null, null, '1', '0.00', null, null, '', '', '1525050393', '0', '0', '0', '0', '0.00', '', 'oJj3g014sEvms584WPZdkyHm8pt0', 'a1ff39910826839989c87344ffe5f671', '');
INSERT INTO `xl_userinfo` VALUES ('629', '', null, null, null, '1', '0.00', null, null, '', '', '1525051796', '0', '0', '0', '0', '0.00', '', 'oJj3g08Gve-cOzoJi2Q1o2Ex4rN8', 'a0d75f4946e3593e53326996c6782c98', '');
INSERT INTO `xl_userinfo` VALUES ('630', '', null, null, null, '1', '0.00', null, null, '', '', '1525052668', '0', '0', '0', '0', '0.00', '', 'oJj3g0wg-E4GBJdtvyKYqcd80zLk', 'a6b856447879223b5e89e63959dbaf28', '');
INSERT INTO `xl_userinfo` VALUES ('631', '', null, null, null, '1', '0.00', null, null, '', '', '1525054723', '0', '0', '0', '0', '0.00', '', 'oJj3g0936NKLmX0pWIabqEW1xoaU', 'f5482e63ccdba1e6002ff5b5e77c5c19', '');
INSERT INTO `xl_userinfo` VALUES ('632', '', null, null, null, '1', '0.00', null, null, '', '', '1525060114', '0', '0', '0', '0', '0.00', '', 'oJj3g09IqjJ67Otl6hQF8z4Hp8MA', '41e4ddc900598fc082fdd7a8817326ba', '');
INSERT INTO `xl_userinfo` VALUES ('633', '', null, null, null, '1', '0.00', null, null, '', '', '1525060229', '0', '0', '0', '0', '0.00', '', 'oJj3g0-kX8SIEx0EEnM9MetDYUAU', '1c5d7d902f553e1be4b18d0564e9d728', '');
INSERT INTO `xl_userinfo` VALUES ('634', '', null, null, null, '1', '0.00', null, null, '', '', '1525082023', '0', '0', '0', '0', '0.00', '', 'oJj3g038dpTq4Nc3sEqQRef0lRJM', 'a3ec296fbac7fae50fc24a9b04853ecf', '');
INSERT INTO `xl_userinfo` VALUES ('635', '', null, null, null, '1', '0.00', null, null, '', '', '1525089723', '0', '0', '0', '0', '0.00', '', 'oJj3g066l5kS0o3HkUuQSsn6pJe4', '22fd070aa23d2bd2ab10f900cd3d06c3', '');
INSERT INTO `xl_userinfo` VALUES ('636', '', null, null, null, '1', '0.00', null, null, '', '', '1525094266', '0', '0', '0', '0', '0.00', '', 'oJj3g0_F9f8jMllDFUyz-EdXAwYo', 'e4deb3e14abc59b1172e21b5e4693b24', '');
INSERT INTO `xl_userinfo` VALUES ('637', '', null, null, null, '1', '0.00', null, null, '', '', '1525094442', '0', '0', '0', '0', '0.00', '', 'oJj3g00wLoLMhBCZQA_niv9tNmWM', '19cf3d24c3d05d605ada8b76de53283b', '');
INSERT INTO `xl_userinfo` VALUES ('638', '', null, null, null, '1', '0.00', null, null, '', '', '1525108465', '0', '0', '0', '0', '0.00', '', 'oJj3g06mh5Dy5xfrYmK6hu1Bxi1w', '551bbe4cd127466eb4c2ebc7fb4651cf', '');
INSERT INTO `xl_userinfo` VALUES ('639', '13661730548', null, '13661730548', null, '1', '0.00', null, null, '4afebe236af028336f8086ab0596a235', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525167965', '1', '0', '0', '0', '0.00', '', 'oJj3g09E9UTVETNu0SbZ6E227gtA', '531f947eeb5645d2f50ec79700394aca', '');
INSERT INTO `xl_userinfo` VALUES ('640', '', null, null, null, '1', '0.00', null, null, '', '', '1525226289', '0', '0', '0', '0', '0.00', '', 'oJj3g0-9IVx1Wg5gHjSQ3MZUpvA4', '5e75cc995519c6e0ae39c353b49bc51d', '');
INSERT INTO `xl_userinfo` VALUES ('641', '', null, null, null, '1', '0.00', null, null, '', '', '1525232389', '0', '0', '0', '0', '0.00', '', 'oJj3g0zPLLNG5kNbNcem4ikaCN3E', 'a5da24f8637f1040add47f9f65c8d14a', '');
INSERT INTO `xl_userinfo` VALUES ('642', '', null, null, null, '1', '0.00', null, null, '', '', '1525239426', '0', '0', '0', '0', '0.00', '', 'oJj3g0_nFchPvDG0-MGgfcy0RJ24', 'c7c3c2a61768736d10931462994f767b', '');
INSERT INTO `xl_userinfo` VALUES ('643', '', null, null, null, '1', '0.00', null, null, '', '', '1525247003', '0', '0', '0', '0', '0.00', '', 'oJj3g08mC-7wHYCJkqLvbcjmXy1s', '6b042f40cc83cbcc0eb5f3cf8766805c', '');
INSERT INTO `xl_userinfo` VALUES ('644', '', null, null, null, '1', '0.00', null, null, '', '', '1525247709', '0', '0', '0', '0', '0.00', '', 'oJj3g03c8e-zCM_nZY057m99Ou2I', '6173029a14e9015ba833bd23a8accc49', '');
INSERT INTO `xl_userinfo` VALUES ('645', '', null, null, null, '1', '0.00', null, null, '', '', '1525266065', '0', '0', '0', '0', '0.00', '', 'oJj3g00MolcXZSpIosWEuHE8rIDo', '1a5701f1cc394386364ae5e2781de2e5', '');
INSERT INTO `xl_userinfo` VALUES ('646', '爱美雪梨', null, '17721182160', null, '2', '79.20', null, null, '2d44ddd64a0eaf4129ee1e9c265b5133', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525317659', '1', '0', '0', '0', '0.00', '', 'oJj3g04Q7d1CE52vpAY8n6UBZBBk', 'eb970ec7caa81b95dfbd31b86ee8bc88', '');
INSERT INTO `xl_userinfo` VALUES ('647', '17317395991', null, '17317395991', null, '1', '0.00', null, null, 'eff5451809518a47d7b192b8bc223e01', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525319133', '1', '0', '0', '0', '0.00', '', 'oJj3g05ie5KW_XUDxC_FY7h97ed0', 'eace1400d03abf1d71d0db94ecd0b2c9', '');
INSERT INTO `xl_userinfo` VALUES ('648', '', null, null, null, '1', '0.00', null, null, '', '', '1525319114', '0', '0', '0', '0', '0.00', '', 'oJj3g02tOgiWBaoGxAwKjRwCQkhg', '4d94a18bc16d3f85b6f3abefcffba2c3', '');
INSERT INTO `xl_userinfo` VALUES ('649', '阿平', null, '18817475573', null, '1', '0.00', null, null, '4a243f0f63ab1fc4785966afeb816d9c', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525319557', '1', '0', '0', '0', '0.00', '', 'oJj3g0-FJTqGVua5U3i8LHsAONVA', '1cc0bc73930626e261907269f52f664a', '');
INSERT INTO `xl_userinfo` VALUES ('650', '', null, null, null, '1', '0.00', null, null, '', '', '1525331786', '0', '0', '0', '0', '0.00', '', 'oJj3g0xRwNxa6QJQa2LTgK4NGr-E', '54fb0243d1f913f4ad5f8b41ee2eb9d3', '');
INSERT INTO `xl_userinfo` VALUES ('651', '', null, null, null, '1', '0.00', null, null, '', '', '1525332460', '0', '0', '0', '0', '0.00', '', 'oJj3g0x5TmJN3cOWty-M8RVsL9qo', '0aa72ac1b67dd3fd7c9aafd651c62931', '');
INSERT INTO `xl_userinfo` VALUES ('652', '塑时代', null, '15829866845', null, '2', '0.00', null, null, 'ae35d4b52c2dc637ab4b1794231ce531', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532505691', '1', '0', '1000', '0', '0.00', '', 'oJj3g01CIDcXEeA1bzc72dSDidFk', '44733ba268cfe762628b46c09b7e7a29', 'c2fc6b52220199cbc20e74025c49b6c3');
INSERT INTO `xl_userinfo` VALUES ('653', '', null, null, null, '1', '0.00', null, null, '', '', '1525333020', '0', '0', '0', '0', '0.00', '', 'oJj3g04dSYEUVpqnoXvouPMUJmwY', '89d6abe4671cfd24f5c3e4f8a2110881', '');
INSERT INTO `xl_userinfo` VALUES ('654', '', null, null, null, '1', '0.00', null, null, '', '', '1525333061', '0', '0', '0', '0', '0.00', '', 'oJj3g02X5-V8nUrjC_3KfL_jwlWI', '252645b56f2f4c147de8f320d564b320', '');
INSERT INTO `xl_userinfo` VALUES ('655', '', null, null, null, '1', '0.00', null, null, '', '', '1525333185', '0', '0', '0', '0', '0.00', '', 'oJj3g03PRrGmECD1gaGApF27XSd8', '83fab8458b42c78068ea3249f2c25c21', '');
INSERT INTO `xl_userinfo` VALUES ('656', '', null, null, null, '1', '0.00', null, null, '', '', '1525333241', '0', '0', '0', '0', '0.00', '', 'oJj3g08TWErxvV-qZ212oMQLrxcw', '7b74cec8436f1e00bc1f286f65603343', '');
INSERT INTO `xl_userinfo` VALUES ('657', '13671629866', null, '13671629866', null, '1', '0.00', null, null, '3e27d55ddc00d33c5754a0d17874b194', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525333362', '1', '0', '0', '0', '0.00', '', 'oJj3g06U9-E2hvzvtMgIZEi1cmzs', '55e8fcefc1fdbefe0c1e1690008b0741', '');
INSERT INTO `xl_userinfo` VALUES ('658', '', null, null, null, '1', '0.00', null, null, '', '', '1525333338', '0', '0', '0', '0', '0.00', '', 'oJj3g00Fp9b_-42a55i9y-xUytZE', '59b83804da88dc475d6396864fc43d7d', '');
INSERT INTO `xl_userinfo` VALUES ('659', '', null, null, null, '1', '0.00', null, null, '', '', '1525333440', '0', '0', '0', '0', '0.00', '', 'oJj3g0-QPwvT56kUCCD_-Fl15ges', 'b975515b209f7a8c56addead6651f212', '');
INSERT INTO `xl_userinfo` VALUES ('660', '', null, null, null, '1', '0.00', null, null, '', '', '1525333836', '0', '0', '0', '0', '0.00', '', 'oJj3g05NmS7YsK5QqP7EUppukHiY', '721900f9fa6494763bc0d151feeb4ef3', '');
INSERT INTO `xl_userinfo` VALUES ('661', '', null, null, null, '1', '0.00', null, null, '', '', '1525334533', '0', '0', '0', '0', '0.00', '', 'oJj3g0xp-eCH7u40cyf3RCHjP6mo', 'a97768ae821a0c3104d5f45f008fb03d', '');
INSERT INTO `xl_userinfo` VALUES ('662', '', null, null, null, '1', '0.00', null, null, '', '', '1525334765', '0', '0', '0', '0', '0.00', '', 'oJj3g00C8crCfDWVd4GNVHPIRw_Q', 'b235fc83e2c83a85a438578fa5e10837', '');
INSERT INTO `xl_userinfo` VALUES ('663', '', null, null, null, '1', '0.00', null, null, '', '', '1525334825', '0', '0', '0', '0', '0.00', '', 'oJj3g028SJYj2nCGmB_wTS2oodL4', 'c756bfd96f2770fe0019caf51fabf717', '');
INSERT INTO `xl_userinfo` VALUES ('664', '', null, null, null, '1', '0.00', null, null, '', '', '1525334910', '0', '0', '0', '0', '0.00', '', 'oJj3g0-LDMGrcsq_r573NRh2b6CA', '4e1b0e4c2ffcca1a51d741d4e9e2d578', '');
INSERT INTO `xl_userinfo` VALUES ('665', '15601859263', null, '15601859263', null, '1', '0.00', null, null, '634cb8ca5d18eab89ff3b530b200eef2', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525335367', '1', '0', '0', '0', '0.00', '', 'oJj3g00i5dhfN6pxtB5GGfs1pGg4', '53dd46e40da913960f9de9caca7a22cd', '');
INSERT INTO `xl_userinfo` VALUES ('666', '', null, null, null, '1', '0.00', null, null, '', '', '1525336748', '0', '0', '0', '0', '0.00', '', 'oJj3g02cACfuEQDPWzrY-GaPs5kI', '15fc62252bad9801cd2cb750d907e32a', '');
INSERT INTO `xl_userinfo` VALUES ('667', '', null, null, null, '1', '0.00', null, null, '', '', '1525336785', '0', '0', '0', '0', '0.00', '', 'oJj3g0wNoLXVcaoLEt8dYhDRyRwY', 'f2a671de6ba4158b3fa42c501b42a68d', '');
INSERT INTO `xl_userinfo` VALUES ('668', '', null, null, null, '1', '0.00', null, null, '', '', '1525336971', '0', '0', '0', '0', '0.00', '', 'oJj3g0wjwQCZLz6CsD0gUxPOCo-g', '87c8fbf1340c4fe1b443a542dd96e7b7', '');
INSERT INTO `xl_userinfo` VALUES ('669', '', null, null, null, '1', '0.00', null, null, '', '', '1525336977', '0', '0', '0', '0', '0.00', '', 'oJj3g0z7Vk9_I0aQpLRwcS51xwlQ', '604c042ceb65e799665e7650625b1c38', '');
INSERT INTO `xl_userinfo` VALUES ('670', '', null, null, null, '1', '0.00', null, null, '', '', '1525337103', '0', '0', '0', '0', '0.00', '', 'oJj3g0_yl5MVSlm-xEqtN-YxHUOM', '781a7b39b0c802c508123bccdf35c615', '');
INSERT INTO `xl_userinfo` VALUES ('671', '', null, null, null, '1', '0.00', null, null, '', '', '1525337856', '0', '0', '0', '0', '0.00', '', 'oJj3g0-VphdYKyArYeAwk7qEU-pU', '868c15794d87c7a4339b8236c3bfd9e9', '');
INSERT INTO `xl_userinfo` VALUES ('672', '', null, null, null, '1', '0.00', null, null, '', '', '1525340256', '0', '0', '0', '0', '0.00', '', 'oJj3g0zO9q9xx9Zo6pfTFNULYKIg', '3cba4878cc7623ff1fb39ddf0909c544', '');
INSERT INTO `xl_userinfo` VALUES ('742', '', null, null, null, '1', '0.00', null, null, '', '', '1526289106', '0', '0', '0', '0', '0.00', '', 'oJj3g0-mbZWAq57UE4VvgqNy46KI', '709ab21ff3323cf46c289ddc3b5b3969', '');
INSERT INTO `xl_userinfo` VALUES ('673', '', null, null, null, '1', '0.00', null, null, '', '', '1525341768', '0', '0', '0', '0', '0.00', '', 'oJj3g0_xRu1gWkWZpCFhYh2aWesY', '200110f1198239f94344b979acef56f3', '');
INSERT INTO `xl_userinfo` VALUES ('674', '', null, null, null, '1', '0.00', null, null, '', '', '1525341921', '0', '0', '0', '0', '0.00', '', 'oJj3g06Xw5jWzcBr7zotMt_BUc68', '85062ce93d90bb16ec06dd5b9117a1d1', '');
INSERT INTO `xl_userinfo` VALUES ('675', '', null, null, null, '1', '0.00', null, null, '', '', '1525344462', '0', '0', '0', '0', '0.00', '', 'oJj3g02Kt4BxOACaBffxPO1mo6uk', 'c0fdfa3f3716f90e64b53e5cb021aed5', '');
INSERT INTO `xl_userinfo` VALUES ('676', '', null, null, null, '1', '0.00', null, null, '', '', '1525344747', '0', '0', '0', '0', '0.00', '', 'oJj3g03eI4H35yKKZ0PcJ6HbhHvY', '9b6fc6910d492b84439f8f850d5d0669', '');
INSERT INTO `xl_userinfo` VALUES ('677', '', null, null, null, '1', '0.00', null, null, '', '', '1525345390', '0', '0', '0', '0', '0.00', '', 'oJj3g02y3MIKGO4KOUGU87qIbbfg', '6ed5c3e2af748c24fa4539accbf0c314', '');
INSERT INTO `xl_userinfo` VALUES ('678', '', null, null, null, '1', '0.00', null, null, '', '', '1525345735', '0', '0', '0', '0', '0.00', '', 'oJj3g02QewNwewSaxSd9YrRU1Bkg', 'c48cac01bb6dd6897441d192dd162e46', '');
INSERT INTO `xl_userinfo` VALUES ('679', '', null, null, null, '1', '0.00', null, null, '', '', '1525350874', '0', '0', '0', '0', '0.00', '', 'oJj3g03IsTkZp2_RnEUVYcxEihDk', 'cd5bc60f03b046b8dbeedf02d033dd50', '');
INSERT INTO `xl_userinfo` VALUES ('680', '', null, null, null, '1', '0.00', null, null, '', '', '1525350954', '0', '0', '0', '0', '0.00', '', 'oJj3g0wRAkGe7eejX9X4MiX3S5Ns', '92e9753b9c21410e19ea4a65ec9f2f58', '');
INSERT INTO `xl_userinfo` VALUES ('681', '', null, null, null, '1', '0.00', null, null, '', '', '1525350961', '0', '0', '0', '0', '0.00', '', 'oJj3g097UgupQGZWs1UhwZN1oTW0', 'e78bbacec5998b0fa9b027a8db44f75a', '');
INSERT INTO `xl_userinfo` VALUES ('682', '', null, null, null, '1', '0.00', null, null, '', '', '1525351782', '0', '0', '0', '0', '0.00', '', 'oJj3g0w2FwV7J6ljzaNOXxIXesOk', '52fcb6e5d71d9f27480f647c5a4a169b', '');
INSERT INTO `xl_userinfo` VALUES ('683', '', null, null, null, '1', '0.00', null, null, '', '', '1525351933', '0', '0', '0', '0', '0.00', '', 'oJj3g04YP_Unez5NgHepARB5H5xk', '7fcb22ef60b59a017d07cbb0919b6851', '');
INSERT INTO `xl_userinfo` VALUES ('684', '', null, null, null, '1', '0.00', null, null, '', '', '1525351967', '0', '0', '0', '0', '0.00', '', 'oJj3g04xlsSyUYb7VU5apYvvzJ70', '6a4074f97c7eec9b083e55ea5c03093d', '');
INSERT INTO `xl_userinfo` VALUES ('685', '', null, null, null, '1', '0.00', null, null, '', '', '1525352684', '0', '0', '0', '0', '0.00', '', 'oJj3g08sTAFmPEITRmucnxLnOqDc', '55366f620ada4f7b646ff3d9e1d8fd48', '');
INSERT INTO `xl_userinfo` VALUES ('686', '', null, null, null, '1', '0.00', null, null, '', '', '1525352764', '0', '0', '0', '0', '0.00', '', 'oJj3g0xeUKw3JufKDqYtOWM-pcDQ', 'df2ff2e83dc0e0b4692421a8712ce78f', '');
INSERT INTO `xl_userinfo` VALUES ('687', '', null, null, null, '1', '0.00', null, null, '', '', '1525355790', '0', '0', '0', '0', '0.00', '', 'oJj3g02-gyz-ZUO7wAtllJmfw168', 'bdb75e6bf724551d034747b153c1daad', '');
INSERT INTO `xl_userinfo` VALUES ('688', '', null, null, null, '1', '0.00', null, null, '', '', '1525355859', '0', '0', '0', '0', '0.00', '', 'oJj3g0zppOX8jwC97eZ4eccb35ds', '9c036c875fbc0286564816f5d6439f54', '');
INSERT INTO `xl_userinfo` VALUES ('689', '', null, null, null, '1', '0.00', null, null, '', '', '1525356163', '0', '0', '0', '0', '0.00', '', 'oJj3g0zlth20JOeY9hLjlCuSXrWo', '1870f2c30d11e2f807413235cc767fdd', '');
INSERT INTO `xl_userinfo` VALUES ('690', '', null, null, null, '1', '0.00', null, null, '', '', '1525356836', '0', '0', '0', '0', '0.00', '', 'oJj3g0xNLu2aqRqcbdNqs8o9AugY', '4c2488e2722b1cd7258afefff6609198', '');
INSERT INTO `xl_userinfo` VALUES ('691', '', null, null, null, '1', '0.00', null, null, '', '', '1525363403', '0', '0', '0', '0', '0.00', '', 'oJj3g0-781vqPKis1bNrDnFi-9Xk', 'ac672b99e8dbe87df6919379e0090b27', '');
INSERT INTO `xl_userinfo` VALUES ('692', '', null, null, null, '1', '0.00', null, null, '', '', '1525367253', '0', '0', '0', '0', '0.00', '', 'oJj3g019BN15n8wd58CiD8VfovEc', '8323c6cf1b3c6a8b327eb9db752af769', '');
INSERT INTO `xl_userinfo` VALUES ('693', '', null, null, null, '1', '0.00', null, null, '', '', '1525367575', '0', '0', '0', '0', '0.00', '', 'oJj3g0253UqZgrqx1HBgPJim4V0A', '55f15b41488641795c48c14837d61b36', '');
INSERT INTO `xl_userinfo` VALUES ('694', '', null, null, null, '1', '0.00', null, null, '', '', '1525378713', '0', '0', '0', '0', '0.00', '', 'oJj3g09mR17CY5bicWQvgChJxt_g', 'ace259d902653dfe2917804a06eb8889', '');
INSERT INTO `xl_userinfo` VALUES ('695', '', null, null, null, '1', '0.00', null, null, '', '', '1525385443', '0', '0', '0', '0', '0.00', '', 'oJj3g0xJOtHNJI3Lj_hjpIuJHzOc', '9273618743df314584b2cbee09a4a4bb', '');
INSERT INTO `xl_userinfo` VALUES ('696', '', null, null, null, '1', '0.00', null, null, '', '', '1525387096', '0', '0', '0', '0', '0.00', '', 'oJj3g05MZ5_5PD8SL-aBL3EZHs8E', 'a221361cfe7591d73cfab45a84262fec', '');
INSERT INTO `xl_userinfo` VALUES ('697', '', null, null, null, '1', '0.00', null, null, '', '', '1525387195', '0', '0', '0', '0', '0.00', '', 'oJj3g00IvaN-PErbMy3WCe7s_hCk', '68fa798879266c0ef80f75c13b667e4a', '');
INSERT INTO `xl_userinfo` VALUES ('698', '', null, null, null, '1', '0.00', null, null, '', '', '1525389424', '0', '0', '0', '0', '0.00', '', 'oJj3g04deYC2EubYBNdVCWjfrZTc', '1c9cc2c5e176fa922d8dd3e2d49f68cc', '');
INSERT INTO `xl_userinfo` VALUES ('699', '', null, null, null, '1', '0.00', null, null, '', '', '1525389740', '0', '0', '0', '0', '0.00', '', 'oJj3g01EY3uKUY6NObXw865vvWDc', 'a9f2b1a41cdd74b37655da69e1e1bee8', '');
INSERT INTO `xl_userinfo` VALUES ('700', '', null, null, null, '1', '0.00', null, null, '', '', '1525390285', '0', '0', '0', '0', '0.00', '', 'oJj3g07IgSfHrjYtP3c2gvleRbZI', '2bbb2ab21e15bcc52a1460e7b4dc8457', '');
INSERT INTO `xl_userinfo` VALUES ('701', '', null, null, null, '1', '0.00', null, null, '', '', '1525390647', '0', '0', '0', '0', '0.00', '', 'oJj3g0xhqw_FIr_Q4V7J_5x6ve2U', '35d70a5add1eaf9b35947e1cb3a6e55b', '');
INSERT INTO `xl_userinfo` VALUES ('702', '18101898871', null, '18101898871', null, '1', '0.00', null, null, '73de8abc8d01c5fc2b21f47ddbb9d9e5', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525391761', '1', '516', '0', '0', '0.00', '', 'oJj3g07T-vw9AnltigRO2i8GKB5Y', '1a282c40914317b72e16f3cc9a7c58c1', '');
INSERT INTO `xl_userinfo` VALUES ('703', '', null, null, null, '1', '0.00', null, null, '', '', '1525392588', '0', '0', '0', '0', '0.00', '', 'oJj3g08HHgzZyheT6LEzazNHfC1M', '0a53af87c1d0aecaed2eac925443660c', '');
INSERT INTO `xl_userinfo` VALUES ('704', '', null, null, null, '1', '0.00', null, null, '', '', '1525392665', '0', '0', '0', '0', '0.00', '', 'oJj3g02VBiKFJ1mIbiRcnhWSRWk4', 'c0415ed992f8e7eb5fe74fac5ecce055', '');
INSERT INTO `xl_userinfo` VALUES ('705', '', null, null, null, '1', '0.00', null, null, '', '', '1525392873', '0', '0', '0', '0', '0.00', '', 'oJj3g02L1_N8ycj4pgPDhpAoDl0Y', '06828191bf51a5c9f74127951289bec7', '');
INSERT INTO `xl_userinfo` VALUES ('706', '', null, null, null, '1', '0.00', null, null, '', '', '1525395980', '0', '0', '0', '0', '0.00', '', 'oJj3g0-hSWGToExVanIReQZEJhNs', 'fda502743c5fbef53eafb44ef91d6529', '');
INSERT INTO `xl_userinfo` VALUES ('707', '', null, null, null, '1', '0.00', null, null, '', '', '1525396340', '0', '0', '0', '0', '0.00', '', 'oJj3g0_PhWut5GRdgSw0sCMwQrrU', 'd2746cc103bf8045e82ca3e889399323', '');
INSERT INTO `xl_userinfo` VALUES ('708', '', null, null, null, '1', '0.00', null, null, '', '', '1525396973', '0', '0', '0', '0', '0.00', '', 'oJj3g06_2hQrEfAzemqoRoRbssMU', 'de385dcd577e896333292691e3ceb943', '');
INSERT INTO `xl_userinfo` VALUES ('709', '', null, null, null, '1', '0.00', null, null, '', '', '1525415094', '0', '0', '0', '0', '0.00', '', 'oJj3g01cuaiUKlL7aULuDTnuc9uU', 'c256984798869ce61d8495c49dd51fa1', '');
INSERT INTO `xl_userinfo` VALUES ('710', '', null, null, null, '1', '0.00', null, null, '', '', '1525418027', '0', '0', '0', '0', '0.00', '', 'oJj3g01SgJ9ulrGC-Gmbtig87cYI', '67030e4183079664ac1ba0a131f8fe08', '');
INSERT INTO `xl_userinfo` VALUES ('711', '13524040153', null, '13524040153', null, '1', '0.00', null, null, '76aeb94e72874494bc3853385990be87', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525424250', '1', '0', '0', '0', '0.00', '', 'oJj3g0xgD-VlJ_6xygw1UFDBIP6w', 'b12784127c35e4dc90ba9327800d5bb8', '');
INSERT INTO `xl_userinfo` VALUES ('712', '', null, null, null, '1', '0.00', null, null, '', '', '1525441893', '0', '0', '0', '0', '0.00', '', 'oJj3g028l3KKvDevJ_LymKstlH30', '8f49641bc8b5064fdd328fbd5e5416d2', '');
INSERT INTO `xl_userinfo` VALUES ('713', '', null, null, null, '1', '0.00', null, null, '', '', '1525483360', '0', '0', '0', '0', '0.00', '', 'oJj3g03_1aa6mlFIIbH_ph7wa42k', 'd88bacc639059362b5781b28833b4f36', '');
INSERT INTO `xl_userinfo` VALUES ('714', '', null, null, null, '1', '0.00', null, null, '', '', '1525483745', '0', '0', '0', '0', '0.00', '', 'oJj3g0wamWxOOlCMoy0yCJLcNqgQ', 'a08cb8878dfeb66680325236ffdaa706', '');
INSERT INTO `xl_userinfo` VALUES ('715', '', null, null, null, '1', '0.00', null, null, '', '', '1525483898', '0', '0', '0', '0', '0.00', '', 'oJj3g07JwDDi0qAQ0S9SbZAd67ZY', 'b514271cf3f19bf4fa8b0040f5343e92', '');
INSERT INTO `xl_userinfo` VALUES ('716', '13761937715', null, '13761937715', null, '1', '0.00', null, null, 'fd91b590f6c9af864a97e01704de47ff', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525485048', '1', '0', '0', '0', '0.00', '', 'oJj3g0-5_Re82HKY49_7Ym8evKbY', '9b63af7e7873c14b5cf5cf51ec07b468', '');
INSERT INTO `xl_userinfo` VALUES ('717', '', null, null, null, '1', '0.00', null, null, '', '', '1525485178', '0', '0', '0', '0', '0.00', '', 'oJj3g0_Qli3GYVQ8vyW2-Rc55JR4', 'faeebd8fcbc2280883ab4f17dcc3ee0f', '');
INSERT INTO `xl_userinfo` VALUES ('718', '', null, null, null, '1', '0.00', null, null, '', '', '1525485923', '0', '0', '0', '0', '0.00', '', 'oJj3g04tIo58FrGz9YXr3ElEjKus', '155dcf680c56119c5b4abca4e37194d0', '');
INSERT INTO `xl_userinfo` VALUES ('719', '', null, null, null, '1', '0.00', null, null, '', '', '1525487841', '0', '0', '0', '0', '0.00', '', 'oJj3g08u_Tg0dOmlMDr9hC_i83ik', '8cb44ab69a31af944a820d18f1378472', '');
INSERT INTO `xl_userinfo` VALUES ('720', '', null, null, null, '1', '0.00', null, null, '', '', '1525488146', '0', '0', '0', '0', '0.00', '', 'oJj3g063TWsrGTjsw2LSLQ4f-H20', '9720d5497a134cbea67771592d59fb4e', '');
INSERT INTO `xl_userinfo` VALUES ('721', '', null, null, null, '1', '0.00', null, null, '', '', '1525489832', '0', '0', '0', '0', '0.00', '', 'oJj3g07BeEeirE09eC3jGVvXBqao', '96b8e2046ad4e4bbe77ac9286a45d93e', '');
INSERT INTO `xl_userinfo` VALUES ('722', '', null, null, null, '1', '0.00', null, null, '', '', '1525496961', '0', '0', '0', '0', '0.00', '', 'oJj3g0wOAP0xOG6kj2qogAEcIhVI', '67737d04a71708253cf2cfbd69fe76bc', '');
INSERT INTO `xl_userinfo` VALUES ('723', '', null, null, null, '1', '0.00', null, null, '', '', '1525499887', '0', '0', '0', '0', '0.00', '', 'oJj3g03W8XoEc3iOp0wo-ejkyA5c', '1e2ba8c29534e430f0c0a6301115a9d6', '');
INSERT INTO `xl_userinfo` VALUES ('724', '新宝', null, '13409930757', null, '2', '0.00', null, null, '1ca069da57743822a6d9bc5c44052d86', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525520314', '1', '0', '0', '0', '0.00', '', 'oJj3g04L0Xj-lxyu6qciwHlJPANU', 'a3354f733513613ea85f420d84158597', 'd56aaddcafb45e8a8e01b5a76e4b2e0f');
INSERT INTO `xl_userinfo` VALUES ('725', '', null, null, null, '1', '0.00', null, null, '', '', '1525514356', '0', '0', '0', '0', '0.00', '', 'oJj3g0-2cL24_-lm1QiD1rMYAtgw', 'b53faffbbcc4e751fd39a40b6eafbb55', '');
INSERT INTO `xl_userinfo` VALUES ('726', '', null, null, null, '1', '0.00', null, null, '', '', '1525618029', '0', '0', '0', '0', '0.00', '', 'oJj3g05L3xsBwZrtn8CU0sjb5F08', '7fc4030ea7d27d028427a09661480cbb', '');
INSERT INTO `xl_userinfo` VALUES ('727', '', null, null, null, '1', '0.00', null, null, '', '', '1525644531', '0', '0', '0', '0', '0.00', '', 'oJj3g05yfg_LwvwLwuXz-cWXvsSY', '3f706c9fec6c5b19b1ed535640ba15ac', '');
INSERT INTO `xl_userinfo` VALUES ('728', '18550231381', null, '18550231381', null, '1', '0.00', null, null, '8816d46e15637a08dad06ebe77f56c8c', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525680484', '1', '0', '0', '0', '0.00', '', 'oJj3g0yE_6JJc6g08nmLTQOBAvTY', '441e25df1319dddff353be69fb968ea1', '');
INSERT INTO `xl_userinfo` VALUES ('729', '18917856000', null, '18917856000', null, '1', '0.00', null, null, '0557171cd024d9a869a88d2f8619d5cf', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1525794298', '1', '0', '0', '0', '0.00', '', 'oJj3g0zQn3h2wWEs6f1JWxwvF99U', '4696111338fcf2d86f9ce9c821a0d363', '');
INSERT INTO `xl_userinfo` VALUES ('730', '霖湫', null, '15288881130', null, '2', '0.00', null, null, '2947e324b580c750bf49e06cca928b70', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527127153', '1', '0', '0', '0', '0.00', '', 'oJj3g0x15PqeTQTgNpjGXTxA5wU8', 'ac230ea2bc1252e659cdc73183dba38d', '81dca4685df88246bea643bd5bc88fab');
INSERT INTO `xl_userinfo` VALUES ('731', '', null, null, null, '1', '0.00', null, null, '', '', '1525834885', '0', '0', '0', '0', '0.00', '', 'oJj3g03kNNqf4Hl_GPU4qMN8GKEc', '96ca568a22df832bb8c17589aec4600c', '');
INSERT INTO `xl_userinfo` VALUES ('732', '', null, null, null, '1', '0.00', null, null, '', '', '1525847036', '0', '0', '0', '0', '0.00', '', 'oJj3g08IvSJnorwVrA68KbcNkH6M', '88d898d7d9edc866cb2ba5c77d708ad3', '');
INSERT INTO `xl_userinfo` VALUES ('733', '', null, null, null, '1', '0.00', null, null, '', '', '1525849083', '0', '0', '0', '0', '0.00', '', 'oJj3g05h2NuMOTIOp6AJGugQ-1A0', '5cc13db0c343bfe474609e459145604d', '');
INSERT INTO `xl_userinfo` VALUES ('734', '', null, null, null, '1', '0.00', null, null, '', '', '1525849345', '0', '0', '0', '0', '0.00', '', 'oJj3g02dOJYRhyv4ZycXb9H-wqII', 'eb17fdc64997f2238fc1f9db7360f1d8', '');
INSERT INTO `xl_userinfo` VALUES ('735', '', null, null, null, '1', '0.00', null, null, '', '', '1525858248', '0', '0', '0', '0', '0.00', '', 'oJj3g0-r7Kb6z4xL1Fl9jp_rkUnM', '0cf5b068a16317a1f60be10067617111', '');
INSERT INTO `xl_userinfo` VALUES ('736', '', null, null, null, '1', '0.00', null, null, '', '', '1525858298', '0', '0', '0', '0', '0.00', '', 'oJj3g0zAx50CQADGpnUml388a6hk', 'c332f2209d52d470b760081c52ae08c3', '');
INSERT INTO `xl_userinfo` VALUES ('737', '', null, null, null, '1', '0.00', null, null, '', '', '1525858327', '0', '0', '0', '0', '0.00', '', 'oJj3g05aydiAhMofRzK2rTyUw0W0', '77ca347707b4322e75024b59e9d2d59c', '');
INSERT INTO `xl_userinfo` VALUES ('738', '', null, null, null, '1', '0.00', null, null, '', '', '1525859727', '0', '0', '0', '0', '0.00', '', 'oJj3g0_96QiiWq_PLX4gkiDIJ8i8', '18666ae1676aaf110f0da59191f4ddfc', '');
INSERT INTO `xl_userinfo` VALUES ('739', '', null, null, null, '1', '0.00', null, null, '', '', '1525863414', '0', '0', '0', '0', '0.00', '', 'oJj3g05wlqMV88Sc3ozF7A7zjUj4', 'aea2d8e37a48a33e1c04d896ab16bf17', '');
INSERT INTO `xl_userinfo` VALUES ('740', '', null, null, null, '1', '0.00', null, null, '', '', '1525916352', '0', '0', '0', '0', '0.00', '', 'oJj3g01g5W5T-oDVSJFeKzf5oE1Q', '067d6aef43a753947e8c84cbce93d849', '');
INSERT INTO `xl_userinfo` VALUES ('741', '', null, null, null, '1', '0.00', null, null, '', '', '1526026082', '0', '0', '0', '0', '0.00', '', 'oJj3g0yxT8yMUQPwMpF4yTUWP4DU', 'a6a74104f8d35eca2e046836470f8b1a', '');
INSERT INTO `xl_userinfo` VALUES ('743', '', null, null, null, '1', '0.00', null, null, '', '', '1526348060', '0', '0', '0', '0', '0.00', '', 'oJj3g0_VKa7PKzmzzyYnqRGQvg9Y', 'e902de05b5fff99e054be846c71144e1', '');
INSERT INTO `xl_userinfo` VALUES ('744', '18271015101', null, '18271015101', null, '1', '0.00', null, null, '64b8df177d71475b7faf6d8980f9464b', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1529550533', '1', '0', '0', '0', '0.00', '', 'oJj3g041HaxSU0AI8SXsq7da23jM', '4025f4b7f9a00492086459cd1b3d4b9f', 'adb4c903674d579c1a43dbf3ae93f077');
INSERT INTO `xl_userinfo` VALUES ('745', '', null, null, null, '1', '0.00', null, null, '', '', '1526364928', '0', '0', '0', '0', '0.00', '', 'oJj3g0w7w3NgEhyNsKY6cn48l4i8', '099be877c26a43a892330ca8a4bd9a87', '');
INSERT INTO `xl_userinfo` VALUES ('746', '', null, null, null, '1', '0.00', null, null, '', '', '1526529885', '0', '0', '0', '0', '0.00', '', 'oJj3g02NAEYHj-3rYYsPAcV96nYU', '62d4f8db156d1bfc421a1f702345c952', '');
INSERT INTO `xl_userinfo` VALUES ('747', '新新', null, '13585530737', null, '3', '0.00', null, null, 'f48a35e4e36726f58f6c5452ad85fa8f', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1526544018', '1', '0', '0', '1', '0.00', '', 'oJj3g04CYJTfcnJHuyjppUUX4cD4', 'e64ecb75208610aa208cd0d1c9e07020', '16eeeb491080ff779eefceb3565812db');
INSERT INTO `xl_userinfo` VALUES ('748', '15921357580', null, '15921357580', null, '2', '0.00', null, null, 'c8861289faa03fab3d1f862730907a57', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1526617023', '1', '0', '0', '0', '0.00', '', 'oJj3g04_cjB-uEO8vCjDUrBhG0Dg', '918fa67b15e08aa7bb8dbaef528334e5', '');
INSERT INTO `xl_userinfo` VALUES ('749', '', null, null, null, '1', '0.00', null, null, '', '', '1526631696', '0', '0', '0', '0', '0.00', '', 'oJj3g05-1RwsXSmQoY7oHB_lFXC0', 'b689e1fe7927ad1d6f5dca530c1089ab', '');
INSERT INTO `xl_userinfo` VALUES ('750', '13262607535', null, '13262607535', null, '3', '0.00', null, null, '459f5d660915e28bf43e631bdb75a589', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1526698278', '1', '0', '0', '0', '0.00', '', 'oJj3g09Vp-ZQesLliZVDZoLRd0ZM', 'af619369c8eb2b2b547a08beeba45361', '');
INSERT INTO `xl_userinfo` VALUES ('751', '', null, null, null, '1', '0.00', null, null, '', '', '1526706091', '0', '0', '0', '0', '0.00', '', 'oJj3g07rlE00SJx1_kEr_TF-Sthg', '69ee08c7b5c8785902ee7382a05f674a', '');
INSERT INTO `xl_userinfo` VALUES ('752', '新发型', null, '13564738726', null, '2', '0.00', null, null, '0df71bb9f10f9f414c822bd5050d9892', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1526713680', '1', '0', '0', '0', '0.00', '', 'oJj3g066uDwbwqx3geWVxI_kj2jc', '465829bfba9b5e0fa88a59abaffe75b6', '');
INSERT INTO `xl_userinfo` VALUES ('753', '纤姿美容', null, '13818799724', null, '2', '0.00', null, null, 'd4234a418b72d7ac58f9d86b20741439', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1526721745', '1', '0', '0', '0', '0.00', '', 'oJj3g09WU5uYTG9tIIX-c10ezXgo', '6dfdea70baac561580f997b61e3552f7', '');
INSERT INTO `xl_userinfo` VALUES ('754', '李', null, '18964317368', null, '2', '0.00', null, null, 'dc49e4e5295bf296cbf79ff37cf58167', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1526796095', '1', '0', '0', '0', '0.00', '', 'oJj3g00TVhYTawVV2nsSVfDpRI1o', '1fa9823f29ab0dcde39bc1123a25a490', '');
INSERT INTO `xl_userinfo` VALUES ('755', '', null, null, null, '1', '0.00', null, null, '', '', '1526809199', '0', '0', '0', '0', '0.00', '', 'oJj3g00xZeyvWB4uxLzmSBouCSPQ', 'ca776fb18c2e28bc29ba9433c78c9bc5', '');
INSERT INTO `xl_userinfo` VALUES ('756', '', null, null, null, '1', '0.00', null, null, '', '', '1526836886', '0', '0', '0', '0', '0.00', '', 'oJj3g0217zgyAZ_NDTn1Cjtnws_8', '385ab1efa76d06ce5c02e18d514a01dc', '');
INSERT INTO `xl_userinfo` VALUES ('757', '卡玛格美容院', null, '13162957789', null, '2', '0.00', null, null, 'fcfe19ae1ef39644cc827bc70c6fe2b6', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1526967277', '1', '0', '0', '0', '0.00', '', 'oJj3g0x_xK8xax3ol1XIrxJerMoI', '05876cb1fec11feadb2d67e40712e55a', '');
INSERT INTO `xl_userinfo` VALUES ('758', '', null, null, null, '1', '0.00', null, null, '', '', '1526996663', '0', '0', '0', '0', '0.00', '', 'oJj3g08CoUgrFV3MtgPnUEJxlAFE', '9e73be9dd1c89aa7a9379217f5b292ff', '');
INSERT INTO `xl_userinfo` VALUES ('759', '火凤凰高端美容会所', null, '13621805151', null, '2', '0.00', null, null, '86f19263f43ad1392012d29c0dce6d17', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527051492', '1', '0', '0', '0', '0.00', '', 'oJj3g03gU28lC62TyJMZi0Y5MPbE', 'c70d8fa4fe9f6cfc19e22a283a94fb98', '');
INSERT INTO `xl_userinfo` VALUES ('760', '18918022169', null, '18918022169', null, '1', '0.00', null, null, '9ac420b471c4fd23f1e5afd1d424dbab', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527064168', '1', '0', '0', '0', '0.00', '', 'oJj3g0xbHfGJ9uV-flPfOohrU3OM', 'ade681bf4c66ee33b5a2901ad44ac761', '');
INSERT INTO `xl_userinfo` VALUES ('761', '颜汐', null, '18283989448', null, '2', '0.00', null, null, '1d395673705f8ae4b3d00503e2aab5a3', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527562934', '1', '0', '0', '0', '0.00', '', 'oJj3g0_iwkK05OFDUjEGzEZtFxfM', '4d3d0a64adaa9e3b28cc43fb2ec0c8da', '8410dbdfff261119425cfc0c542a9523');
INSERT INTO `xl_userinfo` VALUES ('762', '17612179132', null, '17612179132', null, '1', '0.00', null, null, '1b8d66446fc0c2d22a96cda3fe40f2c5', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527127440', '1', '0', '0', '0', '0.00', '', 'oJj3g0xaWibO_Ddrn1olLcYc6AjU', '2cd5e35fe9e41ec06a823be272b09543', 'd2fd06621e7f352fa7125a158038bc57');
INSERT INTO `xl_userinfo` VALUES ('763', '13761173859', null, '13761173859', null, '5', '0.00', null, null, '74e8474d18e2fe4cb21cc553996f359d', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527159090', '1', '0', '0', '0', '0.00', '中美联教育', 'oJj3g0-Cw5ejD-upxrfuzC6KGgOc', '7024ffbe95dbe16e72bbbb354024bb97', '');
INSERT INTO `xl_userinfo` VALUES ('764', '熳时光SPA', null, '15386284000', null, '2', '0.00', null, null, '495fe909c1820613e98a0e8ee22cdc5c', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527315727', '1', '0', '0', '0', '0.00', '', 'oJj3g0_DjYwuddjaiZWACpbc2wT4', 'c5cca90e611a2fd7806c6fba360938f7', '');
INSERT INTO `xl_userinfo` VALUES ('765', '', null, null, null, '1', '0.00', null, null, '', '', '1527329824', '0', '0', '0', '0', '0.00', '', 'oJj3g0xxV9ig7j1jHgL3yK4RaDao', '520e185da703df563940db9546f2187f', '');
INSERT INTO `xl_userinfo` VALUES ('766', '豆豆妈妈', null, '15901866008', null, '2', '0.00', null, null, '13cdcc77080c14548bdd54cc965ab19b', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527395495', '1', '0', '0', '0', '0.00', '', 'oJj3g0-ufgA9Ufc7nqsALY03lx74', 'ac26b2cc4f6713b9dcced2c6aa569f13', '');
INSERT INTO `xl_userinfo` VALUES ('767', '佳人轩', null, '15056526688', null, '2', '0.00', null, null, 'cf87086e03701593d43f93ee1458d0b1', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527495048', '1', '0', '0', '0', '0.00', '', 'oJj3g0zYvnHoJ-yGxt4Hgn7B29cI', '9b5c56bde141f636c1d9a6ce9238c060', '');
INSERT INTO `xl_userinfo` VALUES ('768', '', null, null, null, '1', '0.00', null, null, '', '', '1527564659', '0', '0', '0', '0', '0.00', '', 'oJj3g05L_iYviCwE03sYiMoN3Lqs', '8fe23caf3ebc69f95ae101abbe2390a1', '');
INSERT INTO `xl_userinfo` VALUES ('769', '', null, null, null, '1', '0.00', null, null, '', '', '1527577936', '0', '0', '0', '0', '0.00', '', 'oJj3g05ojwUqe99yjuXaN73V1aO4', '3a002f87efd578f6a8e3a26e08226d23', '');
INSERT INTO `xl_userinfo` VALUES ('770', '', null, null, null, '1', '0.00', null, null, '', '', '1527582859', '0', '0', '0', '0', '0.00', '', 'oJj3g02eMdaFTM1Xu4xb4m4CBpHk', '8ec0330b7e1856406e0afef890b46a9a', '');
INSERT INTO `xl_userinfo` VALUES ('771', '', null, null, null, '1', '0.00', null, null, '', '', '1527583666', '0', '0', '0', '0', '0.00', '', 'oJj3g05ASDxDOIl0pYvmDzsZRyW8', 'e8c7e49cf0a51294eb62a7aa460c1aba', '');
INSERT INTO `xl_userinfo` VALUES ('772', '18019055587', null, '18019055587', null, '4', '1.00', null, null, 'ad7ebcb6541512ca2054d0170755ac83', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1530417027', '1', '0', '0', '0', '0.20', '', 'oJj3g042yvfbFGdmXK1jK2-EXLt8', 'fff0167e31d96cfe89a46c72db6378a9', 'f0841deaffec3545f7c94b494fdb833f');
INSERT INTO `xl_userinfo` VALUES ('773', '', null, null, null, '1', '0.00', null, null, '', '', '1527737545', '0', '0', '0', '0', '0.00', '', 'oJj3g0xIo3GxFQS0sBooqcpRsMTQ', 'b23ac9fa4cf7f63ea566868636af031a', '');
INSERT INTO `xl_userinfo` VALUES ('774', '麗麗美容', null, '13761843496', null, '2', '0.00', null, null, '16eb6271952055755ead64a406c8d8b0', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527838047', '1', '0', '0', '0', '0.00', '', 'oJj3g0_JCxEa9G85Tg2tY2lcxsnI', 'ff790f173d4bf15bae5b894624483778', 'c1686f86dbc884bab3328fb5af2f5ba7');
INSERT INTO `xl_userinfo` VALUES ('809', '18516410816', null, '18516410816', null, '1', '0.00', null, null, '89d3fcf57e87359f932c05e2d13f2d89', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532325706', '1', '514', '0', '0', '0.00', '', 'oJj3g04h15QziDZ4aEPR2plMHJ0Y', 'ee605e961740d6dc935aca6708a72dfc', '74d23a6500c5cffde1f94d35d0915559');
INSERT INTO `xl_userinfo` VALUES ('775', '哈哈', null, '15250105938', null, '2', '5.69', 'e10adc3949ba59abbe56e057f20f883e', null, 'ee8b52a1aaf4ff7d274eb8c3357729af', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1527922486', '1', '0', '996399', '0', '0.00', '', 'oJj3g09sX7Z9x6EBjR8cDry-cJjU', 'aad46c84f455fc6d42fda9d5e6f422a9', 'b3377e183990b02e56a51ab3db814d2e');
INSERT INTO `xl_userinfo` VALUES ('776', '', null, null, null, '1', '0.00', null, null, '', '', '1527927969', '0', '0', '0', '0', '0.00', '', 'oJj3g00oWbPEDly6IVhZ4CoY63iU', '470639fa858f0cf9097a9e6bf0d99efd', '');
INSERT INTO `xl_userinfo` VALUES ('777', '邵宏骏', null, '18621107925', null, '2', '0.00', null, null, '77dc85d22a24627f3bfcf6de6c44bd53', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1529041805', '1', '0', '0', '0', '0.00', '', 'oJj3g091znN62TCkbmCZzwzTQsho', '3c484d92a89ab5711035ae7aa4f31925', '73ea78729d717e6a435948b8912a67cf');
INSERT INTO `xl_userinfo` VALUES ('778', '', null, null, null, '1', '0.00', null, null, '', '', '1528006390', '0', '0', '0', '0', '0.00', '', 'oJj3g0yj9uL8d7nxeK2_lsCerPlw', '21c9937a0220336394628d79da92ffea', '');
INSERT INTO `xl_userinfo` VALUES ('779', '', null, null, null, '1', '0.00', null, null, '', '', '1528120294', '0', '0', '0', '0', '0.00', '', 'oJj3g07omPKrgC-ko_FwDIEDdIHk', '602f08cb01c4fc9ed3d69322d70f30ee', '');
INSERT INTO `xl_userinfo` VALUES ('780', '逸晨造型', null, '13774470223', null, '2', '0.00', null, null, 'bad9d8967a57dc1658bb92967600839b', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1528177678', '1', '0', '0', '0', '0.00', '', 'oJj3g01unEtTlf4diwEUMTlKpQDQ', '6359d2c4efa88a3ec48477f85be6ce6d', '719a6e5ecb3067f0725a36f477404c5c');
INSERT INTO `xl_userinfo` VALUES ('781', '英伦玫瑰', null, '17621357743', null, '2', '0.00', null, null, '34d1e2c27d7fcb11f5a12095b1f15475', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1528263892', '1', '0', '0', '0', '0.00', '', 'oJj3g0yopfTvq7sa42wjFqpdBR-s', 'e753ed39b82c4295ec4ac8a15ea8f4fb', '1e4be82281a54a839c8849d1e7440d32');
INSERT INTO `xl_userinfo` VALUES ('782', '15201801099', null, '15201801099', null, '3', '0.00', null, null, '78510c7ddec5bd7b79487bb85077a395', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1528284534', '1', '0', '0', '0', '0.00', '', 'oJj3g0-HNIRy9qql_of6NNzy1FNc', '9864c759058bd97c5f222e1eeeaf88f3', '4dec26a76b3baa1dced953a6ed79dba6');
INSERT INTO `xl_userinfo` VALUES ('783', '', null, null, null, '1', '0.00', null, null, '', '', '1528433378', '0', '0', '0', '0', '0.00', '', 'oJj3g02F1D0y2VWapCGYYhK9k2sg', '0ac4fdfabe7e56491fad60815d06b99d', '');
INSERT INTO `xl_userinfo` VALUES ('784', '', null, null, null, '1', '0.00', null, null, '', '', '1528436766', '0', '0', '0', '0', '0.00', '', 'oJj3g0z7OuRi0sfdQPC_www_8uSs', '977cf0bb04aec9fec5f72a804e49ab64', '');
INSERT INTO `xl_userinfo` VALUES ('785', '', null, null, null, '1', '0.00', null, null, '', '', '1528485076', '0', '0', '0', '0', '0.00', '', 'oJj3g06atw-iz2uEfUMIlC40D0uo', '326410b07e92587fbd8c1a765c140cf4', '');
INSERT INTO `xl_userinfo` VALUES ('786', '', null, null, null, '1', '0.00', null, null, '', '', '1528535373', '0', '0', '0', '0', '0.00', '', 'oJj3g0wnt29iTxKO3ZERuVkhxYzE', '4f15b90e2c255d61fe2c6889ae8f0bcd', '');
INSERT INTO `xl_userinfo` VALUES ('787', '', null, null, null, '1', '0.00', null, null, '', '', '1528536130', '0', '0', '0', '0', '0.00', '', 'oJj3g04mAreEWK9-o8nxLKU_uYQI', 'b6bb616178c07f4bcc6b181c287bd027', '');
INSERT INTO `xl_userinfo` VALUES ('788', '', null, null, null, '1', '0.00', null, null, '', '', '1528627394', '0', '0', '0', '0', '0.00', '', 'oJj3g06tHrj7YiWWRabo0uB-cyu8', 'a9db25e2dbe77a581eef27c177ee2aa4', '');
INSERT INTO `xl_userinfo` VALUES ('789', '', null, null, null, '1', '0.00', null, null, '', '', '1528628650', '0', '0', '0', '0', '0.00', '', 'oJj3g025MotJ5kUZhmQbNbxQUQsE', 'aef74d4156831e6e943233248c658967', '');
INSERT INTO `xl_userinfo` VALUES ('790', '香兰阁', null, '18121015415', null, '2', '0.00', null, null, '8f47d7c5617a816e33899d317940312a', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1528961400', '1', '0', '0', '0', '0.00', '', 'oJj3g00V3p-mbP1rMRoeaGaRNNNY', 'c8044ae22d8f8a152eaf5257479aa8fe', '3e2309f10cc986e761d11632be29f3ad');
INSERT INTO `xl_userinfo` VALUES ('791', '', null, null, null, '1', '0.00', null, null, '', '', '1528961774', '0', '0', '0', '0', '0.00', '', 'oJj3g0_fNhs6BxUCwyFudpCtUJxg', 'e15b9825c7c26ad80e345ec88d435f4f', '');
INSERT INTO `xl_userinfo` VALUES ('792', '', null, null, null, '1', '0.00', null, null, '', '', '1529098893', '0', '0', '0', '0', '0.00', '', 'oJj3g00eol9D1DTr2JbLkWicC1Ag', '4221f7422772af355d2c744ba10613d6', '');
INSERT INTO `xl_userinfo` VALUES ('793', '', null, null, null, '1', '0.00', null, null, '', '', '1529126440', '0', '0', '0', '0', '0.00', '', 'oJj3g04PiWZzO3sNkjRqpex_dwac', '41d01579dfc85da1aa1ff4fa084e6426', '');
INSERT INTO `xl_userinfo` VALUES ('794', '', null, null, null, '1', '0.00', null, null, '', '', '1529378913', '0', '0', '0', '0', '0.00', '', 'oJj3g01DYJLUPEWl2-7Byfym1rvA', 'fdd83ad817cd5c9339b81dc98abd7aa6', '');
INSERT INTO `xl_userinfo` VALUES ('795', '', null, null, null, '1', '0.00', null, null, '', '', '1529599287', '0', '0', '0', '0', '0.00', '', 'oJj3g0462C6904Eeoic9W-FIz4hU', '77bd47740e858fac5ce74e42786ba8d5', '');
INSERT INTO `xl_userinfo` VALUES ('796', '', null, null, null, '1', '0.00', null, null, '', '', '1529650692', '0', '0', '0', '0', '0.00', '', 'oJj3g08cobcZPasoMub1tRJAbWPs', '73f2cef381a6796fe12c40dbc6d10e14', '');
INSERT INTO `xl_userinfo` VALUES ('797', '', null, null, null, '1', '0.00', null, null, '', '', '1529735290', '0', '0', '0', '0', '0.00', '', 'oJj3g06LFjoUgbvggaJUv32_BwRs', '962003125d86bdc07fecec4b7d7ebff4', '');
INSERT INTO `xl_userinfo` VALUES ('798', '', null, null, null, '1', '0.00', null, null, '', '', '1529746266', '0', '0', '0', '0', '0.00', '', 'oJj3g09XYFFS_TbMdp3IRxznl4IQ', 'b17b6e6a18612406f17a5098ee40e43f', '');
INSERT INTO `xl_userinfo` VALUES ('799', '', null, null, null, '1', '0.00', null, null, '', '', '1530079679', '0', '0', '0', '0', '0.00', '', 'oJj3g00j8hmv15GdhZXNZLKtw8m0', '75bff45f4855ec77d34c1b5db96b7082', '');
INSERT INTO `xl_userinfo` VALUES ('800', '思莉芙', null, '18012276444', null, '2', '0.00', null, null, '4c215bed0dc5426dcb468c2b362fbe5f', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532667295', '1', '0', '0', '0', '0.00', '', 'oJj3g07RbgK_pHAo7AtjJHigXfUg', 'afa31d6f9f9d3c9c7e011be7d20c47ce', '3f998e713a6e02287c374fd26835d87e');
INSERT INTO `xl_userinfo` VALUES ('801', '', null, null, null, '1', '0.00', null, null, '', '', '1530346069', '0', '0', '0', '0', '0.00', '', 'oJj3g073YpOKewSfD80XD9T9o-5g', '229747957e1b04df54537a654f5c016f', '');
INSERT INTO `xl_userinfo` VALUES ('802', '', null, null, null, '1', '0.00', null, null, '', '', '1530363977', '0', '0', '0', '0', '0.00', '', 'oJj3g0-dkxEF83iNcDp1aidcJR7s', 'c2380871d8d29221c7f89b0179e0d3e4', '');
INSERT INTO `xl_userinfo` VALUES ('803', '', null, null, null, '1', '0.00', null, null, '', '', '1530606213', '0', '0', '0', '0', '0.00', '', 'oJj3g03Sne1xitLxOCxO7mmUwjAQ', '20c45113bdbb09833ef208d77edcab50', '');
INSERT INTO `xl_userinfo` VALUES ('804', '', null, null, null, '1', '0.00', null, null, '', '', '1530612575', '0', '0', '0', '0', '0.00', '', 'oJj3g06G-I19eUHvaQE7ZFUm6G2Y', '2d8f92148c79a6e60e3da6a03e5c3ab2', '');
INSERT INTO `xl_userinfo` VALUES ('805', '', null, null, null, '1', '0.00', null, null, '', '', '1530945751', '0', '0', '0', '0', '0.00', '', 'oJj3g0-wR8Jmh3xWtCXJr9YpkOBc', '971e6430e677c21e1159650715f0bc22', '');
INSERT INTO `xl_userinfo` VALUES ('806', '17630507319', null, '17630507319', null, '1', '0.00', null, null, '38119721452f25e95fc884e80d1689a8', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1531309624', '1', '0', '0', '0', '0.00', '', 'oJj3g01mmO6_L4BJHrlXJrY89STo', '9f883c8d1a2e6fa119c47993687228c0', 'ffdc324c91928245f88206c3e329467e');
INSERT INTO `xl_userinfo` VALUES ('807', '', null, null, null, '1', '0.00', null, null, '', '', '1531386072', '0', '0', '0', '0', '0.00', '', 'oJj3g060sw5nq9NIRLmULuEeYAqM', 'cd5c67acf9fe9928ab67e6f63a9bce28', '');
INSERT INTO `xl_userinfo` VALUES ('808', '', null, null, null, '1', '0.00', null, null, '', '', '1531898180', '0', '0', '0', '0', '0.00', '', 'oJj3g01EKlUOvtiwZ43X4Y6tdncA', 'fcc04a48675a1854af44df01d50cc91a', '');
INSERT INTO `xl_userinfo` VALUES ('810', '', null, null, null, '1', '0.00', null, null, '', '', '1532267290', '0', '0', '0', '0', '0.00', '', 'oJj3g068zcgGoHvAKXZ_x4M5pyhc', 'c436a846b5619715f8ce9972e6129786', '');
INSERT INTO `xl_userinfo` VALUES ('811', '', null, null, null, '1', '0.00', null, null, '', '', '1532267389', '0', '0', '0', '0', '0.00', '', 'oJj3g05UbkY9DvT1z0aCHcySLXrw', '63dc04464ffb0776e18c7c9139e1fd62', '');
INSERT INTO `xl_userinfo` VALUES ('812', '', null, null, null, '1', '0.00', null, null, '', '', '1532267740', '0', '0', '0', '0', '0.00', '', 'oJj3g0zgthPJMXgqhX5ymVdmn5xI', '0d404bb00d3bc0d572b57898041e533b', '');
INSERT INTO `xl_userinfo` VALUES ('813', '', null, null, null, '1', '0.00', null, null, '', '', '1532268185', '0', '0', '0', '0', '0.00', '', 'oJj3g07Z7qPf7n2e4EOY3Ekqicx0', 'c83cfc6df92a35be1b0655d733cb7038', '');
INSERT INTO `xl_userinfo` VALUES ('814', '', null, null, null, '1', '0.00', null, null, '', '', '1532268733', '0', '0', '0', '0', '0.00', '', 'oJj3g04rJnt8DUe_XtqQYf9A0-OE', '79afb72c3314dc8bb9151d4ddba5eecb', '');
INSERT INTO `xl_userinfo` VALUES ('815', '13166311214', null, '13166311214', null, '1', '0.00', null, null, 'be9bd23fb1db9bd5c559f3edeb65158e', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532337017', '1', '0', '0', '0', '0.00', '', 'oJj3g0xs3u1LcMJ6zzqshCY_ZnKk', '874ff8c8cbd689018bdb1f630b74ddb7', 'd006bce17dc2f016b118efb55be3e121');
INSERT INTO `xl_userinfo` VALUES ('816', '', null, null, null, '1', '0.00', null, null, '', '', '1532323775', '0', '0', '0', '0', '0.00', '', 'oJj3g0zdgedM82DwJ-Tc7thyHh-A', 'e37d6c76a79d0a7233068045570ff745', '');
INSERT INTO `xl_userinfo` VALUES ('817', '', null, null, null, '1', '0.00', null, null, '', '', '1532339825', '0', '0', '0', '0', '0.00', '', 'oJj3g02MTvxq64slVKABekdGOD-U', 'b606246312c024aa62536132ec8fcd7e', '');
INSERT INTO `xl_userinfo` VALUES ('818', '', null, null, null, '1', '0.00', null, null, '', '', '1532339998', '0', '0', '0', '0', '0.00', '', 'oJj3g0xm073WxKPSbgt_RTQ8unLc', '0948fd14dcc4a88106e03eb0061648b3', '');
INSERT INTO `xl_userinfo` VALUES ('819', '', null, null, null, '1', '0.00', null, null, '', '', '1532340104', '0', '0', '0', '0', '0.00', '', 'oJj3g08JZ1q5ytTCYkqC_WeoHxPo', 'dd2b60bbe74f1b7a176303d4a4ee5e22', '');
INSERT INTO `xl_userinfo` VALUES ('820', '', null, null, null, '1', '0.00', null, null, '', '', '1532340122', '0', '0', '0', '0', '0.00', '', 'oJj3g0-5YLxVpVxp4vhwHOXgAQ_M', 'd246bbdb9541355d4b012ba9bd978afd', '');
INSERT INTO `xl_userinfo` VALUES ('821', '', null, null, null, '1', '0.00', null, null, '', '', '1532340164', '0', '0', '0', '0', '0.00', '', 'oJj3g0yUZr5_mYneCPikLg0couv0', 'e9bba1afeba0b8124a86d321e9b38f82', '');
INSERT INTO `xl_userinfo` VALUES ('822', '', null, null, null, '1', '0.00', null, null, '', '', '1532340170', '0', '0', '0', '0', '0.00', '', 'oJj3g00ZU-Fs4sHcKtylQJpGlCFU', '8cc66068cca2fc6cf5fd2916bd8baf9f', '');
INSERT INTO `xl_userinfo` VALUES ('823', '', null, null, null, '1', '0.00', null, null, '', '', '1532340309', '0', '0', '0', '0', '0.00', '', 'oJj3g0zrAK6-5q6QQjvpoDLRMG_c', '06fa94fcd9cde5fdcd9957d70c1f4fe2', '');
INSERT INTO `xl_userinfo` VALUES ('824', '', null, null, null, '1', '0.00', null, null, '', '', '1532340472', '0', '0', '0', '0', '0.00', '', 'oJj3g0_NeDFz1b6sqEeWyuorz6gU', '8ee415ffce9e0e9592addfb9cf0905e2', '');
INSERT INTO `xl_userinfo` VALUES ('825', '', null, null, null, '1', '0.00', null, null, '', '', '1532340777', '0', '0', '0', '0', '0.00', '', 'oJj3g078M4GqmRBCghL5ONSNfdoU', 'dc6329c6f91441cdf5b644e9cd483ce0', '');
INSERT INTO `xl_userinfo` VALUES ('826', '', null, null, null, '1', '0.00', null, null, '', '', '1532341111', '0', '0', '0', '0', '0.00', '', 'oJj3g097HoFb1dU7MuECBcR6IZcw', '7c433f34734781973f2bd2a713337a39', '');
INSERT INTO `xl_userinfo` VALUES ('827', '', null, null, null, '1', '0.00', null, null, '', '', '1532341139', '0', '0', '0', '0', '0.00', '', 'oJj3g0xcPnKn4pfLX61nE-zve8aM', '342962c0919864bdc7d88d5c8c5ea0a0', '');
INSERT INTO `xl_userinfo` VALUES ('828', '', null, null, null, '1', '0.00', null, null, '', '', '1532341305', '0', '0', '0', '0', '0.00', '', 'oJj3g05ddFxKfxQdhGJd0viDoaFA', 'ebf8b0102eeb84864ba4e8bb766a57f2', '');
INSERT INTO `xl_userinfo` VALUES ('829', '15921164142', null, '15921164142', null, '1', '0.00', null, null, '12ca6ff7a63b3fa44304d0c557733281', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532341496', '1', '0', '0', '0', '0.00', '', 'oJj3g08KM_uvrfk9lhHdqdIFZSxo', 'ec5cd17daef5b2b010f98f438aa0bbec', '7cb8bef8be2221a6c4fc8fa63e058a5b');
INSERT INTO `xl_userinfo` VALUES ('830', '', null, null, null, '1', '0.00', null, null, '', '', '1532341541', '0', '0', '0', '0', '0.00', '', 'oJj3g094GhfzoaY56frVMaH3Ourw', '307f87529a10ab71887b065702d04980', '');
INSERT INTO `xl_userinfo` VALUES ('831', '', null, null, null, '1', '0.00', null, null, '', '', '1532341828', '0', '0', '0', '0', '0.00', '', 'oJj3g027L6v-IHWX4A-xmA_th008', '0531df4a0b87549564d5d608e1359fe5', '');
INSERT INTO `xl_userinfo` VALUES ('832', '', null, null, null, '1', '0.00', null, null, '', '', '1532341908', '0', '0', '0', '0', '0.00', '', 'oJj3g07jQOM44fm3rii7zF1je-bQ', 'fbeb4bebc8bdfb8185098f6c5f7e9264', '');
INSERT INTO `xl_userinfo` VALUES ('833', '', null, null, null, '1', '0.00', null, null, '', '', '1532344327', '0', '0', '0', '0', '0.00', '', 'oJj3g07W41-cyvrzy-8sSsm82ge4', 'b1aa6378c0a89904a8e8285ae507b35e', '');
INSERT INTO `xl_userinfo` VALUES ('834', '', null, null, null, '1', '0.00', null, null, '', '', '1532344526', '0', '0', '0', '0', '0.00', '', 'oJj3g09IX1rdrWSRCGNFWHBTbhuA', '7f17ecc3b3dc80ea1bd5dda35b9a83af', '');
INSERT INTO `xl_userinfo` VALUES ('835', '', null, null, null, '1', '0.00', null, null, '', '', '1532345031', '0', '0', '0', '0', '0.00', '', 'oJj3g0xzuXusc34P02ukXd6uVRZU', '5e30413d0c9b20377a1195caad8f0679', '');
INSERT INTO `xl_userinfo` VALUES ('836', '', null, null, null, '1', '0.00', null, null, '', '', '1532346335', '0', '0', '0', '0', '0.00', '', 'oJj3g04HvllwHNkR35K9I0bp2OOc', '7c64a627dbe913a18bee8398d219f3a7', '');
INSERT INTO `xl_userinfo` VALUES ('837', '', null, null, null, '1', '0.00', null, null, '', '', '1532348014', '0', '0', '0', '0', '0.00', '', 'oJj3g0-Fq5xoIJSbebxOnYrM1fHc', '9ad2b8bdcd99e3cd2552d922d89f1bca', '');
INSERT INTO `xl_userinfo` VALUES ('838', '', null, null, null, '1', '0.00', null, null, '', '', '1532353328', '0', '0', '0', '0', '0.00', '', 'oJj3g013-BpxOJzJV-4inLbFSf8I', '8d3f1d841c8a7f083988d0be64c97b25', '');
INSERT INTO `xl_userinfo` VALUES ('839', '', null, null, null, '1', '0.00', null, null, '', '', '1532356479', '0', '0', '0', '0', '0.00', '', 'oJj3g078kvk2_rfwwjZ9QYZ5wUPs', '4b1a13b5a3512f9c0b2cdfb9d0b8f2bd', '');
INSERT INTO `xl_userinfo` VALUES ('840', '', null, null, null, '1', '0.00', null, null, '', '', '1532356672', '0', '0', '0', '0', '0.00', '', 'oJj3g0wL4080D9gL9qxocUt6p36A', '9efdb164d2f4a67e55f70947ef9fc701', '');
INSERT INTO `xl_userinfo` VALUES ('841', '', null, null, null, '1', '0.00', null, null, '', '', '1532407192', '0', '0', '0', '0', '0.00', '', 'oJj3g01lq0zITNNAnWifpVg_C0dY', 'eb108a5bbdffbedf5417d586cc8f450b', '');
INSERT INTO `xl_userinfo` VALUES ('842', '18221660575', null, '18221660575', null, '3', '0.00', null, null, '8f9413ecc66945316d6f43abc02a8b56', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532498457', '1', '0', '0', '0', '0.00', '', 'oJj3g04vzBEzO5lCnA9-3ut2OlGg', 'a5643e352a3e071e98aefd5e7d43388e', '5b448f7d78ddecf3578f85e44038c1bd');
INSERT INTO `xl_userinfo` VALUES ('843', '', null, null, null, '1', '0.00', null, null, '', '', '1532496147', '0', '0', '0', '0', '0.00', '', 'oJj3g00JVwufiouJi8ibxzD9RNsM', '57bdce8d759e22749b47b47cd4f074f4', '');
INSERT INTO `xl_userinfo` VALUES ('844', '克丽缇娜江浦店', null, '15901878442', null, '2', '0.00', null, null, '386d34ec3e6733e573f5a6492dd349cd', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532512762', '1', '0', '0', '0', '0.00', '', 'oJj3g09q8xUAfSdBrfTylSK5hC4c', 'fda6599e93d71ce0156b065a9a2505d9', '27f8674dd42d4dbad025377e543dd711');
INSERT INTO `xl_userinfo` VALUES ('845', '', null, null, null, '1', '0.00', null, null, '', '', '1532577322', '0', '0', '0', '0', '0.00', '', 'oJj3g03EKLZK4WyMmHplOG_8dO_g', '4005015e5c5907c8cf631d50252259c5', '');
INSERT INTO `xl_userinfo` VALUES ('846', '', null, null, null, '1', '0.00', null, null, '', '', '1532598815', '0', '0', '0', '0', '0.00', '', 'oJj3g03MKdWGkdonlVu1yfe5qbt4', '216507248d36287874eaf235275e05cf', '');
INSERT INTO `xl_userinfo` VALUES ('847', '', null, null, null, '1', '0.00', null, null, '', '', '1532680310', '0', '0', '0', '0', '0.00', '', 'oJj3g0yebmS-QQekywW34sEN0vRs', 'acd1844f90c92ebf990eaeca8280ba66', '');
INSERT INTO `xl_userinfo` VALUES ('848', '', null, null, null, '1', '0.00', null, null, '', '', '1532683602', '0', '0', '0', '0', '0.00', '', 'oJj3g0yU2MOTRe5EJgLJ6IaLi5RI', '36ed32fcc5a7aaed88a3ed449901669f', '');
INSERT INTO `xl_userinfo` VALUES ('849', '13155549114', null, '13155549114', null, '1', '0.00', null, null, 'f1f68cad250487da2a1951b496f0f2ac', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532751878', '1', '0', '0', '0', '0.00', '', 'oJj3g05-nCa4ZgmAZNOCqpzAHyGE', '0c283e094e2d0d75b5773bbf6ba513f7', '30e05e44e620ef12586bed5352dcd218');
INSERT INTO `xl_userinfo` VALUES ('850', '寇氏减肥环城南路店', null, '15921172406', null, '2', '0.00', null, null, 'e141bb075037c181f6dd46a733f52e6e', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1532931382', '1', '0', '0', '0', '0.00', '', 'oJj3g09Y4V5rjw3h4b0lvYk6Wnuw', 'beccc65e08da0c578333fe0665ccc6f0', '11ccf58f042c0bfac410befd3513abcf');
INSERT INTO `xl_userinfo` VALUES ('851', '', null, null, null, '1', '0.00', null, null, '', '', '1532936696', '0', '0', '0', '0', '0.00', '', 'oJj3g085sJCSQdY3SQAzkgY16wd8', '5abf93f9f4969858057dff71f578d597', '');
INSERT INTO `xl_userinfo` VALUES ('852', '18221851508', null, '18221851508', null, '1', '0.00', null, null, '994c1e9c36dd46769ad3364e4489c845', 'http://www.amyshirley.com/aml/img/headimg/aml_logo.png', '1533017110', '1', '0', '0', '0', '0.00', '', 'oJj3g0_7pAp9LAajyZiDcatGkOZw', '7fbcdc51b387662f61999d06310d9780', '7fdb263344bd6f672fe6320d097150f0');
INSERT INTO `xl_userinfo` VALUES ('853', '', null, null, null, '1', '0.00', null, null, '', '', '1533017080', '0', '0', '0', '0', '0.00', '', 'oJj3g075M49epn5DIJMLy08tVe-w', '9aee6bdf7ee30e836c16c261d3e7bf68', '');
INSERT INTO `xl_userinfo` VALUES ('854', '', null, null, null, '1', '0.00', null, null, '', '', '1533105278', '0', '0', '0', '0', '0.00', '', 'oJj3g0zCRsnmecZkupyCkhqGw67M', 'f35819c30e90ef6cb27da2929a2c0fab', '');
INSERT INTO `xl_userinfo` VALUES ('855', '', null, null, null, '1', '0.00', null, null, '', '', '1533113014', '0', '0', '0', '0', '0.00', '', 'oJj3g0wFZ3ZdUgYAIuLWt2cq1Zoo', '6aabec30ef703312a8b0f488ddeb287c', '');
INSERT INTO `xl_userinfo` VALUES ('856', '', null, null, null, '1', '0.00', null, null, '', '', '1533121192', '0', '0', '0', '0', '0.00', '', 'oJj3g00e4wffBNNkCQL5QiH4KfRc', 'e0e5a7e4fb00213a0187259118d3ebed', '');
INSERT INTO `xl_userinfo` VALUES ('857', '', null, null, null, '1', '0.00', null, null, '', '', '1533131675', '0', '0', '0', '0', '0.00', '', 'oJj3g08uowH8NzKkzYs3uSdZkKW0', '31061a40f9254558a5553e7b05a8bd14', '');
INSERT INTO `xl_userinfo` VALUES ('858', '', null, null, null, '1', '0.00', null, null, '', '', '1533137964', '0', '0', '0', '0', '0.00', '', 'oJj3g0zG2hwyLTE0jF0LdAUhaRXs', '330c26852e3689ebcf1c506bde0d637c', '');
INSERT INTO `xl_userinfo` VALUES ('859', '', null, null, null, '1', '0.00', null, null, '', '', '1533179209', '0', '0', '0', '0', '0.00', '', 'oJj3g06jrRnS99cn42MdUshGWon0', '4beb2b65300d1e0e07673aa7e0abf5c6', '');
INSERT INTO `xl_userinfo` VALUES ('860', '', null, null, null, '1', '0.00', null, null, '', '', '1533179209', '0', '0', '0', '0', '0.00', '', 'oJj3g0ycIlNpenkPfrVW0fSo0stk', '35eb60eeab4fef103a85ac1b3ed6bc2b', '');
INSERT INTO `xl_userinfo` VALUES ('861', '', null, null, null, '1', '0.00', null, null, '', '', '1533208799', '0', '0', '0', '0', '0.00', '', 'oJj3g08cqIaLtjdUBW4EroW7oR4o', '7c800965f959e1a1e9795304d224a42d', '');
INSERT INTO `xl_userinfo` VALUES ('862', '', null, null, null, '1', '0.00', null, null, '', '', '1533286261', '0', '0', '0', '0', '0.00', '', 'oJj3g06GMWLufJiQce8hmHCm0ldo', '68fe9e07d924486066a8435deec68f63', '');
INSERT INTO `xl_userinfo` VALUES ('863', '', null, null, null, '1', '0.00', null, null, '', '', '1533557917', '0', '0', '0', '0', '0.00', '', 'oJj3g06oLwEadrycaSvS76smMoEM', '90da93a00128c1dbdacceb0bf480db96', '');
INSERT INTO `xl_userinfo` VALUES ('864', '', null, null, null, '1', '0.00', null, null, '', '', '1533626671', '0', '0', '0', '0', '0.00', '', 'oJj3g0-TKUOsJpPhWXL6XJTzgyVM', '76fdf4bd2c14b06579de88defc18cba9', '');
INSERT INTO `xl_userinfo` VALUES ('865', '', null, null, null, '1', '0.00', null, null, '', '', '1533644475', '0', '0', '0', '0', '0.00', '', 'oJj3g06m04z_SdzADB5QJlmQ2w1Y', '809b01cf779ce29e72d7fe19d8c13919', '');
INSERT INTO `xl_userinfo` VALUES ('866', '', null, null, null, '1', '0.00', null, null, '', '', '1533721114', '0', '0', '0', '0', '0.00', '', 'oJj3g03AmpyCUTlX_JNqebltjEtE', '469c095744cac6dd86c475b60b95a9dd', '');

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
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xl_withdrawlist
-- ----------------------------
INSERT INTO `xl_withdrawlist` VALUES ('59', '775', '1533458848', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('60', '775', '1533459597', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('61', '775', '1533461229', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('63', '550', '1533462708', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('64', '550', '1533462712', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('65', '550', '1533462714', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('66', '550', '1533462725', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('67', '550', '1533462728', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('68', '512', '1533462817', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('69', '550', '1533462819', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('70', '512', '1533462820', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('71', '512', '1533462881', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('72', '512', '1533463012', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('73', '512', '1533463263', '1.10', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('74', '512', '1533463275', '2.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('75', '512', '1533463331', '1.00', '', '0', null);
INSERT INTO `xl_withdrawlist` VALUES ('76', '512', '1533463745', '1.10', '', '0', null);
