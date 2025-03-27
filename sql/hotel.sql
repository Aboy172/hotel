/*
 Navicat Premium Data Transfer

 Source Server         : localhost-mysql
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : 127.0.0.1:3306
 Source Schema         : kvf_admin

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 28/10/2024 22:32:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for check_ins
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel`  (
                             `id` bigint NOT NULL AUTO_INCREMENT,
                             `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_ci NULL DEFAULT NULL COMMENT '轮播图名称',
                             `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_ci NULL COMMENT '轮播图路径',
                             `sort` tinyint NULL DEFAULT NULL COMMENT '排序',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_as_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carousel
-- ----------------------------

DROP TABLE IF EXISTS `check_ins`;
CREATE TABLE `check_ins`  (
  `check_in_id` bigint NOT NULL AUTO_INCREMENT COMMENT '入住ID',
  `reservation_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '预定ID',
  `user_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `room_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '客房ID',
  `check_in_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '实际入住时间',
  `check_out_date` timestamp NULL DEFAULT NULL COMMENT '实际退房时间',
  `total_cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '总费用',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '入住状态',
  PRIMARY KEY (`check_in_id`) USING BTREE,
  INDEX `reservation_id`(`reservation_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `room_id`(`room_id` ASC) USING BTREE,
  CONSTRAINT `check_ins_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reservation_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `check_ins_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `check_ins_ibfk_3` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '入住管理表：记录用户的实际入住和退房信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_ins
-- ----------------------------
INSERT INTO `check_ins` VALUES (1, 42, 2, 1, '2024-10-27 00:00:00', '2024-10-27 00:00:00', 1200.00, 3);
INSERT INTO `check_ins` VALUES (2, 43, 2, 2, '2024-10-27 00:00:00', '2024-10-30 00:00:00', 800.00, 3);
INSERT INTO `check_ins` VALUES (3, 43, 2, 2, '2024-10-27 00:00:00', '2024-10-28 00:00:00', 800.00, 3);

-- ----------------------------
-- Table structure for check_out_settlements
-- ----------------------------
DROP TABLE IF EXISTS `check_out_settlements`;
CREATE TABLE `check_out_settlements`  (
  `settlement_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '结算ID',
  `reservation_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '预定ID',
  `user_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '总金额',
  `paid` tinyint(1) NULL DEFAULT 0 COMMENT '是否支付完成',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结算时间',
  PRIMARY KEY (`settlement_id`) USING BTREE,
  INDEX `reservation_id`(`reservation_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `check_out_settlements_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reservation_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `check_out_settlements_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '结算表：记录退房时的结算信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_out_settlements
-- ----------------------------
INSERT INTO `check_out_settlements` VALUES (1, 42, 2, 1200.00, 2, '2024-10-27 19:44:47');
INSERT INTO `check_out_settlements` VALUES (2, 43, 2, 800.00, 2, '2024-10-28 21:21:56');

-- ----------------------------
-- Table structure for complaints
-- ----------------------------
DROP TABLE IF EXISTS `complaints`;
CREATE TABLE `complaints`  (
  `complaint_id` bigint NOT NULL AUTO_INCREMENT COMMENT '投诉ID',
  `user_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `hotel_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '酒店ID',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '投诉内容',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '投诉状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '投诉提交时间',
  PRIMARY KEY (`complaint_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `hotel_id`(`hotel_id` ASC) USING BTREE,
  CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '投诉表：存储用户的投诉信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of complaints
-- ----------------------------

-- ----------------------------
-- Table structure for hotel_notifications
-- ----------------------------
DROP TABLE IF EXISTS `hotel_notifications`;
CREATE TABLE `hotel_notifications`  (
  `notification_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `hotel_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '酒店ID',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '通知内容',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '通知发布时间',
  PRIMARY KEY (`notification_id`) USING BTREE,
  INDEX `hotel_id`(`hotel_id` ASC) USING BTREE,
  CONSTRAINT `hotel_notifications_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '酒店通知表：存储酒店发布的通知信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotel_notifications
-- ----------------------------
INSERT INTO `hotel_notifications` VALUES (1, 1, '感谢您选择豪华大酒店，祝您入住愉快！', '2024-10-21 23:23:05');
INSERT INTO `hotel_notifications` VALUES (2, 2, '海滨度假村即将举行特价促销活动，敬请期待！', '2024-10-21 23:23:05');

-- ----------------------------
-- Table structure for hotels
-- ----------------------------
DROP TABLE IF EXISTS `hotels`;
CREATE TABLE `hotels`  (
  `hotel_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '酒店ID',
  `hotel_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '酒店名称',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '酒店图片',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '酒店地址',
  `rating` decimal(2, 1) NULL DEFAULT NULL COMMENT '平均评分',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '酒店描述',
  PRIMARY KEY (`hotel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '酒店表：存储酒店的基本信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotels
-- ----------------------------
INSERT INTO `hotels` VALUES (1, '豪华大酒店', 'http://localhost/static/image/hotels/h1.jpg', '北京市朝阳区', 5.0, '提供高端的住宿服务，配备齐全的设施。');
INSERT INTO `hotels` VALUES (2, '海滨度假村', 'http://localhost/static/image/hotels/h1.jpg', '海南三亚', 4.8, '享有绝美的海景，适合家庭度假。');
INSERT INTO `hotels` VALUES (3, '经济型旅馆', 'http://localhost/static/image/hotels/h1.jpg', '上海市浦东新区', 3.0, '性价比高，适合预算有限的游客。');
INSERT INTO `hotels` VALUES (4, '青年旅馆', 'http://localhost/static/image/hotels/h1.jpg', '上海市浦东新区', 5.0, '性价比高，适合预算有限的游客。');

-- ----------------------------
-- Table structure for reservations
-- ----------------------------
DROP TABLE IF EXISTS `reservations`;
CREATE TABLE `reservations`  (
  `reservation_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '预定ID',
  `user_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `room_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '客房ID',
  `check_in_date` date NULL DEFAULT NULL COMMENT '入住日期',
  `check_out_date` date NULL DEFAULT NULL COMMENT '退房日期',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '预定状态 0未入住，1已入住',
  `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '预定总金额',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '预定创建时间',
  PRIMARY KEY (`reservation_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `room_id`(`room_id` ASC) USING BTREE,
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '预定表：存储用户的房间预定信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservations
-- ----------------------------
INSERT INTO `reservations` VALUES (41, 2, 4, '2024-10-27', '2024-10-30', 3, 1200.00, '2024-10-27 19:25:34');
INSERT INTO `reservations` VALUES (42, 2, 1, '2024-10-27', '2024-10-30', 3, 1200.00, '2024-10-27 19:42:45');
INSERT INTO `reservations` VALUES (43, 2, 2, '2024-10-27', '2024-10-30', 3, 800.00, '2024-10-27 19:44:57');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `review_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `user_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `hotel_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '酒店ID',
  `rating` decimal(2, 1) NULL DEFAULT NULL COMMENT '评分',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '评价内容',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  PRIMARY KEY (`review_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `hotel_id`(`hotel_id` ASC) USING BTREE,
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reviews_chk_1` CHECK (`rating` between 1.0 and 5.0)
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评价表：存储用户对酒店的评价' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES (1, 1, 1, 4.5, '非常满意，环境优雅。', '2024-10-21 23:23:05');
INSERT INTO `reviews` VALUES (2, 2, 2, 5.0, '无可挑剔的服务，海景房很美。', '2024-10-21 23:23:05');
INSERT INTO `reviews` VALUES (3, 2, 3, 5.0, '111', '2024-10-27 20:50:40');
INSERT INTO `reviews` VALUES (4, 2, 3, 5.0, '111', '2024-10-27 20:50:50');
INSERT INTO `reviews` VALUES (5, 2, 3, 5.0, '1111', '2024-10-27 21:03:31');
INSERT INTO `reviews` VALUES (6, 2, 3, 5.0, '111', '2024-10-27 21:03:50');
INSERT INTO `reviews` VALUES (7, 2, 3, 5.0, '222222222', '2024-10-27 21:04:41');
INSERT INTO `reviews` VALUES (8, 2, 3, 5.0, '2222222222', '2024-10-27 21:05:08');
INSERT INTO `reviews` VALUES (9, 2, 1, 5.0, '2132131', '2024-10-27 21:08:13');
INSERT INTO `reviews` VALUES (10, 2, 1, 5.0, '2222222', '2024-10-27 21:10:32');
INSERT INTO `reviews` VALUES (11, 2, 1, 5.0, '11111', '2024-10-28 21:33:38');

-- ----------------------------
-- Table structure for room_types
-- ----------------------------
DROP TABLE IF EXISTS `room_types`;
CREATE TABLE `room_types`  (
  `room_type_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '房间类型ID',
  `hotel_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '酒店ID',
  `type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间类型名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '房间类型描述',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '每晚价格',
  `capacity` int NULL DEFAULT NULL COMMENT '房间容纳人数',
  PRIMARY KEY (`room_type_id`) USING BTREE,
  INDEX `hotel_id`(`hotel_id` ASC) USING BTREE,
  CONSTRAINT `room_types_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '房间类型表：定义每个酒店的不同房间类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_types
-- ----------------------------
INSERT INTO `room_types` VALUES (1, 1, '豪华套房', '宽敞舒适，配有独立卫生间', 1200.00, 2);
INSERT INTO `room_types` VALUES (2, 1, '标准间', '适合两人入住，温馨舒适', 800.00, 2);
INSERT INTO `room_types` VALUES (3, 2, '海景房', '绝佳的海景，享受日出', 1500.00, 2);
INSERT INTO `room_types` VALUES (4, 3, '经济单人间', '适合单人入住，基础设施齐全', 400.00, 1);

-- ----------------------------
-- Table structure for rooms
-- ----------------------------
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms`  (
  `room_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '客房ID',
  `room_number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '房间号码',
  `hotel_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '酒店ID',
  `room_type_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '房间类型ID',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '房间状态',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客房照片',
  PRIMARY KEY (`room_id`) USING BTREE,
  INDEX `hotel_id`(`hotel_id` ASC) USING BTREE,
  INDEX `room_type_id`(`room_type_id` ASC) USING BTREE,
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `rooms_ibfk_2` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`room_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客房表：存储各个房间的具体信息及其状态' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rooms
-- ----------------------------
INSERT INTO `rooms` VALUES (1, '101', 1, 1, 0, 'http://localhost/static/image/hotels/h1.jpg');
INSERT INTO `rooms` VALUES (2, '102', 1, 2, 0, 'http://localhost/static/image/hotels/h1.jpg');
INSERT INTO `rooms` VALUES (3, '201', 2, 3, 1, 'http://localhost/static/image/hotels/h1.jpg');
INSERT INTO `rooms` VALUES (4, '301', 3, 4, 1, 'http://localhost/static/image/hotels/h1.jpg');

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bean` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'bean名称',
  `method` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态。0：运行中；1：已暂停；2：已完成；3：运行失败；',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES (1, 'helloJob', NULL, NULL, '0 0 12 * * ?', 1, '无参测试', '2019-08-18 13:30:08');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` bigint NOT NULL COMMENT '上级部门ID。一级部门为0',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
  `type` tinyint NOT NULL COMMENT '类型。0：公司；1：部门；2：科室/小组',
  `area_id` bigint NULL DEFAULT NULL COMMENT '所在区域ID',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序值。越小越靠前',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态。0：正常；1：禁用',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 0, 'Kalvin', 0, 1, 0, 0, '2024-10-25 21:33:46', NULL, '2019-05-01 16:40:08');
INSERT INTO `sys_dept` VALUES (2, 1, 'IT部', 1, 1, 0, 0, '2019-05-01 17:12:54', NULL, '2019-05-01 17:12:54');
INSERT INTO `sys_dept` VALUES (3, 2, '研发组', 2, 1, 0, 0, '2019-05-01 17:13:48', NULL, '2019-05-01 17:13:48');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` bigint NOT NULL COMMENT '父级ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典名称',
  `type` tinyint NOT NULL DEFAULT 0 COMMENT '类型。0：字典类别；1：字典项；',
  `code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典码',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典值',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态。0：有效；1：无效',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序值。越小越靠前',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, 0, '根目录', 0, 'ROOT', '', 0, 0, NULL);
INSERT INTO `sys_dict` VALUES (2, 1, '性别', 0, 'SEX', '', 0, 0, NULL);
INSERT INTO `sys_dict` VALUES (3, 2, '未知', 1, 'SEX_UNKNOWN', '0', 0, 0, NULL);
INSERT INTO `sys_dict` VALUES (4, 2, '男', 1, 'SEX_MAN', '1', 0, 0, NULL);
INSERT INTO `sys_dict` VALUES (5, 2, '女', 1, 'SEX_LADY', '2', 0, 0, NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录名称',
  `operation` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作功能',
  `forward_action` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作uri',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `browser` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '浏览器',
  `os` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统',
  `time` bigint NOT NULL DEFAULT 0 COMMENT '请求耗时。毫秒',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 273 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 206, '2024-10-21 21:29:13');
INSERT INTO `sys_log` VALUES (2, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 211, '2024-10-21 21:37:17');
INSERT INTO `sys_log` VALUES (3, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 9, '2024-10-21 22:03:46');
INSERT INTO `sys_log` VALUES (4, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 234, '2024-10-21 22:07:40');
INSERT INTO `sys_log` VALUES (5, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 235, '2024-10-21 22:17:31');
INSERT INTO `sys_log` VALUES (6, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 259, '2024-10-21 22:28:56');
INSERT INTO `sys_log` VALUES (7, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 276, '2024-10-21 22:36:16');
INSERT INTO `sys_log` VALUES (8, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 223, '2024-10-21 22:40:28');
INSERT INTO `sys_log` VALUES (9, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 264, '2024-10-21 22:47:01');
INSERT INTO `sys_log` VALUES (10, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 274, '2024-10-21 22:49:47');
INSERT INTO `sys_log` VALUES (11, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 283, '2024-10-21 22:51:16');
INSERT INTO `sys_log` VALUES (12, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-21 22:51:16');
INSERT INTO `sys_log` VALUES (13, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 211, '2024-10-21 23:14:39');
INSERT INTO `sys_log` VALUES (14, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 258, '2024-10-21 23:18:32');
INSERT INTO `sys_log` VALUES (15, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 229, '2024-10-21 23:30:13');
INSERT INTO `sys_log` VALUES (16, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 253, '2024-10-21 23:43:56');
INSERT INTO `sys_log` VALUES (17, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 218, '2024-10-21 23:44:25');
INSERT INTO `sys_log` VALUES (18, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 268, '2024-10-21 23:46:18');
INSERT INTO `sys_log` VALUES (19, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 242, '2024-10-21 23:46:58');
INSERT INTO `sys_log` VALUES (20, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 261, '2024-10-21 23:49:19');
INSERT INTO `sys_log` VALUES (21, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 240, '2024-10-21 23:54:35');
INSERT INTO `sys_log` VALUES (22, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 269, '2024-10-21 23:55:55');
INSERT INTO `sys_log` VALUES (23, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 222, '2024-10-21 23:56:37');
INSERT INTO `sys_log` VALUES (24, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 256, '2024-10-21 23:57:03');
INSERT INTO `sys_log` VALUES (25, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 72, '2024-10-23 12:03:29');
INSERT INTO `sys_log` VALUES (26, 1, 'admin', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-23 12:19:21');
INSERT INTO `sys_log` VALUES (27, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 32, '2024-10-26 00:18:01');
INSERT INTO `sys_log` VALUES (28, 1, 'admin', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 00:18:26');
INSERT INTO `sys_log` VALUES (29, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 16, '2024-10-26 01:51:20');
INSERT INTO `sys_log` VALUES (30, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 01:51:23');
INSERT INTO `sys_log` VALUES (31, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 01:51:38');
INSERT INTO `sys_log` VALUES (32, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 179745, '2024-10-26 01:54:59');
INSERT INTO `sys_log` VALUES (33, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 7205, '2024-10-26 01:54:59');
INSERT INTO `sys_log` VALUES (34, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 20, '2024-10-26 01:54:59');
INSERT INTO `sys_log` VALUES (35, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 29, '2024-10-26 01:54:59');
INSERT INTO `sys_log` VALUES (36, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 11, '2024-10-26 01:59:28');
INSERT INTO `sys_log` VALUES (37, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 265, '2024-10-26 02:00:14');
INSERT INTO `sys_log` VALUES (38, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-26 02:07:16');
INSERT INTO `sys_log` VALUES (39, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 02:07:45');
INSERT INTO `sys_log` VALUES (40, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 02:08:51');
INSERT INTO `sys_log` VALUES (41, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 02:09:38');
INSERT INTO `sys_log` VALUES (42, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 02:10:20');
INSERT INTO `sys_log` VALUES (43, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 02:10:45');
INSERT INTO `sys_log` VALUES (44, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 02:12:58');
INSERT INTO `sys_log` VALUES (45, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 02:13:28');
INSERT INTO `sys_log` VALUES (46, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 02:13:32');
INSERT INTO `sys_log` VALUES (47, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 02:14:41');
INSERT INTO `sys_log` VALUES (48, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 02:14:46');
INSERT INTO `sys_log` VALUES (49, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 02:14:50');
INSERT INTO `sys_log` VALUES (50, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 02:14:55');
INSERT INTO `sys_log` VALUES (51, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 02:16:33');
INSERT INTO `sys_log` VALUES (52, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 55, '2024-10-26 20:00:12');
INSERT INTO `sys_log` VALUES (53, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 20:00:16');
INSERT INTO `sys_log` VALUES (54, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 20:00:18');
INSERT INTO `sys_log` VALUES (55, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 20:04:19');
INSERT INTO `sys_log` VALUES (56, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 20:05:11');
INSERT INTO `sys_log` VALUES (57, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 20:05:47');
INSERT INTO `sys_log` VALUES (58, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 20:05:49');
INSERT INTO `sys_log` VALUES (59, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 20:06:47');
INSERT INTO `sys_log` VALUES (60, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 20:06:49');
INSERT INTO `sys_log` VALUES (61, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 20:38:57');
INSERT INTO `sys_log` VALUES (62, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 20:54:22');
INSERT INTO `sys_log` VALUES (63, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 20:54:25');
INSERT INTO `sys_log` VALUES (64, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 21:43:39');
INSERT INTO `sys_log` VALUES (65, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 21:46:11');
INSERT INTO `sys_log` VALUES (66, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-26 21:46:15');
INSERT INTO `sys_log` VALUES (67, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 21:46:48');
INSERT INTO `sys_log` VALUES (68, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-26 21:46:50');
INSERT INTO `sys_log` VALUES (69, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 21:48:24');
INSERT INTO `sys_log` VALUES (70, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-26 21:48:27');
INSERT INTO `sys_log` VALUES (71, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-26 21:48:54');
INSERT INTO `sys_log` VALUES (72, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 21:58:53');
INSERT INTO `sys_log` VALUES (73, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 357, '2024-10-26 21:59:24');
INSERT INTO `sys_log` VALUES (74, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 21:59:30');
INSERT INTO `sys_log` VALUES (75, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-26 22:00:20');
INSERT INTO `sys_log` VALUES (76, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 22:00:22');
INSERT INTO `sys_log` VALUES (77, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 59, '2024-10-26 22:33:58');
INSERT INTO `sys_log` VALUES (78, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 22:34:01');
INSERT INTO `sys_log` VALUES (79, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 22:34:13');
INSERT INTO `sys_log` VALUES (80, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 40, '2024-10-26 22:38:40');
INSERT INTO `sys_log` VALUES (81, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 44, '2024-10-26 23:02:48');
INSERT INTO `sys_log` VALUES (82, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-26 23:03:53');
INSERT INTO `sys_log` VALUES (83, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:05:08');
INSERT INTO `sys_log` VALUES (84, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:05:26');
INSERT INTO `sys_log` VALUES (85, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-26 23:07:30');
INSERT INTO `sys_log` VALUES (86, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:08:22');
INSERT INTO `sys_log` VALUES (87, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:08:44');
INSERT INTO `sys_log` VALUES (88, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-26 23:22:51');
INSERT INTO `sys_log` VALUES (89, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:22:53');
INSERT INTO `sys_log` VALUES (90, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 23:22:58');
INSERT INTO `sys_log` VALUES (91, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:26:29');
INSERT INTO `sys_log` VALUES (92, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:26:34');
INSERT INTO `sys_log` VALUES (93, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:26:52');
INSERT INTO `sys_log` VALUES (94, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:27:25');
INSERT INTO `sys_log` VALUES (95, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:29:19');
INSERT INTO `sys_log` VALUES (96, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 23:29:21');
INSERT INTO `sys_log` VALUES (97, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:29:22');
INSERT INTO `sys_log` VALUES (98, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:29:23');
INSERT INTO `sys_log` VALUES (99, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:29:47');
INSERT INTO `sys_log` VALUES (100, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:29:48');
INSERT INTO `sys_log` VALUES (101, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:29:49');
INSERT INTO `sys_log` VALUES (102, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:29:49');
INSERT INTO `sys_log` VALUES (103, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:29:49');
INSERT INTO `sys_log` VALUES (104, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:29:49');
INSERT INTO `sys_log` VALUES (105, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:29:56');
INSERT INTO `sys_log` VALUES (106, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 23:30:33');
INSERT INTO `sys_log` VALUES (107, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:30:34');
INSERT INTO `sys_log` VALUES (108, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:30:34');
INSERT INTO `sys_log` VALUES (109, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:30:35');
INSERT INTO `sys_log` VALUES (110, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:30:35');
INSERT INTO `sys_log` VALUES (111, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-26 23:30:35');
INSERT INTO `sys_log` VALUES (112, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:30:35');
INSERT INTO `sys_log` VALUES (113, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:31:11');
INSERT INTO `sys_log` VALUES (114, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:31:25');
INSERT INTO `sys_log` VALUES (115, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:31:29');
INSERT INTO `sys_log` VALUES (116, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:31:59');
INSERT INTO `sys_log` VALUES (117, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:32:32');
INSERT INTO `sys_log` VALUES (118, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:33:11');
INSERT INTO `sys_log` VALUES (119, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:33:21');
INSERT INTO `sys_log` VALUES (120, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:33:47');
INSERT INTO `sys_log` VALUES (121, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:33:51');
INSERT INTO `sys_log` VALUES (122, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:34:01');
INSERT INTO `sys_log` VALUES (123, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:34:39');
INSERT INTO `sys_log` VALUES (124, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:34:54');
INSERT INTO `sys_log` VALUES (125, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:36:54');
INSERT INTO `sys_log` VALUES (126, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:37:01');
INSERT INTO `sys_log` VALUES (127, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:37:11');
INSERT INTO `sys_log` VALUES (128, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:38:09');
INSERT INTO `sys_log` VALUES (129, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-26 23:39:00');
INSERT INTO `sys_log` VALUES (130, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:40:34');
INSERT INTO `sys_log` VALUES (131, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:40:44');
INSERT INTO `sys_log` VALUES (132, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:40:51');
INSERT INTO `sys_log` VALUES (133, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:40:58');
INSERT INTO `sys_log` VALUES (134, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:46:15');
INSERT INTO `sys_log` VALUES (135, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 8, '2024-10-26 23:48:43');
INSERT INTO `sys_log` VALUES (136, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:49:10');
INSERT INTO `sys_log` VALUES (137, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:56:07');
INSERT INTO `sys_log` VALUES (138, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-26 23:56:12');
INSERT INTO `sys_log` VALUES (139, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:56:21');
INSERT INTO `sys_log` VALUES (140, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:56:43');
INSERT INTO `sys_log` VALUES (141, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:57:29');
INSERT INTO `sys_log` VALUES (142, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-26 23:58:14');
INSERT INTO `sys_log` VALUES (143, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-26 23:58:33');
INSERT INTO `sys_log` VALUES (144, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 300, '2024-10-27 00:30:02');
INSERT INTO `sys_log` VALUES (145, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 309, '2024-10-27 00:31:08');
INSERT INTO `sys_log` VALUES (146, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 342, '2024-10-27 00:32:13');
INSERT INTO `sys_log` VALUES (147, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 299, '2024-10-27 00:34:09');
INSERT INTO `sys_log` VALUES (148, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 337, '2024-10-27 00:36:17');
INSERT INTO `sys_log` VALUES (149, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 00:47:04');
INSERT INTO `sys_log` VALUES (150, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 00:48:22');
INSERT INTO `sys_log` VALUES (151, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 00:49:12');
INSERT INTO `sys_log` VALUES (152, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 345, '2024-10-27 00:56:27');
INSERT INTO `sys_log` VALUES (153, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 00:56:27');
INSERT INTO `sys_log` VALUES (154, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 322, '2024-10-27 00:57:18');
INSERT INTO `sys_log` VALUES (155, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 01:05:29');
INSERT INTO `sys_log` VALUES (156, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 01:11:19');
INSERT INTO `sys_log` VALUES (157, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 01:14:54');
INSERT INTO `sys_log` VALUES (158, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 01:24:16');
INSERT INTO `sys_log` VALUES (159, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 377, '2024-10-27 01:27:45');
INSERT INTO `sys_log` VALUES (160, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 419, '2024-10-27 01:33:12');
INSERT INTO `sys_log` VALUES (161, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 286, '2024-10-27 01:35:54');
INSERT INTO `sys_log` VALUES (162, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 275, '2024-10-27 01:38:00');
INSERT INTO `sys_log` VALUES (163, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 01:59:43');
INSERT INTO `sys_log` VALUES (164, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 02:11:41');
INSERT INTO `sys_log` VALUES (165, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 02:22:54');
INSERT INTO `sys_log` VALUES (166, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 02:31:51');
INSERT INTO `sys_log` VALUES (167, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 02:37:53');
INSERT INTO `sys_log` VALUES (168, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 02:43:34');
INSERT INTO `sys_log` VALUES (169, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 02:44:36');
INSERT INTO `sys_log` VALUES (170, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 02:51:09');
INSERT INTO `sys_log` VALUES (171, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 02:59:48');
INSERT INTO `sys_log` VALUES (172, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 03:00:43');
INSERT INTO `sys_log` VALUES (173, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 03:11:39');
INSERT INTO `sys_log` VALUES (174, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:15:13');
INSERT INTO `sys_log` VALUES (175, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:20:00');
INSERT INTO `sys_log` VALUES (176, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:20:01');
INSERT INTO `sys_log` VALUES (177, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:23:38');
INSERT INTO `sys_log` VALUES (178, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:26:50');
INSERT INTO `sys_log` VALUES (179, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:30:24');
INSERT INTO `sys_log` VALUES (180, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:32:56');
INSERT INTO `sys_log` VALUES (181, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:33:24');
INSERT INTO `sys_log` VALUES (182, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 03:34:37');
INSERT INTO `sys_log` VALUES (183, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:34:49');
INSERT INTO `sys_log` VALUES (184, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:35:57');
INSERT INTO `sys_log` VALUES (185, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:39:32');
INSERT INTO `sys_log` VALUES (186, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:41:30');
INSERT INTO `sys_log` VALUES (187, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:41:35');
INSERT INTO `sys_log` VALUES (188, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:41:48');
INSERT INTO `sys_log` VALUES (189, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:45:28');
INSERT INTO `sys_log` VALUES (190, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:45:43');
INSERT INTO `sys_log` VALUES (191, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:47:39');
INSERT INTO `sys_log` VALUES (192, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:48:06');
INSERT INTO `sys_log` VALUES (193, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:48:15');
INSERT INTO `sys_log` VALUES (194, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:51:06');
INSERT INTO `sys_log` VALUES (195, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:51:10');
INSERT INTO `sys_log` VALUES (196, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:51:38');
INSERT INTO `sys_log` VALUES (197, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:52:11');
INSERT INTO `sys_log` VALUES (198, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:52:23');
INSERT INTO `sys_log` VALUES (199, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:52:40');
INSERT INTO `sys_log` VALUES (200, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:52:50');
INSERT INTO `sys_log` VALUES (201, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:55:05');
INSERT INTO `sys_log` VALUES (202, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:55:10');
INSERT INTO `sys_log` VALUES (203, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:55:21');
INSERT INTO `sys_log` VALUES (204, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-27 03:57:04');
INSERT INTO `sys_log` VALUES (205, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:57:31');
INSERT INTO `sys_log` VALUES (206, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 03:58:14');
INSERT INTO `sys_log` VALUES (207, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:58:19');
INSERT INTO `sys_log` VALUES (208, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:58:55');
INSERT INTO `sys_log` VALUES (209, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 03:59:00');
INSERT INTO `sys_log` VALUES (210, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 04:00:06');
INSERT INTO `sys_log` VALUES (211, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 04:01:07');
INSERT INTO `sys_log` VALUES (212, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 04:01:25');
INSERT INTO `sys_log` VALUES (213, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 04:01:47');
INSERT INTO `sys_log` VALUES (214, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 04:03:07');
INSERT INTO `sys_log` VALUES (215, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 04:03:29');
INSERT INTO `sys_log` VALUES (216, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 04:03:44');
INSERT INTO `sys_log` VALUES (217, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 04:04:26');
INSERT INTO `sys_log` VALUES (218, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 04:05:28');
INSERT INTO `sys_log` VALUES (219, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 04:06:06');
INSERT INTO `sys_log` VALUES (220, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 04:06:43');
INSERT INTO `sys_log` VALUES (221, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 04:07:11');
INSERT INTO `sys_log` VALUES (222, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 04:07:22');
INSERT INTO `sys_log` VALUES (223, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 2, '2024-10-27 04:07:39');
INSERT INTO `sys_log` VALUES (224, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 15:11:56');
INSERT INTO `sys_log` VALUES (225, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 332, '2024-10-27 16:11:13');
INSERT INTO `sys_log` VALUES (226, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 31, '2024-10-27 17:01:29');
INSERT INTO `sys_log` VALUES (227, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 17:04:54');
INSERT INTO `sys_log` VALUES (228, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 343, '2024-10-27 17:44:32');
INSERT INTO `sys_log` VALUES (229, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 32, '2024-10-27 18:03:08');
INSERT INTO `sys_log` VALUES (230, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 33, '2024-10-27 18:12:55');
INSERT INTO `sys_log` VALUES (231, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 273, '2024-10-27 18:14:45');
INSERT INTO `sys_log` VALUES (232, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 46, '2024-10-27 18:20:02');
INSERT INTO `sys_log` VALUES (233, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 32, '2024-10-27 18:25:06');
INSERT INTO `sys_log` VALUES (234, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 280, '2024-10-27 19:07:00');
INSERT INTO `sys_log` VALUES (235, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 16, '2024-10-27 19:13:44');
INSERT INTO `sys_log` VALUES (236, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 65, '2024-10-27 19:14:28');
INSERT INTO `sys_log` VALUES (237, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 65, '2024-10-27 19:15:31');
INSERT INTO `sys_log` VALUES (238, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 61, '2024-10-27 19:17:26');
INSERT INTO `sys_log` VALUES (239, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 51, '2024-10-27 19:18:55');
INSERT INTO `sys_log` VALUES (240, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 57, '2024-10-27 19:20:06');
INSERT INTO `sys_log` VALUES (241, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 61, '2024-10-27 19:23:30');
INSERT INTO `sys_log` VALUES (242, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 62, '2024-10-27 19:24:17');
INSERT INTO `sys_log` VALUES (243, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-27 19:26:45');
INSERT INTO `sys_log` VALUES (244, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 19:26:47');
INSERT INTO `sys_log` VALUES (245, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 62, '2024-10-27 19:40:54');
INSERT INTO `sys_log` VALUES (246, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 29, '2024-10-27 19:44:42');
INSERT INTO `sys_log` VALUES (247, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-27 19:45:22');
INSERT INTO `sys_log` VALUES (248, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 19:45:24');
INSERT INTO `sys_log` VALUES (249, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-27 20:01:49');
INSERT INTO `sys_log` VALUES (250, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-27 20:02:21');
INSERT INTO `sys_log` VALUES (251, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 298, '2024-10-27 20:50:24');
INSERT INTO `sys_log` VALUES (252, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 60, '2024-10-27 20:53:38');
INSERT INTO `sys_log` VALUES (253, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 336, '2024-10-27 20:59:24');
INSERT INTO `sys_log` VALUES (254, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 21:01:50');
INSERT INTO `sys_log` VALUES (255, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-27 21:01:55');
INSERT INTO `sys_log` VALUES (256, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 6, '2024-10-27 21:02:11');
INSERT INTO `sys_log` VALUES (257, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 21:02:13');
INSERT INTO `sys_log` VALUES (258, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 21:02:42');
INSERT INTO `sys_log` VALUES (259, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 21:03:06');
INSERT INTO `sys_log` VALUES (260, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 21:03:18');
INSERT INTO `sys_log` VALUES (261, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 21:03:23');
INSERT INTO `sys_log` VALUES (262, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 360, '2024-10-27 21:05:57');
INSERT INTO `sys_log` VALUES (263, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 61, '2024-10-27 21:08:04');
INSERT INTO `sys_log` VALUES (264, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-27 21:11:04');
INSERT INTO `sys_log` VALUES (265, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 21:11:05');
INSERT INTO `sys_log` VALUES (266, 1, 'admin', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-27 21:12:40');
INSERT INTO `sys_log` VALUES (267, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 4, '2024-10-27 21:12:42');
INSERT INTO `sys_log` VALUES (268, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 44, '2024-10-27 21:34:59');
INSERT INTO `sys_log` VALUES (269, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 15, '2024-10-27 21:55:03');
INSERT INTO `sys_log` VALUES (270, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 18, '2024-10-27 21:57:37');
INSERT INTO `sys_log` VALUES (271, 2, 'dev', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-27 22:12:59');
INSERT INTO `sys_log` VALUES (272, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 5, '2024-10-27 22:13:00');
INSERT INTO `sys_log` VALUES (273, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 274, '2024-10-27 22:14:30');
INSERT INTO `sys_log` VALUES (274, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 15, '2024-10-28 21:21:50');
INSERT INTO `sys_log` VALUES (275, 2, 'dev', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 13, '2024-10-28 21:33:32');
INSERT INTO `sys_log` VALUES (276, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 42, '2024-10-28 21:38:01');
INSERT INTO `sys_log` VALUES (277, 1, 'admin', '退出', '/logout', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 0, '2024-10-28 21:44:36');
INSERT INTO `sys_log` VALUES (278, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 3, '2024-10-28 21:44:56');
INSERT INTO `sys_log` VALUES (279, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 122.0.0.0', 'Windows', 305, '2024-10-28 22:10:16');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` bigint NOT NULL COMMENT '父菜单ID。一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `permission` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权标识。多个用逗号分隔，如：user:list,user:create',
  `type` tinyint NULL DEFAULT NULL COMMENT '类型。0：目录；1：菜单；2：按钮；3：导航菜单',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态。0：正常；1：禁用',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序值。越小越靠前',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, '', 1, 'fa fa-cogs', 0, 0, NULL, '2019-05-06 21:46:33');
INSERT INTO `sys_menu` VALUES (2, 1, '用户管理', 'sys/user/index', 'sys:user:index', 1, NULL, 0, 0, NULL, '2019-05-06 21:46:47');
INSERT INTO `sys_menu` VALUES (3, 1, '菜单管理', 'sys/menu/index', 'sys:menu:index', 1, NULL, 0, 2, NULL, '2019-05-11 11:50:57');
INSERT INTO `sys_menu` VALUES (4, 1, '角色管理', 'sys/role/index', 'sys:role:index', 1, NULL, 0, 3, NULL, '2019-05-11 11:51:31');
INSERT INTO `sys_menu` VALUES (5, 1, '部门管理', 'sys/dept/index', 'sys:dept:index', 1, NULL, 0, 1, NULL, '2019-05-11 11:51:58');
INSERT INTO `sys_menu` VALUES (7, 0, '系统审计', NULL, '', 0, 'fa fa-industry', 0, 1, NULL, '2019-05-11 12:04:09');
INSERT INTO `sys_menu` VALUES (9, 7, '操作日志', 'sys/log/index', 'sys:log:index', 1, NULL, 0, 0, NULL, '2019-05-11 13:26:02');
INSERT INTO `sys_menu` VALUES (10, 2, '添加', NULL, 'sys:user:add', 2, NULL, 0, 0, NULL, '2019-05-07 21:25:46');
INSERT INTO `sys_menu` VALUES (11, 2, '删除', NULL, 'sys:user:del', 2, NULL, 0, 2, NULL, '2019-05-11 14:26:54');
INSERT INTO `sys_menu` VALUES (12, 2, '编辑', NULL, 'sys:user:edit', 2, NULL, 0, 1, NULL, '2019-05-11 14:28:06');
INSERT INTO `sys_menu` VALUES (13, 3, '添加', NULL, 'sys:menu:add', 2, NULL, 0, 0, NULL, '2019-05-11 14:28:59');
INSERT INTO `sys_menu` VALUES (14, 3, '编辑', NULL, 'sys:menu:edit', 2, NULL, 0, 1, NULL, '2019-05-11 14:29:35');
INSERT INTO `sys_menu` VALUES (15, 3, '删除', NULL, 'sys:menu:del', 2, NULL, 0, 2, NULL, '2019-05-11 14:29:55');
INSERT INTO `sys_menu` VALUES (16, 4, '添加', NULL, 'sys:role:add', 2, NULL, 0, 0, NULL, '2019-05-11 14:30:07');
INSERT INTO `sys_menu` VALUES (17, 4, '编辑', NULL, 'sys:role:edit', 2, NULL, 0, 1, NULL, '2019-05-11 14:30:28');
INSERT INTO `sys_menu` VALUES (18, 4, '删除', NULL, 'sys:role:del', 2, NULL, 0, 2, NULL, '2019-05-11 14:30:37');
INSERT INTO `sys_menu` VALUES (19, 4, '权限设置', NULL, 'sys:role:permission', 2, NULL, 0, 3, NULL, '2019-05-11 14:30:37');
INSERT INTO `sys_menu` VALUES (20, 5, '添加', NULL, 'sys:dept:add', 2, NULL, 0, 0, NULL, '2019-05-11 14:30:47');
INSERT INTO `sys_menu` VALUES (21, 5, '编辑', NULL, 'sys:dept:edit', 2, NULL, 0, 1, NULL, '2019-05-11 14:30:58');
INSERT INTO `sys_menu` VALUES (22, 5, '删除', NULL, 'sys:dept:del', 2, NULL, 0, 2, NULL, '2019-05-11 14:31:13');
INSERT INTO `sys_menu` VALUES (23, 2, '重置密码', NULL, 'sys:user:reset', 2, NULL, 0, 3, NULL, '2019-05-12 18:01:10');
INSERT INTO `sys_menu` VALUES (28, 27, '添加', NULL, 'sys:dict:add', 2, NULL, 0, 0, NULL, '2019-08-12 09:48:03');
INSERT INTO `sys_menu` VALUES (29, 27, '编辑', NULL, 'sys:dict:edit', 2, NULL, 0, 0, NULL, '2019-08-12 09:48:20');
INSERT INTO `sys_menu` VALUES (30, 27, '删除', NULL, 'sys:dict:del', 2, NULL, 0, 0, NULL, '2019-08-12 09:48:45');
INSERT INTO `sys_menu` VALUES (31, 1, '定时任务', 'schedule/job/index', 'schedule:job:index', 1, NULL, 0, 5, NULL, '2019-08-17 18:13:22');
INSERT INTO `sys_menu` VALUES (32, 31, '添加', NULL, 'schedule:job:add', 1, NULL, 0, 0, NULL, '2019-08-17 18:14:20');
INSERT INTO `sys_menu` VALUES (33, 31, '编辑', NULL, 'schedule:job:edit', 2, NULL, 0, 0, NULL, '2019-08-17 18:14:36');
INSERT INTO `sys_menu` VALUES (34, 31, '删除', NULL, 'schedule:job:del', 2, NULL, 0, 0, NULL, '2019-08-17 18:14:55');
INSERT INTO `sys_menu` VALUES (35, 31, '暂停', NULL, 'schedule:job:pause', 2, NULL, 0, 0, NULL, '2019-08-17 18:16:10');
INSERT INTO `sys_menu` VALUES (36, 31, '恢复', NULL, 'schedule:job:resume', 2, NULL, 0, 0, NULL, '2019-08-17 18:16:28');
INSERT INTO `sys_menu` VALUES (40, 0, '酒店管理', '', '', 1, 'fa fa-hotel', 0, 0, NULL, '2024-10-21 22:19:35');
INSERT INTO `sys_menu` VALUES (41, 40, '酒店列表', 'hotels/hotels/index', 'hotels:hotels:index', 1, NULL, 0, 0, NULL, '2024-10-21 22:24:48');
INSERT INTO `sys_menu` VALUES (42, 0, '房间管理', '', NULL, 1, 'fa fa-adjust', 0, 0, NULL, '2024-10-21 23:19:08');
INSERT INTO `sys_menu` VALUES (43, 42, '房型列表', 'room_types/types/index', 'room_types:types:index', 1, NULL, 0, 0, NULL, '2024-10-21 23:21:00');
INSERT INTO `sys_menu` VALUES (44, 42, '房间列表', 'rooms/rooms/index', 'rooms:rooms:index', 1, NULL, 0, 0, NULL, '2024-10-21 23:21:37');
INSERT INTO `sys_menu` VALUES (45, 0, '预定管理', '', NULL, 1, 'fa fa-arrows-h', 0, 0, NULL, '2024-10-21 23:23:53');
INSERT INTO `sys_menu` VALUES (46, 45, '预定列表', 'reservations/reservations/index', 'reservations:reservations:index', 1, NULL, 0, 0, NULL, '2024-10-21 23:26:32');
INSERT INTO `sys_menu` VALUES (47, 0, '投诉管理', '', NULL, 0, 'fa fa-american-sign-language-interpreting', 0, 0, NULL, '2024-10-21 23:26:46');
INSERT INTO `sys_menu` VALUES (48, 47, '处理投诉', 'complaints/complaints/index', 'complaints:complaints:index', 1, NULL, 0, 0, NULL, '2024-10-21 23:27:33');
INSERT INTO `sys_menu` VALUES (49, 40, '公告列表', 'hotel_notifications/notifications/index', 'hotel_notifications:notifications:index', 1, NULL, 0, 0, NULL, '2024-10-21 23:35:00');
INSERT INTO `sys_menu` VALUES (50, 40, '入住列表', 'check_ins/ins/index', 'check_ins:ins:index', 1, NULL, 0, 0, NULL, '2024-10-21 23:39:49');
INSERT INTO `sys_menu` VALUES (51, 40, '退房结算', 'check/outSettlements/index', 'check:outSettlements:index', 1, NULL, 0, 0, NULL, '2024-10-21 23:41:10');
INSERT INTO `sys_menu` VALUES (53, 48, '添加', NULL, 'complaints:complaints:add', 2, NULL, 0, 0, NULL, '2024-10-27 22:16:28');
INSERT INTO `sys_menu` VALUES (54, 48, '编辑', NULL, 'complaints:complaints:edit', 2, NULL, 0, 0, NULL, '2024-10-27 22:16:36');
INSERT INTO `sys_menu` VALUES (56, 48, '删除', NULL, 'complaints:complaints:del', 2, NULL, 0, 0, NULL, '2024-10-27 22:17:03');
INSERT INTO `sys_menu` VALUES (57, 41, '添加', NULL, 'hotels:hotels:add', 2, NULL, 0, 0, NULL, '2024-10-27 22:18:15');
INSERT INTO `sys_menu` VALUES (58, 41, '删除', NULL, 'hotels:hotels:del', 2, NULL, 0, 0, NULL, '2024-10-27 22:18:24');
INSERT INTO `sys_menu` VALUES (59, 41, '编辑', NULL, 'hotels:hotels:edit', 2, NULL, 0, 0, NULL, '2024-10-27 22:18:39');
INSERT INTO `sys_menu` VALUES (60, 43, '添加', NULL, 'room_types:types:add', 2, NULL, 0, 0, NULL, '2024-10-27 22:19:01');
INSERT INTO `sys_menu` VALUES (61, 43, '删除', NULL, 'room_types:types:del', 2, NULL, 0, 0, NULL, '2024-10-27 22:19:11');
INSERT INTO `sys_menu` VALUES (62, 43, '编辑', NULL, 'room_types:types:edit', 2, NULL, 0, 0, NULL, '2024-10-27 22:19:42');
INSERT INTO `sys_menu` VALUES (63, 49, '添加', NULL, 'hotel_notifications:notifications:add', 2, NULL, 0, 0, NULL, '2024-10-27 22:20:20');
INSERT INTO `sys_menu` VALUES (64, 49, '删除', NULL, 'hotel_notifications:notifications:del', 2, NULL, 0, 0, NULL, '2024-10-27 22:20:29');
INSERT INTO `sys_menu` VALUES (65, 49, '编辑', NULL, 'hotel_notifications:notifications:edit', 2, NULL, 0, 0, NULL, '2024-10-27 22:20:44');
INSERT INTO `sys_menu` VALUES (66, 50, '添加', NULL, 'check_ins:ins:add', 2, NULL, 0, 0, NULL, '2024-10-27 22:21:21');
INSERT INTO `sys_menu` VALUES (67, 50, '删除', NULL, 'check_ins:ins:del', 2, NULL, 0, 0, NULL, '2024-10-27 22:21:29');
INSERT INTO `sys_menu` VALUES (68, 50, '编辑', NULL, 'check_ins:ins:edit', 2, NULL, 0, 0, NULL, '2024-10-27 22:21:38');
INSERT INTO `sys_menu` VALUES (69, 51, '添加', NULL, 'check:outSettlements:add', 2, NULL, 0, 0, NULL, '2024-10-27 22:22:04');
INSERT INTO `sys_menu` VALUES (70, 51, '删除', NULL, 'check:outSettlements:del', 2, NULL, 0, 0, NULL, '2024-10-27 22:22:11');
INSERT INTO `sys_menu` VALUES (71, 51, '编辑', NULL, 'check:outSettlements:edit', 2, NULL, 0, 0, NULL, '2024-10-27 22:22:18');
INSERT INTO `sys_menu` VALUES (72, 44, '添加', NULL, 'rooms:rooms:add', 2, NULL, 0, 0, NULL, '2024-10-27 22:22:41');
INSERT INTO `sys_menu` VALUES (73, 44, '删除', NULL, 'rooms:rooms:del', 2, NULL, 0, 0, NULL, '2024-10-27 22:22:50');
INSERT INTO `sys_menu` VALUES (74, 44, '编辑', NULL, 'rooms:rooms:edit', 2, NULL, 0, 0, NULL, '2024-10-27 22:22:57');
INSERT INTO `sys_menu` VALUES (75, 46, '添加', NULL, 'reservations:reservations:add', 2, NULL, 0, 0, NULL, '2024-10-27 22:23:15');
INSERT INTO `sys_menu` VALUES (76, 46, '编辑', NULL, 'reservations:reservations:edit', 2, NULL, 0, 0, NULL, '2024-10-27 22:23:24');
INSERT INTO `sys_menu` VALUES (77, 46, '删除', NULL, 'reservations:reservations:del', 2, NULL, 0, 0, NULL, '2024-10-27 22:23:32');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `parent_id` bigint NOT NULL COMMENT '父级ID',
  `type` tinyint NOT NULL COMMENT '类型。0：分类；1：角色',
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '系统角色', 0, 0, '', NULL, '2019-05-19 22:32:38', '2019-05-08 22:07:14');
INSERT INTO `sys_role` VALUES (2, '研发组', 0, 0, '', NULL, '2019-05-19 22:32:54', '2019-05-08 22:17:09');
INSERT INTO `sys_role` VALUES (3, '系统管理员', 1, 1, NULL, NULL, '2019-05-19 22:33:12', '2019-05-19 22:33:12');
INSERT INTO `sys_role` VALUES (4, '项目组长', 2, 1, NULL, NULL, '2019-05-19 22:33:32', '2019-05-19 22:33:32');
INSERT INTO `sys_role` VALUES (5, '开发者', 0, 1, '', NULL, '2019-06-07 19:42:14', '2019-06-07 19:42:14');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 3, 7);
INSERT INTO `sys_role_menu` VALUES (2, 3, 9);
INSERT INTO `sys_role_menu` VALUES (3, 3, 1);
INSERT INTO `sys_role_menu` VALUES (4, 3, 2);
INSERT INTO `sys_role_menu` VALUES (5, 3, 10);
INSERT INTO `sys_role_menu` VALUES (6, 3, 12);
INSERT INTO `sys_role_menu` VALUES (7, 3, 11);
INSERT INTO `sys_role_menu` VALUES (8, 3, 23);
INSERT INTO `sys_role_menu` VALUES (9, 3, 5);
INSERT INTO `sys_role_menu` VALUES (10, 3, 20);
INSERT INTO `sys_role_menu` VALUES (11, 3, 21);
INSERT INTO `sys_role_menu` VALUES (12, 3, 22);
INSERT INTO `sys_role_menu` VALUES (13, 3, 3);
INSERT INTO `sys_role_menu` VALUES (14, 3, 13);
INSERT INTO `sys_role_menu` VALUES (15, 3, 14);
INSERT INTO `sys_role_menu` VALUES (16, 3, 15);
INSERT INTO `sys_role_menu` VALUES (17, 3, 4);
INSERT INTO `sys_role_menu` VALUES (18, 3, 16);
INSERT INTO `sys_role_menu` VALUES (19, 3, 17);
INSERT INTO `sys_role_menu` VALUES (20, 3, 18);
INSERT INTO `sys_role_menu` VALUES (21, 3, 19);
INSERT INTO `sys_role_menu` VALUES (25, 5, 1);
INSERT INTO `sys_role_menu` VALUES (26, 5, 2);
INSERT INTO `sys_role_menu` VALUES (27, 5, 5);
INSERT INTO `sys_role_menu` VALUES (28, 5, 3);
INSERT INTO `sys_role_menu` VALUES (29, 5, 4);
INSERT INTO `sys_role_menu` VALUES (30, 5, 7);
INSERT INTO `sys_role_menu` VALUES (38, 3, 31);
INSERT INTO `sys_role_menu` VALUES (39, 3, 32);
INSERT INTO `sys_role_menu` VALUES (40, 3, 33);
INSERT INTO `sys_role_menu` VALUES (41, 3, 34);
INSERT INTO `sys_role_menu` VALUES (42, 3, 35);
INSERT INTO `sys_role_menu` VALUES (43, 3, 36);
INSERT INTO `sys_role_menu` VALUES (44, 4, 7);
INSERT INTO `sys_role_menu` VALUES (45, 4, 9);
INSERT INTO `sys_role_menu` VALUES (49, 3, 40);
INSERT INTO `sys_role_menu` VALUES (50, 3, 41);
INSERT INTO `sys_role_menu` VALUES (51, 3, 42);
INSERT INTO `sys_role_menu` VALUES (52, 3, 44);
INSERT INTO `sys_role_menu` VALUES (53, 3, 43);
INSERT INTO `sys_role_menu` VALUES (54, 3, 47);
INSERT INTO `sys_role_menu` VALUES (55, 3, 48);
INSERT INTO `sys_role_menu` VALUES (56, 3, 45);
INSERT INTO `sys_role_menu` VALUES (57, 3, 46);
INSERT INTO `sys_role_menu` VALUES (58, 3, 49);
INSERT INTO `sys_role_menu` VALUES (59, 3, 50);
INSERT INTO `sys_role_menu` VALUES (60, 3, 51);
INSERT INTO `sys_role_menu` VALUES (64, 3, 53);
INSERT INTO `sys_role_menu` VALUES (65, 3, 54);
INSERT INTO `sys_role_menu` VALUES (66, 3, 56);
INSERT INTO `sys_role_menu` VALUES (67, 3, 63);
INSERT INTO `sys_role_menu` VALUES (68, 3, 64);
INSERT INTO `sys_role_menu` VALUES (69, 3, 65);
INSERT INTO `sys_role_menu` VALUES (70, 3, 69);
INSERT INTO `sys_role_menu` VALUES (71, 3, 70);
INSERT INTO `sys_role_menu` VALUES (72, 3, 71);
INSERT INTO `sys_role_menu` VALUES (73, 3, 66);
INSERT INTO `sys_role_menu` VALUES (74, 3, 67);
INSERT INTO `sys_role_menu` VALUES (75, 3, 68);
INSERT INTO `sys_role_menu` VALUES (76, 3, 57);
INSERT INTO `sys_role_menu` VALUES (77, 3, 58);
INSERT INTO `sys_role_menu` VALUES (78, 3, 59);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dept_id` bigint NOT NULL COMMENT '归属部门',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `realname` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `sex` tinyint NOT NULL DEFAULT 0 COMMENT '性别。0：未知；1：男；2：女',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `tel` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '固定电话',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `job_title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职务名称',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '用户状态。0：正常；1：禁用',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序。值越小越靠前',
  `del_flag` int NOT NULL DEFAULT 0 COMMENT '删除标识。0：未删除；1：已删除',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 3, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 1, '18218798428', '123', '123', 'static/image/avatar/tz.jpg', '超级管理员', 0, 0, 0, NULL, '2024-10-28 21:42:51', '2019-04-30 22:44:17');
INSERT INTO `sys_user` VALUES (2, 2, 'dev', 'e10adc3949ba59abbe56e057f20f883e', '开发人员', 2, '18218798428', '131', '123', 'static/image/avatar/tz.jpg', '开发人员', 0, 1, 0, NULL, '2024-10-28 21:42:55', '2019-05-02 12:22:38');
INSERT INTO `sys_user` VALUES (3, 2, 'test', 'e10adc3949ba59abbe56e057f20f883e', '测试账号', 2, '18218798428', '131', '123', NULL, '测试', 0, 1, 0, NULL, '2019-05-19 18:34:16', '2019-05-02 12:22:38');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 3, '2019-05-09 22:06:16');
INSERT INTO `sys_user_role` VALUES (2, 2, 5, '2019-05-10 21:25:08');
INSERT INTO `sys_user_role` VALUES (3, 3, 4, '2019-05-10 21:25:08');

SET FOREIGN_KEY_CHECKS = 1;
