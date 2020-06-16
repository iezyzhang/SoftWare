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
				$("#birthdayError").hide();
				$("#phoneNumberError").hide();
				
				var sexReq = "${userDetail.sex}";
				
				// 初始化性别
				if (sexReq == "男")
				{
					$("#sex1").attr("checked",'checked');
				}
				else
				{
					$("#sex2").attr("checked",'checked');
				}
				
				$("#sexHidden").val(sexReq);
				
				initLogin("${username}");
				
                var dd = new DropDown($('#dd'));

                $(document).click(function() {
                    // all dropdowns
                    $('.wrapper-dropdown-2').removeClass('active');
                });

            });
            
 	$(function()
 	{
 		// 性别改动
		$('input[name="sex"]').change(function()
		{
				// 获取性别
				$("#sexHidden").val($(this).val());
		});
		
		// 校验邮箱格式
		$("#userEmail").blur(function()
		{
			var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		    if (!reg.test($(this).val())) 
			{ 
				$("#emailError").show();
				return;
			}
			else if ($(this).val().length > 32)
			{
				$("#emailError").show();
				return;
			}
			else
			{
				$("#emailError").hide();
			}
		});		
		
		// 校验出生年月
		$("#birthday").blur(function()
		{
			var birthdayReg = /^[\d]{4}[-\ ][\d]{1,2}[-\ ][\d]{1,2}$/;
		    if (!birthdayReg.test($(this).val()) || $(this).val().length != 10) 
			{ 
				$("#birthdayError").show();
				return;
			}
			else
			{
				$("#birthdayError").hide();
			}
		});	
		
		// 校验手机号码
		$("#phoneNumber").blur(function()
		{
			var phoneReg = /^[1][358][0-9]{9}$/;
		    if (!phoneReg.test($(this).val())) 
			{ 
				$("#phoneNumberError").show();
				return;
			}
			else
			{
				$("#phoneNumberError").hide();
			}
		});
		

		$("#reset").click(function()
		{
			// 所有提示文字隐藏
			$("#emailError").hide();
			$("#birthdayError").hide();
			$("#phoneNumberError").hide();
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
		
		
		var birthdayReg = /^[\d]{4}[-\ ][\d]{1,2}[-\ ][\d]{1,2}$/;
	    if (!birthdayReg.test($("#birthday").val()) || $("#birthday").val().length != 10) 
		{ 
			$("#birthdayError").show();
			return false;
		}
		else
		{
			$("#birthdayError").hide();
		}
		
		var phoneReg = /^[1][358][0-9]{9}$/;
	    if (!phoneReg.test($("#phoneNumber").val())) 
		{ 
			$("#phoneNumberError").show();
			return false;
		}
		else
		{
			$("#phoneNumberError").hide();
		}		
		
	};            
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
                                    基本信息
                                </h2>
                                <form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/modifyUser?username=${username}"
                                onsubmit="return submitCheck();">
                                    <div>
                                        <span>
                                            <label>
                                                用户名:
                                            </label>
                                        </span>
                                        <span>
                                            <input id="username" name="username" type="text" class="textbox" value="${userDetail.username}"
                                            disabled="disabled">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                用户状态：
                                            </label>
                                        </span>
                                        <span>
                                            <input id="userStatus" name="userStatus" type="text" class="textbox" value="${userDetail.userStatus}"
                                            disabled="disabled">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                是否为VIP：
                                            </label>
                                        </span>
                                        <span>
                                            <input id="isVip" name="isVip" type="text" class="textbox" value="${userDetail.isVip}"
                                            disabled="disabled">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                邮箱：
                                            </label>
                                            <label id="emailError">
                                                <font color="red">
                                                    邮箱格式不正确或长度大于32字符
                                                </font>
                                            </label>
                                        </span>
                                        <span>
                                            <input id="userEmail" name="userEmail" type="text" class="textbox" value="${userDetail.email}">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                性别：
                                            </label>
                                            <label>
                                                <input id="sex1" name="sex" type="radio" value="男" />
                                                男
                                            </label>
                                            <label>
                                                <input id="sex2" name="sex" type="radio" value="女" />
                                                女
                                            </label>
                                            <input id="sexHidden" name="sexHidden" type="hidden" />
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                出生年月：
                                            </label>
                                            <label id="birthdayError">
                                                <font color="red">
                                                    请填写正确的格式如: 1988-07-07
                                                </font>
                                            </label>
                                            <input id="birthday" name="birthday" type="text" class="textbox" maxLength="10"
                                            value="${userDetail.birthday}">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                手机号码：
                                            </label>
                                            <label id="phoneNumberError">
                                                <font color="red">
                                                    请填写正确的手机号码如：13815468547
                                                </font>
                                            </label>
                                            <input id="phoneNumber" name="phoneNumber" type="text" class="textbox"
                                            value="${userDetail.phoneNumber}">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                创建时间：
                                            </label>
                                            <input id="createTime" name="createTime" type="text" class="textbox" value="${userDetail.createTime}"
                                            disabled="true">
                                        </span>
                                    </div>
                                    <div>
                                        <span>
                                            <label>
                                                最后登陆时间：
                                            </label>
                                            <input id="lastLoginTime" name="lastLoginTime" type="text" class="textbox"
                                            value="${userDetail.lastLoginTime}" disabled="true">
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