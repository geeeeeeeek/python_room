/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : localhost:3306
 Source Schema         : python_room

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 17/12/2025 10:29:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `accounts_blacklist`;
CREATE TABLE `accounts_blacklist`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `banned_at` datetime(6) NOT NULL,
  `unbanned_at` datetime(6) NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `banned_by_id` bigint(20) NULL DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `accounts_blacklist_banned_by_id_bd5b30d1_fk_accounts_user_id`(`banned_by_id`) USING BTREE,
  INDEX `accounts_blacklist_user_id_c51c78f1_fk_accounts_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `accounts_blacklist_banned_by_id_bd5b30d1_fk_accounts_user_id` FOREIGN KEY (`banned_by_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `accounts_blacklist_user_id_c51c78f1_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for accounts_user
-- ----------------------------
DROP TABLE IF EXISTS `accounts_user`;
CREATE TABLE `accounts_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_banned` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `student_id`(`student_id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_user
-- ----------------------------
INSERT INTO `accounts_user` VALUES (1, 'pbkdf2_sha256$260000$T0xHTZc8cDfW6Ic7Kl4xXD$kLGPMAGzaYLaPNpE1kEfb7RGQ2LAsERPZC07vpXts08=', '2025-12-17 02:22:02.241522', 1, 'admin123', '', '', 1, 1, '2025-12-16 07:47:36.965721', '', 'admin123@qq.com', '', '', 'student', 0, '2025-12-16 07:47:37.029283', '2025-12-16 07:47:37.029283');
INSERT INTO `accounts_user` VALUES (2, 'pbkdf2_sha256$260000$F11pZzXgxH4Ia8OqXkC8Kv$x6Tr6RahMBY/OY/mKawMPD+2iGY+G+ojsHowHPfz4KI=', '2025-12-17 02:25:24.425529', 0, 'aaaa1234', '', '', 0, 1, '2025-12-16 08:00:25.515617', '12345', 'aaa@qq.com', '2322111', 'avatars/格子衫.jpg', 'student', 0, '2025-12-16 08:00:25.799753', '2025-12-16 08:00:49.414181');

-- ----------------------------
-- Table structure for accounts_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `accounts_user_groups`;
CREATE TABLE `accounts_user_groups`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `accounts_user_groups_user_id_group_id_59c0b32f_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `accounts_user_groups_group_id_bd11a704_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `accounts_user_groups_user_id_52b62117_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for accounts_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `accounts_user_user_permissions`;
CREATE TABLE `accounts_user_user_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `accounts_user_user_p_permission_id_113bb443_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `accounts_user_user_p_user_id_e4f0a161_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add 用户', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change 用户', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete 用户', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view 用户', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add 黑名单', 7, 'add_blacklist');
INSERT INTO `auth_permission` VALUES (26, 'Can change 黑名单', 7, 'change_blacklist');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 黑名单', 7, 'delete_blacklist');
INSERT INTO `auth_permission` VALUES (28, 'Can view 黑名单', 7, 'view_blacklist');
INSERT INTO `auth_permission` VALUES (29, 'Can add 自习室', 8, 'add_studyroom');
INSERT INTO `auth_permission` VALUES (30, 'Can change 自习室', 8, 'change_studyroom');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 自习室', 8, 'delete_studyroom');
INSERT INTO `auth_permission` VALUES (32, 'Can view 自习室', 8, 'view_studyroom');
INSERT INTO `auth_permission` VALUES (33, 'Can add 座位', 9, 'add_seat');
INSERT INTO `auth_permission` VALUES (34, 'Can change 座位', 9, 'change_seat');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 座位', 9, 'delete_seat');
INSERT INTO `auth_permission` VALUES (36, 'Can view 座位', 9, 'view_seat');
INSERT INTO `auth_permission` VALUES (37, 'Can add 预约', 10, 'add_booking');
INSERT INTO `auth_permission` VALUES (38, 'Can change 预约', 10, 'change_booking');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 预约', 10, 'delete_booking');
INSERT INTO `auth_permission` VALUES (40, 'Can view 预约', 10, 'view_booking');
INSERT INTO `auth_permission` VALUES (41, 'Can add 签到记录', 11, 'add_checkin');
INSERT INTO `auth_permission` VALUES (42, 'Can change 签到记录', 11, 'change_checkin');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 签到记录', 11, 'delete_checkin');
INSERT INTO `auth_permission` VALUES (44, 'Can view 签到记录', 11, 'view_checkin');

