<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% 
String path=request.getContextPath(); 
String basePath=request.getScheme()
    + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<script src="js/jquery3.3.7.js"></script>
<script type="text/javascript">
//校验用户名是否存在
var url = "<%=basePath%>/getCategroyRecordList";
	$.post(url, 
	{
		
	},
	function(result) 
	{
		 var categroyRecordList = eval(result); 
		var html = "";
  		for(var i =0;i<categroyRecordList.length  ;i++){
  			html +="<li>";
  			html += "<a href=<%=basePath%>/searchProduct?categroyId=";
  			html += categroyRecordList[i].categroyId;
  			html += "&username=";
  			html += "${username}" ;
  			html += ">";
            	html += categroyRecordList[i].categroyItem;
            	html += "</a></li>";
  		}
		$("#categroyShow").html(html);
	},"json");
</script>
<div class="categories">
    <ul id="categroyShow">
        <h3>
            分类
        </h3>
      
       
      
      	
      
    </ul>
</div>