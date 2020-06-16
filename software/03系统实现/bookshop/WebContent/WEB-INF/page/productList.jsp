<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
String path=request.getContextPath(); 
String basePath=request.getScheme()
    + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML>
<html>
    
    <head>
        <title>
            瑾晨书屋
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all"
        />
        <link href="css/slider.css" rel="stylesheet" type="text/css" media="all"
        />
        <link href="css/productShow.css" rel="stylesheet" type="text/css" media="all"
        />
        <script type="text/javascript" src="js/jquery-1.7.2.min.js">
        </script>
        <script type="text/javascript" src="js/move-top.js">
        </script>
        <script type="text/javascript" src="js/easing.js">
        </script>
        <script type="text/javascript" src="js/startstop-slider.js">
        </script>
        <script type="text/javascript" src="js/CommonUtils.js">
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
        <input type="hidden" id="menuColor" value="index" />
        <div class="wrap">
            <div class="header">
                <jsp:include page="topCommon.jsp"></jsp:include>
                <div class="header_slide">
                    <div class="header_bottom_left">
                        <jsp:include page="leftCategoryCommon.jsp"></jsp:include>
                    </div>
                    <div class="header_bottom_right">
                        <div class="slider">
                            <div id="slider">
                                <div class="main">
                                    <div class="content">
                                        <div class="content_top">
                                            <div class="heading">
                                                <h3>
                                                    搜索结果
                                                </h3>
                                            </div>
                                            <div class="see">
                                                <p>
                                                    <a href="<%=basePath%>/searchProduct?username=${username}">
                                                        所有书籍
                                                    </a>
                                                </p>
                                            </div>
                                            <div class="clear">
                                            </div>
                                        </div>
                                        <div class="bookShow">
                                            <ul>
                                                <c:choose>
                                                    <c:when test="${empty productList}">
                                                        <label>
                                                            没有符合条件的数据
                                                        </label>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${productList}" var="productDetail">
                                                            <li>
                                                                <a href="<%=basePath%>/productDetail?productId=${productDetail.productId}&username=${username}"
                                                                target="_blank">
                                                                    <img src='userimages/${productDetail.iconUrl}' />
                                                                </a>
                                                                <p class="name">
                                                                    <a href="<%=basePath%>/productDetail?productId=${productDetail.productId}&username=${username}"
                                                                    target="_blank" title="${productDetail.productName}">
                                                                        ${productDetail.productName}
                                                                    </a>
                                                                </p>
                                                                <p class="author">
                                                                    <span class="author_t">
                                                                    </span>
                                                                    作者: ${productDetail.author}
                                                                </p>
                                                                <p class="press_date">
                                                                    <span class="press_t">
                                                                        出版时间：
                                                                    </span>
                                                                    ${productDetail.publicationTime}
                                                                </p>
                                                                <p class="price">
                                                                    <span class="rob">
                                                                        <span>
                                                                            &yen;
                                                                        </span>
                                                                        <span>
                                                                            ${productDetail.price}
                                                                        </span>
                                                                    </span>
                                                                    <span class="price_r">
                                                                        <span>
                                                                            &yen;
                                                                        </span>
                                                                        <span>
                                                                            ${productDetail.marketPrice}
                                                                        </span>
                                                                    </span>
                                                                </p>
                                                            </li>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                             </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="bottomCommon.jsp"></jsp:include>
    </body>

</html>