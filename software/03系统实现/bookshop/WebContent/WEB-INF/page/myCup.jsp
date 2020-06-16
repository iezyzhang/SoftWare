<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
String path=request.getContextPath(); 
String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML>
<html>
<head>
<title>我的购物车</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
<link href="css/easy-responsive-tabs.css" rel="stylesheet" type="text/css" media="all"/>
<link href="css/productShow.css" rel="stylesheet" type="text/css" media="all"/>
<link rel="stylesheet" href="css/myCommon.css">
<link rel="stylesheet" href="css/global.css">
<link href="css/myStyle.css" rel="stylesheet" type="text/css" media="all"/>
<link href="css/slider.css" rel="stylesheet" type="text/css" media="all"/>


<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script> 
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
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

			$(function() {

				var dd = new DropDown( $('#dd') );

				initLogin("${username}");

				$(document).click(function() {
					// all dropdowns
					$('.wrapper-dropdown-2').removeClass('active');
				});
				
				setTotal();
				
				// 限制数量只能输入数字
				$("input[name=currentCount]").keyup(function()
				{     
				      var tmptxt=$(this).val();   
				      
				      if (tmptxt < 1 ||  tmptxt < '1')
				      {
				      	$(this).val('1');
				      }
				      else
				      {
				      	$(this).val(tmptxt.replace(/\D/g,'1'));
				      }
				      setTotal();
				         
				   }).bind("paste",function()
				   {
				   
				      var tmptxt=$(this).val(); 
				        
				      if (tmptxt < 1 ||  tmptxt < '1')
				      {
				      	$(this).val('1');
				      }
				      else
				      {
				      	$(this).val(tmptxt.replace(/\D/g,'1'));         
				      }
				      setTotal();
				   }).css("ime-mode", "disabled"); 
				   
				// 点击增加1
				$(".J_Plus").click(function()
				{
				
					var t=$(this).parent().find('input[class=text-amount]');
					t.val(parseInt(t.val())+1);
					setTotal();		
				});
				// 点击减少1
				$(".J_Minus").click(function() 
				{
					var t=$(this).parent().find('input[class=text-amount]'); 
					t.val(parseInt(t.val())-1);
					if(parseInt(t.val())<= 0)
					{ 
						t.val(1);
					} 
					setTotal();
				});
				
			function setTotal()
			{ 
				var s = 0;
				$("#myCupTable tr[class=row-info]").each(function()
				{ 
				    var amout = $(this).find('input[class=text-amount]');
				    var price = $(this).find('span[class=price]');
					if (null != amout && price != null)
					{
						var lineTotal = parseInt(amout.val()) * parseFloat(price.text());
						var totalPriceTd = $(this).find('td[class=productTotalPrice]');
						totalPriceTd.find('label[class=myCupPrice]').text(lineTotal.toFixed(1));
						
						s += lineTotal;
					}
				});
				
				$("#myCupTotalPrice").text(s.toFixed(1));
			} 
				
			});
			
		   function submit()
		   {
		   	    // 构造json字符串
		   		var jsonArr = "";
		   		var i = 0;
				$("#myCupTable tr[class=row-info]").each(function()
				{ 
					var productId = $(this).find('input[class=productIdClass]').val();
				    var amout = $(this).find('input[class=text-amount]').val();
				    var param = productId + "," + amout;
				    jsonArr = jsonArr + param + "|";
				    i = i + 1;
				});
				
				if (i == 0)
				{
					alert("购物车里还没有商品，快去挑选吧！");
					location.href = "<%=basePath%>/searchProduct?username=${username}";
				}
				else
				{
					// 跳转
					var url = "<%=basePath%>/cupCount?jsonArr=" + jsonArr +"&username=${username}";
					location.href = url;
				}
		   }
			
			
	function deleteCup(productId, cupCount)
	{
		if(confirm("确定删除?"))
		{
			var url = "<%=basePath%>/deleteCup?productId=" + productId + "&cupCount=" + cupCount +"&username=${username}";
			location.href = url;
		}
	}
	
	function clearCup()
	{
		if(confirm("确定清空?"))
		{
			var url = "<%=basePath%>/clearCup?username=${username}";
			location.href = url;
		}
	}

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
<form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/submitSubscribe?productId=${productDetail.productId}&totalCount=${totalCount}&totalPrice=${totalPrice}&username=${username}">

						<div style="margin-top:20px" id="makeSureDiv">
						<h1 style="font-size: 14px;color: #333;font-weight: 700;">购物车</h1>

                                    <table id="myCupTable" class="tablecenter makeSureTable">
                                        <thead>
                                            <tr>
                                                <th>
                                                </th>
                                                <th>
                                                    作者
                                                </th>                                                
                                                <th>
                                                    单价（元）
                                                </th>
                                                <th>
                                                     数量
                                                </th>
                                                <th>
                                                     金额（元）
                                                </th>                                                
												<th>
                                                    操作
                                                </th>
                                            </tr>
                                        </thead>
                                        
								<c:forEach items="${cupProductList}" var="productDetail">                                        
                                        
										<tr class="row-border">
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										</tr>                                        
										<tr class="row-info">
	                                        <td>
	                                            <a href="<%=basePath%>/productDetail?productId=${productDetail.productId}&username=${username}"
	                                            target="_blank">
	                                                <img src='userimages/${productDetail.iconUrl}' style="width: 50px;display: block;height: 50px;"/>
	                                            </a>
		                                           <a href="<%=basePath%>/productDetail?productId=${productDetail.productId}&username=${username}"
		                                                                  target="_blank" title="${productDetail.productName}">
		                                                                      <font style="font-size: 1.5em;">${productDetail.productName}</font>
		                                           </a>
		                                           <input class="productIdClass" type="hidden" value="${productDetail.productId}"/>
	                                        </td>
	                                        <td>
	                                         ${productDetail.author}
	                                         <br /><br /><br /><br />
	                                        </td>
	                                        <td>
							                    <span class="price">
							                        <font style="font-size:13px;font-family: Arial;color:#f40;">
							                        <label class="myCupPrice">${productDetail.price}</label>
							                        </font>
							                    </span>	                                        
	                                        <br />
	                                        </td>
	                                        <td align="center">
												<div class="item-amount">
												<a href="#" class="J_Minus">-</a>
												<input name="currentCount" type="text" value="${productDetail.cupCount}" class="text-amount" maxlength="8">
												<a href="#" class="J_Plus">+</a>
												</div>
	                                        <br />
	                                        </td>
	                                        <td align="center" class="productTotalPrice">
							                    <span>
							                        <font style="font-size:13px;font-family: Arial;color:#f40;">
							                        <label class="myCupPrice">${productDetail.price}</label>
							                        </font>
							                    </span>	                                        
	                                        <br />
	                                        </td>	                                        
	                                        <td>
	                                        	<a name="deleteCup" href="javascript:deleteCup('${productDetail.productId}','${productDetail.cupCount}');"><font style="font-size: 1.5em;">删除</font></a>
	                                        <br />
	                                        </td>                             	                                        	                                        	                                        	                                        	                                        	                                        
                                        </tr>
                            </c:forEach>
										<tr class="row-foot">
	                                        <td class="tube-count"  colspan="6">
	                                        <br />
	                                        店铺合计(含运费): <font style="font-family: Arial;font-size:22px;color:#f40;">
	                                        ¥<label id="myCupTotalPrice" class="myCupPrice">${totalPrice}</label>
	                                        </font>
	                                        <br />
	                                        <br />
	                                        </td>	                                        	                                        	                                        	                                        	                                        	                                        	                                        
                                        </tr>
                                    </table>
						</div>
                        <div>
                            <ul>
                                <li class="compare">
                                    <a rel="nofollow" id=submitSubscribe href="javascript:submit();">
										<i>
										</i>去结算
                                    </a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <a rel="nofollow" id="clearCup" href="javascript:clearCup();">
										<i>
										</i>清空
                                    </a>                                    
                                </li>
                            </ul>
                            <br/>
                            <br/>
                            <br/>
                        </div>
</form>
						
                    </div>
                    <div class="clear">
                    </div>
                </div>
                
            </div>
        </div>
    </div>
    <jsp:include page="bottomCommon.jsp"></jsp:include>
</body>

</html>