<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
            + request.getServerName() + ":" + request.getServerPort()  
            + path;  
%>

<!DOCTYPE html>
<html>
<head>
    <title>新增用户</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="A_Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="A_Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="A_Css/style.css" />
    <script type="text/javascript" src="A_Js/jquery.js"></script>
    <script type="text/javascript" src="A_Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="A_Js/bootstrap.js"></script>
    <script type="text/javascript" src="A_Js/ckform.js"></script>
    <script type="text/javascript" src="A_Js/common.js"></script>
<script type="text/javascript">
    $(function () {       
		$('#backid').click(function(){
				window.location.href="<%=basePath%>/backstage_getManagerContent";
		 });

    });
</script>
<script type="text/javascript">
 
            $(function() 
            {
				$("#passwordConfirmError").hide();
				$("#passwordError").hide();
				$("#usernameError").hide();
				$("#emailError").hide();
				$("#birthdayError").hide();
				$("#phoneNumberError").hide();
				
				// 获取性别
				var sex = $('input[name="sex"]:checked').val();
				$("#sexHidden").val(sex);				
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
		
 		/* // 性别改动
		$('input[name="sex"]').change(function()
		{
				// 获取性别
				$("#sexHidden").val($(this).val());
		});		 */
		
		// 校验邮箱格式
		/* $("#userEmail").blur(function()
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
		});		 */
		
		// 校验出生年月
		/* $("#birthday").blur(function()
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
		});	 */
		
		// 校验手机号码
		/* $("#phoneNumber").blur(function()
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
		 */

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
	function submitCheck()
	{
 	 	//只处验证不能为空并且只能为英文或者数字或者下划线组成的6-12个字符
	    if (!/^[a-zA-Z0-9_]{6,12}$/.test($("#adminName").val())) 
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
		var url = "<%=basePath%>/backstage_checkManagerName";
		$.post(url, 
		{
			adminName: $("#adminName").val()
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
		
		/* var birthdayReg = /^[\d]{4}[-\ ][\d]{1,2}[-\ ][\d]{1,2}$/;
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
	/* 	var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
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
		}		 */
	}; 

</script>


    <style type="text/css">
        body 
        {
            padding-bottom: 40px;
        }
        
        label
        {
       		font-size:13px;
        }
        
        .sidebar-nav 
        {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }


    </style>
</head>
<body>
<form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/backstage_addManager"  onsubmit="return submitCheck();">
<input type="hidden" name="userId" value="${userDetail.userId}" />
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">登录名</td>
            <td>
                <font color="red"> 
                 <label id="usernameError"> 
                    用户名只能为英文或者数字或者下划线组成的6-12个字符 
                 </label> 
                </font>
            	<input type="text" id="adminName" name="adminName"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">密码</td>
            <td>
                <font color="red"> 
                 <label id="passwordError"> 
                    密码长度必须在6-12位
                 </label> 
                </font>
            	<input id="password" name="password" type="password" />
            </td>
        </tr>
        <tr>
            <td class="tableleft">确认密码</td>
            <td>
                <font color="red"> 
                 <label id="passwordConfirmError"> 
                    两次密码不一致 
                 </label> 
                </font>
            	<input id="passwordConfirm" name="userRepassword" type="password"/>
            </td>
        </tr>        
         <tr>
        		<td class="atableleft">用户角色</td>
        		<td>
        			 <select id="selectRoleId" name="selectRoleId">
        			 	<option style="width:180px" value="0">系统用户管理员</option>
        			 	<option style="width:180px" value="1">用户管理员</option>
        			 	<option style="width:180px" value="2">商品管理员</option>
        			 	<option style="width:180px" value="3">网站管理员</option>
        			 	<option style="width:180px" value="4">系统用户管理员</option>
        			 	<option style="width:180px" value="5">商城订单管理员</option>
        			 	
        			 </select>
        		</td>
        </tr>
       
        <tr>
            <td class="tableleft"></td>
            <td>
                <button type="submit" class="btn btn-primary" type="submit">保存</button> &nbsp;&nbsp;
                <button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
