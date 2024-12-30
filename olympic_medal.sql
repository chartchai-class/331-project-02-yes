/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50651 (5.6.51)
 Source Host           : localhost:3306
 Source Schema         : olympic_medal

 Target Server Type    : MySQL
 Target Server Version : 50651 (5.6.51)
 File Encoding         : 65001

 Date: 20/12/2024 22:24:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_ibfk_1`(`user_id`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, 1, 'come on ever body！', '2024-12-20 19:28:03', 1);
INSERT INTO `comments` VALUES (3, 3, '88,nice', '2024-12-20 22:01:11', 1);

-- ----------------------------
-- Table structure for countries
-- ----------------------------
DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of countries
-- ----------------------------
INSERT INTO `countries` VALUES (1, 'United States', 'The United States performed exceptionally well at the 2024 Paris Olympics, winning gold medals in multiple events.', 'uploadFile/bcd47455-be3b-4c96-a40c-f0e83f56f268.png');
INSERT INTO `countries` VALUES (2, 'China', 'China achieved historic breakthroughs at the 2024 Paris Olympics, securing gold medals in several events for the first time.', '/images/CHN.png');
INSERT INTO `countries` VALUES (3, 'Japan', 'Japan also performed well at the 2024 Paris Olympics, achieving notable success in traditional strong events.', '/images/JPN.png');
INSERT INTO `countries` VALUES (4, 'Australia', 'Australia had a strong showing at the 2024 Paris Olympics, particularly in swimming and athletics.', '/images/AUS.png');
INSERT INTO `countries` VALUES (5, 'France', 'As the host nation, France had a successful Olympics, with strong performances in cycling and judo.', '/images/FRA.png');
INSERT INTO `countries` VALUES (6, 'Netherlands', 'Netherlands performed well in cycling and speed skating.', '/images/NED.png');
INSERT INTO `countries` VALUES (7, 'Great Britain', 'Great Britain had a strong showing in cycling and athletics.', '/images/GBR.png');
INSERT INTO `countries` VALUES (8, 'South Korea', 'South Korea excelled in archery and taekwondo.', '/images/KOR.png');
INSERT INTO `countries` VALUES (9, 'Italy', 'Italy had a strong performance in athletics and fencing.', '/images/ITA.png');
INSERT INTO `countries` VALUES (10, 'Germany', 'Germany performed well in athletics and rowing.', '/images/GER.png');
INSERT INTO `countries` VALUES (11, 'New Zealand', 'New Zealand had a strong showing in athletics and rowing.', '/images/NZL.png');
INSERT INTO `countries` VALUES (12, 'Canada', 'Canada performed well in athletics and swimming.', '/images/CAN.png');
INSERT INTO `countries` VALUES (13, 'Uzbekistan', 'Uzbekistan had a strong performance in wrestling and judo.', '/images/UZB.png');
INSERT INTO `countries` VALUES (14, 'Hungary', 'Hungary excelled in fencing and water polo.', '/images/HUN.png');
INSERT INTO `countries` VALUES (15, 'Spain', 'Spain performed well in cycling and athletics.', '/images/ESP.png');
INSERT INTO `countries` VALUES (16, 'Sweden', 'Sweden had a strong showing in athletics and swimming.', '/images/SWE.png');
INSERT INTO `countries` VALUES (17, 'Kenya', 'Kenya excelled in long-distance running.', '/images/KEN.png');
INSERT INTO `countries` VALUES (18, 'Norway', 'Norway performed well in athletics and cross-country skiing.', '/images/NOR.png');
INSERT INTO `countries` VALUES (19, 'Ireland', 'Ireland had a strong showing in athletics and boxing.', '/images/IRL.png');
INSERT INTO `countries` VALUES (20, 'Brazil', 'Brazil performed well in football and volleyball.', '/images/BRA.png');

-- ----------------------------
-- Table structure for sports
-- ----------------------------
DROP TABLE IF EXISTS `sports`;
CREATE TABLE `sports`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `sport_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gold` int(11) NOT NULL,
  `silver` int(11) NOT NULL,
  `bronze` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `country_id`(`country_id`) USING BTREE,
  CONSTRAINT `sports_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 476 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sports
