<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
            + request.getServerName() + ":" + request.getServerPort()  
            + path;  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>vip管理</title>
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
</head>
<body>
	<form class="form-inline definewidth m20" id="submitForm" name="submitForm" method="post" action="<%=basePath%>/backstage_userManage"  onsubmit="return submitCheck();">
	<div>		                                        
		<label id="queryError"  style="font-size:13px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font color="red">查询条件不合法</font>
		</label>
	</div>
	<div>
    用户名称：
    <input type="text" name="username" id="username"class="abc input-default" placeholder="" maxlength="12">&nbsp;&nbsp;  
    <button id="query" type="submit" class="btn btn-primary">查询</button>&nbsp;&nbsp; <!-- <button type="button" class="btn btn-success" id="addnew">新增用户</button> -->
	</div>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>用户名</th>
        <th>用户状态</th>
        <th>邮箱</th>
        <th>手机号码</th>
        <th>出生年月</th>
        <th>是否为VIP</th>
        <th>创建时间</th>
        <th>最后登录时间</th>
        <th>操作</th>
    </tr>
    </thead>
    
	<c:choose> 
	<c:when test="${empty userDetailList}"> 
	<tr> 
		<td colspan="9">没有符合条件的数据</td> 
	</tr>	
	</c:when> 
	<c:otherwise> 
		<c:forEach items="${userDetailList}" var="userDetail"> 
		<tr> 
			  <td>${userDetail.username}</td>
			  <td>${userDetail.userStatus}</td>
			  <td>${userDetail.email}</td>
			  <td>${userDetail.phoneNumber}</td>
			  <td>${userDetail.birthday}</td>
			  <td>${userDetail.isVip}</td>
			  <td>${userDetail.createTime}</td>
			  <td>${userDetail.lastLoginTime}</td>
	          <td>
          		<a href="<%=basePath%>/backstage_toModifyUser?userId=${userDetail.userId}">编辑</a>
          	
          		
          		<c:choose>
          		<c:when test="${userDetail.userStatus=='正常'}"> 
          			<a href="<%=basePath%>/backstage_toModifyUserStatus?userId=${userDetail.userId}&userStatus=1">暂停</a>
          		</c:when>	
          		<c:when test="${userDetail.userStatus=='未激活'}"> 
          			<a href="<%=basePath%>/backstage_toModifyUserStatus?userId=${userDetail.userId}&userStatus=0">恢复</a>
         		</c:when>
         		</c:choose>
         		
          	</td>													
		</tr> 
	</c:forEach> 
	</c:otherwise> 
	</c:choose>
</table>
</body>
</html>