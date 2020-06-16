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
    <title></title>
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
				window.location.href="<%=basePath%>/backstage_toAddManager";
		});
		 
		 $("#queryError").hide();
		 
		 
 	 	//只处验证不能为空并且只能为英文或者数字或者下划线组成的6-12个字符
		$("#username").blur(function()
		{
		    if (!/^[a-zA-Z0-9_]{0,12}$/.test($("#username").val())) 
			{ 
				//如果没有匹配到，那么就错误
				$("#queryError").show();
				return;
			}
			else 
			{
				$("#queryError").hide();
			}
		});		 
		 
    });
    
    

	function del(id)
	{
		if(confirm("确定要删除吗？"))
		{
		
			var url = "<%=basePath%>/backstage_getManagerContent";
			
			window.location.href=url;		
		
		}
	}
	
	// 提交校验，若校验失败，则不能提交
	function submitCheck()
	{
	 	 	//只处验证不能为空并且只能为英文或者数字或者下划线组成的6-12个字符
	    if (!/^[a-zA-Z0-9_]{0,12}$/.test($("#managerName").val())) 
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
<form class="form-inline definewidth m20" id="submitForm" name="submitForm" method="post" action="<%=basePath%>/backstage_getManagerByCondition"  onsubmit="return submitCheck();">
	<div>		                                        
		<label id="queryError"  style="font-size:13px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font color="red">查询条件不合法</font>
		</label>
	</div>
	<div>
    系统用户名称：
    <input type="text" name="managerName" id="managerName" class="abc input-default" placeholder="" maxlength="12">&nbsp;&nbsp;  
    <button id="query" type="submit" class="btn btn-primary">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addnew">新增系统用户</button>
	</div>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
    		<th>序号</th>
    		<th>管理员角色</th>
        <th>管理员账号</th>
        <th>管理员上次登陆时间</th>
       	<th>管理员创建时间</th>
       	<th>操作</th>
    </tr>
    </thead>
    
	<c:choose> 
	<c:when test="${empty managerRecordList}"> 
	<tr> 
		<td colspan="9">没有符合条件的数据</td> 
	</tr>	
	</c:when> 
	<c:otherwise> 
		<c:forEach items="${managerRecordList}" var="managerDetail"> 
		
		<tr> 
			  <td>${managerDetail.managerId}</td>
			  <td>
					<c:if test="${managerDetail.role eq 0}">
						 ROOT管理员						
					</c:if>
					<c:if test="${managerDetail.role eq 1}">
						 用户管理员						
					</c:if>
					<c:if test="${managerDetail.role eq 2}">
						 产品管理员						
					</c:if>
					<c:if test="${managerDetail.role eq 3}">
						 网站管理员
					</c:if>
					<c:if test="${managerDetail.role eq 4}">
						 系统用户管理员
					</c:if>
					<c:if test="${managerDetail.role eq 5}">
						 商城订单管理员
					</c:if>
					
			  </td>
			  <td>${managerDetail.managerName}</td>
			
			  <td>${managerDetail.lastLoginTime}
			  	 <c:if test="${managerDetail.lastLoginTime eq null}">
			  		此用户无登陆记录
			  	 </c:if>
			  </td>
			  <td>${managerDetail.createTime}</td>
			  
	          <td>
<%-- 	          <c:out value="${managerDetail.managerName}"></c:out>
	          <c:out value="${currentAdmin}"></c:out> --%>
	          <c:choose>
		          <c:when test="${managerDetail.managerName != currentAdmin}">
	          		<a href="<%=basePath%>/backstage_toUpdateManager?managerId=${managerDetail.managerId}">修改管理员</a>
	          		
	          		<a href="<%=basePath%>/backstage_deleteManager?managerId=${managerDetail.managerId}" onclick="javascript:del(id)">删除管理员</a>
			
				  </c:when>
	              <c:otherwise>
	              	无
	              </c:otherwise>
	          </c:choose>
          		
         		
         		
          	</td>													
		</tr> 
	</c:forEach> 
	</c:otherwise> 
	</c:choose>
</table>
</body>
</html>
