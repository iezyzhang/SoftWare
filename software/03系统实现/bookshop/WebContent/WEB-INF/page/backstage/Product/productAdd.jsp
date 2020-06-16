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
    <title>新增产品</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="A_Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="A_Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="A_Css/style.css" />
    <script type="text/javascript" src="A_Js/jquery.js"></script>
    <script type="text/javascript" src="A_Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="A_Js/bootstrap.js"></script>
    <script type="text/javascript" src="A_Js/ckform.js"></script>
    <script type="text/javascript" src="A_Js/common.js"></script>
    
    <script type="text/javascript" charset="utf-8" src="ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="ueditor1_4_3-utf8-jsp/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="ueditor1_4_3-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
    

  <!-- 实例化编辑器 -->
  <script type="text/javascript">
      var ue = UE.getEditor('container');
  </script>    
    
<script type="text/javascript">
    $(function () {       
		$('#backid').click(function(){
				window.location.href="<%=basePath%>/backstage_productManage";
		 });

    });
</script>
<script type="text/javascript">
 
            $(function() 
            {
				$("#productNameError").hide();
				$("#authorError").hide();
				$("#publicationTimeError").hide();
				$("#categoryIdError").hide();
				$("#descriptionError").hide();
				$("#stockError").hide();
				$("#priceError").hide();
				$("#marketPriceError").hide();
				$("#iconUrlError").hide();
				
				$("#categoryId").val($("#selectCategoryId").val());
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
		$("#selectCategoryId").change(function()
		{
				// 获取性别
				$("#categoryId").val($(this).val());
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
	function submitCheck()
	{
		// 获取富文本
		var content = UE.getEditor('container').getContent();
		$("#productDetailContent").val(content);
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
<form id="submitForm" name="submitForm" action="<%=basePath%>/backstage_addProduct" onsubmit="return submitCheck();" method="POST" enctype="multipart/form-data">
<input type="hidden" name="userId" value="${userDetail.userId}" />
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">产品名</td>
            <td>
                <font color="red"> 
                 <label id="productNameError"> 
                    产品名不合法
                 </label> 
                </font>
            	<input type="text" id="productName" name="productName"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">作者</td>
            <td>
                <font color="red"> 
                 <label id="authorError"> 
                    作者不合法
                 </label> 
                </font>
            	<input id="author" name="author" type="text" />
            </td>
        </tr>
        <tr>
            <td class="tableleft">出版社</td>
            <td>
            	<input id="press" name="press" type="text"/>
            </td>
        </tr>        
        <tr>
            <td class="tableleft">出版时间</td>
            <td>
                <font color="red"> 
                 <label id="publicationTimeError"> 
                    出版时间不合法
                 </label> 
                </font>
            	<input id="publicationTime" name="publicationTime" type="text"/>
            </td>
        </tr>        
        
        <tr>
            <td class="tableleft">类别</td>
            <td>
                <label id="categoryIdError">
                    <font color="red">邮箱格式不正确或长度大于32字符</font>
                </label>
			  <select id="selectCategoryId">
				<c:forEach items="${categoryMap}" var="category">
			   		<option style="width:180px" value="${category.key}">${category.value}</option>
				</c:forEach>		  
			  </select>
			  <input type="hidden" id="categoryId" name="categoryId"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">描述</td>
            <td>
                <label id="descriptionError">
                    <font color="red">描述不能为空</font>
                </label>            	
            	<input type="text" id="description" name="description"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">存货</td>
            <td>
                <label id="stockError">
                    <font color="red">存货必须是数字</font>
                </label>            
				<input id="stock" name="stock" type="text" />
            </td>
        </tr>
        <tr>
            <td class="tableleft">价格</td>
            <td>
                <label id="priceError">
                    <font color="red">价格必须是数字</font>
                </label>            
            	<input type="text" id="price" name="price"/>
            </td>
        </tr>   
        <tr>
            <td class="tableleft">市场价格</td>
            <td>
                <label id="marketPriceError">
                    <font color="red">市场价格必须是数字</font>
                </label>            
            	<input type="text" id="marketPrice" name="marketPrice"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">产品图片</td>
            <td>
                <label id="iconUrlError">
                    <font color="red">产品图片不能为空</font>
                </label>            
            	<input type="file" id="uploadFile" name="uploadFile" accept="image/jpeg"/>
            </td>
        </tr>

        <tr>
            <td class="tableleft">编辑产品详情</td>
            <td>        
            	<div style="width: 750px; z-index: 999;">    
				    <!-- 加载编辑器的容器 -->
				    <script id="container" name="content" type="text/plain"></script>
    				<input type="hidden" id="productDetailContent" name="productDetailContent" />
    			</div>
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