-- ----------------------------
-- Table structure for bookings_booking
-- ----------------------------
DROP TABLE IF EXISTS `bookings_booking`;
CREATE TABLE `bookings_booking`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `booking_date` date NOT NULL,
  `time_slot` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `note` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `seat_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `bookings_booking_seat_id_booking_date_time_slot_9efe12e6_uniq`(`seat_id`, `booking_date`, `time_slot`) USING BTREE,
  INDEX `bookings_booking_user_id_834dfc23_fk_accounts_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `bookings_booking_seat_id_764de9cf_fk_rooms_seat_id` FOREIGN KEY (`seat_id`) REFERENCES `rooms_seat` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bookings_booking_user_id_834dfc23_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bookings_booking
-- ----------------------------
INSERT INTO `bookings_booking` VALUES (1, '2025-12-19', 'afternoon', 'approved', '000', '2025-12-17 02:19:27.753967', '2025-12-17 02:19:27.753967', 2, 2);

-- ----------------------------
-- Table structure for bookings_checkin
-- ----------------------------
DROP TABLE IF EXISTS `bookings_checkin`;
CREATE TABLE `bookings_checkin`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `checkin_time` datetime(6) NOT NULL,
  `checkout_time` datetime(6) NULL DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `note` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `booking_id`(`booking_id`) USING BTREE,
  CONSTRAINT `bookings_checkin_booking_id_354b221e_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bookings_checkin
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_accounts_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2025-12-17 02:22:33.812808', '5', '五号自习室', 2, '[{\"changed\": {\"fields\": [\"\\u72b6\\u6001\"]}}]', 8, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (7, 'accounts', 'blacklist');
INSERT INTO `django_content_type` VALUES (6, 'accounts', 'user');
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (10, 'bookings', 'booking');
INSERT INTO `django_content_type` VALUES (11, 'bookings', 'checkin');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (9, 'rooms', 'seat');
INSERT INTO `django_content_type` VALUES (8, 'rooms', 'studyroom');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2025-12-16 07:46:54.066116');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2025-12-16 07:46:54.137194');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2025-12-16 07:46:54.444877');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2025-12-16 07:46:54.496808');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2025-12-16 07:46:54.503232');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2025-12-16 07:46:54.514938');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2025-12-16 07:46:54.523835');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2025-12-16 07:46:54.529534');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2025-12-16 07:46:54.535920');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2025-12-16 07:46:54.544965');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2025-12-16 07:46:54.553131');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2025-12-16 07:46:54.573247');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2025-12-16 07:46:54.581856');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2025-12-16 07:46:54.592056');
INSERT INTO `django_migrations` VALUES (15, 'accounts', '0001_initial', '2025-12-16 07:46:55.243678');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0001_initial', '2025-12-16 07:46:55.426795');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2025-12-16 07:46:55.434019');
INSERT INTO `django_migrations` VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2025-12-16 07:46:55.443071');
INSERT INTO `django_migrations` VALUES (19, 'rooms', '0001_initial', '2025-12-16 07:46:55.733874');
INSERT INTO `django_migrations` VALUES (20, 'bookings', '0001_initial', '2025-12-16 07:46:55.997613');
INSERT INTO `django_migrations` VALUES (21, 'sessions', '0001_initial', '2025-12-16 07:46:56.066589');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for rooms_seat
-- ----------------------------
DROP TABLE IF EXISTS `rooms_seat`;
CREATE TABLE `rooms_seat`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seat_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `row` int(11) NOT NULL,
  `column` int(11) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `has_power` tinyint(1) NOT NULL,
  `has_lamp` tinyint(1) NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `room_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `rooms_seat_room_id_seat_number_ddc31ca3_uniq`(`room_id`, `seat_number`) USING BTREE,
  CONSTRAINT `rooms_seat_room_id_7d24ad15_fk_rooms_studyroom_id` FOREIGN KEY (`room_id`) REFERENCES `rooms_studyroom` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rooms_seat
