<%@ page language="java" pageEncoding="UTF-8" %>
<% 
String path=request.getContextPath(); String basePath=request.getScheme()
    + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <title>
            瑾晨书店
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all"
        />
        <link href="css/slider.css" rel="stylesheet" type="text/css" media="all"
        />
        <script type="text/javascript" src="js/jquery-1.7.2.min.js">
        </script>
        <script type="text/javascript" src="js/move-top.js">
        </script>
        <script type="text/javascript" src="js/easing.js">
        </script>
        <script type="text/javascript" src="js/startstop-slider.js">
        </script>
        <script type="text/javascript">
            function DropDown(el) {
                this.dd = el;
                this.initEvents();
            }
            DropDown.prototype = {
                initEvents: function() {
                    var obj = this;

                    obj.dd.on('click',
                    function(event) {
                        $(this).toggleClass('active');
                        event.stopPropagation();
                    });
                }
            }

            $(function() {

                var dd = new DropDown($('#dd'));

                $(document).click(function() {
                    // all dropdowns
                    $('.wrapper-dropdown-2').removeClass('active');
                });

            });
            
            function loginSuccess(){
            	alert("登陆成功！");
            }
        </script>
    </head>
    
    <body>
        <div class="wrap">
            <div class="header">

				<jsp:include page="topCommon.jsp"></jsp:include>
	
	购物车
		</div>
	
        <div class="footer">
            <div class="wrap">
                <div class="section group">
                    <div class="col_1_of_4 span_1_of_4">
                        <h4>
                            资讯
                        </h4>
                        <ul>
                            <li>
                                <a href="about.html">
                                    About Us
                                </a>
                            </li>
                            <li>
                                <a href="contact.html">
                                    Customer Service
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Advanced Search
                                </a>
                            </li>
                            <li>
                                <a href="delivery.html">
                                    Orders and Returns
                                </a>
                            </li>
                            <li>
                                <a href="contact.html">
                                    Contact Us
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="col_1_of_4 span_1_of_4">
                        <h4>
                            为什么选择我们
                        </h4>
                        <ul>
                            <li>
                                <a href="about.html">
                                    About Us
                                </a>
                            </li>
                            <li>
                                <a href="contact.html">
                                    Customer Service
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Privacy Policy
                                </a>
                            </li>
                            <li>
                                <a href="contact.html">
                                    Site Map
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Search Terms
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="col_1_of_4 span_1_of_4">
                        <h4>
                            我的账户
                        </h4>
                        <ul>
                            <li>
                                <a href="contact.html">
                                    Sign In
                                </a>
                            </li>
                            <li>
                                <a href="index.html">
                                    View Cart
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    My Wishlist
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Track My Order
                                </a>
                            </li>
                            <li>
                                <a href="contact.html">
                                    Help
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="col_1_of_4 span_1_of_4">
                        <h4>
                            联系我们
                        </h4>
                        <ul>
                            <li>
                                <span>
                                    +8615851816458
                                </span>
                            </li>
                            <li>
                                <span>
                                    QQ:84562655
                                </span>
                            </li>
                        </ul>
                        <div class="social-icons">
                            <h4>
                                合作
                            </h4>
                            <ul>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/facebook.png" alt="" />
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/twitter.png" alt="" />
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/skype.png" alt="" />
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/dribbble.png" alt="" />
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/linkedin.png" alt="" />
                                    </a>
                                </li>
                                <div class="clear">
                                </div>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="copy_right">
                <p>
                    Copyright &copy; 2014.瑾晨书屋 All rights reserved.
                    <a target="_blank" href="http://www.777moban.com/">
                    </a>
                </p>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {
                $().UItoTop({
                    easingType: 'easeOutQuart'
                });

            });
        </script>
                <a href="#" id="toTop">
                    <span id="toTopHover">
                    </span>
                </a>
	</body>
</html>