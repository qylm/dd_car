/*
Navicat MySQL Data Transfer

Source Server         : dd
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : dd_car

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-12-23 10:39:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dd_activity
-- ----------------------------
-- DROP TABLE IF EXISTS `dd_activity`;
drop database if exists dd_car;
create database dd_car default CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
USE dd_car;


CREATE TABLE `dd_activity` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动规则表id主键',
  `d_type` int(11) DEFAULT NULL COMMENT '类型：1-打折，2-满减',
  `d_remarks` varchar(255) DEFAULT NULL COMMENT '活动规则描述',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_activity
-- ----------------------------

-- ----------------------------
-- Table structure for dd_add
-- ----------------------------
DROP TABLE IF EXISTS `dd_add`;
CREATE TABLE `dd_add` (
  `d_id` int(11) NOT NULL COMMENT '常用地址表id',
  `d_userid` int(11) DEFAULT NULL COMMENT '用户id，外键',
  `d_address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `d_type` int(11) DEFAULT NULL COMMENT '地址类型：0-家；1-公司',
  PRIMARY KEY (`d_id`),
  KEY `dd_add_ibfk_1` (`d_userid`),
  CONSTRAINT `dd_add_ibfk_1` FOREIGN KEY (`d_userid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_add
-- ----------------------------

-- ----------------------------
-- Table structure for dd_applyorder
-- ----------------------------
DROP TABLE IF EXISTS `dd_applyorder`;
CREATE TABLE `dd_applyorder` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单详情表主键id',
  `d_userid` int(11) DEFAULT NULL COMMENT '关联用户表id外键',
  `d_uptime` datetime DEFAULT NULL COMMENT '订单发布时间',
  `d_startlocation` varchar(10) DEFAULT NULL COMMENT '起始点',
  `d_endlocation` varchar(10) DEFAULT NULL COMMENT '终点',
  `d_planmileage` double DEFAULT NULL COMMENT '里程',
  `d_plangold` double DEFAULT NULL COMMENT '预计金额',
  `d_peoples` smallint(6) DEFAULT NULL COMMENT '乘坐人数',
  `d_state` int(11) DEFAULT NULL COMMENT '订单状态：1-关闭，2-完成',
  PRIMARY KEY (`d_id`),
  KEY `d_userid` (`d_userid`),
  CONSTRAINT `dd_applyorder_ibfk_1` FOREIGN KEY (`d_userid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_applyorder
-- ----------------------------

-- ----------------------------
-- Table structure for dd_appraise
-- ----------------------------
DROP TABLE IF EXISTS `dd_appraise`;
CREATE TABLE `dd_appraise` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论表id主键',
  `d_applyorderid` int(11) DEFAULT NULL COMMENT '关联订单详情表iD外键',
  `d_time` datetime DEFAULT NULL COMMENT '评论时间',
  `d_content` tinytext COMMENT '评论内容',
  `d_score` double DEFAULT NULL COMMENT '评分',
  PRIMARY KEY (`d_id`),
  KEY `d_applyorderid` (`d_applyorderid`),
  CONSTRAINT `dd_appraise_ibfk_1` FOREIGN KEY (`d_applyorderid`) REFERENCES `dd_applyorder` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_appraise
-- ----------------------------

-- ----------------------------
-- Table structure for dd_banner
-- ----------------------------
DROP TABLE IF EXISTS `dd_banner`;
CREATE TABLE `dd_banner` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'banner表id',
  `d_url` varchar(100) DEFAULT NULL COMMENT '图片url',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_banner
-- ----------------------------

-- ----------------------------
-- Table structure for dd_cargps
-- ----------------------------
DROP TABLE IF EXISTS `dd_cargps`;
CREATE TABLE `dd_cargps` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '车主定位表id',
  `d_userid` int(11) DEFAULT NULL COMMENT '用户id外键',
  `d_location` char(10) DEFAULT NULL COMMENT '车主定位经纬度',
  `d_updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`d_id`),
  KEY `dd_cargps_ibfk_1` (`d_userid`),
  CONSTRAINT `dd_cargps_ibfk_1` FOREIGN KEY (`d_userid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_cargps
-- ----------------------------

-- ----------------------------
-- Table structure for dd_carinfo
-- ----------------------------
DROP TABLE IF EXISTS `dd_carinfo`;
CREATE TABLE `dd_carinfo` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '车辆信息id',
  `d_carownerid` int(11) DEFAULT NULL COMMENT '车主信息id外键',
  `d_brand` varchar(20) DEFAULT NULL COMMENT '汽车品牌',
  `d_cartype` varchar(20) DEFAULT NULL COMMENT '汽车型号',
  `d_carnumber` varchar(20) DEFAULT NULL COMMENT '车牌',
  `d_busload` smallint(6) DEFAULT NULL COMMENT '载客量',
  PRIMARY KEY (`d_id`),
  KEY `d_carownerid` (`d_carownerid`),
  CONSTRAINT `dd_carinfo_ibfk_1` FOREIGN KEY (`d_carownerid`) REFERENCES `dd_carowner` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_carinfo
-- ----------------------------

-- ----------------------------
-- Table structure for dd_carowner
-- ----------------------------
DROP TABLE IF EXISTS `dd_carowner`;
CREATE TABLE `dd_carowner` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '车主信息表主键id',
  `d_userid` int(11) DEFAULT NULL COMMENT '用户id外键',
  `d_drivingid` int(11) DEFAULT NULL COMMENT '驾驶证号',
  `d_state` int(11) DEFAULT NULL COMMENT '车主状态：0-审核中；1-审核通过；2-审核不通过',
  `d_score` double DEFAULT NULL COMMENT '车主评分',
  PRIMARY KEY (`d_id`),
  KEY `dd_carowner_ibfk_1` (`d_userid`),
  CONSTRAINT `dd_carowner_ibfk_1` FOREIGN KEY (`d_userid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_carowner
-- ----------------------------

-- ----------------------------
-- Table structure for dd_carphoto
-- ----------------------------
DROP TABLE IF EXISTS `dd_carphoto`;
CREATE TABLE `dd_carphoto` (
  `d_id` int(11) NOT NULL COMMENT '车辆照片id',
  `d_carinfoid` int(11) DEFAULT NULL COMMENT '车辆信息id外键',
  `d_img` varchar(100) DEFAULT NULL COMMENT '车辆照片',
  `d_imgtype` varchar(20) DEFAULT NULL COMMENT '车辆照片类型',
  PRIMARY KEY (`d_id`),
  KEY `d_carinfoid` (`d_carinfoid`),
  CONSTRAINT `dd_carphoto_ibfk_1` FOREIGN KEY (`d_carinfoid`) REFERENCES `dd_carinfo` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_carphoto
-- ----------------------------

-- ----------------------------
-- Table structure for dd_cartype
-- ----------------------------
DROP TABLE IF EXISTS `dd_cartype`;
CREATE TABLE `dd_cartype` (
  `d_id` int(11) NOT NULL COMMENT '车主运营类型id',
  `d_carownerid` int(11) DEFAULT NULL COMMENT '车主信息表id，外键',
  `d_cartype` int(11) DEFAULT NULL COMMENT '运营类型：1-快车，2-顺风车，3-出租车，4-专车',
  PRIMARY KEY (`d_id`),
  KEY `d_carownerid` (`d_carownerid`),
  CONSTRAINT `dd_cartype_ibfk_1` FOREIGN KEY (`d_carownerid`) REFERENCES `dd_carowner` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_cartype
-- ----------------------------

-- ----------------------------
-- Table structure for dd_collection
-- ----------------------------
DROP TABLE IF EXISTS `dd_collection`;
CREATE TABLE `dd_collection` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '收付款记录主键id',
  `d_time` datetime DEFAULT NULL COMMENT '付款时间',
  `d_fromuserid` int(11) DEFAULT NULL COMMENT '付款人',
  `d_touserid` int(11) DEFAULT NULL,
  `d_gold` double DEFAULT NULL COMMENT '付款金额',
  PRIMARY KEY (`d_id`),
  KEY `d_fromuserid` (`d_fromuserid`),
  KEY `d_touserid` (`d_touserid`),
  CONSTRAINT `dd_collection_ibfk_1` FOREIGN KEY (`d_fromuserid`) REFERENCES `dd_user` (`d_id`),
  CONSTRAINT `dd_collection_ibfk_2` FOREIGN KEY (`d_touserid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_collection
-- ----------------------------

-- ----------------------------
-- Table structure for dd_complaints
-- ----------------------------
DROP TABLE IF EXISTS `dd_complaints`;
CREATE TABLE `dd_complaints` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '投诉表id',
  `d_fromuserid` int(11) DEFAULT NULL COMMENT '投诉人id外键',
  `d_touserid` int(11) DEFAULT NULL COMMENT '被投诉人id外键',
  `d_uptime` datetime DEFAULT NULL COMMENT '投诉提交时间',
  `d_remarks` varchar(255) DEFAULT NULL COMMENT '投诉描述',
  `d_state` int(11) DEFAULT NULL COMMENT '投诉处理状态：0-未处理，1-处理中，2-已完成',
  PRIMARY KEY (`d_id`),
  KEY `d_fromuserid` (`d_fromuserid`),
  KEY `d_touserid` (`d_touserid`),
  CONSTRAINT `dd_complaints_ibfk_1` FOREIGN KEY (`d_fromuserid`) REFERENCES `dd_user` (`d_id`),
  CONSTRAINT `dd_complaints_ibfk_2` FOREIGN KEY (`d_touserid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_complaints
-- ----------------------------

-- ----------------------------
-- Table structure for dd_correlate
-- ----------------------------
DROP TABLE IF EXISTS `dd_correlate`;
CREATE TABLE `dd_correlate` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动详情表id主键',
  `d_starttime` datetime DEFAULT NULL COMMENT '活动开始时间',
  `d_endtime` datetime DEFAULT NULL COMMENT '活动结束时间',
  `d_type` int(11) DEFAULT NULL COMMENT '活动类型',
  `d_remarks` varchar(255) DEFAULT NULL COMMENT '活动描述',
  `d_activityid` int(11) DEFAULT NULL COMMENT '关联活动规则表id外键',
  PRIMARY KEY (`d_id`),
  KEY `d_activityid` (`d_activityid`),
  CONSTRAINT `dd_correlate_ibfk_1` FOREIGN KEY (`d_activityid`) REFERENCES `dd_activity` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_correlate
-- ----------------------------

-- ----------------------------
-- Table structure for dd_employees
-- ----------------------------
DROP TABLE IF EXISTS `dd_employees`;

CREATE TABLE `dd_employees` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工表id',
  `d_username` varchar(30) DEFAULT NULL COMMENT '账号',
  `d_pwd` char(60) DEFAULT NULL COMMENT '密码',
  `d_state` int(11) DEFAULT '1' COMMENT '员工状态：0-锁定，1-可用',
  `d_registime` datetime DEFAULT NULL COMMENT '账号生成时间',
  `d_roleid` int(11) DEFAULT NULL COMMENT '外键角色id',
  PRIMARY KEY (`d_id`),
  KEY `d_roleid` (`d_roleid`),
  CONSTRAINT `dd_employees_ibfk_1` FOREIGN KEY (`d_roleid`) REFERENCES `dd_role` (`d_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_employees
-- ----------------------------
INSERT INTO `dd_employees` VALUES ('1', 'root', '$2y$10$oIO6uZUfGnMbZ6EcgkVtI.WKHXkc81obTnNXMaKXZogT34m2jnRIG', '1', '2017-12-23 10:32:58', '1');

-- ----------------------------
-- Table structure for dd_log
-- ----------------------------
DROP TABLE IF EXISTS `dd_log`;
CREATE TABLE `dd_log` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '操作日志表主键id',
  `d_staffid` int(11) DEFAULT NULL COMMENT '关联员工id外键',
  `d_time` datetime DEFAULT NULL COMMENT '操作时间',
  `d_content` varchar(255) DEFAULT NULL COMMENT '操作内容',
  `d_type` int(11) DEFAULT NULL COMMENT '操作类型：',
  PRIMARY KEY (`d_id`),
  KEY `d_staffid` (`d_staffid`),
  CONSTRAINT `dd_log_ibfk_1` FOREIGN KEY (`d_staffid`) REFERENCES `dd_staff` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_log
-- ----------------------------

-- ----------------------------
-- Table structure for dd_nameauthentication
-- ----------------------------
DROP TABLE IF EXISTS `dd_nameauthentication`;
CREATE TABLE `dd_nameauthentication` (
  `d_id` int(11) NOT NULL COMMENT '实名认证信息表主键id',
  `d_userid` int(11) DEFAULT NULL COMMENT '用户id外键',
  `d_name` varchar(20) DEFAULT NULL COMMENT '认证姓名',
  `d_type` int(11) DEFAULT NULL COMMENT '证件类型：0-身份证，1-军官证',
  `d_number` int(11) DEFAULT NULL COMMENT '证件号',
  `d_state` int(11) DEFAULT NULL COMMENT '认证状态',
  PRIMARY KEY (`d_id`),
  KEY `dd_nameauthentication_ibfk_1` (`d_userid`),
  CONSTRAINT `dd_nameauthentication_ibfk_1` FOREIGN KEY (`d_userid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_nameauthentication
-- ----------------------------

-- ----------------------------
-- Table structure for dd_newsimg
-- ----------------------------
DROP TABLE IF EXISTS `dd_newsimg`;
CREATE TABLE `dd_newsimg` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻图id',
  `d_url` varchar(100) DEFAULT NULL COMMENT '新闻图url',
  `d_type` int(1) DEFAULT NULL COMMENT '新闻图类型：按数字分类；',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_newsimg
-- ----------------------------

-- ----------------------------
-- Table structure for dd_operation
-- ----------------------------
DROP TABLE IF EXISTS `dd_operation`;
CREATE TABLE `dd_operation` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单操作表主键id',
  `d_applyorderid` int(11) DEFAULT NULL COMMENT '订单详情表外键id',
  `d_uptime` datetime DEFAULT NULL COMMENT '更新时间',
  `d_state` int(11) DEFAULT NULL COMMENT '订单状态：',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_operation
-- ----------------------------

-- ----------------------------
-- Table structure for dd_orderinfo
-- ----------------------------
DROP TABLE IF EXISTS `dd_orderinfo`;
CREATE TABLE `dd_orderinfo` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '正式订单信息表主键id',
  `d_applyorderid` int(11) DEFAULT NULL COMMENT '订单详情表id外键',
  `d_userid` int(11) DEFAULT NULL COMMENT '司机id',
  `d_starttime` datetime DEFAULT NULL COMMENT '旅程开始时间',
  `d_endtime` datetime DEFAULT NULL COMMENT '旅程结束时间',
  `d_mileage` double DEFAULT NULL COMMENT '实际里程',
  `d_gold` double DEFAULT NULL COMMENT '实际支付金额',
  `d_state` int(11) DEFAULT NULL COMMENT '订单状态：0-已接单，1-前往接送乘客，2-已接到乘客，3-到达目的地',
  PRIMARY KEY (`d_id`),
  KEY `d_userid` (`d_userid`),
  CONSTRAINT `dd_orderinfo_ibfk_1` FOREIGN KEY (`d_userid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_orderinfo
-- ----------------------------

-- ----------------------------
-- Table structure for dd_orderpay
-- ----------------------------
DROP TABLE IF EXISTS `dd_orderpay`;
CREATE TABLE `dd_orderpay` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单支付表主键id',
  `d_applyorderid` int(11) DEFAULT NULL COMMENT '关联订单详情id外键',
  `d_paytime` datetime DEFAULT NULL COMMENT '付款时间',
  `d_paynumber` double DEFAULT NULL COMMENT '付款金额',
  `d_paystate` int(11) DEFAULT NULL COMMENT '付款状态：0-未支付，1-已支付',
  PRIMARY KEY (`d_id`),
  KEY `d_applyorderid` (`d_applyorderid`),
  CONSTRAINT `dd_orderpay_ibfk_1` FOREIGN KEY (`d_applyorderid`) REFERENCES `dd_applyorder` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_orderpay
-- ----------------------------

-- ----------------------------
-- Table structure for dd_orderrule
-- ----------------------------
DROP TABLE IF EXISTS `dd_orderrule`;
CREATE TABLE `dd_orderrule` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单计费规则表主键id',
  `d_name` varchar(30) DEFAULT NULL COMMENT '规则名',
  `d_type` int(11) DEFAULT NULL COMMENT '规则类型',
  `d_remarks` varchar(255) DEFAULT NULL COMMENT '规则描述',
  `d_starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `d_endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `d_billingcharging` double DEFAULT NULL COMMENT '计费/公里',
  `d_startprice` double DEFAULT NULL COMMENT '起步价',
  `d_cartype` int(11) DEFAULT NULL COMMENT '运营车辆类型，活动使用类型',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_orderrule
-- ----------------------------

-- ----------------------------
-- Table structure for dd_rechargerecord
-- ----------------------------
DROP TABLE IF EXISTS `dd_rechargerecord`;
CREATE TABLE `dd_rechargerecord` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '充值表主键id',
  `d_userid` int(11) DEFAULT NULL COMMENT '关联用户id外键',
  `d_rechargetime` datetime DEFAULT NULL COMMENT '充值时间',
  `d_rechargenumber` int(11) DEFAULT '100' COMMENT '充值金额',
  PRIMARY KEY (`d_id`),
  KEY `d_userid` (`d_userid`),
  CONSTRAINT `dd_rechargerecord_ibfk_1` FOREIGN KEY (`d_userid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_rechargerecord
-- ----------------------------

-- ----------------------------
-- Table structure for dd_role
-- ----------------------------
DROP TABLE IF EXISTS `dd_role`;
CREATE TABLE `dd_role` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色iD主键',
  `d_name` char(10) DEFAULT NULL COMMENT '角色名',
  `d_remarks` varchar(100) DEFAULT NULL COMMENT '角色描述',
  `d_level` int(11) DEFAULT NULL COMMENT '角色等级',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_role
-- ----------------------------
INSERT INTO `dd_role` VALUES ('1', '超级管理员', '创世神', '777');

-- ----------------------------
-- Table structure for dd_rolestaff
-- ----------------------------
DROP TABLE IF EXISTS `dd_rolestaff`;
CREATE TABLE `dd_rolestaff` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限关联表id主键',
  `d_roleid` int(11) DEFAULT NULL COMMENT '角色iD外键',
  `d_staffid` int(11) DEFAULT NULL COMMENT '权限id外键',
  PRIMARY KEY (`d_id`),
  KEY `d_roleid` (`d_roleid`),
  KEY `d_staffid` (`d_staffid`),
  CONSTRAINT `dd_rolestaff_ibfk_1` FOREIGN KEY (`d_roleid`) REFERENCES `dd_role` (`d_id`),
  CONSTRAINT `dd_rolestaff_ibfk_2` FOREIGN KEY (`d_staffid`) REFERENCES `dd_staff` (`d_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_rolestaff
-- ----------------------------
INSERT INTO `dd_rolestaff` VALUES ('1', '1', '1');
INSERT INTO `dd_rolestaff` VALUES ('2', '1', '2');
INSERT INTO `dd_rolestaff` VALUES ('3', '1', '3');
INSERT INTO `dd_rolestaff` VALUES ('4', '1', '4');
INSERT INTO `dd_rolestaff` VALUES ('5', '1', '5');
INSERT INTO `dd_rolestaff` VALUES ('6', '1', '6');
INSERT INTO `dd_rolestaff` VALUES ('7', '1', '7');
INSERT INTO `dd_rolestaff` VALUES ('8', '1', '8');
INSERT INTO `dd_rolestaff` VALUES ('9', '1', '9');
INSERT INTO `dd_rolestaff` VALUES ('10', '1', '10');
INSERT INTO `dd_rolestaff` VALUES ('11', '1', '11');
INSERT INTO `dd_rolestaff` VALUES ('12', '1', '12');
INSERT INTO `dd_rolestaff` VALUES ('13', '1', '13');
INSERT INTO `dd_rolestaff` VALUES ('14', '1', '14');
INSERT INTO `dd_rolestaff` VALUES ('15', '1', '15');
INSERT INTO `dd_rolestaff` VALUES ('16', '1', '16');
INSERT INTO `dd_rolestaff` VALUES ('17', '1', '17');
INSERT INTO `dd_rolestaff` VALUES ('18', '1', '18');
INSERT INTO `dd_rolestaff` VALUES ('19', '1', '19');
INSERT INTO `dd_rolestaff` VALUES ('20', '1', '20');
INSERT INTO `dd_rolestaff` VALUES ('21', '1', '21');

-- ----------------------------
-- Table structure for dd_route
-- ----------------------------
DROP TABLE IF EXISTS `dd_route`;
CREATE TABLE `dd_route` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路线详情表主键id',
  `d_applyorderid` int(11) DEFAULT NULL COMMENT '关联订单详情表id外键',
  `d_startlocation` char(10) DEFAULT NULL COMMENT '开始七点',
  `d_endlocation` char(10) DEFAULT NULL COMMENT '结束地点',
  `d_carerstate` int(11) DEFAULT NULL COMMENT '车主状态',
  PRIMARY KEY (`d_id`),
  KEY `d_applyorderid` (`d_applyorderid`),
  CONSTRAINT `dd_route_ibfk_1` FOREIGN KEY (`d_applyorderid`) REFERENCES `dd_applyorder` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_route
-- ----------------------------

-- ----------------------------
-- Table structure for dd_staff
-- ----------------------------
DROP TABLE IF EXISTS `dd_staff`;
CREATE TABLE `dd_staff` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限表id主键',
  `d_name` varchar(10) DEFAULT NULL COMMENT '权限名',
  `d_url` varchar(50) DEFAULT NULL COMMENT '权限网址',
  `d_fsid` int(11) DEFAULT NULL COMMENT '权限父id',
  PRIMARY KEY (`d_id`),
  KEY `d_fsid` (`d_fsid`),
  CONSTRAINT `dd_staff_ibfk_1` FOREIGN KEY (`d_fsid`) REFERENCES `dd_staff` (`d_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_staff
-- ----------------------------
INSERT INTO `dd_staff` VALUES ('1', '总权限', null, null);
INSERT INTO `dd_staff` VALUES ('2', '内部管理', null, '1');
INSERT INTO `dd_staff` VALUES ('3', '财务管理', null, '1');
INSERT INTO `dd_staff` VALUES ('4', '用户管理', null, '1');
INSERT INTO `dd_staff` VALUES ('5', '订单管理', '', '1');
INSERT INTO `dd_staff` VALUES ('6', '评价管理', 'appraise', '1');
INSERT INTO `dd_staff` VALUES ('7', '投诉管理', 'complaints', '1');
INSERT INTO `dd_staff` VALUES ('8', '活动管理', null, '1');
INSERT INTO `dd_staff` VALUES ('9', '客服管理', 'service', '1');
INSERT INTO `dd_staff` VALUES ('10', '消息管理', 'message', '1');
INSERT INTO `dd_staff` VALUES ('11', '运营监控', 'operationmanager', '1');
INSERT INTO `dd_staff` VALUES ('12', '数据统计', 'datastatistics', '1');
INSERT INTO `dd_staff` VALUES ('13', '操作日志', 'operationlog', '1');
INSERT INTO `dd_staff` VALUES ('14', '员工管理', 'staff', '2');
INSERT INTO `dd_staff` VALUES ('15', '角色管理', 'role', '2');
INSERT INTO `dd_staff` VALUES ('16', '转账记录', 'transferrecord', '3');
INSERT INTO `dd_staff` VALUES ('17', '充值记录', 'rechargerecord', '3');
INSERT INTO `dd_staff` VALUES ('18', '订单详情', 'orderinfo', '5');
INSERT INTO `dd_staff` VALUES ('19', '计费规则', 'billingrule', '5');
INSERT INTO `dd_staff` VALUES ('20', '活动详情', 'activityinfo', '8');
INSERT INTO `dd_staff` VALUES ('21', '活动规则', 'activityrule', '8');

-- ----------------------------
-- Table structure for dd_user
-- ----------------------------
DROP TABLE IF EXISTS `dd_user`;
CREATE TABLE `dd_user` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id主键',
  `d_tell` int(11) NOT NULL COMMENT '用户手机，用于登录',
  `d_pwd` char(32) NOT NULL COMMENT '用户密码',
  `d_carer` int(1) DEFAULT '0' COMMENT '车主认证，0-未认证。1-已认证',
  `d_state` int(1) DEFAULT '0' COMMENT '用户状态：0-正常使用，1-锁定',
  `d_level` int(1) DEFAULT '0' COMMENT '用户等级：0-普通会员，1-中级会员，2-高级会员',
  `d_salt` char(60) DEFAULT NULL COMMENT '盐',
  `d_nickname` char(30) DEFAULT NULL COMMENT '用户昵称：限制在30字符内',
  `d_headimg` varchar(100) DEFAULT NULL COMMENT '用户头像：字符长度限制100字符',
  `d_score` double DEFAULT NULL COMMENT '用户评分',
  PRIMARY KEY (`d_id`),
  UNIQUE KEY `d_tell` (`d_tell`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_user
-- ----------------------------
INSERT INTO `dd_user` VALUES ('1', '1588080808', 'a12345', '1', '0', '0', null, '吴彦祖', 'headimg.jpg', '10');

-- ----------------------------
-- Table structure for dd_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `dd_userinfo`;
CREATE TABLE `dd_userinfo` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户详情表id，主键递增',
  `d_userid` int(11) DEFAULT NULL COMMENT '用户id外键',
  `d_gold` double DEFAULT NULL COMMENT '用户余额',
  `d_age` smallint(6) DEFAULT NULL COMMENT '用户年龄',
  `d_sex` int(11) DEFAULT NULL COMMENT '用户性别：0-女；1-男',
  `d_sigature` varchar(255) DEFAULT NULL COMMENT '用户个性签名；有长度限制',
  `d_post` varchar(20) DEFAULT NULL COMMENT '用户所属行业',
  `d_company` varchar(50) DEFAULT NULL COMMENT '用户所属公司',
  `d_job` varchar(20) DEFAULT NULL COMMENT '用户职位',
  `d_firstman` varchar(255) DEFAULT NULL COMMENT '紧急联系人',
  `d_firsttell` int(11) DEFAULT NULL COMMENT '紧急联系电话',
  PRIMARY KEY (`d_id`),
  KEY `dd_userinfo_ibfk_1` (`d_userid`),
  CONSTRAINT `dd_userinfo_ibfk_1` FOREIGN KEY (`d_userid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_userinfo
-- ----------------------------

-- ----------------------------
-- Table structure for dd_usertoservicechatrecord
-- ----------------------------
DROP TABLE IF EXISTS `dd_usertoservicechatrecord`;
CREATE TABLE `dd_usertoservicechatrecord` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户聊天记录表iD主键',
  `d_fromuserid` int(11) DEFAULT NULL COMMENT '用户表id外键',
  `d_touserid` int(11) DEFAULT NULL COMMENT '接收用户id外键',
  `d_sendtime` datetime DEFAULT NULL COMMENT '发送时间',
  `d_content` varchar(255) DEFAULT NULL COMMENT '聊天内容',
  `d_type` int(11) DEFAULT '0' COMMENT '聊天类型：0-客服to用户；1-用户to客服',
  `d_state` int(11) DEFAULT NULL COMMENT '聊天信息状态：0-未读，1-已读',
  PRIMARY KEY (`d_id`),
  KEY `d_fromuserid` (`d_fromuserid`),
  KEY `d_touserid` (`d_touserid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_usertoservicechatrecord
-- ----------------------------

-- ----------------------------
-- Table structure for dd_usertouserchatrecord
-- ----------------------------
DROP TABLE IF EXISTS `dd_usertouserchatrecord`;
CREATE TABLE `dd_usertouserchatrecord` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户聊天记录表iD主键',
  `d_fromuserid` int(11) DEFAULT NULL COMMENT '用户表id外键',
  `d_touserid` int(11) DEFAULT NULL COMMENT '接收用户id外键',
  `d_sendtime` datetime DEFAULT NULL COMMENT '发送时间',
  `d_content` varchar(255) DEFAULT NULL COMMENT '聊天内容',
  `d_type` int(11) DEFAULT '0' COMMENT '聊天类型：0-普通',
  `d_state` int(11) unsigned zerofill DEFAULT NULL COMMENT '聊天信息状态：0-未读，1-已读',
  PRIMARY KEY (`d_id`),
  KEY `d_fromuserid` (`d_fromuserid`),
  KEY `d_touserid` (`d_touserid`),
  CONSTRAINT `dd_usertouserchatrecord_ibfk_1` FOREIGN KEY (`d_fromuserid`) REFERENCES `dd_user` (`d_id`),
  CONSTRAINT `dd_usertouserchatrecord_ibfk_2` FOREIGN KEY (`d_touserid`) REFERENCES `dd_user` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dd_usertouserchatrecord
-- ----------------------------

