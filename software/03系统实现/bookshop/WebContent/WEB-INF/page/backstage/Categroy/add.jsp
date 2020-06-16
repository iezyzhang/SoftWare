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
    <title>新增品类</title>
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
	 window.onload = function(){
			 $("#categroyError").hide();
		 }
	function save(){
		var categroyText = $("#categroyName").val();
		if(categroyText!= null && categroyText != ""){
			return true;
		}else{
			 $("#categroyError").show();
			return false;
		}
	}
    $(function () {       
		$('#backid').click(function(){
				window.location.href="<%=basePath%>/backstage_getManagerContent";
		 });

    });
    
</script>
<script type="text/javascript">
 

 
		

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
<form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/backstage_addCategroy"  onsubmit="return save()">
<input type="hidden" name="categroyId" value="${categroy.categroyId}" />
	<script>
		
	</script>
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td class="tableleft">品类名</td>
            <td>
                <font color="red"> 
                	
                 <label id="categroyError" > 
                   类名不能为空
                 </label> 
                </font>
            	<input id="categroyName" name="categroyName" type="text" />
            </td>
        </tr>
        
        
        <tr>
            <td class="tableleft"></td>
            <td>
                <button type="submit" class="btn btn-primary" type="submit" >保存</button> &nbsp;&nbsp;
                <button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
