<%@ page language="java" pageEncoding="UTF-8" %>
<% String path=request.getContextPath(); String basePath=request.getScheme()
+ "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <title>
            新闻
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all"
        />
        <script type="text/javascript" src="js/jquery-1.7.2.min.js">
        </script>
        <script type="text/javascript" src="js/move-top.js">
        </script>
        <script type="text/javascript" src="js/easing.js">
        </script>
		<script type="text/javascript" src="js/CommonUtils.js"></script>
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

            $(function() 
            {
				initLogin("${username}");

                var dd = new DropDown($('#dd'));

                $(document).click(function() {
                    // all dropdowns
                    $('.wrapper-dropdown-2').removeClass('active');
                });

            });
        </script>
    </head>
    
    <body>
     <input type="hidden" id="menuColor" value="news"/>
        <div class="wrap">
            <div class="header">
               
            <jsp:include page="topCommon.jsp"></jsp:include>
            </div>    
            <div class="main">
                <div class="content">
                    <div class="image group">
                        <div class="grid images_3_of_1">
                            <img src="images/newsimg1.jpg" alt="" />
                        </div>
                        <div class="grid news_desc">
                            <h3>
                                新闻1
                            </h3>
                            <h4>
                                <span>
                                    <a href="#">
                                         头条
                                    </a>
                                </span>
                            </h4>
                            <p>
没有什么大事
                            </p>
                            <p>
新闻1
                                <a href="#" title="more">
                                    [....]
                                </a>
                            </p>
                        </div>
                    </div>
                    <div class="image group">
                        <div class="grid images_3_of_1">
                            <img src="images/newsimg2.jpg" alt="" />
                        </div>
                       <div class="grid news_desc">
                            <h3>
                                新闻1
                            </h3>
                            <h4>
                                <span>
                                    <a href="#">
                                         头条
                                    </a>
                                </span>
                            </h4>
                            <p>
没有什么大事
                            </p>
                            <p>
新闻1
                                <a href="#" title="more">
                                    [....]
                                </a>
                            </p>
                        </div>
                    </div>
                    <div class="image group">
                        <div class="grid images_3_of_1">
                            <img src="images/newsimg3.jpg" alt="" />
                        </div>
                        <div class="grid news_desc">
                            <h3>
                                新闻1
                            </h3>
                            <h4>
                                <span>
                                    <a href="#">
                                         头条
                                    </a>
                                </span>
                            </h4>
                            <p>
没有什么大事
                            </p>
                            <p>
新闻1
                                <a href="#" title="more">
                                    [....]
                                </a>
                            </p>
                        </div>
                    </div>
                    <div class="content-pagenation">
                        <li>
                            <a href="#">
                                Frist
                            </a>
                        </li>
                        <li class="active">
                            <a href="#">
                                1
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                2
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                3
                            </a>
                        </li>
                        <li>
                            <span>
                                ....
                            </span>
                        </li>
                        <li>
                            <a href="#">
                                Last
                            </a>
                        </li>
                        <div class="clear">
                        </div>
                    </div>
                </div>
            </div>
        </div>
 <jsp:include page="bottomCommon.jsp"></jsp:include>
    </body>

</html>