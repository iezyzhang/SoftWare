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
            瑾晨书店-重置密码
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
            function DropDown(el) 
            {
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
				$("#oldPasswordError").hide();
				$("#passwordConfirmError").hide();
				$("#passwordError").hide();
				
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
	 		// 校验原密码是否正确
			$.ajax(
			{
				url:"<%=basePath%>/checkLoginInfo",
				username: $("#username").val(),
				data:{username:$("#username").val(),password: $("#oldPassword").val()},
				type:'POST',
				async: false,
				success: (function(data)
				{
				  // 如果正确，直接放通	
			      if(data == "1")
				  {
				  	$("#oldPasswordError").hide();
				  }
				  else
				  {
				    // 如果不正确，返回false
				  	$("#oldPasswordError").show();
				  	return false;
				  }
				}),
				error:(function(xhr)
				{
					alert('请求有问题\n'+xhr.responseText);
					return false;
				})
			});
			
			// 密码长度
			if($("#password").val().length >= 6 && $("#password").val().length <= 12)
			{
				$("#passwordError").hide();
			} 
			else 
			{
				$("#passwordError").text("密码长度必须在6-12位");
				$("#passwordError").show();
				return false;
			}
			
			// 新密码和旧密码不能一样
			if ($("#password").val() == $("#oldPassword").val())
			{
				$("#passwordError").text("新密码不能和原密码相同");
				$("#passwordError").show();
				return false;
			}
			
			// 两次密码要一致
			if($("#passwordConfirm").val()==$("#password").val()){
				$("#passwordConfirmError").hide();
			} else {
				$("#passwordConfirmError").show();
				return false;
			}
	};
	
 	$(function()
 	{
		$("#oldPassword").blur(function()
		{
			var flag = 0;
	 		// 校验原密码是否正确
			$.ajax(
			{
				url:"<%=basePath%>/checkLoginInfo",
				username: $("#username").val(),
				data:{username:$("#username").val(),password: $("#oldPassword").val()},
				type:'POST',
				async: false,
				success: (function(data)
				{
				  // 如果正确，直接放通	
			      if(data == "1")
				  {
				  	$("#oldPasswordError").hide();
				  }
				  else
				  {
				    // 如果不正确，返回false
				  	$("#oldPasswordError").show();
				  	flag = 1;
				  }
				}),
				error:(function(xhr)
				{
					alert('请求有问题\n'+xhr.responseText);
					flag = 1;
				})
			});
			
			// 新密码和旧密码不能一样
			var newPass = $("#password").val();
			if (null != newPass && newPass != "" && flag == 0)
			{
				if (newPass == $("#oldPassword").val())
				{
					$("#passwordError").text("新密码不能和原密码相同");
					$("#passwordError").show();
				}
			}
		}); 
 	
 		// 校验新密码是否一致  
		$("#passwordConfirm").blur(function()
		{
			if($(this).val()==$("#password").val()){
				$("#passwordConfirmError").hide();
			} else {
				$("#passwordConfirmError").show();
			}
		});
		
		// 校验密码长度
		$("#password").blur(function()
		{
			var flag = 0;
			
			if($(this).val().length >= 6 && $(this).val().length <= 12)
			{
				$("#passwordError").hide();
			} 
			else 
			{
				$("#passwordError").text("密码长度必须在6-12位");
				$("#passwordError").show();
				flag = 1;
			}
			
			// 新密码和旧密码不能一样
			var oldPass = $("#oldPassword").val();
			if (null != oldPass && oldPass != "" && flag == 0)
			{
				if (oldPass == $("#password").val())
				{
					$("#passwordError").text("新密码不能和原密码相同");
					$("#passwordError").show();
				}
			}
		});
		
		$("#reset").click(function()
		{
			// 所有提示文字隐藏
			$("#oldPasswordError").hide();
			$("#passwordError").hide();
			$("#passwordConfirmError").hide();
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
                        <div class="col span_2_of_3">
                            <div class="form-userinfo">
                                <h2>
                                    修改密码
                                </h2>
                                <form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/resetPassword?username=${username}"
                                onsubmit="return submitCheck();">
                                    <div>
                                        <span>
                                            <label>
                                                用户名:
                                            </label>
                                        </span>
                                        <span>
                                            <input id="username" name="username" type="text" class="textbox" value="${userRecord.username}"
                                            disabled="true">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                原密码：
                                            </label>
                                            <label id="oldPasswordError">
                                                <font color="red">
                                                    原密码不正确
                                                </font>
                                            </label>
                                        </span>
                                        <span>
                                            <input id="oldPassword" name="oldPassword" type="password" class="textbox">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                新密码：
                                            </label>
                                            <font color="red">
                                                <label id="passwordError">
                                                    密码长度必须在6-12位
                                                </label>
                                            </font>
                                        </span>
                                        <span>
                                            <input id="password" name="password" type="password" class="textbox">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                确认新密码：
                                            </label>
                                            <label id="passwordConfirmError">
                                                <font color="red">
                                                    两次密码不一致
                                                </font>
                                            </label>
                                        </span>
                                        <span>
                                            <input id="passwordConfirm" name="userRepassword" type="password" class="textbox">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <input id="reset" type="reset" value="重置" class="myButton">
                                            <input id="submit" type="submit" value="修改" class="myButton">
                                        </span>
                                        <span>
                                        </span>
                                    </div>
                                </form>
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