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
            瑾晨书店-基本信息
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/slider.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/myStyle.css" rel="stylesheet" type="text/css" media="all"/>
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

				// 所有提示文字隐藏
				$("#emailError").hide();

				initLogin("${username}");
				
                var dd = new DropDown($('#dd'));

                $(document).click(function() {
                    // all dropdowns
                    $('.wrapper-dropdown-2').removeClass('active');
                });

            });
            
	// 提交校验，若校验失败，则不能提交
	function submitCheck()
	{
		// 校验邮箱格式
		var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	    if (!reg.test($("#userEmail").val())) 
		{ 
			$("#emailError").show();
			return false;
		}
		else if ($("#userEmail").val().length > 32)
		{
			$("#emailError").show();
			return false;
		}
		else
		{
			$("#emailError").hide();
		}		
	};            
        </script>
    </head>
    
    <body>
    <input type="hidden" id="menuColor" value="index"/>
        <div class="wrap">
            <div class="header">

				<jsp:include page="topCommon.jsp"></jsp:include>
				
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
 
							<div class="col span_2_of_3">
		                         <div class="form-userinfo">
		                            <h2>
		                                ${message}
		                            </h2>
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
 
 
 
<jsp:include page="bottomCommon.jsp"></jsp:include>
	</body>
</html>