-- ----------------------------
INSERT INTO `sports` VALUES (1, 1, 'Athletics', 10, 2, 1);
INSERT INTO `sports` VALUES (2, 1, 'Swimming', 15, 9, 7);
INSERT INTO `sports` VALUES (3, 1, 'Basketball', 2, 0, 0);
INSERT INTO `sports` VALUES (4, 1, 'Volleyball', 2, 1, 0);
INSERT INTO `sports` VALUES (5, 1, 'Football', 1, 0, 0);
INSERT INTO `sports` VALUES (6, 1, 'Baseball/Softball', 1, 0, 0);
INSERT INTO `sports` VALUES (7, 1, 'Gymnastics', 4, 3, 2);
INSERT INTO `sports` VALUES (8, 1, 'Tennis', 3, 2, 1);
INSERT INTO `sports` VALUES (9, 1, 'Cycling', 3, 2, 1);
INSERT INTO `sports` VALUES (10, 1, 'Rowing', 2, 1, 1);
INSERT INTO `sports` VALUES (11, 1, 'Sailing', 1, 1, 1);
INSERT INTO `sports` VALUES (12, 1, 'Shooting', 2, 1, 1);
INSERT INTO `sports` VALUES (13, 1, 'Wrestling', 3, 2, 1);
INSERT INTO `sports` VALUES (14, 1, 'Boxing', 2, 1, 1);
INSERT INTO `sports` VALUES (15, 1, 'Judo', 1, 1, 1);
INSERT INTO `sports` VALUES (16, 1, 'Taekwondo', 1, 1, 1);
INSERT INTO `sports` VALUES (17, 1, 'Equestrian', 1, 1, 1);
INSERT INTO `sports` VALUES (18, 1, 'Fencing', 1, 1, 1);
INSERT INTO `sports` VALUES (19, 1, 'Golf', 1, 0, 0);
INSERT INTO `sports` VALUES (20, 1, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (21, 1, 'Hockey', 1, 0, 0);
INSERT INTO `sports` VALUES (22, 1, 'Modern Pentathlon', 0, 1, 0);
INSERT INTO `sports` VALUES (23, 1, 'Rugby Sevens', 0, 1, 0);
INSERT INTO `sports` VALUES (24, 1, 'Triathlon', 1, 0, 0);
INSERT INTO `sports` VALUES (25, 1, 'Water Polo', 1, 1, 0);
INSERT INTO `sports` VALUES (26, 1, 'Beach Volleyball', 1, 1, 0);
INSERT INTO `sports` VALUES (27, 1, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (28, 1, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (29, 1, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (30, 1, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (31, 1, 'Archery', 0, 1, 1);
INSERT INTO `sports` VALUES (32, 1, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (33, 1, 'Diving', 1, 1, 11);
INSERT INTO `sports` VALUES (34, 1, 'Synchronized Swimming', 1, 0, 0);
INSERT INTO `sports` VALUES (35, 1, 'Artistic Swimming', 1, 0, 0);
INSERT INTO `sports` VALUES (36, 2, 'Athletics', 5, 3, 4);
INSERT INTO `sports` VALUES (37, 2, 'Swimming', 4, 2, 3);
INSERT INTO `sports` VALUES (38, 2, 'Gymnastics', 3, 2, 1);
INSERT INTO `sports` VALUES (39, 2, 'Table Tennis', 4, 0, 1);
INSERT INTO `sports` VALUES (40, 2, 'Badminton', 2, 1, 2);
INSERT INTO `sports` VALUES (41, 2, 'Weightlifting', 5, 1, 1);
INSERT INTO `sports` VALUES (42, 2, 'Diving', 4, 2, 1);
INSERT INTO `sports` VALUES (43, 2, 'Shooting', 2, 1, 2);
INSERT INTO `sports` VALUES (44, 2, 'Taekwondo', 1, 1, 1);
INSERT INTO `sports` VALUES (45, 2, 'Wrestling', 2, 1, 1);
INSERT INTO `sports` VALUES (46, 2, 'Judo', 1, 1, 1);
INSERT INTO `sports` VALUES (47, 2, 'Cycling', 2, 1, 1);
INSERT INTO `sports` VALUES (48, 2, 'Fencing', 1, 1, 1);
INSERT INTO `sports` VALUES (49, 2, 'Boxing', 1, 1, 1);
INSERT INTO `sports` VALUES (50, 2, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (51, 2, 'Rowing', 1, 0, 1);
INSERT INTO `sports` VALUES (52, 2, 'Sailing', 1, 0, 1);
INSERT INTO `sports` VALUES (53, 2, 'Equestrian', 0, 1, 1);
INSERT INTO `sports` VALUES (54, 2, 'Triathlon', 0, 1, 1);
INSERT INTO `sports` VALUES (55, 2, 'Volleyball', 1, 0, 0);
INSERT INTO `sports` VALUES (56, 2, 'Basketball', 1, 0, 0);
INSERT INTO `sports` VALUES (57, 2, 'Football', 0, 1, 0);
INSERT INTO `sports` VALUES (58, 2, 'Handball', 0, 0, 1);
INSERT INTO `sports` VALUES (59, 2, 'Hockey', 0, 0, 1);
INSERT INTO `sports` VALUES (60, 2, 'Tennis', 0, 1, 0);
INSERT INTO `sports` VALUES (61, 2, 'Synchronized Swimming', 1, 0, 0);
INSERT INTO `sports` VALUES (62, 2, 'Artistic Swimming', 1, 0, 0);
INSERT INTO `sports` VALUES (63, 2, 'Modern Pentathlon', 0, 1, 0);
INSERT INTO `sports` VALUES (64, 2, 'Karate', 1, 0, 0);
INSERT INTO `sports` VALUES (65, 2, 'Archery', 0, 1, 1);
INSERT INTO `sports` VALUES (66, 2, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (67, 2, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (68, 2, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (69, 2, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (70, 2, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (71, 2, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (72, 2, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (73, 3, 'Athletics', 2, 1, 1);
INSERT INTO `sports` VALUES (74, 3, 'Swimming', 3, 2, 1);
INSERT INTO `sports` VALUES (75, 3, 'Gymnastics', 2, 1, 1);
INSERT INTO `sports` VALUES (76, 3, 'Table Tennis', 1, 1, 1);
INSERT INTO `sports` VALUES (77, 3, 'Badminton', 1, 0, 0);
INSERT INTO `sports` VALUES (78, 3, 'Weightlifting', 1, 0, 0);
INSERT INTO `sports` VALUES (79, 3, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (80, 3, 'Shooting', 1, 0, 0);
INSERT INTO `sports` VALUES (81, 3, 'Taekwondo', 1, 1, 1);
INSERT INTO `sports` VALUES (82, 3, 'Wrestling', 3, 2, 1);
INSERT INTO `sports` VALUES (83, 3, 'Judo', 4, 2, 1);
INSERT INTO `sports` VALUES (84, 3, 'Cycling', 1, 0, 0);
INSERT INTO `sports` VALUES (85, 3, 'Fencing', 0, 1, 0);
INSERT INTO `sports` VALUES (86, 3, 'Boxing', 1, 0, 0);
INSERT INTO `sports` VALUES (87, 3, 'Canoe/Kayak', 1, 0, 0);
INSERT INTO `sports` VALUES (88, 3, 'Rowing', 0, 1, 0);
INSERT INTO `sports` VALUES (89, 3, 'Sailing', 0, 0, 1);
INSERT INTO `sports` VALUES (90, 3, 'Equestrian', 0, 0, 1);
INSERT INTO `sports` VALUES (91, 3, 'Triathlon', 1, 0, 0);
INSERT INTO `sports` VALUES (92, 3, 'Volleyball', 0, 1, 0);
INSERT INTO `sports` VALUES (93, 3, 'Basketball', 0, 0, 1);
INSERT INTO `sports` VALUES (94, 3, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (95, 3, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (96, 3, 'Hockey', 0, 0, 0);
INSERT INTO `sports` VALUES (97, 3, 'Tennis', 1, 0, 0);
INSERT INTO `sports` VALUES (98, 3, 'Synchronized Swimming', 0, 1, 0);
INSERT INTO `sports` VALUES (99, 3, 'Artistic Swimming', 0, 1, 0);
INSERT INTO `sports` VALUES (100, 3, 'Modern Pentathlon', 0, 0, 0);
INSERT INTO `sports` VALUES (101, 3, 'Karate', 2, 1, 1);
INSERT INTO `sports` VALUES (102, 3, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (103, 3, 'Baseball/Softball', 1, 0, 0);
INSERT INTO `sports` VALUES (104, 3, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (105, 3, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (106, 3, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (107, 3, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (108, 3, 'Skateboarding', 1, 0, 0);
INSERT INTO `sports` VALUES (109, 3, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (110, 4, 'Athletics', 4, 3, 2);
INSERT INTO `sports` VALUES (111, 4, 'Swimming', 2, 2, 1);
INSERT INTO `sports` VALUES (112, 4, 'Cycling', 3, 2, 1);
INSERT INTO `sports` VALUES (113, 4, 'Gymnastics', 1, 1, 1);
INSERT INTO `sports` VALUES (114, 4, 'Football', 1, 0, 0);
INSERT INTO `sports` VALUES (115, 4, 'Basketball', 0, 1, 0);
INSERT INTO `sports` VALUES (116, 4, 'Volleyball', 0, 1, 0);
INSERT INTO `sports` VALUES (117, 4, 'Handball', 1, 0, 0);
INSERT INTO `sports` VALUES (118, 4, 'Hockey', 0, 0, 0);
INSERT INTO `sports` VALUES (119, 4, 'Tennis', 1, 0, 0);
INSERT INTO `sports` VALUES (120, 4, 'Rowing', 2, 1, 1);
INSERT INTO `sports` VALUES (121, 4, 'Sailing', 1, 1, 1);
INSERT INTO `sports` VALUES (122, 4, 'Shooting', 1, 0, 0);
INSERT INTO `sports` VALUES (123, 4, 'Wrestling', 1, 1, 1);
INSERT INTO `sports` VALUES (124, 4, 'Boxing', 1, 0, 0);
INSERT INTO `sports` VALUES (125, 4, 'Judo', 2, 1, 1);
INSERT INTO `sports` VALUES (126, 4, 'Taekwondo', 1, 1, 1);
INSERT INTO `sports` VALUES (127, 4, 'Equestrian', 2, 1, 1);
INSERT INTO `sports` VALUES (128, 4, 'Fencing', 2, 1, 1);
INSERT INTO `sports` VALUES (129, 4, 'Modern Pentathlon', 1, 0, 0);
INSERT INTO `sports` VALUES (130, 4, 'Triathlon', 1, 0, 0);
INSERT INTO `sports` VALUES (131, 4, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (132, 4, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (133, 4, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (134, 4, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (135, 4, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (136, 4, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (137, 4, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (138, 4, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (139, 4, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (140, 4, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (141, 4, 'Synchronized Swimming', 0, 1, 0);
INSERT INTO `sports` VALUES (142, 4, 'Artistic Swimming', 0, 1, 0);
INSERT INTO `sports` VALUES (143, 4, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (144, 5, 'Athletics', 3, 2, 2);
INSERT INTO `sports` VALUES (145, 5, 'Swimming', 6, 4, 3);
INSERT INTO `sports` VALUES (146, 5, 'Cycling', 2, 1, 1);
INSERT INTO `sports` VALUES (147, 5, 'Gymnastics', 0, 1, 0);
INSERT INTO `sports` VALUES (148, 5, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (149, 5, 'Basketball', 0, 1, 0);
INSERT INTO `sports` VALUES (150, 5, 'Volleyball', 0, 0, 0);
INSERT INTO `sports` VALUES (151, 5, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (152, 5, 'Hockey', 1, 0, 0);
INSERT INTO `sports` VALUES (153, 5, 'Tennis', 0, 1, 0);
INSERT INTO `sports` VALUES (154, 5, 'Rowing', 2, 1, 1);
INSERT INTO `sports` VALUES (155, 5, 'Sailing', 1, 1, 1);
INSERT INTO `sports` VALUES (156, 5, 'Shooting', 0, 1, 0);
INSERT INTO `sports` VALUES (157, 5, 'Wrestling', 0, 0, 1);
INSERT INTO `sports` VALUES (158, 5, 'Boxing', 0, 1, 0);
INSERT INTO `sports` VALUES (159, 5, 'Judo', 0, 0, 1);
INSERT INTO `sports` VALUES (160, 5, 'Taekwondo', 0, 0, 1);
INSERT INTO `sports` VALUES (161, 5, 'Equestrian', 1, 0, 0);
INSERT INTO `sports` VALUES (162, 5, 'Fencing', 0, 0, 1);
INSERT INTO `sports` VALUES (163, 5, 'Modern Pentathlon', 0, 0, 0);
INSERT INTO `sports` VALUES (164, 5, 'Triathlon', 1, 0, 0);
INSERT INTO `sports` VALUES (165, 5, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (166, 5, 'Beach Volleyball', 0, 1, 0);
INSERT INTO `sports` VALUES (167, 5, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (168, 5, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (169, 5, 'Rugby Sevens', 1, 0, 0);
INSERT INTO `sports` VALUES (170, 5, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (171, 5, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (172, 5, 'Archery', 0, 0, 1);
INSERT INTO `sports` VALUES (173, 5, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (174, 5, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (175, 5, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (176, 5, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (177, 5, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (178, 6, 'Athletics', 3, 2, 1);
INSERT INTO `sports` VALUES (179, 6, 'Swimming', 2, 1, 2);
INSERT INTO `sports` VALUES (180, 6, 'Cycling', 3, 2, 1);
INSERT INTO `sports` VALUES (181, 6, 'Gymnastics', 1, 1, 1);
INSERT INTO `sports` VALUES (182, 6, 'Football', 0, 1, 0);
INSERT INTO `sports` VALUES (183, 6, 'Basketball', 0, 0, 1);
INSERT INTO `sports` VALUES (184, 6, 'Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (185, 6, 'Handball', 1, 0, 0);
INSERT INTO `sports` VALUES (186, 6, 'Hockey', 1, 0, 0);
INSERT INTO `sports` VALUES (187, 6, 'Tennis', 0, 1, 0);
INSERT INTO `sports` VALUES (188, 6, 'Rowing', 2, 1, 1);
INSERT INTO `sports` VALUES (189, 6, 'Sailing', 1, 1, 1);
INSERT INTO `sports` VALUES (190, 6, 'Shooting', 1, 0, 0);
INSERT INTO `sports` VALUES (191, 6, 'Wrestling', 1, 1, 1);
INSERT INTO `sports` VALUES (192, 6, 'Boxing', 0, 1, 0);
INSERT INTO `sports` VALUES (193, 6, 'Judo', 1, 1, 1);
INSERT INTO `sports` VALUES (194, 6, 'Taekwondo', 0, 1, 1);
INSERT INTO `sports` VALUES (195, 6, 'Equestrian', 2, 1, 1);
INSERT INTO `sports` VALUES (196, 6, 'Fencing', 1, 1, 1);
INSERT INTO `sports` VALUES (197, 6, 'Modern Pentathlon', 1, 0, 0);
INSERT INTO `sports` VALUES (198, 6, 'Triathlon', 0, 1, 0);
INSERT INTO `sports` VALUES (199, 6, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (200, 6, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (201, 6, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (202, 6, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (203, 6, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (204, 6, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (205, 6, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (206, 6, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (207, 6, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (208, 6, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (209, 6, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (210, 6, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (211, 6, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (212, 7, 'Athletics', 2, 2, 1);
INSERT INTO `sports` VALUES (213, 7, 'Swimming', 3, 2, 1);
INSERT INTO `sports` VALUES (214, 7, 'Cycling', 1, 1, 1);
INSERT INTO `sports` VALUES (215, 7, 'Gymnastics', 0, 1, 0);
INSERT INTO `sports` VALUES (216, 7, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (217, 7, 'Basketball', 0, 0, 1);
INSERT INTO `sports` VALUES (218, 7, 'Volleyball', 0, 1, 0);
INSERT INTO `sports` VALUES (219, 7, 'Handball', 0, 0, 1);
INSERT INTO `sports` VALUES (220, 7, 'Hockey', 0, 0, 0);
INSERT INTO `sports` VALUES (221, 7, 'Tennis', 1, 0, 0);
INSERT INTO `sports` VALUES (222, 7, 'Rowing', 1, 1, 1);
INSERT INTO `sports` VALUES (223, 7, 'Sailing', 1, 1, 1);
INSERT INTO `sports` VALUES (224, 7, 'Shooting', 0, 1, 0);
INSERT INTO `sports` VALUES (225, 7, 'Wrestling', 1, 1, 1);
INSERT INTO `sports` VALUES (226, 7, 'Boxing', 0, 1, 0);
INSERT INTO `sports` VALUES (227, 7, 'Judo', 1, 1, 1);
INSERT INTO `sports` VALUES (228, 7, 'Taekwondo', 0, 1, 1);
INSERT INTO `sports` VALUES (229, 7, 'Equestrian', 1, 0, 0);
INSERT INTO `sports` VALUES (230, 7, 'Fencing', 2, 1, 1);
INSERT INTO `sports` VALUES (231, 7, 'Modern Pentathlon', 0, 0, 1);
INSERT INTO `sports` VALUES (232, 7, 'Triathlon', 0, 1, 0);
INSERT INTO `sports` VALUES (233, 7, 'Water Polo', 0, 0, 1);
INSERT INTO `sports` VALUES (234, 7, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (235, 7, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (236, 7, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (237, 7, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (238, 7, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (239, 7, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (240, 7, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (241, 7, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (242, 7, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (243, 7, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (244, 7, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (245, 7, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (246, 8, 'Athletics', 1, 1, 1);
INSERT INTO `sports` VALUES (247, 8, 'Swimming', 1, 0, 1);
INSERT INTO `sports` VALUES (248, 8, 'Cycling', 0, 1, 0);
INSERT INTO `sports` VALUES (249, 8, 'Gymnastics', 0, 1, 0);
INSERT INTO `sports` VALUES (250, 8, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (251, 8, 'Basketball', 0, 0, 0);
INSERT INTO `sports` VALUES (252, 8, 'Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (253, 8, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (254, 8, 'Hockey', 0, 0, 0);
INSERT INTO `sports` VALUES (255, 8, 'Tennis', 0, 1, 0);
INSERT INTO `sports` VALUES (256, 8, 'Rowing', 0, 0, 1);
INSERT INTO `sports` VALUES (257, 8, 'Sailing', 0, 0, 1);
INSERT INTO `sports` VALUES (258, 8, 'Shooting', 2, 1, 1);
INSERT INTO `sports` VALUES (259, 8, 'Wrestling', 1, 1, 1);
INSERT INTO `sports` VALUES (260, 8, 'Boxing', 1, 0, 1);
INSERT INTO `sports` VALUES (261, 8, 'Judo', 1, 1, 1);
INSERT INTO `sports` VALUES (262, 8, 'Taekwondo', 2, 1, 1);
INSERT INTO `sports` VALUES (263, 8, 'Equestrian', 0, 0, 0);
INSERT INTO `sports` VALUES (264, 8, 'Fencing', 1, 0, 0);
INSERT INTO `sports` VALUES (265, 8, 'Modern Pentathlon', 0, 0, 0);
INSERT INTO `sports` VALUES (266, 8, 'Triathlon', 0, 0, 1);
INSERT INTO `sports` VALUES (267, 8, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (268, 8, 'Beach Volleyball', 0, 0, 0);
INSERT INTO `sports` VALUES (269, 8, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (270, 8, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (271, 8, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (272, 8, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (273, 8, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (274, 8, 'Archery', 2, 1, 0);
INSERT INTO `sports` VALUES (275, 8, 'Canoe/Kayak', 0, 1, 1);
INSERT INTO `sports` VALUES (276, 8, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (277, 8, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (278, 8, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (279, 8, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (280, 9, 'Athletics', 1, 1, 1);
INSERT INTO `sports` VALUES (281, 9, 'Swimming', 1, 1, 1);
INSERT INTO `sports` VALUES (282, 9, 'Cycling', 2, 1, 1);
INSERT INTO `sports` VALUES (283, 9, 'Gymnastics', 0, 1, 0);
INSERT INTO `sports` VALUES (284, 9, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (285, 9, 'Basketball', 0, 0, 0);
INSERT INTO `sports` VALUES (286, 9, 'Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (287, 9, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (288, 9, 'Hockey', 1, 1, 0);
INSERT INTO `sports` VALUES (289, 9, 'Tennis', 0, 1, 0);
INSERT INTO `sports` VALUES (290, 9, 'Rowing', 1, 1, 1);
INSERT INTO `sports` VALUES (291, 9, 'Sailing', 2, 1, 1);
INSERT INTO `sports` VALUES (292, 9, 'Shooting', 0, 1, 0);
INSERT INTO `sports` VALUES (293, 9, 'Wrestling', 0, 1, 1);
INSERT INTO `sports` VALUES (294, 9, 'Boxing', 0, 1, 0);
INSERT INTO `sports` VALUES (295, 9, 'Judo', 1, 1, 1);
INSERT INTO `sports` VALUES (296, 9, 'Taekwondo', 0, 1, 1);
INSERT INTO `sports` VALUES (297, 9, 'Equestrian', 1, 1, 1);
INSERT INTO `sports` VALUES (298, 9, 'Fencing', 0, 1, 0);
INSERT INTO `sports` VALUES (299, 9, 'Modern Pentathlon', 0, 0, 1);
INSERT INTO `sports` VALUES (300, 9, 'Triathlon', 0, 1, 0);
INSERT INTO `sports` VALUES (301, 9, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (302, 9, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (303, 9, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (304, 9, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (305, 9, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (306, 9, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (307, 9, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (308, 9, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (309, 9, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (310, 9, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (311, 9, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (312, 9, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (313, 9, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (314, 10, 'Athletics', 1, 2, 1);
INSERT INTO `sports` VALUES (315, 10, 'Swimming', 2, 1, 1);
INSERT INTO `sports` VALUES (316, 10, 'Cycling', 1, 1, 1);
INSERT INTO `sports` VALUES (317, 10, 'Gymnastics', 0, 1, 0);
INSERT INTO `sports` VALUES (318, 10, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (319, 10, 'Basketball', 0, 0, 1);
INSERT INTO `sports` VALUES (320, 10, 'Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (321, 10, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (322, 10, 'Hockey', 0, 0, 1);
INSERT INTO `sports` VALUES (323, 10, 'Tennis', 0, 1, 0);
INSERT INTO `sports` VALUES (324, 10, 'Rowing', 1, 1, 1);
INSERT INTO `sports` VALUES (325, 10, 'Sailing', 1, 1, 1);
INSERT INTO `sports` VALUES (326, 10, 'Shooting', 0, 1, 0);
INSERT INTO `sports` VALUES (327, 10, 'Wrestling', 1, 1, 1);
INSERT INTO `sports` VALUES (328, 10, 'Boxing', 0, 1, 0);
INSERT INTO `sports` VALUES (329, 10, 'Judo', 0, 1, 1);
INSERT INTO `sports` VALUES (330, 10, 'Taekwondo', 0, 1, 1);
INSERT INTO `sports` VALUES (331, 10, 'Equestrian', 0, 1, 0);
INSERT INTO `sports` VALUES (332, 10, 'Fencing', 0, 1, 0);
INSERT INTO `sports` VALUES (333, 10, 'Modern Pentathlon', 0, 0, 1);
INSERT INTO `sports` VALUES (334, 10, 'Triathlon', 0, 1, 0);
INSERT INTO `sports` VALUES (335, 10, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (336, 10, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (337, 10, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (338, 10, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (339, 10, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (340, 10, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (341, 10, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (342, 10, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (343, 10, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (344, 10, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (345, 10, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (346, 10, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (347, 10, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (348, 11, 'Athletics', 1, 1, 1);
INSERT INTO `sports` VALUES (349, 11, 'Swimming', 2, 1, 1);
INSERT INTO `sports` VALUES (350, 11, 'Cycling', 0, 1, 1);
INSERT INTO `sports` VALUES (351, 11, 'Gymnastics', 2, 1, 1);
INSERT INTO `sports` VALUES (352, 11, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (353, 11, 'Basketball', 0, 0, 1);
INSERT INTO `sports` VALUES (354, 11, 'Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (355, 11, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (356, 11, 'Hockey', 0, 0, 1);
INSERT INTO `sports` VALUES (357, 11, 'Tennis', 1, 1, 0);
INSERT INTO `sports` VALUES (358, 11, 'Rowing', 1, 1, 1);
INSERT INTO `sports` VALUES (359, 11, 'Sailing', 1, 1, 1);
INSERT INTO `sports` VALUES (360, 11, 'Shooting', 0, 1, 0);
INSERT INTO `sports` VALUES (361, 11, 'Wrestling', 2, 1, 1);
INSERT INTO `sports` VALUES (362, 11, 'Boxing', 1, 1, 0);
INSERT INTO `sports` VALUES (363, 11, 'Judo', 3, 2, 1);
INSERT INTO `sports` VALUES (364, 11, 'Taekwondo', 1, 1, 1);
INSERT INTO `sports` VALUES (365, 11, 'Equestrian', 0, 1, 0);
INSERT INTO `sports` VALUES (366, 11, 'Fencing', 0, 1, 0);
INSERT INTO `sports` VALUES (367, 11, 'Modern Pentathlon', 0, 0, 1);
INSERT INTO `sports` VALUES (368, 11, 'Triathlon', 0, 1, 0);
INSERT INTO `sports` VALUES (369, 11, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (370, 11, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (371, 11, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (372, 11, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (373, 11, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (374, 11, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (375, 11, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (376, 11, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (377, 11, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (378, 11, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (379, 11, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (380, 11, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (381, 11, 'Baseball/Softball', 1, 0, 0);
INSERT INTO `sports` VALUES (382, 12, 'Athletics', 1, 1, 1);
INSERT INTO `sports` VALUES (383, 12, 'Swimming', 2, 1, 1);
INSERT INTO `sports` VALUES (384, 12, 'Cycling', 0, 1, 1);
INSERT INTO `sports` VALUES (385, 12, 'Gymnastics', 2, 1, 1);
INSERT INTO `sports` VALUES (386, 12, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (387, 12, 'Basketball', 0, 0, 1);
INSERT INTO `sports` VALUES (388, 12, 'Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (389, 12, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (390, 12, 'Hockey', 0, 0, 1);
INSERT INTO `sports` VALUES (391, 12, 'Tennis', 1, 1, 0);
INSERT INTO `sports` VALUES (392, 12, 'Rowing', 1, 1, 1);
INSERT INTO `sports` VALUES (393, 12, 'Sailing', 1, 1, 1);
INSERT INTO `sports` VALUES (394, 12, 'Shooting', 0, 1, 0);
INSERT INTO `sports` VALUES (395, 12, 'Wrestling', 2, 1, 1);
INSERT INTO `sports` VALUES (396, 12, 'Boxing', 1, 1, 0);
INSERT INTO `sports` VALUES (397, 12, 'Judo', 3, 2, 1);
INSERT INTO `sports` VALUES (398, 12, 'Taekwondo', 1, 1, 1);
INSERT INTO `sports` VALUES (399, 12, 'Equestrian', 0, 1, 0);
INSERT INTO `sports` VALUES (400, 12, 'Fencing', 0, 1, 0);
INSERT INTO `sports` VALUES (401, 12, 'Modern Pentathlon', 0, 0, 1);
INSERT INTO `sports` VALUES (402, 12, 'Triathlon', 0, 1, 0);
INSERT INTO `sports` VALUES (403, 12, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (404, 12, 'Beach Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (405, 12, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (406, 12, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (407, 12, 'Rugby Sevens', 0, 0, 0);
INSERT INTO `sports` VALUES (408, 12, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (409, 12, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (410, 12, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (411, 12, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (412, 12, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (413, 12, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (414, 12, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (415, 12, 'Baseball/Softball', 1, 0, 0);
INSERT INTO `sports` VALUES (416, 13, 'Athletics', 3, 2, 1);
INSERT INTO `sports` VALUES (417, 13, 'Swimming', 4, 3, 2);
INSERT INTO `sports` VALUES (418, 13, 'Cycling', 1, 1, 1);
INSERT INTO `sports` VALUES (419, 13, 'Gymnastics', 0, 1, 0);
INSERT INTO `sports` VALUES (420, 13, 'Football', 0, 0, 1);
INSERT INTO `sports` VALUES (421, 13, 'Basketball', 0, 1, 0);
INSERT INTO `sports` VALUES (422, 13, 'Volleyball', 0, 0, 1);
INSERT INTO `sports` VALUES (423, 13, 'Handball', 0, 0, 0);
INSERT INTO `sports` VALUES (424, 13, 'Hockey', 1, 0, 0);
INSERT INTO `sports` VALUES (425, 13, 'Tennis', 0, 1, 0);
INSERT INTO `sports` VALUES (426, 13, 'Rowing', 2, 1, 1);
INSERT INTO `sports` VALUES (427, 13, 'Sailing', 2, 1, 1);
INSERT INTO `sports` VALUES (428, 13, 'Shooting', 0, 1, 0);
INSERT INTO `sports` VALUES (429, 13, 'Wrestling', 0, 1, 1);
INSERT INTO `sports` VALUES (430, 13, 'Boxing', 0, 1, 0);
INSERT INTO `sports` VALUES (431, 13, 'Judo', 0, 1, 1);
INSERT INTO `sports` VALUES (432, 13, 'Taekwondo', 0, 1, 1);
INSERT INTO `sports` VALUES (433, 13, 'Equestrian', 0, 1, 0);
INSERT INTO `sports` VALUES (434, 13, 'Fencing', 0, 1, 0);
INSERT INTO `sports` VALUES (435, 13, 'Modern Pentathlon', 0, 0, 1);
INSERT INTO `sports` VALUES (436, 13, 'Triathlon', 1, 0, 0);
INSERT INTO `sports` VALUES (437, 13, 'Water Polo', 0, 0, 0);
INSERT INTO `sports` VALUES (438, 13, 'Beach Volleyball', 0, 1, 0);
INSERT INTO `sports` VALUES (439, 13, 'Breakdancing', 0, 0, 0);
INSERT INTO `sports` VALUES (440, 13, 'Climbing', 0, 0, 0);
INSERT INTO `sports` VALUES (441, 13, 'Rugby Sevens', 1, 0, 0);
INSERT INTO `sports` VALUES (442, 13, 'Skateboarding', 0, 0, 0);
INSERT INTO `sports` VALUES (443, 13, 'Surfing', 0, 0, 0);
INSERT INTO `sports` VALUES (444, 13, 'Archery', 0, 1, 0);
INSERT INTO `sports` VALUES (445, 13, 'Canoe/Kayak', 1, 1, 1);
INSERT INTO `sports` VALUES (446, 13, 'Diving', 0, 1, 0);
INSERT INTO `sports` VALUES (447, 13, 'Synchronized Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (448, 13, 'Artistic Swimming', 0, 0, 0);
INSERT INTO `sports` VALUES (449, 13, 'Baseball/Softball', 0, 0, 0);
INSERT INTO `sports` VALUES (450, 14, 'Fencing', 3, 3, 2);
INSERT INTO `sports` VALUES (451, 14, 'Water Polo', 1, 1, 1);
INSERT INTO `sports` VALUES (452, 14, 'Swimming', 1, 1, 1);
INSERT INTO `sports` VALUES (453, 14, 'Football', 1, 1, 1);
INSERT INTO `sports` VALUES (454, 14, 'Archery', 0, 0, 0);
INSERT INTO `sports` VALUES (455, 14, 'Cycling', 0, 0, 0);
INSERT INTO `sports` VALUES (456, 15, 'Cycling', 2, 2, 2);
INSERT INTO `sports` VALUES (457, 15, 'Athletics', 2, 1, 3);
INSERT INTO `sports` VALUES (458, 15, 'Football', 1, 1, 1);
INSERT INTO `sports` VALUES (459, 15, 'Tennis', 0, 0, 1);
INSERT INTO `sports` VALUES (460, 15, 'Rowing', 0, 0, 1);
INSERT INTO `sports` VALUES (461, 16, 'Athletics', 2, 2, 1);
INSERT INTO `sports` VALUES (462, 16, 'Swimming', 2, 2, 2);
INSERT INTO `sports` VALUES (463, 16, 'Cycling', 0, 0, 0);
INSERT INTO `sports` VALUES (464, 17, 'Athletics', 4, 2, 5);
INSERT INTO `sports` VALUES (465, 17, 'Football', 0, 1, 0);
INSERT INTO `sports` VALUES (466, 17, 'Triathlon', 0, 0, 0);
INSERT INTO `sports` VALUES (467, 18, 'Athletics', 2, 1, 1);
INSERT INTO `sports` VALUES (468, 18, 'Cross-Country Skiing', 2, 0, 2);
INSERT INTO `sports` VALUES (469, 19, 'Athletics', 2, 0, 1);
INSERT INTO `sports` VALUES (470, 19, 'Boxing', 2, 0, 2);
INSERT INTO `sports` VALUES (471, 20, 'Football', 1, 2, 2);
INSERT INTO `sports` VALUES (472, 20, 'Volleyball', 1, 2, 2);
INSERT INTO `sports` VALUES (473, 20, 'Athletics', 1, 1, 2);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'uploadFile/416b5a58-f29f-4d53-b76b-a0bb39e41171.png', '0', '2024-12-20 18:53:35');
INSERT INTO `users` VALUES (3, 'zhangsan', '123456', 'uploadFile/0e25432a-286f-467a-af09-7ecbebbd8e75.png', '0', '2024-12-20 22:00:24');

SET FOREIGN_KEY_CHECKS = 1;
