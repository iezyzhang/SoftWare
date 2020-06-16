<%@ page language="java" import="java.util.Map" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String path=request.getContextPath(); 
String basePath=request.getScheme()
    + "://" + request.getServerName() + ":" + request.getServerPort() + path;
  Map map = (Map)request.getSession().getAttribute(request.getSession().getId());
  
  String count = "0";
  if (null != map)
  {
  	count = (String)map.get("COUNT");
  }
%>

<script src="js/jquery3.3.7.js"></script>
<style type="text/css">
ul, li
{
margin: 0;
padding: 0;
}
#scrollDiv
{
width: 300px;
height: 35px;
line-height: 25px;

overflow: hidden;
}
#scrollDiv li
{
height: 25px;
padding-left: 10px;
}


#scrollDiv li a
{
	display:block;
	font-size:0.9em;
	padding:8px 15px;
    color: #9C9C9C;
    font-family: 'ambleregular';
    margin:0 20px;
    background:url(../images/drop_arrow.png) no-repeat 0;
    border-bottom: 1px solid #EEE;
    text-transform:uppercase;	
}
#scrollDiv li a:hover
{
	color:#B81D22;
}

</style>
<script type="text/javascript">

function forwordUrl(url)
{
	var username = "${username}";
	var base = "<%=basePath%>";
	
	var url = base + url + "?username=" + username;
	
	location.href = url;
}

function submitCheck()
{
	var condition = $("#condition").val();
	
	if (condition == null || condition == "")
	{
		return false;
	}
}

function AutoScroll(obj) 
{
    $(obj).find("ul:first").animate({
        marginTop: "-25px"
    },
    500,
    function() {
        $(this).css({
            marginTop: "0px"
        }).find("li:first").appendTo(this);
    });
}

	
    var myar = setInterval('AutoScroll("#scrollDiv")', 1000);
    $("#scrollDiv").hover(function() {
        clearInterval(myar);
    },
    function() {
        myar = setInterval('AutoScroll("#scrollDiv")', 2000);
    }); //当鼠标放上去的时候，滚动停止，鼠标离开的时候滚动开始
    
    var menuColor = $("#menuColor").val();
    $("#"+menuColor).addClass("active");

});

</script>

<div class="headertop_desc">
    <div class="call">
        <p>
            <span>
                需要帮助? 联系我们
            </span>
            <span class="number">
                QQ:123456
            </span>
        </p>
    </div>
    <div class="account_desc">
    		
        <div id="noLogin" style="display: block">
            <ul>
                <li>
                    <a href="javascript:forwordUrl('/addUserPage');">
                        注册
                    </a>
                </li>
                <li>
                    <a href="javascript:forwordUrl('/toLogin');">
                        登陆
                    </a>
                </li>
                <li>
                    <a href="javascript:forwordUrl('/mySubscription');">
                        我的订单
                    </a>
                </li>
                <li>
                    <a href="javascript:forwordUrl('/shoppingCar');">
                        购物车<font style="color:red">(<label id="copCount1"><%=count%></label>)</font>
                    </a>
                </li>
            </ul>
        </div>
        <div id="logined" style="display: none">
            <ul>
            		
                <li>
                    <a href="javascript:forwordUrl('/myAccount');">
                        ${username}
                    </a>
                </li>
                <li>
                    <a href="javascript:forwordUrl('/loginOut');">
                        退出
                    </a>
                </li>
                <li>
                    <a href="javascript:forwordUrl('/mySubscription');">
                        我的订单
                    </a>
                </li>
                <li>
                    <a href="javascript:forwordUrl('/shoppingCar');">
                        购物车<font style="color:red">(<label id="copCount2"><%=count%></label>)</font>
                    </a>
                </li>
            </ul>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="header_top">
        <div class="logo">
            <a href="javascript:forwordUrl('/index');">
                <img src="images/logo.png" alt="" />
            </a>
        </div>
        <div class="cart">
            <!-- 公告开始 -->
            <div id="scrollDiv">
                <ul id="printUL">
            		    
					
                    
                </ul>
            </div>
            <!-- 公告结束 -->
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="header_bottom">
        <div class="menu">
            <ul>
                <li id="index">
                    <a href="javascript:forwordUrl('/index');">
                        首页
                    </a>
                </li>
                <li id="about">
                    <a id="aboutA" href="javascript:forwordUrl('/about');">
                        关于我们
                    </a>
                </li>
                <li id="delivery">
                    <a href="javascript:forwordUrl('/delivery');">
                        书籍发货
                    </a>
                </li>
                <li id="news">
                    <a href="javascript:forwordUrl('/news');">
                        新闻
                    </a>
                </li>
                <li id="contact">
                    <a href="javascript:forwordUrl('/contact');">
                        联系我们
                    </a>
                </li>
            </ul>
        </div>
        <div class="search_box">
            <form method="post" action="<%=basePath%>/searchProduct?username=${username}"
            onsubmit="return submitCheck();">
                <input id="condition" name="condition" type="text" value="JAVA疯狂讲义" onfocus="this.value = '';"
                onblur="if (this.value == '') {this.value = 'JAVA疯狂讲义';}">
                <input id="searchSub" type="submit" value="">
            </form>
        </div>
        <div class="clear">
        </div>
    </div>
</div>