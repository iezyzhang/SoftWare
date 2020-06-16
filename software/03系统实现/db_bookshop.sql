/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.7.18-log : Database - bookshop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bookshop` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bookshop`;

/*Table structure for table `t_file_info` */

DROP TABLE IF EXISTS `t_file_info`;

CREATE TABLE `t_file_info` (
  `objectId` varchar(50) DEFAULT NULL,
  `fileType` int(11) DEFAULT NULL,
  `fileUrl` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_file_info` */

insert  into `t_file_info`(`objectId`,`fileType`,`fileUrl`) values ('d981aec8-7ed3-4784-b8d9-a0a3c75f5f5b',2,'userimages/1440248342456java.jpg'),('c3247483-600f-4d30-902b-1ba99366da1d',2,'userimages/144024858071022862056-1_w_1.jpg'),('6699ca27-e36e-40a7-852c-15b78cad4782',2,'userimages/14402499473282-image.jpg'),('88384cc9-b8f8-414f-9fc1-28b9289110ca',2,'userimages/1440254082907big_00.jpg'),('ca6bdabe-938c-4f48-a602-795e223c9ad4',2,'http://img51.ddimg.cn/99999990000629691.jpg'),('ca6bdabe-938c-4f48-a602-795e223c9ad4',2,'userimages/152587529677924106647-1_b_6.jpg'),('59367575-c5cb-4191-aa8f-6532a5a477b3',2,'userimages/1526694980219WX20180509-234249.jpg'),('f8153219-de3e-43ac-ba99-594bc86b53ed',2,'ueditor/jsp/upload/image/20180511/1526024667829060914.jpg'),('f8153219-de3e-43ac-ba99-594bc86b53ed',2,'userimages/15266949988384a1fe3b8b4dbf32ff4ec9f73e5f232ce.jpg'),('a6267a19-6a00-4d5d-8e83-0532fda1be7f',2,'userimages/152671623013023633883-1_b_1.jpg');

/*Table structure for table `t_notice` */

DROP TABLE IF EXISTS `t_notice`;

CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT,
  `noticeContent` varchar(255) NOT NULL,
  `createTime` varchar(32) NOT NULL,
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `t_notice` */

insert  into `t_notice`(`noticeId`,`noticeContent`,`createTime`) values (7,'想看好书吗？来瑾晨书屋吧！\r\n		\r\n	','2018-05-09 22:25:49'),(8,'		请飞往北极度蜜月吧!当地夜长24小时	\r\n		\r\n	','2018-03-21 19:57:17'),(10,'看好书！！来瑾晨','2018-03-23 20:12:48'),(11,'有书就不会输——瑾晨书店和你一起赢\r\n		','2018-03-26 22:50:52'),(12,'夏日读书日，所有图书八折优惠		\r\n		','2018-05-09 22:26:33');

/*Table structure for table `t_product` */

DROP TABLE IF EXISTS `t_product`;

CREATE TABLE `t_product` (
  `productId` varchar(36) NOT NULL,
  `productName` varchar(500) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '0',
  `author` varchar(100) NOT NULL,
  `press` varchar(100) NOT NULL,
  `publicationTime` varchar(14) NOT NULL,
  `categoryId` varchar(36) NOT NULL DEFAULT '1',
  `description` varchar(3000) DEFAULT NULL,
  `stock` int(8) NOT NULL DEFAULT '0',
  `marketPrice` int(5) NOT NULL DEFAULT '0',
  `price` int(5) NOT NULL DEFAULT '0',
  `salesvolume` int(7) NOT NULL DEFAULT '0',
  `iconUrl` varchar(1000) DEFAULT NULL,
  `createTime` varchar(14) NOT NULL,
  `detailContent` longtext,
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_product` */

insert  into `t_product`(`productId`,`productName`,`status`,`author`,`press`,`publicationTime`,`categoryId`,`description`,`stock`,`marketPrice`,`price`,`salesvolume`,`iconUrl`,`createTime`,`detailContent`) values ('59367575-c5cb-4191-aa8f-6532a5a477b3','计算机视觉：模型、学习和推理',1,'西蒙 J.D. 普林斯（Simon J. D. Prince','机械工业出版社','2017年06月 ','5','计算机视觉的经典教材，全面讲述与现代计算机视觉研究和应用相关的机器学习基础知识和核心技术',97,119,94,2,'1526694980219WX20180509-234249.jpg','20180519095620','<p><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/></p><ul class=\"key clearfix list-paddingleft-2\" style=\"list-style-type: none;\"><li><p>版 次：1</p></li><li><p>页 数：</p></li><li><p>字 数：</p></li><li><p>印刷时间：2017年06月20日</p></li><li><p>开 本：16开</p></li><li><p>纸 张：胶版纸</p></li><li><p>包 装：平装-胶订</p></li><li><p>是否套装：否</p></li><li><p>国际标准书号ISBN：9787111516828</p></li><li><p>丛书名：计算机科学丛书</p></li><li><p><label style=\"position: absolute; top: 0px; left: 20px;\">所属分类：</label><span class=\"lie\" style=\"display: block; padding: 0px; font-family: sinsun; clear: both;\"><a target=\"_bland\" href=\"http://category.dangdang.com/cp01.00.00.00.00.00.html\" class=\"green\" data-category-id=\"1805\" style=\"text-decoration: none; color: rgb(26, 102, 179);\">图书</a>&gt;<a target=\"_bland\" href=\"http://category.dangdang.com/cp01.54.00.00.00.00.html\" class=\"green\" data-category-id=\"7207\" style=\"text-decoration: none; color: rgb(26, 102, 179);\">计算机/网络</a>&gt;<a target=\"_bland\" href=\"http://category.dangdang.com/cp01.54.12.00.00.00.html\" class=\"green\" data-category-id=\"7353\" style=\"text-decoration: none; color: rgb(26, 102, 179);\">人工智能</a></span></p></li></ul><p><a id=\"operation_point2\" style=\"white-space: normal; height: 0px; font-size: 0px; line-height: 0; overflow: hidden; color: rgb(100, 100, 100); position: absolute; right: -90px; top: -58px; font-family: &quot;Hiragino Sans GB&quot;, Verdana, Simsun;\" name=\"operation_point2\"></a></p><ul id=\"navigation-labels\" style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>快速直达</p></li><li><p><a><span class=\"icon\" style=\"position: absolute; left: 0px; top: 15px; display: block; width: 8px; height: 8px; overflow: hidden; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-position: 0px -500px; background-repeat: no-repeat no-repeat;\"></span>内容简介</a></p></li><li><p><a><span class=\"icon\" style=\"position: absolute; left: 0px; top: 15px; display: block; width: 8px; height: 8px; overflow: hidden; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-position: 0px -500px; background-repeat: no-repeat no-repeat;\"></span>作者简介</a></p></li><li><p><a><span class=\"icon\" style=\"position: absolute; left: 0px; top: 15px; display: block; width: 8px; height: 8px; overflow: hidden; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-position: 0px -500px; background-repeat: no-repeat no-repeat;\"></span>目　　录</a></p></li><li><p><a style=\"color: rgb(255, 40, 50);\"><span class=\"icon\" style=\"position: absolute; left: -12px; top: 15px; display: block; width: 7px; height: 7px; overflow: hidden; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-position: -15px -500px; background-repeat: no-repeat no-repeat;\"></span>前　　言</a></p></li></ul><p><a id=\"eBook-download\" dd_name=\"电子书推广\" style=\"color: rgb(100, 100, 100);\"><span style=\"display: block; font-stretch: normal; font-size: 14px; line-height: 18px; font-family: &quot;Microsoft Yahei&quot;; margin: 0px auto; text-align: center;\"><br/></span></a></p><p><span style=\"float: left; border-left-width: 2px; border-left-style: solid; border-left-color: rgb(255, 40, 50); padding: 0px 30px 2px 6px; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-color: rgb(229, 229, 229); height: 22px; margin-bottom: -2px; position: relative; font-stretch: normal; font-size: 14px; line-height: 22px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(50, 50, 50); background-position: right -525px; background-repeat: no-repeat no-repeat;\">内容简介</span></p><p><br/></p><p><span id=\"content-all\"></span>本书是一本从机器学习视角讲解计算机视觉的非常好的教材。全书图文并茂、语言浅显易懂，算法描述由浅入深，即使是数学背景不强的学生也能轻松理解和掌握。作者展示了如何使用训练数据来学习观察到的图像数据和我们希望预测的现实世界现象之间的联系，以及如何如何研究这些联系来从新的图像数据中作出新的推理。本书要求少的前导知识，从介绍概率和模型的基础知识开始，接着给出让学生能够实现和修改来构建有用的视觉系统的实际示例。适合作为计算机视觉和机器学习的高年级本科生或研究生的教材，书中详细的方法演示和示例对于计算机视觉领域的专业人员也非常有用。</p><p><span style=\"float: left; border-left-width: 2px; border-left-style: solid; border-left-color: rgb(255, 40, 50); padding: 0px 30px 2px 6px; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-color: rgb(229, 229, 229); height: 22px; margin-bottom: -2px; position: relative; font-stretch: normal; font-size: 14px; line-height: 22px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(50, 50, 50); background-position: right -525px; background-repeat: no-repeat no-repeat;\">作者简介</span></p><p><br/></p><p><span id=\"authorIntroduction-all\"></span>Simon J. D. Prince博士，伦敦大学学院计算机科学系高级讲师。他主讲的课程包括：计算机视觉、图像处理和高级数学方法。他有着计算机科学和生物学的专业背景，发表了多篇论文，涉及计算机视觉、生物测定学、心理学、生理学、医学影像、计算机图形学和人机交互。</p><p><span style=\"float: left; border-left-width: 2px; border-left-style: solid; border-left-color: rgb(255, 40, 50); padding: 0px 30px 2px 6px; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-color: rgb(229, 229, 229); height: 22px; margin-bottom: -2px; position: relative; font-stretch: normal; font-size: 14px; line-height: 22px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(50, 50, 50); background-position: right -525px; background-repeat: no-repeat no-repeat;\">目　　录</span></p><p><br/></p><p><span id=\"catalog-show\">目录<br/>Computer Vision:Models,Learning,and Inference<br/><br/>译者序<br/>译者简介<br/>序<br/>前言<br/>第1章绪论1<br/>11本书结构2<br/>12其他书籍4<br/>第一部分概率<br/>第2章概率概述6<br/>21随机变量6<br/>22联合概率7</span></p><p><a class=\"section_show_more\" id=\"catalog-btn\" dd_name=\"显示全部信息\" style=\"color: rgb(80, 80, 80); padding: 0px 15px; height: 22px; overflow: hidden; line-height: 22px; background-image: url(http://product.dangdang.com/images/product_sprites.png); border: 1px solid rgb(230, 230, 230); float: right; border-top-left-radius: 3px; border-top-right-radius: 3px; border-bottom-right-radius: 3px; border-bottom-left-radius: 3px; margin-left: 10px; font-size: 12px; background-position: 0px -95px; background-repeat: repeat no-repeat;\">显示全部信息</a></p><p><span style=\"float: left; border-left-width: 2px; border-left-style: solid; border-left-color: rgb(255, 40, 50); padding: 0px 30px 2px 6px; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-color: rgb(229, 229, 229); height: 22px; margin-bottom: -2px; position: relative; font-stretch: normal; font-size: 14px; line-height: 22px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(50, 50, 50); background-position: right -525px; background-repeat: no-repeat no-repeat;\">前　　言</span></p><p><br/></p><p><span id=\"preface-show\">前言Computer Vision:Models,Learning,and Inference目前，已有很多关于计算机视觉的书籍，那么还有必要再写另外一本吗？下面解释撰写本书的原因。<br/>计算机视觉是一门工程学科，机器在现实世界中捕获的视觉信息可以激发我们的积极性。因此，我们通过使用计算机视觉解决现实问题来对我们的知识进行分类。例如，大多数视觉教科书都包含目标识别和立体视觉内容。我们的学术研讨会也是用同样的模式进行组织的。本书对这一传统方式提出了质疑：这真的是我们组织自己知识的正确方法吗？对于目标识别问题，目前已提出多种算法解决这一问题（例如子空间模型、boosting模型、语义包模型、星座模型等）然而，这些方法没有什么共同点。任何试图全面描述知识的壮举都会转变为一个非结构化的技术列表。我们怎样让新同学把所有的技术和理论都弄懂呢?我主张使用一种不同的方式来组织知识，但首先让我告诉大家我是如何看待计算机视觉问题的。<br/>对于一幅图像，我们不仅要观察图像中的内容，同时还需要提取其测量值。例如，我们可以直接使用RGB值，或者对图像进行滤波处理，或者执行一些更复杂的预处理。计算机视觉的目标或者需要解决的问题是使用这些测量值来推理全局状态。例如：在立体视觉中，我们尝试推断出场景的深度。在目标识别中，我们尝试推断某一特定类目标存在与否。</span></p><p><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/></p><p><br/></p><p><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/></p><p><br/></p><p><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/></p><p><br/></p>'),('5a8582aa-bd2e-4ec9-b9e2-3693fad5b182','Java7',1,'孙鑫','清华大学出版社','20151001','7','一本书让你成为Java高手（最新）',186,98,88,14,'1440249674825pic1.jpg','20180319210128','<p>一本书让你成为Java高手</p><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/>'),('6699ca27-e36e-40a7-852c-15b78cad4782','Java面试宝典',1,'谭浩强','清华大学出版社','20151001','10','让你轻松走向人生巅峰',154,98,80,6,'14402499473282-image.jpg','20150822212547','<p>让你轻松走向人生巅峰</p>'),('88384cc9-b8f8-414f-9fc1-28b9289110ca','浮沉',1,'王刚','上海文艺出版社','20151002','9','谁主浮沉？',100,65,50,0,'1440254082907big_00.jpg','20150822223442','<p>不错不错的一本书。<br/></p>'),('a6267a19-6a00-4d5d-8e83-0532fda1be7f','阿里巴巴',1,'ab','dd','19950109','3','瑾考虑到解放路开始的加夫里什房间里睡觉啦',22,66,45,0,'152671623013023633883-1_b_1.jpg','20180519155030','<embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/>fsdfsd'),('c3247483-600f-4d30-902b-1ba99366da1d','Java核心技术',1,'Bruce','清华大学出版社','20151001','7','Java核心技术讲解',187,98,98,13,'1440248342456java.jpg','20150822210131','<p>高级查询设计<br/></p><p><br/></p>'),('ca6bdabe-938c-4f48-a602-795e223c9ad4','深入理解计算机系统',1,'（美）兰德尔?E.布莱恩特（Randal E.Bryant）','机器工业出版社','20161114','2','.第二版销售突破100000册，第三版重磅上市！ 2.理解计算机系统*书目， 10余万程序员的共同选择 3.卡内基-梅隆、北京大学、清华大学、上海交通大学等国内外众多知名高校选用指定教材 4.从程序员视角全面剖析的实现细节',19,139,111,1,'152587529677924106647-1_b_6.jpg','20180509221456','<p>1.第二版销售突破100000册，第三版重磅上市！<br/>2.理解计算机系统*书目， 10余万程序员的共同选择<br/>3.卡内基-梅隆、北京大学、清华大学、上海交通大学等国内外众多知名高校选用指定教材<br/>4.从程序员视角全面剖析的实现细节，使读者深刻理解程序的行为，将所有计算机系统的相关知识融会贯通。<br/>5.新版本全面基于X86-64位处理器<br/>6.全新的阅读和学习体验：由国内名师录制章前导读，使读者可以了解各章的重点内容和知识关联，形成关于计算机系统的知识架构。并开设了本书的网络社区，读者可加入社区，获得本书相关学习资源，了解活动信息。</p><p><img src=\"http://img51.ddimg.cn/99999990000629691.jpg\" style=\"width: 800px; height: 4085.66px; display: block;\"/></p><p>&nbsp;</p><p>内容简介</p><p><span id=\"content-all\"></span></p><p>和第2版相比，本版内容上*的变化是，从以IA32和x86-64为基础转变为完全以x86-64为基础。主要更新如下：<br/>• 基于x86-64，大量地重写代码，首次介绍对处理浮点数据的程序的机器级支持。<br/>• 处理器体系结构修改为支持64位字和操作的设计。<br/>• 引入更多的功能单元和更复杂的控制逻辑，使基于程序数据流表示的程序性能模型预测更加可靠。<br/>• 扩充关于用GOT和PLT创建与位置无关代码的讨论，描述了更加强大的链接技术（比如库打桩）。<br/>• 增加了对信号处理程序更细致的描述，包括异步信号安全的函数等。<br/>• 采用*函数，更新了与协议无关和线程安全的网络编程。</p><p>作者简介</p><p><span id=\"authorIntroduction-show\">Randal E. Bryant &nbsp; 1981年于麻省理工学院获得计算机博士学位，1984年至今一直任教于卡内基-梅隆大学。现任卡内基-梅隆大学计算机科学学院院长、教授，同时还受邀任教于电子和计算机工程系。他从事本科生和研究生计算机系统方面课程的教学近40年。他和O’Hallaron教授一起在卡内基梅隆大学开设了15-213课程“计算机系统导论”，那便是本书的基础。他还是ACM院士、IEEE院士、美国国家工程院院士和美国人文与科学研究院院士。其研究成果被Intel、IBM、Fujitsu和Microsoft等主要计算机制造商使用，他还因研究获得过Semiconductor Research Corporation、ACM、IEEE颁发的多项大奖。<br/><br/>David R. O’Hallaron卡内基梅隆大学电子和计算机工程系教授。在弗吉尼亚大学（University of Virginia）获得计算机科学的博士学位，2007年-2010年为Intel匹兹堡实验室主任。他教授本科生和研究生的计算机系统方面的课程已有20余年，并和Bryant教授一起开设了“计算机系统导论”课程。曾获得CMU计算机学院颁发的Herbert Simon杰出教学奖。他主要从事计算机系统领域的研究，与Quake项目成员一起获得过高性能计算领域中的最高国际奖项——Gordon Bell奖。他目前的工作重点是研究自动分级（autograding）概念，即评价其他程序质量的程序。</span></p><p><br/></p><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/>'),('d981aec8-7ed3-4784-b8d9-a0a3c75f5f5b','Java Web程序设计',1,'孙卫琴','清华大学出版社','20151001','7','Java Web程序设计',91,68,68,8,'144024858071022862056-1_w_1.jpg','20150822210300','<p>Java Web程序设计</p>'),('f8153219-de3e-43ac-ba99-594bc86b53ed','精通Python网络爬虫：核心技术、框架与项目实战',1,'韦玮','机械工业出版社','2017年03月 ','3','资深专家，以实战为导向，讲透Python网络爬虫各项核心技术和主流框架，深度讲解网络爬虫的抓取技术与反爬攻关技巧',56,69,55,0,'15266949988384a1fe3b8b4dbf32ff4ec9f73e5f232ce.jpg','20180519095638','<p><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/></p><p><span style=\"float: left; border-left-width: 2px; border-left-style: solid; border-left-color: rgb(255, 40, 50); padding: 0px 30px 2px 6px; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-color: rgb(229, 229, 229); height: 22px; margin-bottom: -2px; position: relative; font-stretch: normal; font-size: 14px; line-height: 22px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(50, 50, 50); background-position: right -525px; background-repeat: no-repeat no-repeat;\">编辑推荐</span></p><p><span id=\"abstract-all\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">从技术、工具、实战3个维度讲透Python网络爬虫各项核心技术和主流框架，深度讲解网络爬虫的抓取技术与反爬攻关技巧</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\"><img src=\"ueditor/jsp/upload/image/20180511/1526024667829060914.jpg\" title=\"1526024667829060914.jpg\" alt=\"99999990001072431.jpg\"/></p><p>&nbsp;</p><p><span style=\"float: left; border-left-width: 2px; border-left-style: solid; border-left-color: rgb(255, 40, 50); padding: 0px 30px 2px 6px; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-color: rgb(229, 229, 229); height: 22px; margin-bottom: -2px; position: relative; font-stretch: normal; font-size: 14px; line-height: 22px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(50, 50, 50); background-position: right -525px; background-repeat: no-repeat no-repeat;\">内容简介</span></p><p><span id=\"content-all\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">本书从技术、工具与实战3个维度讲解了Python网络爬虫：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">技术维度：详细讲解了Python网络爬虫实现的核心技术，包括网络爬虫的工作原理、如何用urllib库编写网络爬虫、爬虫的异常处理、正则表达式、爬虫中Cookie的使用、爬虫的浏览器伪装技术、定向爬取技术、反爬虫技术，以及如何自己动手编写网络爬虫；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">工具维度：以流行的Python网络爬虫框架Scrapy为对象，详细讲解了Scrapy的功能使用、高级技巧、架构设计、实现原理，以及如何通过Scrapy来更便捷、高效地编写网络爬虫；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">实战维度：以实战为导向，是本书的主旨，除了完全通过手动编程实现网络爬虫和通过Scrapy框架实现网络爬虫的实战案例以外，本书还有博客爬取、图片爬取、模拟登录等多个综合性的网络爬虫实践案例。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">作者在Python领域有非常深厚的积累，不仅精通Python网络爬虫，在Python机器学习、Python数据分析与挖掘、Python Web开发等多个领域都有丰富的实战经验</p><p><span style=\"float: left; border-left-width: 2px; border-left-style: solid; border-left-color: rgb(255, 40, 50); padding: 0px 30px 2px 6px; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-color: rgb(229, 229, 229); height: 22px; margin-bottom: -2px; position: relative; font-stretch: normal; font-size: 14px; line-height: 22px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(50, 50, 50); background-position: right -525px; background-repeat: no-repeat no-repeat;\">作者简介</span></p><p><span id=\"authorIntroduction-all\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\"><strong>韦玮</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">资深网络爬虫技术专家、大数据专家和软件开发工程师，从事大型软件开发与技术服务多年，现任重庆韬翔网络科技有限公司创始人兼CEO，国家专利发明人。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">精通Python技术，在Python网络爬虫、Python机器学习、Python数据分析与挖掘、Python Web开发等多个领域都有丰富的实战经验。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; list-style-type: none; border: 0px;\">CSDN、51CTO、天善智能等科技类社区和媒体的特邀专家和讲师，输出了大量的高质量课程和文章，深受用户喜爱。</p><p>微博：http://weibo.com/qiansyy<br/><br/></p><p><span style=\"float: left; border-left-width: 2px; border-left-style: solid; border-left-color: rgb(255, 40, 50); padding: 0px 30px 2px 6px; background-image: url(http://product.dangdang.com/images/product_sprites.png); background-color: rgb(229, 229, 229); height: 22px; margin-bottom: -2px; position: relative; font-stretch: normal; font-size: 14px; line-height: 22px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(50, 50, 50); background-position: right -525px; background-repeat: no-repeat no-repeat;\">媒体评论</span></p><p><span id=\"mediaFeedback-show\" style=\"font-family: &quot;Hiragino Sans GB&quot;, Verdana, Simsun;\">网络爬虫是互联网上进行信息采集的通用手段，在互联网的各个专业方向上都是不可或缺的底层技术支撑。本书从爬虫基础开始，全面阐述了Python网络爬虫技术，并且包含各种经典的网络爬虫项目案例，特别是详细给出了基于Scapy框架实现网络爬虫的*实践方案与流程，实战性非常强，是一本关于Python网络爬虫的优秀实战书籍，值得推荐。&nbsp;<br/>——诸葛建伟 清华大学副研究员/《Metasploit渗透测试魔鬼训练营》作者<br/><br/>本书详细讲解了如何基于Python从零开始构建一个成熟的网络爬虫解决方案的完整过程，以及业界主流爬虫技术的原理与实战案例，同时也引入了作者个人的经验与思考，非常有价值。本书循序渐进的内容组织结构，相信无论是新手还是老手，均能很好地阅读和吸收。<br/>——刘天斯 腾讯高级工程师，《Python自动化运维》作者<br/></span><span style=\"font-family: &quot;Hiragino Sans GB&quot;, Verdana, Simsun; background-color: rgb(255, 255, 255);\"></span></p><p><span style=\"font-family: &quot;Hiragino Sans GB&quot;, Verdana, Simsun;\"><br/></span></p><p><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/><embed id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\" type=\"application/thunder_download_plugin\" height=\"0\" width=\"0\"/></p><p><br/></p><p><br/></p>');

/*Table structure for table `t_product_categroy` */

DROP TABLE IF EXISTS `t_product_categroy`;

CREATE TABLE `t_product_categroy` (
  `categroyId` int(11) NOT NULL AUTO_INCREMENT,
  `categroyItem` varchar(32) NOT NULL,
  PRIMARY KEY (`categroyId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `t_product_categroy` */

insert  into `t_product_categroy`(`categroyId`,`categroyItem`) values (1,'游戏'),(2,'操作系统'),(3,'数据库'),(4,'图形图像'),(5,'多媒体'),(6,'网络工程与通信'),(7,'软件工程设计'),(8,'硬件维护'),(9,'教材'),(10,'考试认证'),(11,'电子电气'),(12,'工具书软件'),(16,'外国文学');

/*Table structure for table `t_product_comment` */

DROP TABLE IF EXISTS `t_product_comment`;

CREATE TABLE `t_product_comment` (
  `commentId` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `productId` varchar(36) NOT NULL,
  `userId` varchar(36) NOT NULL,
  `author` varchar(100) NOT NULL DEFAULT 'MS',
  `comment` varchar(3000) DEFAULT NULL,
  `commentTime` varchar(14) NOT NULL,
  `subscriptionId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `t_product_comment` */

insert  into `t_product_comment`(`commentId`,`productId`,`userId`,`author`,`comment`,`commentTime`,`subscriptionId`) values (0000000001,'5a8582aa-bd2e-4ec9-b9e2-3693fad5b182','a1736b8b-b917-4653-ad87-be06c8719004','MS','这本书真的很不错\r\n','20180319235030','2b0dd659-8836-4194-b694-3b9b50642e06'),(0000000002,'d981aec8-7ed3-4784-b8d9-a0a3c75f5f5b','c72237ef-ad23-4dc4-9fce-f03fa64dd5e8','MS','赞，，不错','20150822223239','4d4a6c03-da7e-4493-b50b-aaf2300c4059'),(0000000003,'d981aec8-7ed3-4784-b8d9-a0a3c75f5f5b','d2790b7b-c0ba-4478-91a2-3709b5b674cf','MS','不错不错的一本书','20150822220649','1a371df9-0163-49b2-8169-3280c9202c10'),(0000000004,'5a8582aa-bd2e-4ec9-b9e2-3693fad5b182','db9757b6-8961-4e96-842f-986affcf73d2','MS','对学习java是一本很好的书','20180327184117','403df2f8-edcc-46eb-8d25-d8d255ea56b6'),(0000000007,'04e253fd-2e1d-4f7d-8ee3-28520f0d7a23','db9757b6-8961-4e96-842f-986affcf73d2','MS','齐心协力，共创佳绩','20180509014510','fe37c006-85b3-4234-b85d-1a215487e2a1');

/*Table structure for table `t_subscription` */

DROP TABLE IF EXISTS `t_subscription`;

CREATE TABLE `t_subscription` (
  `subscriptionId` varchar(50) NOT NULL,
  `userId` varchar(50) DEFAULT NULL,
  `productId` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `subscriptionTime` datetime DEFAULT NULL,
  `unsubscribeTime` datetime DEFAULT NULL,
  `message` varchar(100) DEFAULT NULL,
  `totalCount` int(11) DEFAULT NULL,
  `totalPrice` float DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`subscriptionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_subscription` */

insert  into `t_subscription`(`subscriptionId`,`userId`,`productId`,`status`,`subscriptionTime`,`unsubscribeTime`,`message`,`totalCount`,`totalPrice`,`address`) values ('1710f65a-7a0c-4894-a329-5c81f02f9bdd','34a4a39f-2d16-43bf-be9f-34641610ba1d','ca6bdabe-938c-4f48-a602-795e223c9ad4',3,'2018-06-13 21:29:22',NULL,'ds',1,111,'safsad'),('253d707f-79fc-4f11-8496-ac080f76b899','db9757b6-8961-4e96-842f-986affcf73d2','6699ca27-e36e-40a7-852c-15b78cad4782',2,'2018-05-19 15:45:55',NULL,' ',1,64,'æ·±å³å¸é¾å²åºä¸­å¿åxxè±å­xxæ xxæ¿'),('2e3c99e7-459f-4471-826a-4f4053d04556','db9757b6-8961-4e96-842f-986affcf73d2','5a8582aa-bd2e-4ec9-b9e2-3693fad5b182',2,'2018-05-19 12:29:26',NULL,'123456',1,70.4,'æ·±å³å¸é¾å²åºä¸­å¿åxxè±å­xxæ xxæ¿'),('310d6668-68b7-4422-9b8b-04b2d06f8fa2','34a4a39f-2d16-43bf-be9f-34641610ba1d','5a8582aa-bd2e-4ec9-b9e2-3693fad5b182',2,'2018-06-13 21:29:22',NULL,' ',1,88,'safsad'),('643b0950-3000-4579-946b-e17af4386939','db9757b6-8961-4e96-842f-986affcf73d2','d981aec8-7ed3-4784-b8d9-a0a3c75f5f5b',5,'2018-05-19 09:47:59',NULL,' ',1,54.4,'æ·±å³å¸é¾å²åºä¸­å¿åxxè±å­xxæ xxæ¿'),('b90bdd77-3a52-4092-b551-ed3e8e6787bb','74f5b397-1b87-4d74-809e-2165458d6ae9','5a8582aa-bd2e-4ec9-b9e2-3693fad5b182',2,'2018-06-12 22:01:44',NULL,' ',1,70.4,'广州天河区'),('d15f35cd-ea5b-4ce3-a056-afe59e0b6c5e','34a4a39f-2d16-43bf-be9f-34641610ba1d','6699ca27-e36e-40a7-852c-15b78cad4782',3,'2018-06-13 21:29:22',NULL,'d',3,240,'safsad');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `userId` varchar(36) NOT NULL,
  `userName` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `userType` int(1) NOT NULL DEFAULT '1',
  `sex` varchar(4) NOT NULL,
  `birthday` varchar(8) DEFAULT NULL,
  `email` varchar(32) NOT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `userStatus` int(1) NOT NULL DEFAULT '0',
  `isAdmin` int(1) NOT NULL DEFAULT '0',
  `isVip` int(1) NOT NULL DEFAULT '0',
  `createTime` varchar(14) NOT NULL,
  `lastLoginTime` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`userId`,`userName`,`password`,`userType`,`sex`,`birthday`,`email`,`phoneNumber`,`userStatus`,`isAdmin`,`isVip`,`createTime`,`lastLoginTime`) values ('34a4a39f-2d16-43bf-be9f-34641610ba1d','java1234','123456',1,'男','19891112','213213121@qq.com','13815468541',0,0,1,'20180613212557','20180613214637'),('401fcc32-553d-4323-ad6f-5dca2fc79065','json_123','123456',1,'男','19990402','123@qq.com','15676862656',0,0,0,'20180612215959','20180612215959'),('74f5b397-1b87-4d74-809e-2165458d6ae9','admin_d','123456',1,'男','19950110','790130908@qq.com','13437756883',0,0,1,'20180322205822','20180612220011'),('a1736b8b-b917-4653-ad87-be06c8719004','c123456','000123',1,'男','19880110','1234567@qq.com','13691750882',0,0,1,'20170622143926','20180321220626'),('c72237ef-ad23-4dc4-9fce-f03fa64dd5e8','hellokitty','123456',1,'女','19981112','hellokt@qq.com','13789890001',0,0,0,'20150822223106','20150822223114'),('d2790b7b-c0ba-4478-91a2-3709b5b674cf','gaoyuanyuan','123456',1,'女','19801010','gaoyy@qq.com','13888811111',0,0,0,'20150822213045','20150822221941'),('db9757b6-8961-4e96-842f-986affcf73d2','cmd00123','1234567',1,'男','19950110','790130908@qq.com','13437878569',0,0,1,'20170614143836','20180519154454');

/*Table structure for table `t_user_delivery_address` */

DROP TABLE IF EXISTS `t_user_delivery_address`;

CREATE TABLE `t_user_delivery_address` (
  `userId` varchar(36) NOT NULL,
  `addressId` varchar(36) NOT NULL,
  `address` varchar(2000) NOT NULL,
  `defaultAddress` int(11) DEFAULT NULL,
  PRIMARY KEY (`userId`,`addressId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_user_delivery_address` */

insert  into `t_user_delivery_address`(`userId`,`addressId`,`address`,`defaultAddress`) values ('34a4a39f-2d16-43bf-be9f-34641610ba1d','f4b4a2a5-583e-4335-affe-2d1c80adb490','safsad',1),('74f5b397-1b87-4d74-809e-2165458d6ae9','1e47b27b-bb49-46a8-894c-7e48b3fd584b','广州天河区',1),('a1736b8b-b917-4653-ad87-be06c8719004','22dd122f-8fc2-4446-abc8-b68493f61083','shenzhenshiguangdongsheng',1),('c72237ef-ad23-4dc4-9fce-f03fa64dd5e8','8c5dcc75-304d-47fa-90e7-924b20396508','北京市西城区陕西路2号',1),('d2790b7b-c0ba-4478-91a2-3709b5b674cf','494b421a-c366-4fce-8de9-9814a32862e5','上海市浦东区宁夏路1号',1),('db9757b6-8961-4e96-842f-986affcf73d2','6de61421-ab77-47f1-b5fe-f5bafc5a2aef','深圳市龙岗区中心城xx花园xx栋xx房',1);

/*Table structure for table `t_user_funds` */

DROP TABLE IF EXISTS `t_user_funds`;

CREATE TABLE `t_user_funds` (
  `userId` varchar(36) NOT NULL,
  `consumeMoney` double(8,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_user_funds` */

insert  into `t_user_funds`(`userId`,`consumeMoney`) values ('34a4a39f-2d16-43bf-be9f-34641610ba1d',439),('74f5b397-1b87-4d74-809e-2165458d6ae9',70),('a1736b8b-b917-4653-ad87-be06c8719004',1138),('c72237ef-ad23-4dc4-9fce-f03fa64dd5e8',166),('d2790b7b-c0ba-4478-91a2-3709b5b674cf',410),('db9757b6-8961-4e96-842f-986affcf73d2',3395);

/*Table structure for table `t_user_manager` */

DROP TABLE IF EXISTS `t_user_manager`;

CREATE TABLE `t_user_manager` (
  `managerId` int(11) NOT NULL AUTO_INCREMENT,
  `managerName` varchar(32) NOT NULL COMMENT '管理员登录名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `lastLoginTime` varchar(32) DEFAULT NULL COMMENT '上次登陆日期',
  `createTime` varchar(32) NOT NULL COMMENT '创建日期',
  `role` varchar(1) NOT NULL COMMENT '角色',
  PRIMARY KEY (`managerId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `t_user_manager` */

insert  into `t_user_manager`(`managerId`,`managerName`,`password`,`lastLoginTime`,`createTime`,`role`) values (1,'admin_root','admin_root','2018-06-13 21:35:16','1995-1-1','0'),(3,'admin_user','admin_user','2018-03-25 23:32:36','2018-03-24 17:06:55','1'),(4,'product','product',NULL,'2018-03-24 17:08:43','2'),(5,'usermanager','usermanager','2018-03-24 17:33:53','2018-03-24 17:09:14','1'),(6,'admin_sub','admin_sub','2018-05-17 22:41:44','2018-03-27 20:10:33','5'),(7,'admin_m','admin_m','2018-03-24','2018-03-24','3'),(8,'aaa123456','aaa123456','2018-03-24','2018-05-09 22:27:12','1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
