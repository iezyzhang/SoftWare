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
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
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
        
        	$(function()
			{ 
				// 所有提示文字隐藏
				$("#passwordConfirmError").hide();
				$("#passwordError").hide();
				$("#usernameError").hide();
				$("#emailError").hide();
				$("#birthdayError").hide();
				$("#phoneNumberError").hide();
				
				initLogin("${username}");
				
				// 获取性别
				var sex = $('input[name="sex"]:checked').val();
				$("#sexHidden").val(sex);
			});
        
        
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
            

          
 	$(function()
 	{
 	 	//只处验证不能为空并且只能为英文或者数字或者下划线组成的6-12个字符
		$("#username").blur(function()
		{
		    if (!/^[a-zA-Z0-9_]{6,12}$/.test($(this).val())) 
			{ 
				//如果没有匹配到，那么就错误
				$("#usernameError").text("用户名只能为英文或者数字或者下划线组成的6-12个字符");
				$("#usernameError").show();
				return;
			}
			else 
			{
				$("#usernameError").hide();
			}
			
			// 校验用户名是否存在
			var url = "<%=basePath%>/checkUsername";
			$.post(url, 
			{
			    username: $(this).val()
			},
			function(result) 
			{
				if (result == "1")
				{
					$("#usernameError").text("用户已存在");
					$("#usernameError").show();
					return;
				}
				else
				{
					$("#usernameError").hide();
				}
			},"text");
		});
 	
 		// 校验密码是否一致  
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
			if($(this).val().length >= 6 && $(this).val().length <= 12)
			{
				$("#passwordError").hide();
			} 
			else 
			{
				$("#passwordError").show();
			}
		});
		
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
	    	if (!birthdayReg.test($("#birthday").val()) || $("#birthday").val().length != 10) 
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
	    	if (!phoneReg.test($("#phoneNumber").val()))
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
			$("#passwordConfirmError").hide();
			$("#passwordError").hide();
			$("#usernameError").hide();
			$("#emailError").hide();
			$("#birthdayError").hide();
			$("#phoneNumberError").hide();
		});
	});

	// 提交校验，若校验失败，则不能提交
	function submitCheck2()
	{
		
 	 	//只处验证不能为空并且只能为英文或者数字或者下划线组成的6-12个字符
	    if (!/^[a-zA-Z0-9_]{6,12}$/.test($("#username").val())) 
		{ 
			//如果没有匹配到，那么就错误
			$("#usernameError").text("用户名只能为英文或者数字或者下划线组成的6-12个字符");
			$("#usernameError").show();
			return false;
		}
		else 
		{
			$("#usernameError").hide();
		}
		
		// 校验用户名是否存在
		var url = "<%=basePath%>/checkUsername";
		$.post(url, 
		{
		    username: $("#username").val()
		},
		function(result) 
		{
			if (result == "1")
			{
				$("#usernameError").text("用户已存在");
				$("#usernameError").show();
				return false;
			}
			else
			{
				$("#usernameError").hide();
			}
		},"text");
	
	
		// 校验密码长度
		if($("#password").val().length >= 6 && $("#password").val().length <= 12)
		{
			$("#passwordError").hide();
		} 
		else 
		{
			$("#passwordError").show()
			return false;
		}	 	
 	
 		// 校验密码是否一致  		
		if($("#passwordConfirm").val()==$("#password").val())
		{
			$("#passwordConfirmError").hide();
		} 
		else 
		{
			$("#passwordConfirmError").show();
			return false;
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
	}

        </script>
    </head>
    
<body>
    <input type="hidden" id="menuColor" value="index" />
    <div class="wrap">
        <div class="header">
            <jsp:include page="topCommon.jsp"></jsp:include>
        </div>
        <div class="main">
            <div class="content">
                <div class="section group">
                    <div class="col span_2_of_3">
                        <div class="contact-form">
                            <h2>
                                注册
                            </h2>
                            <form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/addUser" onsubmit="return  submitCheck2();">
                                <div align="center">
                                </div>
                                <div>
                                    <div align="left">
                                        <blockquote>
                                            <blockquote>
                                                <span>
                                                    <label>
                                                        用户名:
                                                    </label>
                                                    <font color="red">
                                                        <label id="usernameError">
                                                            用户名只能为英文或者数字或者下划线组成的6-12个字符
                                                        </label>
                                                    </font>
                                                </span>
                                                <span>
                                                    <input type="text" id="username" name="username" class="textbox">
                                                </span>
                                            </blockquote>
                                        </blockquote>
                                    </div>
                                </div>
                                <div>
                                    <span>
                                        <label>
                                            密码：
                                        </label>
                                        <label id="passwordError">
                                            <font color="red">
                                                密码长度必须在6-12位
                                            </font>
                                        </label>
                                    </span>
                                    <span>
                                        <input id="password" name="password" type="password" class="textbox">
                                    </span>
                                </div>
                                <div>
                                    <span>
                                        <label>
                                            确认密码：
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
                                        <input id="userEmail" name="userEmail" type="text" class="textbox">
                                    </span>
                                </div>
                                <div>
                                    <span>
                                        <label>
                                            性别：
                                        </label>
                                        <label>
                                            <input id="sex1" name="sex" type="radio" value="男" checked="checked" />
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
                                        <input id="birthday" name="birthday" type="text" class="textbox" maxLength="10">
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
                                        <input id="phoneNumber" name="phoneNumber" type="text" class="textbox">
                                    </span>
                                </div>
                                <div>
                                    <span>
                                        <input id="reset" type="reset" value="重置" class="myButton">
                                        <input id="submit" type="submit" value="注册" class="myButton">
                                    </span>
                                    <span>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col span_1_of_3">
                        <div class="contact_info">
                            <h3>
                                如何找到我们
                            </h3>
                            <div class="map">
                                <iframe width="100%" height="175" frameborder="0" scrolling="no" marginheight="0"
                                marginwidth="0" src="https://maps.google.co.in/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Lighthouse+Point,+FL,+United+States&amp;aq=4&amp;oq=light&amp;sll=26.275636,-80.087265&amp;sspn=0.04941,0.104628&amp;ie=UTF8&amp;hq=&amp;hnear=Lighthouse+Point,+Broward,+Florida,+United+States&amp;t=m&amp;z=14&amp;ll=26.275636,-80.087265&amp;output=embed">
                                </iframe>
                                <br>
                                <small>
                                    <a href="https://maps.google.co.in/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=Lighthouse+Point,+FL,+United+States&amp;aq=4&amp;oq=light&amp;sll=26.275636,-80.087265&amp;sspn=0.04941,0.104628&amp;ie=UTF8&amp;hq=&amp;hnear=Lighthouse+Point,+Broward,+Florida,+United+States&amp;t=m&amp;z=14&amp;ll=26.275636,-80.087265"
                                    style="color:#666;text-align:left;font-size:12px">
                                        View Larger Map
                                    </a>
                                </small>
                            </div>
                        </div>
                                                <div class="company_address">
                            <h3>
                                公司信息 :
                            </h3>
                            <p>
                                南京,
                            </p>
                            <p>
                                夫子庙,
                            </p>
                            <p>
                               江苏
                            </p>
                            <p>
                                电话:(025) 222 666 444
                            </p>
                            <p>
                                传真: (000) 000 00 00 0
                            </p>
                            <p>
                                Email:
                                <span>
                                    800@126.com
                                </span>
                            </p>
                            <p>
                                友情链接:
                                <span>
                                    Facebook
                                </span>
                                ,
                                <span>
                                    Twitter
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="bottomCommon.jsp"></jsp:include>
</body>

</html>