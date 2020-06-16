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
				window.location.href="<%=basePath%>/backstage_toAddNotice";
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
		
			var url = "index.html";
			
			window.location.href=url;		
		
		}
	}
	
	// 提交校验，若校验失败，则不能提交
	function submitCheck()
	{
	 	 	//只处验证不能为空并且只能为英文或者数字或者下划线组成的6-12个字符
	    if (!/^[a-zA-Z0-9_]{0,12}$/.test($("#username").val())) 
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
<form class="form-inline definewidth m20" id="submitForm" name="submitForm" method="post" action="<%=basePath%>/backstage_noticeManage"  onsubmit="return submitCheck();">
	<div>		                                        
		<label id="queryError"  style="font-size:13px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font color="red">查询条件不合法</font>
		</label>
	</div>
	<div>
    查询公告
    <input type="text" name="noticeSelect" id="noticeSelect"class="abc input-default" placeholder="" maxlength="12">&nbsp;&nbsp;  
    <button id="query" type="submit" class="btn btn-primary">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addnew">新增公告</button>
	</div>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th >发布时间</th>
        <th >公告内容</th>
        <th>  操作  </th>
    </tr>
    </thead>
    
	<c:choose> 
	<c:when test="${empty noticeRecordList}"> 
	<tr> 
		<td colspan="9">没有符合条件的数据</td> 
	</tr>	
	</c:when> 
	<c:otherwise> 
		<c:forEach items="${noticeRecordList}" var="noticeDetail"> 
		<tr> 
			  <td>${noticeDetail.createTime}</td>
			  <td>${noticeDetail.noticeContent}</td>
			 
	          <td>
          		<a href="<%=basePath%>/backstage_editNoticeContent?noticeId=${noticeDetail.noticeId}">编辑</a>
          	
          		
          		<a href="<%=basePath%>/backstage_deleteNoticeContent?noticeId=${noticeDetail.noticeId}" onclick="return del(${noticeDetail.noticeId});">删除</a>
         		
          	</td>													
		</tr> 
	</c:forEach> 
	</c:otherwise> 
	</c:choose>
</table>
</body>
</html>
