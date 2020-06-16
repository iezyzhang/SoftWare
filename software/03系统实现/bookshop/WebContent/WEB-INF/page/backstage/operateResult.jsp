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
    <title>操作结果</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <style type="text/css">
body
{
	TEXT-ALIGN: center;
}
#center{ MARGIN-RIGHT: auto;
MARGIN-LEFT: auto;
height:500px;
width:400px;
vertical-align:middle;
}
    </style>
</head>
<body>
	<div id="center">
		<br/>
		<br/>
		<br/>
		<c:choose> 
			<c:when test="${result == 0}"> 
				<img src="images/success.png"/>
			</c:when> 
			<c:otherwise> 
				<img src="images/error.png"/>
			</c:otherwise> 
		</c:choose>
		<p>${message}</p>
	</div>
</body>
</html>
