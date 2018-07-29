/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50630
Source Host           : localhost:3306
Source Database       : blogdb

Target Server Type    : MYSQL
Target Server Version : 50630
File Encoding         : 65001

Date: 2017-10-31 22:25:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add 标签', '6', 'add_tag');
INSERT INTO `auth_permission` VALUES ('17', 'Can change 标签', '6', 'change_tag');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete 标签', '6', 'delete_tag');
INSERT INTO `auth_permission` VALUES ('19', 'Can add 分类', '7', 'add_category');
INSERT INTO `auth_permission` VALUES ('20', 'Can change 分类', '7', 'change_category');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete 分类', '7', 'delete_category');
INSERT INTO `auth_permission` VALUES ('22', 'Can add 用户', '8', 'add_user');
INSERT INTO `auth_permission` VALUES ('23', 'Can change 用户', '8', 'change_user');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete 用户', '8', 'delete_user');
INSERT INTO `auth_permission` VALUES ('25', 'Can add 文章', '9', 'add_article');
INSERT INTO `auth_permission` VALUES ('26', 'Can change 文章', '9', 'change_article');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete 文章', '9', 'delete_article');
INSERT INTO `auth_permission` VALUES ('28', 'Can add 评论', '10', 'add_comment');
INSERT INTO `auth_permission` VALUES ('29', 'Can change 评论', '10', 'change_comment');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete 评论', '10', 'delete_comment');
INSERT INTO `auth_permission` VALUES ('31', 'Can add 友情链接', '11', 'add_links');
INSERT INTO `auth_permission` VALUES ('32', 'Can change 友情链接', '11', 'change_links');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete 友情链接', '11', 'delete_links');
INSERT INTO `auth_permission` VALUES ('34', 'Can add 广告', '12', 'add_ad');
INSERT INTO `auth_permission` VALUES ('35', 'Can change 广告', '12', 'change_ad');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete 广告', '12', 'delete_ad');

-- ----------------------------
-- Table structure for blog_ad
-- ----------------------------
DROP TABLE IF EXISTS `blog_ad`;
CREATE TABLE `blog_ad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  `image_url` varchar(100) NOT NULL,
  `callback_url` varchar(200) DEFAULT NULL,
  `date_publish` datetime NOT NULL,
  `index` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_ad
-- ----------------------------
INSERT INTO `blog_ad` VALUES ('3', '你好，世界！', '你好世界', 'ad/2017/10/a1.jpg', 'http://127.0.0.1:8000/article/?id=8', '2016-11-03 06:18:01', '999');

-- ----------------------------
-- Table structure for blog_article
-- ----------------------------
DROP TABLE IF EXISTS `blog_article`;
CREATE TABLE `blog_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `desc` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `click_count` int(11) NOT NULL,
  `is_recommend` tinyint(1) NOT NULL,
  `date_publish` datetime NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_article_b583a629` (`category_id`),
  KEY `blog_article_e8701ad4` (`user_id`),
  CONSTRAINT `blog_article_category_id_7e38f15e_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`),
  CONSTRAINT `blog_article_user_id_5beb0cc1_fk_blog_user_id` FOREIGN KEY (`user_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_article
