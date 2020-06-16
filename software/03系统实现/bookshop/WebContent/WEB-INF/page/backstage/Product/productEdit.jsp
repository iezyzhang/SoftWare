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
    <title>修改产品</title>
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
     
	ue.ready(function() 
	{
	
    //设置编辑器的内容
    ue.execCommand('insertHtml', "${productDetail.detailContent}");
});
 </script>
<script type="text/javascript">
    $(function () 
    {       
		$('#backid').click(function()
		{
				window.location.href="<%=basePath%>/backstage_productManage";
		});
		
		// 上传新图片后隐藏原图片
		$('#uploadFile').change(function()
		{
			$('#oldImage').hide();
			$('#imageMessage').hide();
		});
    });
</script>
<script type="text/javascript">
 
            $(function() 
            {
				// 获取分类
				var categoryId = "${productDetail.categoryId}";
				$("#selectCategoryId").val(categoryId);
				$("#categoryId").val(categoryId);


		$("#selectCategoryId").change(function()
		{
				$("#categoryId").val($(this).val());
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

		img
		{
	width: 80px;
	height: 80px;
		}

    </style>
</head>
<body>
<form id="submitForm" name="submitForm" action="<%=basePath%>/backstage_modifyProduct"  onsubmit="return submitCheck();" method="POST" enctype="multipart/form-data">
<input type="hidden" name="productId" value="${productDetail.productId}"/>
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">产品名</td>
            <td>
            	<input type="text" id="productName" name="productName" value="${productDetail.productName}"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">状态</td>
            <td>
            	<input id="status" name="status" type="text" value="${productDetail.status}" disabled="disabled"/>
            </td>
        </tr>        
        <tr>
            <td class="tableleft">作者</td>
            <td>
            	<input id="author" name="author" type="text" value="${productDetail.author}"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">出版社</td>
            <td>
            	<input id="press" name="press" type="text" value="${productDetail.press}"/>
            </td>
        </tr>        
        <tr>
            <td class="tableleft">出版时间</td>
            <td>
            	<input id="publicationTime" name="publicationTime" type="text" value="${productDetail.publicationTime}"/>
            </td>
        </tr>        
        
        <tr>
            <td class="tableleft">类别</td>
            <td>
			  <select id="selectCategoryId">
				<c:forEach items="${categoryMap}" var="category">
			   		<option style="width:180px" value="${category.categroyId}">${category.categroyItem}</option>
				</c:forEach>		  
			  </select>
			  <input type="hidden" id="categoryId" name="categoryId"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">描述</td>
            <td>
            	<input type="text" id="description" name="description" value="${productDetail.description}"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">存货</td>
            <td>
				<input id="stock" name="stock" type="text" value="${productDetail.stock}"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">价格</td>
            <td>
            	<input type="text" id="price" name="price" value="${productDetail.price}"/>
            </td>
        </tr>   
        <tr>
            <td class="tableleft">市场价格</td>
            <td>
            	<input type="text" id="marketPrice" name="marketPrice" value="${productDetail.marketPrice}"/>
            </td>
        </tr>
        <tr>
            <td class="tableleft">销量</td>
            <td>
            	<input type="text" id="salesvolume" name="salesvolume" value="${productDetail.salesvolume}" disabled="disabled"/>
            </td>
        </tr>        
        <tr>
            <td class="tableleft">产品图片</td>
            <td>
            	<c:choose>
            		<c:when test="${not empty productDetail.iconUrl}">
            			<img id="oldImage" src='userimages/${productDetail.iconUrl}' />
            			<label id="imageMessage">点击上传新图片</label>
            		</c:when>
            	</c:choose>
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
