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
    <title>编辑系统用户</title>
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
			var reg = /^[\d]{4}[-\ ][\d]{1,2}[-\ ][\d]{1,2}$/;
		    if (!reg.test($(this).val()) || $(this).val().length != 10) 
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


    <style type="text/css">
        body {
            padding-bottom: 40px;
        }
        .sidebar-nav {
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
<form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/backstage_updateManager"  >
<input type="hidden" name="managerId" value="${managerRecord.managerId}" />
<input type="hidden" name="acreateTime"  value="${managerRecord.createTime}" />
<input type="hidden" name="alastLoginTime" value="${managerRecord.lastLoginTime}" />
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">登录名</td>
            <td><input type="text" name="amanagerName" value="${managerRecord.managerName}"/></td>
        </tr>
        <tr>
            <td class="tableleft">密码</td>
            <td><input type="password" name="adminpassword" value="${managerRecord.password}" /></td>
        </tr>
        <tr>
        		<td class="atableleft">用户角色</td>
        		<td>
        			 <select id="selectRoleId" name="selectRoleId">
        			 	<!-- <option style="width:180px" value="0">ROOT用户管理员</option>  -->
        			 	<option style="width:180px" value="1">用户管理员</option>
        			 	<option style="width:180px" value="2">商品管理员</option>
        			 	<option style="width:180px" value="3">网站管理员</option>
        			 	<option style="width:180px" value="4">系统用户管理员</option>
        			 	<option style="width:180px" value="5">商城订单管理员</option>
        			 	
        			 </select>
        		</td>
        </tr>
        
        <tr>
            <td class="tableleft">创建时间</td>
            <td><input type="text" name="createTime" id="createTime" value="${managerRecord.createTime}" disabled="disabled"/></td>
          
        </tr>
        <tr>
            <td class="tableleft">最后登陆时间</td>
            <td><input type="text" name="lastLoginTime" id="lastLoginTime" value="${managerRecord.lastLoginTime}" disabled="disabled"/></td>
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
