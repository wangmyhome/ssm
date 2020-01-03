/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50641
 Source Host           : localhost:3306
 Source Schema         : ssm_crm

 Target Server Type    : MySQL
 Target Server Version : 50641
 File Encoding         : 65001

 Date: 03/01/2020 14:22:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '真实姓名',
  `sex` int(2) NULL DEFAULT NULL COMMENT '性别 1男 2 女',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `phone_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户手机号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '用户创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account`(`account`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (36, '6589654', 'wxm1452', '曹操', 1, '551125@qq.com', '15481548466', '2020-01-03 00:00:00');
INSERT INTO `user` VALUES (37, '51512', '123we', '诸葛亮', 1, '56151@qq.com', '15651454121', '2020-01-03 00:00:00');
INSERT INTO `user` VALUES (38, '542121', 'pkpl12122', '武则天', 2, '155121@qq.com', '15652865247', '2020-01-03 00:00:00');
INSERT INTO `user` VALUES (39, '1545485', '455155454', 'masmdkl', 1, 'asd@qq.com', '15656245455', '2020-01-03 00:00:00');
INSERT INTO `user` VALUES (40, '214324', 'wqe231', 'asda', 2, 'sada454@qq.com', '15454845487', '2020-01-03 00:00:00');
INSERT INTO `user` VALUES (41, '54151', '1215wqw1', '吕布', 1, '1231@qq.com', '15465324554', '2020-01-03 00:00:00');

SET FOREIGN_KEY_CHECKS = 1;
