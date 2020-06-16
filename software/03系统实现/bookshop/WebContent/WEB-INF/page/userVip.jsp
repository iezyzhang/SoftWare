<%@ page language="java" pageEncoding="UTF-8" %>
<% 
String path=request.getContextPath(); 
String basePath=request.getScheme()
    + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML>
<html>
    
    <head>
        <title>
            瑾晨书店-VIP
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/myStyle.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/slider.css" rel="stylesheet" type="text/css" media="all"/>
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
        </div>
        <div class="header_slide">
            <div class="header_bottom_left">
                <div class="categories">
                    <ul>
                        <h3>
                            我的账号
                        </h3>
                        <li>
                            <a href="javascript:forwordUrl('/userInfoDetail');">
                                基本信息
                            </a>
                        </li>
                        <li>
                            <a href="javascript:forwordUrl('/toResetPassword');">
                                修改密码
                            </a>
                        </li>
                        <li>
                            <a href="javascript:forwordUrl('/toAddressManage');">
                                收货地址
                            </a>
                        </li>
                        <li>
                            <a href="javascript:forwordUrl('/toVip');">
                                vip
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="header_bottom_right">
                <div class="slider">
                    <div id="slider">
                        <p>
                            消费满1000瑾晨币可以申请成为VIP用户，VIP用户享有全场8折优惠！
                        </p>
                        <p>
                            您当前消费瑾晨币为：${userMoney}
                        </p>
                    </div>
                    <div class="addressSubmit">
                        <form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/applyVip?username=${username}"
                        onsubmit="return submitCheck();">
                            <span>
                                <input id="submit" type="submit" value="申请VIP" class="myButton" style='${userMoney < 1000 || userIsVip == 1  ? "display:none" : ""}'>
                                ${userIsVip == 1 ? "您已经是尊贵的VIP了，请前往体验VIP特权" : (userMoney < 1000 ? "当前消费总额尚未达到申请标准" : "")}
                            </span>
                        </form>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
    <jsp:include page="bottomCommon.jsp"></jsp:include>
</body>

</html>