-- ----------------------------
INSERT INTO `rooms_seat` VALUES (1, 'A1', 1, 1, 'available', 1, 0, '', '2024-06-01 09:10:00.000000', '2024-06-01 09:10:00.000000', 1);
INSERT INTO `rooms_seat` VALUES (2, 'A2', 1, 2, 'available', 1, 1, '', '2024-06-01 09:10:00.000000', '2024-06-01 09:10:00.000000', 1);
INSERT INTO `rooms_seat` VALUES (3, 'B1', 2, 1, 'occupied', 1, 0, '', '2024-06-01 09:10:00.000000', '2024-06-01 09:10:00.000000', 1);
INSERT INTO `rooms_seat` VALUES (4, 'B2', 2, 2, 'available', 0, 0, '', '2024-06-01 09:10:00.000000', '2024-06-01 09:10:00.000000', 1);
INSERT INTO `rooms_seat` VALUES (5, 'A1', 1, 1, 'available', 1, 0, '', '2024-06-01 09:11:00.000000', '2024-06-01 09:11:00.000000', 2);
INSERT INTO `rooms_seat` VALUES (6, 'A2', 1, 2, 'unavailable', 1, 1, '', '2024-06-01 09:11:00.000000', '2024-06-01 09:11:00.000000', 2);
INSERT INTO `rooms_seat` VALUES (7, 'B1', 2, 1, 'occupied', 1, 0, '', '2024-06-01 09:11:00.000000', '2024-06-01 09:11:00.000000', 2);
INSERT INTO `rooms_seat` VALUES (8, 'B2', 2, 2, 'available', 0, 0, '', '2024-06-01 09:11:00.000000', '2024-06-01 09:11:00.000000', 2);
INSERT INTO `rooms_seat` VALUES (9, 'C1', 1, 1, 'available', 1, 1, '', '2024-06-01 09:12:00.000000', '2024-06-01 09:12:00.000000', 3);
INSERT INTO `rooms_seat` VALUES (10, 'C2', 1, 2, 'occupied', 0, 1, '', '2024-06-01 09:12:00.000000', '2024-06-01 09:12:00.000000', 3);
INSERT INTO `rooms_seat` VALUES (11, 'D1', 2, 1, 'available', 1, 0, '', '2024-06-01 09:12:00.000000', '2024-06-01 09:12:00.000000', 3);
INSERT INTO `rooms_seat` VALUES (12, 'D2', 2, 2, 'available', 1, 0, '', '2024-06-01 09:12:00.000000', '2024-06-01 09:12:00.000000', 3);
INSERT INTO `rooms_seat` VALUES (13, 'E1', 1, 1, 'unavailable', 0, 1, '', '2024-06-01 09:13:00.000000', '2024-06-01 09:13:00.000000', 4);
INSERT INTO `rooms_seat` VALUES (14, 'E2', 1, 2, 'available', 1, 0, '', '2024-06-01 09:13:00.000000', '2024-06-01 09:13:00.000000', 4);
INSERT INTO `rooms_seat` VALUES (15, 'F1', 2, 1, 'occupied', 0, 0, '', '2024-06-01 09:13:00.000000', '2024-06-01 09:13:00.000000', 4);
INSERT INTO `rooms_seat` VALUES (16, 'F2', 2, 2, 'occupied', 1, 1, '', '2024-06-01 09:13:00.000000', '2024-06-01 09:13:00.000000', 4);
INSERT INTO `rooms_seat` VALUES (17, 'G1', 1, 1, 'occupied', 1, 0, '', '2024-06-01 09:14:00.000000', '2024-06-01 09:14:00.000000', 5);
INSERT INTO `rooms_seat` VALUES (18, 'G2', 1, 2, 'unavailable', 0, 1, '', '2024-06-01 09:14:00.000000', '2024-06-01 09:14:00.000000', 5);
INSERT INTO `rooms_seat` VALUES (19, 'H1', 2, 1, 'unavailable', 0, 0, '', '2024-06-01 09:14:00.000000', '2024-06-01 09:14:00.000000', 5);
INSERT INTO `rooms_seat` VALUES (20, 'H2', 2, 2, 'unavailable', 1, 1, '', '2024-06-01 09:14:00.000000', '2024-06-01 09:14:00.000000', 5);
INSERT INTO `rooms_seat` VALUES (21, 'A1', 1, 1, 'available', 1, 0, '窗边座位', '2024-06-02 08:00:00.000000', '2024-06-02 08:00:00.000000', 6);
INSERT INTO `rooms_seat` VALUES (22, 'A2', 1, 2, 'available', 1, 1, '靠门有台灯', '2024-06-02 08:00:00.000000', '2024-06-02 08:00:00.000000', 6);
INSERT INTO `rooms_seat` VALUES (23, 'B1', 1, 1, 'available', 1, 1, '夜灯座', '2024-06-02 08:15:00.000000', '2024-06-02 08:15:00.000000', 7);
INSERT INTO `rooms_seat` VALUES (24, 'B2', 1, 2, 'available', 0, 1, '靠窗台灯位', '2024-06-02 08:15:00.000000', '2024-06-02 08:15:00.000000', 7);