-- ----------------------------
INSERT INTO `blog_article` VALUES ('4', '威少35分雷霆保持不败 保罗准3双快船主场折戟', 'nba战报', '雷霆（4-0）惊险过关，拉塞尔-威斯布鲁克投中制胜一球，拿下了35分、6个篮板和5次助攻，他还抢断3次。其他人得分都没上双，维克托-奥拉迪波得了9分，斯蒂芬-亚当斯抢下11个篮板。\r\n<p>\r\n	快船（3-1）新赛季首败。克里斯-保罗几乎打出三双，得了15分、11个篮板和9次助攻，他还抢断6次。布雷克-格里芬14分、8个篮板和5次助攻，德安德烈-乔丹8分6个篮板。替补出场的马利斯-斯贝茨14分。\r\n</p>\r\n<p>\r\n	比赛开始之前，两队都是3战全胜，今天狭路相逢，必有一队会首尝败果。\r\n</p>\r\n<div id=\"ad_51777\" class=\"otherContent_01\" style=\"margin:10px 20px 10px 0px;padding:4px;\">\r\n</div>\r\n<p>\r\n	雷霆曾经的双少只剩下威斯布鲁克一人，他已经几次砍下神级数据，为雷霆取得不错的开局。快船兵多将广，替补也一反常态地极具深度，取得良好开局不令人意外。\r\n</p>\r\n<p>\r\n	双方一直打得难解难分。上半场最后3分钟，快船只投中一球，威斯布鲁克连连攻击篮下，雷霆打出一波13-2后，以49-41反超。\r\n</p>\r\n<p>\r\n	快船在第三节成功限制威斯布鲁克，逐渐反超。巴斯投中一记压哨三分后，快船以66-65领先。\r\n</p>\r\n<p>\r\n	两队继续苦战。第四节过半时，快船以78-76领先，但此后4分49秒他们一分未得。威斯布鲁克两度得手并送出一次助攻，在比赛还有1分11秒时，他在快攻中暴扣得手，雷霆连得7分，以83-78超出。\r\n</p>\r\n<p>\r\n	快船终于由雷迪克结束久不得分的局面，投中一记三分。罗伯森两罚不中给了快船绝佳机会，可惜他们没抢到篮板。\r\n</p>', '0', '1', '2016-11-03 07:08:01', '1', '2');
INSERT INTO `blog_article` VALUES ('6', '《战狼2》历时5个月杀青 40度拍到零下9度', '新电影动态', '新浪娱乐讯 “11月2日，<a href=\"http://ku.ent.sina.com.cn/movie/26408\" target=\"_blank\">《战狼2》</a>国内部分杀青，谢谢你们，谢谢你们，谢谢你们”。昨日，吴京<a target=\"_blank\" href=\"http://weibo.com/1863847262?zw=ent\" class=\"wt_article_link\">[微博]</a>自导自演的军事动作电影《战狼2》结束了长达5个月的拍摄，顺利杀青。吴京举枪对天连发数枪，“杀青啦”喊出了5个月来的辛苦。暴风雨一夜冲垮刚搭好的景、海上遭遇船长所见过的最大的雾、多次受伤想叫停又咬紧了牙关继续……一起抗过的困难，此刻都化作了一份回忆。“紧绷着的弦终于能松下来了”，整个剧组既兴奋又带着不舍，“《战狼2》明年见！“的声音此起彼伏。\r\n<p>\r\n	吴京还用平淡的幽默，硬汉的方式，记录下了《战狼2》拍摄中的14件小事，细心又暖心。“第一次踏上非洲贫民窟看景，吃了当地料理：树皮”、“非洲小女孩pasha杀青……”，都令《战狼2》的国际格局初露端倪。“水下拍摄，泡了十几个小时，脑子快进水了”、“和弗兰克对打，挺爽的”，《美队》系列大反派“交叉骨”的露面，让动作戏悬念迭生。“温度零下的夜+雨戏，冷锋快冷疯了”、“翻车了，人没事，国产车挺棒的”……面对困难和受伤，吴京反倒调侃起自己“受伤很正常，就怕不连戏了”。\r\n</p>\r\n<p>\r\n	<strong> 《战狼2》历经4年磨砺</strong>\r\n</p>\r\n<p>\r\n	<strong> 吴京：受伤没事，就怕不连戏</strong>\r\n</p>\r\n<p>\r\n	“2013年4月16日，战狼2剧本一稿完成”，与<a href=\"http://ku.ent.sina.com.cn/movie/24126\" target=\"_blank\">《战狼》</a>七年磨一剑一样，早在四年前，吴京就开始了《战狼2》剧本的创作。正是观众对《战狼》的认可，使《战狼2》得以顺利开拍。从4月开始筹备，6月进入拍摄，到11月杀青，5个月的拍摄对于任何剧组都是很大的挑战。前一秒还穿着军大衣，后一秒就脱得只剩短袖冲进雨中，吴京也忍不住说“冷锋差点冷疯了”。\r\n</p>\r\n<p>\r\n	片场的“民工导演”也名不虚传，吴京总是最早到达的一拨人，和摄影指导商量当天的拍摄，基本站着就解决了早饭。超强度的拍摄也让吴京付出了身体上的巨大代价。工作人员透露，因为膝盖做过大手术，吴京每天开工前都要吃止疼片来缓解。拍摄期间，也不断传出吴京受伤的新闻。面对常态性地受伤，吴京反倒调侃起自己，“受点伤很正常，就怕不连戏了”。\r\n</p>\r\n<p>\r\n	<strong>对打美队反派“来真的”</strong>\r\n</p>\r\n<p>\r\n	<strong> 吴京“脑子进水”打出新格局</strong>\r\n</p>\r\n<p>\r\n	“和弗兰克对打，挺爽的”，照片中吴京一个侧踢正中弗兰克头部，看得出高手对决，两人都很过瘾。弗兰克曾凭<a href=\"http://ku.ent.sina.com.cn/movie/12755\" target=\"_blank\">《美国队长》</a>中的大反派“交叉骨”被全球观众熟知。《战狼2》中再次出演反派，弗兰克表示“没见过吴京这样不要命拍电影的。两个人经常放弃套招，感受真实的爆发。”吴京说“一个动作拍了十几遍还是不够，我叫他真的打我，就对了”。\r\n</p>\r\n<p>\r\n	“拍摄水下戏份，泡了十几个小时，脑子都要进水了”，水下打斗即使在好莱坞动作片中，也很少见。在水下拍戏的惊险也让吴京印象深刻，“在水下拍戏不能带氧气瓶，要轮换着来吸氧，差一秒送不到就会窒息，全凭一口气撑着。只有在水下的人才能体会到，什么是命悬一线”。动作指导Sam及摄影团队都是具有二十多年水下摄影经验的“老司机”，不过碰上吴京，他们也坦言这是“第一次拍这样的水下动作”，吴京的完成度更令他们表示“想都不敢想”，最终的也成果令他们充满期待。\r\n</p>\r\n<p>\r\n	<strong><br />\r\n</strong>\r\n</p>', '1', '0', '2016-11-03 07:13:54', '4', '2');
INSERT INTO `blog_article` VALUES ('7', '住在手机里的朋友', '住在手机里的朋友', '通信时代，无论是初次相见还是老友重逢，交换联系方式，常常是彼此交换名片，然后郑重或是出于礼貌用手机记下对方的电话号码。在快节奏的生活里，我们不知不觉中就成为住在别人手机里的朋友。又因某些意外，变成了别人手机里匆忙的过客，这种快餐式的友谊 ...', '3', '1', '2017-10-30 09:42:47', '5', '5');
INSERT INTO `blog_article` VALUES ('8', '你好，世界！', '你好，世界', '<span style=\"color:#E53333;\"><span style=\"font-size:18px;\">你好，世界！你好，世界！你好，世界</span><span style=\"font-size:18px;\"><span style=\"font-size:24px;\"></span></span></span>', '3', '0', '2017-10-30 11:02:20', '1', '5');

