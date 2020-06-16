<%@ page language="java" pageEncoding="UTF-8" %>
<% 
String path=request.getContextPath(); 
String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML>
<html>
<head>
<title>产品评价</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script> 
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
<link href="css/easy-responsive-tabs.css" rel="stylesheet" type="text/css" media="all"/>
<link href="css/productShow.css" rel="stylesheet" type="text/css" media="all"/>
<link rel="stylesheet" href="css/myCommon.css">
<link rel="stylesheet" href="css/global.css">
<script src="js/slides.min.jquery.js"></script>
<script type="text/javascript" src="js/CommonUtils.js"></script>
<script>
		$(function()
		{
			$('#products').slides({
				preload: true,
				preloadImage: 'img/loading.gif',
				effect: 'slide, fade',
				crossfade: true,
				slideSpeed: 350,
				fadeSpeed: 500,
				generateNextPrev: true,
				generatePagination: false
			});

			var content1 = "${productDetail.detailContent}";
			
			$("#productDetailDiv").html(content1);
			
			// 库存
			var stock = "${productDetail.stock}";
			
			if (stock == 0)
			{
				$("#buyCount").val(0);
			}
			
		});

			function DropDown(el) {
				this.dd = el;
				this.initEvents();
			}
			DropDown.prototype = {
				initEvents : function() {
					var obj = this;

					obj.dd.on('click', function(event){
						$(this).toggleClass('active');
						event.stopPropagation();
					});	
				}
			}

			$(function() 
			{

				initLogin("${username}");

				var dd = new DropDown( $('#dd') );

				$(document).click(function() {
					// all dropdowns
					$('.wrapper-dropdown-2').removeClass('active');
				});
				
				// 限制数量只能输入数字
				$("#buyCount").keyup(function()
				{     
					  var stock = "${productDetail.stock}";
				
				      var tmptxt=$(this).val();   
				      
				      if (tmptxt == 0 || tmptxt == '0' || tmptxt == '')
				      {
				      	$(this).val('1');     
				      }
				      else if (tmptxt > stock)
				      {
				      	$(this).val(stock);
				      }				      
				      else
				      {
				      	$(this).val(tmptxt.replace(/\D/g,''));     
				      }
				         
				   }).bind("paste",function(){      
				        var tmptxt=$(this).val(); 
				        
				      if (tmptxt == 0 || tmptxt == '0' || tmptxt == '')
				      {
				      	$(this).val('1');
				      }
				      else if (tmptxt > stock)
				      {
				      	$(this).val(stock);
				      }
				      else
				      {
				      	$(this).val(tmptxt.replace(/\D/g,''));         
				      }
     
				   }).css("ime-mode", "disabled"); 
				   
				// 点击增加1
				$("#mui-amount-increase").click(function() 
				{
					var stock = "${productDetail.stock}";
					var currentCount = parseInt($("#buyCount").val()) + 1;
					
					if (stock <= currentCount)
					{
						$("#buyCount").val(stock);
					}
					else
					{
						$("#buyCount").val(currentCount);
					}					
				});
				// 点击减少1
				$("#mui-amount-decrease").click(function() 
				{
					var stock = "${productDetail.stock}";
					if (stock <= currentCount)
					{
						$("#buyCount").val(stock);
						return;
					}
				
					// 0不能减了
					var currentCount = $("#buyCount").val();
					if (currentCount == 1 || currentCount == 0)
					{
						return;
					}
					var nextCount = parseInt(currentCount) - 1;
					$("#buyCount").val(nextCount);
				});
				
			});	
			
	function toBuy()
	{
			var stock = "${productDetail.stock}";
			if (stock == 0)
			{
				alert('没有库存了');
				return;
			}
		    var count = $("#buyCount").val();
			var url = "<%=basePath%>/toSubscribe?productId=${productDetail.productId}&buyCount=" + count + "&username=${username}";
			location.href = url;
	}
	
	function addToCup()
	{
			var stock = "${productDetail.stock}";
			if (stock == 0)
			{
				alert('没有库存了');
				return;
			}
		
		
			var bookCount = $("#buyCount").val();
			var url = "<%=basePath%>/addToCup?productId=${productDetail.productId}&bookCount=" + bookCount + "&username=${username}";
			$.post(url, 
			{
			},
			function(result) 
			{
				if (result == "-1")
				{
					alert("加入购物车失败，请从新操作!");
					return;
				}
				else
				{
					alert('添加成功');
					$("#copCount1").text(result);
					$("#copCount2").text(result);
				}
			},"text");
	}
	
function abc()	
{
	var comment = $("#commentText").val();
	
	if (comment == null || comment == "")
	{
		alert("评价不能为空");
		return false;
	}
	
	if (comment.length > 500)
	{
		alert("内容过长，最多输入500个字符");
		return false;
	}
}
	
	</script>

<script type="text/javascript">
    $(document).ready(function () 
    {
        $('#horizontalTab').easyResponsiveTabs({
            type: 'default', //Types: default, vertical, accordion           
            width: 'auto', //auto or any width like 600px
            fit: true   // 100% fit in a container
        });
    });
</script>
	
