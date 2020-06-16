<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
            + request.getServerName() + ":" + request.getServerPort()  
            + path;  
%>

<!DOCTYPE HTML>
<html>
 <head>
  <title>瑾晨书屋后台管理后台</title>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <link href="A_assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
  <link href="A_assets/css/bui-min.css" rel="stylesheet" type="text/css" />
   <link href="A_assets/css/main-min.css" rel="stylesheet" type="text/css" />
 </head>
 <body>

  <div class="header">
    
      <div class="dl-title">
       <!--<img src="/chinapost/Public/assets/img/top.png">-->
      </div>

    <div class="dl-log">欢迎您，<span class="dl-log-user">${adminName}</span><a href="<%=basePath%>/backstage_logOut" title="退出系统" class="dl-log-quit">[退出]</a>
    </div>
  </div>
   <div class="content">
    <div class="dl-main-nav">
      <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
      <ul id="J_Nav"  class="nav-list ks-clear">
        		<li class="nav-item dl-selected"><div class="nav-item-inner nav-home">商城后台管理</div></li>	      

      </ul>
    </div>
    <ul id="J_NavContent" class="dl-tab-conten">

    </ul>
   </div>
  <script type="text/javascript" src="A_assets/js/jquery-1.8.1.min.js"></script>
  <script type="text/javascript" src="A_assets/js/bui-min.js"></script>
  <script type="text/javascript" src="A_assets/js/common/main-min.js"></script>
  <script type="text/javascript" src="A_assets/js/config-min.js"></script>
  <script>
var role = "";   
var managerText = "";
  
    BUI.use('common/main',function(){
      
    	var config = [{id:'1',menu:[
	      {
	    	  	text:'用户管理',
	    	  	items:[
	    	 
	    	  	  {id:'11',text:'用户管理',href:'<%=basePath%>/backstage_userManage'},
		      {id:'12',text:'VIP管理',href:'<%=basePath%>/backstage_toVIP'}
		      
		   
		    
		    
	    		  
	    				]
	      },
	     
      		{
	    	  	text:'商品管理',
	    	  	items:[
		      {id:'13',text:'产品管理',href:'<%=basePath%>/backstage_productManage'},
		      {id:'14',text:'类目管理',href:'<%=basePath%>/backstage_toCategroyIndex'}

	    	  	 	]
	    	  
      		},
      		 {
	    	  	text:'订单管理',
	    	  	items:[
		      {id:'15',text:'历史所有订单',href:'<%=basePath%>/backstage_toSubscription'},
		      {id:'16',text:'未处理订单',href:'<%=basePath%>/backstage_toNoSubscription'},

	    	  	 	]
	    	  
    			},
      		{
	    	  	text:'网站管理',
	    	  	items:[
	    	  	 	 {id:'16',text:'评论管理',href:'<%=basePath%>/backstage_toComment'},
			      {id:'17',text:'公告管理',href:'<%=basePath%>/backstage_getNoticeContent'}

	    	  	 	]
	    	  
      		},
      		{
	    	  	text:'系统用户管理',
	    	  	items:[
	    	  	  {id:'18',text:'管理员设置',href:'<%=basePath%>/backstage_getManagerContent'} 

	    	  	 	]
	    	  
      		}
      		
	      ]
    }];
      new PageUtil.MainPage({
        modulesConfig : config
      });
    });
  </script>
 </body>
</html>