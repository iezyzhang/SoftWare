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
    <title>产品管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="A_Css/Mybootstrap.css" />
    <link rel="stylesheet" type="text/css" href="A_Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="A_Css/style.css" />
    <script type="text/javascript" src="A_Js/jquery.js"></script>
    <script type="text/javascript" src="A_Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="A_Js/bootstrap.js"></script>
    <script type="text/javascript" src="A_Js/ckform.js"></script>
    <script type="text/javascript" src="A_Js/common.js"></script>

<script type="text/javascript">
    $(function () 
    {
		$('#addnew').click(function()
		{
				window.location.href="<%=basePath%>/backstage_toAddProduct";
		});
		 
		 $("#queryError").hide();
		 
    });
    
    

	function changeProductStatus(productId,operateType)
	{
		var message = "确定要操作?";
		if (operateType == 1)
		{
			message ="上架后会在商城中展示，确定要上架？";
		}
		else if (operateType == 2)
		{
			message ="下架后会从商城中移除，买家无法购买，确定要下架？";
		}
		else if (operateType == 3)
		{
			message ="删除后无法恢复，确定要删除？";
		}
		
		if(confirm(message))
		{
			var url = "<%=basePath%>/backstage_changeProductStatus?operateType=" + operateType + "&productId=" + productId;
			window.location.href=url;		
		}
	}
	
	// 提交校验，若校验失败，则不能提交
	function submitCheck()
	{
	 	 	//只处验证不能为空并且只能为英文或者数字或者下划线组成的6-12个字符
	    if (!/^[a-zA-Z0-9_]{0,12}$/.test($("#productName").val())) 
		{ 
			//如果没有匹配到，那么就错误
			$("#queryError").show();
			return false;
		}
		else 
		{
			$("#queryError").hide();
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
<form class="form-inline definewidth m20" id="submitForm" name="submitForm" method="post" action="<%=basePath%>/backstage_productManage">
	<div>		                                        
		<label id="queryError" style="font-size:13px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font color="red">查询条件不合法</font>
		</label>
	</div>
	<div>
    产品名称：
    <input type="text" name="productName" id="productName" class="abc input-default"  maxlength="12">&nbsp;&nbsp;  
    <button id="query" type="submit" class="btn btn-primary">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addnew">新增产品</button>
	</div>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>产品名</th>
        <th>状态</th>
        <th>作者</th>
        <th>图书类别</th>
        <th>价格</th>
        <th>销量</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    
	<c:choose> 
	<c:when test="${empty productList}"> 
	<tr> 
		<td colspan="9">没有符合条件的数据</td> 
	</tr>	
	</c:when> 
	<c:otherwise> 
	<c:forEach items="${productList}" var="productDetail">
	<tr> 
		  <td>${productDetail.productName}</td>
		  <td>${productDetail.status}</td>
		  <td>${productDetail.author}</td>
		  <td>${productDetail.category}</td>
		  <td>${productDetail.price}</td>
		  <td>${productDetail.salesvolume}</td>
		  <td>${productDetail.createTime}</td>
          <td>
          	<a href="<%=basePath%>/backstage_toModifyProduct?productId=${productDetail.productId}">编辑</a>
			<c:choose> 
			<c:when test="${productDetail.status == '下架' or productDetail.status == '草稿'}"> 
				<a name="changeStatus" href="javascript:changeProductStatus('${productDetail.productId}',1);">上架</a>
			</c:when> 
			</c:choose>
			<c:choose> 
			<c:when test="${productDetail.status == '上架'}"> 
				<a name="changeStatus" href="javascript:changeProductStatus('${productDetail.productId}',2);">下架</a>
			</c:when> 
			</c:choose>
          	<a name="changeStatus" href="javascript:changeProductStatus('${productDetail.productId}',3);">删除</a>
          </td>													
	</tr> 
	</c:forEach> 
	</c:otherwise> 
	</c:choose>
</table>
</body>
</html>