</head>
<body>
    <input type="hidden" id="menuColor" value="index" />
    <div class="wrap">
        <div class="header">
            <jsp:include page="topCommon.jsp"></jsp:include>
        </div>
        <div class="main">
            <div class="content">
                <div class="content_top">
                    <div class="back-links common">
                            <a href="index.html">首页</a>&nbsp;&gt;&nbsp;<a href="#">${category}</a>&nbsp;&gt;&nbsp;
                            <a href="#">${productDetail.productName}</a>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="section group">
                    <div class="cont-desc span_1_of_2">
                        <div class="product-details">
                            <div class="grid productDetailImg">
                            
                            	<img src='userimages/${productDetail.iconUrl}' />
                            </div>
                            <div class="desc bookDetailShow">
                                <h2>
                                    ${productDetail.productName}
                                </h2>
	                            <h3>
	                            ${productDetail.description}
	                            </h3>
										
                                <div class="price">
                                    <p class="priceP">
                                        <label>瑾 晨 价:</label>
                                        <span>
                                            &yen;${productDetail.price}
                                        </span>
                                        <label id="vipPrice">( VIP 8.0折 )</label>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <label>定    价:</label>
                                        <label id="marketPrice">
                                        	&yen;${productDetail.marketPrice}
                                        </label>
                                    </p>
                                </div>
                                <div class="productInfo">
                                    <ul>
                                        <li>
      										<label>作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;者</label>&nbsp;&nbsp;&nbsp;&nbsp;<label>${productDetail.author}</label>
                                        </li>
                                        <li>
      										<label>出 &nbsp;版&nbsp; 社</label>&nbsp;&nbsp;&nbsp;&nbsp;<label>${productDetail.press}</label>
                                        </li>                                        
                                        <li>
                                        	<label>出版时间 &nbsp;&nbsp;&nbsp;&nbsp; ${productDetail.publicationTime}</label>
                                        </li>
                                        <li>
                                          <label>所属分类 &nbsp;&nbsp;&nbsp;&nbsp; ${category}</label>
                                        </li>
                                        <li style="margin-top:30px">
                                        	<h2>
                                        		<label>销量</label>
                                        		&nbsp;&nbsp;&nbsp;&nbsp;<label id="salesvolume">${productDetail.salesvolume}</label>
                                        		<label>&nbsp;件</label>
                                        		
                                        	</h2>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                    <div class="your-review">
				  	 <h3>添加评价</h3>
						<form method="post" action="<%=basePath%>/addProductComment?username=${username}" onsubmit="return abc();">
							<input type="hidden" name="productId" id="productId" value="${productDetail.productId}" />
							<input type="hidden" name="subscriptionId" id="subscriptionId" value="${subscriptionId}" />
						    <div>
						    	<span><label>内容(最多500个字符)<span class="red">*</span></label></span>
						    	<span><textarea id="commentText" name="commentText"></textarea></span>
						    </div>
						   <div>
						   		<span><input type="submit" value="提交"></span>
						  </div>
					    </form>
				  	 </div>	
                        
                        
                    </div>
                    <div class="rightsidebar span_3_of_1">
                        <h2>
                            分类
                        </h2>
                        <ul>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=1&username=${username}">
                游戏
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=2&username=${username}">
                操作系统
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=3&username=${username}">
                数据库
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=4&username=${username}">
                图形图像
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=5&username=${username}">
                多媒体
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=6&username=${username}">
                网络与通信
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=7&username=${username}">
                软件程序设计
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=8&username=${username}">
                硬件维护
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=9&username=${username}">
                教材
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=10&username=${username}">
                考试认证
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=11&username=${username}">
                电子电气
            </a>
        </li>
        <li>
            <a href="<%=basePath%>/searchProduct?categroyId=12&username=${username}">
                工具书软件
            </a>
        </li>
                        </ul>
                        <div class="subscribe">
                            <h2>
                                问卷调查
                            </h2>
                        </div>
                        <div class="community-poll">
                            <h2>
                            </h2>
                            <p>
                                什么是你主要在线购买产品的原因？
                            </p>
                            <div class="poll">
                                <form>
                                    <ul>
                                        <li>
                                            <input type="radio" name="vote" class="radio" value="1">
                                            <span class="label">
                                                <label>
                                                    更方便的运输和支付
                                                </label>
                                            </span>
                                        </li>
                                        <li>
                                            <input type="radio" name="vote" class="radio" value="2">
                                            <span class="label">
                                                <label for="vote_2">
                                                    价格低廉
                                                </label>
                                            </span>
                                        </li>
                                        <li>
                                            <input type="radio" name="vote" class="radio" value="3">
                                            <span class="label">
                                                <label for="vote_3">
                                                    更多的选择
                                                </label>
                                            </span>
                                        </li>
                                        <li>
                                            <input type="radio" name="vote" class="radio" value="5">
                                            <span class="label">
                                                <label for="vote_5">
                                                    支付安全
                                                </label>
                                            </span>
                                        </li>
                                        <li>
                                            <input type="radio" name="vote" class="radio" value="6">
                                            <span class="label">
                                                <label for="vote_6">
                                                    30天退款保证
                                                </label>
                                            </span>
                                        </li>
                                        <li>
                                            <input type="radio" name="vote" class="radio" value="7">
                                            <span class="label">
                                                <label for="vote_7">
                                                    其他
                                                </label>
                                            </span>
                                        </li>
                                    </ul>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="bottomCommon.jsp"></jsp:include>
</body>

</html>