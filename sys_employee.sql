/*
 Navicat Premium Data Transfer

 Source Server         : mysql_project
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : zhaopin

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 29/06/2020 08:25:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_employee
-- ----------------------------
DROP TABLE IF EXISTS `sys_employee`;
CREATE TABLE `sys_employee` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '员工ID',
  `name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '员工姓名',
  `sex` enum('男','女','保密') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '保密' COMMENT '员工性别',
  `birthday` date DEFAULT NULL COMMENT '员工出生日期',
  `age` int DEFAULT NULL COMMENT '员工年龄',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '员工手机号',
  `address` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '员工住址',
  `salary` bigint DEFAULT NULL COMMENT '员工薪资',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '员工邮箱',
  `job` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '员工职位',
  `status` tinyint DEFAULT NULL COMMENT '员工在职状态，1表示在职',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `entry_time` date DEFAULT NULL COMMENT '入职时间',
  `departure_time` date DEFAULT NULL COMMENT '离职时间',
  `modify_time` date DEFAULT NULL COMMENT '最后一次信息修改时间',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET FOREIGN_KEY_CHECKS = 1;