-- ----------------------------
-- Table structure for rooms_studyroom
-- ----------------------------
DROP TABLE IF EXISTS `rooms_studyroom`;
CREATE TABLE `rooms_studyroom`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total_seats` int(11) NOT NULL,
  `available_seats` int(11) NOT NULL,
  `open_time` time(6) NOT NULL,
  `close_time` time(6) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `facilities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rooms_studyroom
-- ----------------------------
INSERT INTO `rooms_studyroom` VALUES (1, '一号自习室', '教学楼A101', '宽敞明亮', NULL, 4, 4, '08:00:00.000000', '22:00:00.000000', 'open', '空调, 插座, WiFi', '2024-06-01 09:00:00.000000', '2024-06-01 09:00:00.000000');
INSERT INTO `rooms_studyroom` VALUES (2, '二号自习室', '教学楼B201', '安静舒适', NULL, 4, 3, '08:00:00.000000', '22:00:00.000000', 'open', '空调, 插座', '2024-06-01 09:01:00.000000', '2024-06-01 09:01:00.000000');
INSERT INTO `rooms_studyroom` VALUES (3, '三号自习室', '图书馆301', '靠窗环境', NULL, 4, 4, '08:00:00.000000', '22:00:00.000000', 'maintenance', 'WiFi, 插座', '2024-06-01 09:02:00.000000', '2024-06-01 09:02:00.000000');
INSERT INTO `rooms_studyroom` VALUES (4, '四号自习室', '宿舍楼活动室', '小型自习室', NULL, 4, 2, '09:00:00.000000', '21:00:00.000000', 'open', '空调', '2024-06-01 09:03:00.000000', '2024-06-01 09:03:00.000000');
INSERT INTO `rooms_studyroom` VALUES (5, '五号自习室', '教学楼C401', '考试周开放', '', 4, 0, '10:00:00.000000', '17:00:00.000000', 'open', '插座', '2024-06-01 09:04:00.000000', '2025-12-17 02:22:33.809069');
INSERT INTO `rooms_studyroom` VALUES (6, '六号自习室', '科技楼5F', '环境优雅，适合小组讨论', NULL, 6, 5, '07:30:00.000000', '21:30:00.000000', 'open', '空调, 插座, 黑板, WiFi', '2024-06-02 08:00:00.000000', '2024-06-02 08:00:00.000000');
INSERT INTO `rooms_studyroom` VALUES (7, '七号自习室', '教学楼D203', '夜间开放，灯光充足', NULL, 8, 7, '19:00:00.000000', '06:00:00.000000', 'open', '插座, WiFi, 空调, 台灯', '2024-06-02 08:15:00.000000', '2024-06-02 08:15:00.000000');

SET FOREIGN_KEY_CHECKS = 1;