-- ----------------------------
-- Table structure for blog_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_article_tag`;
CREATE TABLE `blog_article_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_article_tag_article_id_818e752b_uniq` (`article_id`,`tag_id`),
  KEY `blog_article_tag_tag_id_f2afe66b_fk_blog_tag_id` (`tag_id`),
  CONSTRAINT `blog_article_tag_article_id_8db2395e_fk_blog_article_id` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`id`),
  CONSTRAINT `blog_article_tag_tag_id_f2afe66b_fk_blog_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_article_tag
-- ----------------------------
INSERT INTO `blog_article_tag` VALUES ('8', '4', '4');
INSERT INTO `blog_article_tag` VALUES ('9', '4', '6');
INSERT INTO `blog_article_tag` VALUES ('12', '6', '4');
INSERT INTO `blog_article_tag` VALUES ('13', '6', '5');
INSERT INTO `blog_article_tag` VALUES ('14', '7', '10');
INSERT INTO `blog_article_tag` VALUES ('15', '8', '10');

-- ----------------------------
-- Table structure for blog_category
-- ----------------------------
DROP TABLE IF EXISTS `blog_category`;
CREATE TABLE `blog_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `index` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_category
-- ----------------------------
INSERT INTO `blog_category` VALUES ('1', '我的生活', '999');
INSERT INTO `blog_category` VALUES ('2', '旅游心情', '999');
INSERT INTO `blog_category` VALUES ('3', '技术达人', '999');
INSERT INTO `blog_category` VALUES ('4', '电影推荐', '999');
INSERT INTO `blog_category` VALUES ('5', '生活交流', '9');

-- ----------------------------
-- Table structure for blog_comment
-- ----------------------------
DROP TABLE IF EXISTS `blog_comment`;
CREATE TABLE `blog_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `date_publish` datetime NOT NULL,
  `article_id` int(11) DEFAULT NULL,
  `pid_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_comment_article_id_3d58bca6_fk_blog_article_id` (`article_id`),
  KEY `blog_comment_pid_id_2a2b4cc4_fk_blog_comment_id` (`pid_id`),
  KEY `blog_comment_user_id_59a54155_fk_blog_user_id` (`user_id`),
  CONSTRAINT `blog_comment_article_id_3d58bca6_fk_blog_article_id` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`id`),
  CONSTRAINT `blog_comment_pid_id_2a2b4cc4_fk_blog_comment_id` FOREIGN KEY (`pid_id`) REFERENCES `blog_comment` (`id`),
  CONSTRAINT `blog_comment_user_id_59a54155_fk_blog_user_id` FOREIGN KEY (`user_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_comment
-- ----------------------------
INSERT INTO `blog_comment` VALUES ('10', 'dfs', '1', '1adsdsadasda@11.com', 'http://www.chalook.net/doc/201308/2644.shtml', '2016-11-04 05:22:13', '6', null, null);
INSERT INTO `blog_comment` VALUES ('11', 'fsdfsdsdffd', 'sfd', '1adsdsadasda@11.com', 'http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack', '2016-11-04 05:22:32', '6', null, null);
INSERT INTO `blog_comment` VALUES ('12', '企鹅亲吻额外区', 'zhangsan', 'sisuo321@163.com', 'http://www.myblog.com', '2016-11-04 05:31:16', '6', null, '2');
INSERT INTO `blog_comment` VALUES ('13', '13213123123', 'zhangsan', 'sisuo321@163.com', 'http://www.myblog.com', '2016-11-04 05:31:21', '6', null, '2');
INSERT INTO `blog_comment` VALUES ('14', '3213123123123', 'zhangsan', 'sisuo321@163.com', 'http://www.myblog.com', '2016-11-04 05:31:24', '6', null, '2');
INSERT INTO `blog_comment` VALUES ('15', '刘海楠 死胖子', 'zhangsan', 'sisuo321@163.com', 'http://www.myblog.com', '2016-11-04 05:32:04', '6', null, '2');
INSERT INTO `blog_comment` VALUES ('16', ';wjeq;lejqlwejq', 'len', 'len@163.com', '', '2016-11-04 05:32:14', '6', null, null);
INSERT INTO `blog_comment` VALUES ('17', '刘海男死胖子', 'zhangsan', 'sisuo321@163.com', 'http://www.myblog.com', '2016-11-04 05:32:33', '4', null, '2');
INSERT INTO `blog_comment` VALUES ('20', 'hello', 'hello or \'1\' == \'1\'', 'a@fd.com', '', '2016-11-04 05:35:00', '6', null, null);
INSERT INTO `blog_comment` VALUES ('21', 'alert(\'hello\')', 'a', 'a@fd.com', '', '2016-11-04 05:36:34', '6', null, null);
INSERT INTO `blog_comment` VALUES ('22', 'fengfeng    kaikaixinxin', 'fengfeng', 'feng@163.com', '', '2016-11-04 05:43:55', '6', null, '4');
INSERT INTO `blog_comment` VALUES ('23', '峰峰  开开心心', 'fengfeng', 'feng@163.com', '', '2016-11-04 05:44:13', '6', null, '4');
INSERT INTO `blog_comment` VALUES ('26', '你好，世界', 'yanrujing', '1342181530@qq.com', '', '2017-10-30 11:03:24', '8', null, '5');

-- ----------------------------
-- Table structure for blog_links
-- ----------------------------
DROP TABLE IF EXISTS `blog_links`;
CREATE TABLE `blog_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  `callback_url` varchar(200) NOT NULL,
  `date_publish` datetime NOT NULL,
  `index` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_links
-- ----------------------------
INSERT INTO `blog_links` VALUES ('1', '百度', '搜索引擎', 'http://www.baidu.com', '2016-11-03 05:29:21', '999');
INSERT INTO `blog_links` VALUES ('2', 'Ubuntu', 'Ubuntu官网', 'http://www.ubuntu.org.cn', '2016-11-03 05:57:10', '999');
INSERT INTO `blog_links` VALUES ('3', 'GIT', 'github官网', 'http://github.com', '2016-11-03 05:57:55', '999');
INSERT INTO `blog_links` VALUES ('4', 'Python', 'Python官网', 'http://www.python.org', '2016-11-03 05:58:27', '999');
INSERT INTO `blog_links` VALUES ('5', '菜鸟在线', '菜鸟在线官网', 'http://www.newbieol.com/', '2016-11-03 05:59:02', '999');
INSERT INTO `blog_links` VALUES ('6', 'Html5 社区门户', 'html5社区', 'http://www.html5cn.org/', '2016-11-03 06:00:20', '999');
INSERT INTO `blog_links` VALUES ('7', 'DjangoBook', 'Djangobook学习', 'http://docs.30c.org/djangobook2/', '2016-11-03 06:01:15', '999');

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
INSERT INTO `blog_tag` VALUES ('1', '工作');
INSERT INTO `blog_tag` VALUES ('2', '教学');
INSERT INTO `blog_tag` VALUES ('3', 'web开发');
INSERT INTO `blog_tag` VALUES ('4', '娱乐');
INSERT INTO `blog_tag` VALUES ('5', '电影');
INSERT INTO `blog_tag` VALUES ('6', '运动');
INSERT INTO `blog_tag` VALUES ('7', '技术开发');
INSERT INTO `blog_tag` VALUES ('8', 'python');
INSERT INTO `blog_tag` VALUES ('9', 'Html5+css');
INSERT INTO `blog_tag` VALUES ('10', '生活');

-- ----------------------------
-- Table structure for blog_user
-- ----------------------------
DROP TABLE IF EXISTS `blog_user`;
CREATE TABLE `blog_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_user
-- ----------------------------
INSERT INTO `blog_user` VALUES ('2', 'pbkdf2_sha256$24000$A7R9nNxYNIfS$XgP2JVrIVAW0A5yLLBpGXkIcRVr7ujSQ867zPfJveE0=', '2016-11-04 05:25:15', '0', 'zhangsan', '', '', 'sisuo321@163.com', '0', '1', '2016-11-03 05:47:24', 'avatar/default.png', null, null, 'http://www.myblog.com');
INSERT INTO `blog_user` VALUES ('3', 'pbkdf2_sha256$24000$9xEkCdqFxCYt$1dxYsBBJ7ul6yqRaYPbIHYrmY0/AoyFjgj1f+2HrXpc=', '2016-11-04 05:23:51', '0', 'lisi', '', '', 'lisi@163.com', '0', '1', '2016-11-04 05:22:18', 'avatar/default.png', null, null, '');
INSERT INTO `blog_user` VALUES ('4', 'pbkdf2_sha256$24000$OwwYsrFEhp0u$yEkB4UyOJq53nmERTzT9oN8ntsMKlpEbJ86MGthb654=', '2016-11-04 05:43:29', '0', 'fengfeng', '', '', 'feng@163.com', '0', '1', '2016-11-04 05:43:29', 'avatar/default.png', null, null, '');
INSERT INTO `blog_user` VALUES ('5', 'pbkdf2_sha256$30000$OKEKJbpni5oF$v3Ysbmr2KfkRfBowM7HCXw8eOlYmsU5+i/CDQNAWBAs=', '2017-10-30 09:30:24', '1', 'yanrujing', '', '', '1342181530@qq.com', '1', '1', '2017-10-30 09:29:50', 'avatar/default.png', null, null, null);

-- ----------------------------
-- Table structure for blog_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `blog_user_groups`;
CREATE TABLE `blog_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_user_groups_user_id_9046f296_uniq` (`user_id`,`group_id`),
  KEY `blog_user_groups_group_id_29990e74_fk_auth_group_id` (`group_id`),
  CONSTRAINT `blog_user_groups_group_id_29990e74_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `blog_user_groups_user_id_4e1acb48_fk_blog_user_id` FOREIGN KEY (`user_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for blog_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `blog_user_user_permissions`;
CREATE TABLE `blog_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_user_user_permissions_user_id_1d3c1311_uniq` (`user_id`,`permission_id`),
  KEY `blog_user_user_perm_permission_id_95ca6010_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `blog_user_user_perm_permission_id_95ca6010_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `blog_user_user_permissions_user_id_379a1502_fk_blog_user_id` FOREIGN KEY (`user_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_blog_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_blog_user_id` FOREIGN KEY (`user_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('41', '2017-10-30 09:30:59', '1', 'admin', '3', '', '8', '5');
INSERT INTO `django_admin_log` VALUES ('42', '2017-10-30 09:33:25', '3', '你好，世界！', '2', '[{\"changed\": {\"fields\": [\"title\", \"description\", \"image_url\"]}}]', '12', '5');
INSERT INTO `django_admin_log` VALUES ('43', '2017-10-30 09:40:28', '4', 'Html5', '3', '', '12', '5');
INSERT INTO `django_admin_log` VALUES ('44', '2017-10-30 09:40:45', '2', 'html课程', '3', '', '9', '5');
INSERT INTO `django_admin_log` VALUES ('45', '2017-10-30 09:42:12', '5', '生活交流', '1', '[{\"added\": {}}]', '7', '5');
INSERT INTO `django_admin_log` VALUES ('46', '2017-10-30 09:42:41', '10', '生活', '1', '[{\"added\": {}}]', '6', '5');
INSERT INTO `django_admin_log` VALUES ('47', '2017-10-30 09:42:47', '7', '住在手机里的朋友', '1', '[{\"added\": {}}]', '9', '5');
INSERT INTO `django_admin_log` VALUES ('48', '2017-10-30 11:02:20', '8', '你好，世界！', '1', '[{\"added\": {}}]', '9', '5');
INSERT INTO `django_admin_log` VALUES ('49', '2017-10-30 11:02:53', '3', '你好，世界！', '2', '[{\"changed\": {\"fields\": [\"callback_url\"]}}]', '12', '5');

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('12', 'blog', 'ad');
INSERT INTO `django_content_type` VALUES ('9', 'blog', 'article');
INSERT INTO `django_content_type` VALUES ('7', 'blog', 'category');
INSERT INTO `django_content_type` VALUES ('10', 'blog', 'comment');
INSERT INTO `django_content_type` VALUES ('11', 'blog', 'links');
INSERT INTO `django_content_type` VALUES ('6', 'blog', 'tag');
INSERT INTO `django_content_type` VALUES ('8', 'blog', 'user');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('10', 'blog', '0001_initial', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('11', 'admin', '0001_initial', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('12', 'admin', '0002_logentry_remove_auto_add', '2016-11-03 03:20:42');
INSERT INTO `django_migrations` VALUES ('13', 'sessions', '0001_initial', '2016-11-03 03:20:42');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('5uhqw6d3gnd9flsler4e1k9rxhsqtwoh', 'NjUzOTAyOGE4MGFjYjZmNTJkNmMwZDkxOGNmYjc4YWU0MGM0NDZkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU1NzIwODAxZTkxNjAyNTU1Mzk3NjA5ODNmOGMxMmI1OTY5MDNlNzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-11-17 05:48:24');
INSERT INTO `django_session` VALUES ('8tpv7cyubtw73uxa9dfn665y11u4o4tx', 'ZTJjOWE0YjUxYTEwOTU0M2EzY2ZjN2I1MzZhOTQ4ZTc0ZDQ3ZDhmYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjY1NDM0MWMzODRkODRiMmQwNGI5ZjkzZTYzZmFiMDhhNTQ2OTA1OTUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI0In0=', '2016-11-18 05:43:29');
INSERT INTO `django_session` VALUES ('mraso0ln3hdnbi5xwpnenp7t5nd5frdc', 'ZmQyNDZmOWEyNTQ1Zjk5ZjViMmY2M2QyMDk5Y2YwNzJjYTY1ZWQ5Njp7Il9hdXRoX3VzZXJfaGFzaCI6IjcxOTUwMTQ2NjVhMzkyOTYwNTIxYjQxYWNiNWIxNzc2ZjQ1YmUxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=', '2016-11-18 05:25:15');
INSERT INTO `django_session` VALUES ('otrz1hqt82p5vwtnv2bn4e0uhm5l2gbr', 'NGY2NTQyZTA1ODMxMzJhMDk4MmExYjVmNTk2NjY2N2U5MzA1OWYwYzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRhNzg0OGFiOTdjYWQ0OWVhNzE5OWMzNGYxMzNmMTIxYmY1YjEyMGIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI1In0=', '2017-11-13 09:30:24');
INSERT INTO `django_session` VALUES ('x3ronjan3sa3bvlovl62wn7oxnipp4ft', 'NjUzOTAyOGE4MGFjYjZmNTJkNmMwZDkxOGNmYjc4YWU0MGM0NDZkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU1NzIwODAxZTkxNjAyNTU1Mzk3NjA5ODNmOGMxMmI1OTY5MDNlNzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-11-18 05:24:50');
