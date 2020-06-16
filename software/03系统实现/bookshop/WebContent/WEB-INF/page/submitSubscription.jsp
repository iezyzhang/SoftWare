<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
String path=request.getContextPath(); 
String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML>
<html>
<head>
<title>我的订单</title>
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
			});
			
		   function submit()
		   {
		   		var address = $('input[name="chooseAddress"]:checked').val();
		   		
		   		// 检查收货地址
		   		if (address == null || address == '')
		   		{
		   			alert('还没有收货地址，赶紧去添加吧');
		   			var url = "<%=basePath%>/toAddressManage?username=${username}";
					location.href = url;
					return;
		   		}
		   		else
		   		{
			   		$("#address").val(address);
			   		
			   	    // 构造json字符串
			   		var jsonArr = "";
			   		var i = 0;
					$("#makeSureTable tr[class=row-info]").each(function()
					{ 
							var param = "";
							var productId = $(this).find('input[class=productIdClass]').val();
						    var amout = $(this).find('label[class=text-amount1]').html();
						    var totalPrice = $(this).find('label[class=text-amount2]').html();
						    param = productId + " " + amout + " " + totalPrice + " ";
					
					    jsonArr = jsonArr + param + " |";
					    i = i + 1;
					});
					
					// 构造json字符串
			   		var jsonArrMessage = "";
			   		var j = 0;
					$("#makeSureTable tr[class=row-foot]").each(function()
					{ 
							var message = $(this).find('input[class=messageInput]').val().trim();
					
							if ('' == message || null == message)
							{
								message = " ";
							}
					
					    	jsonArrMessage = jsonArrMessage + message + " |";
					    	i = i + 1;
					});
					
					
					if (i == 0)
					{
						alert("还没有商品，快去挑选吧！");
						location.href = "<%=basePath%>/searchProduct?username=${username}";
					}
					else
					{
						// 跳转
						var url=encodeURI( "<%=basePath%>/submitSubscribe?jsonArr=" + jsonArr +"&jsonArrMessage=" + jsonArrMessage + "&allPrice="+"${allPrice}" + "&address=" + address + "&username=${username}");
						
						location.href = url;
					}
			   		
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

						<h1 style="font-size: 14px;color: #333;font-weight: 700;">选择收货地址</h1>
						<div id="addressDiv">
				            <ul id="addressUl">
			            		<c:forEach items="${address}" var="deliveryAddress">
				                	<li>
				                		<c:choose>
				                			<c:when test="${deliveryAddress.defaultAddress == 1}">
				                				<input id="${deliveryAddress.addressId}" type="radio" name="chooseAddress" checked="checked" value="${deliveryAddress.address}"/>
				                			</c:when>
				                			<c:otherwise>
				                				<input id="${deliveryAddress.addressId}" type="radio" name="chooseAddress" value="${deliveryAddress.address}"/>
				                			</c:otherwise>
				                		</c:choose>
				                		${deliveryAddress.address}
					                </li>
			                	</c:forEach>
				            </ul>
				            <input type="hidden" id="address" name="address"/>
						</div>
						<div style="margin-top:20px" id="makeSureDiv">
						<h1 style="font-size: 14px;color: #333;font-weight: 700;">确认订单信息</h1>

                                    <table id="makeSureTable" class="tablecenter makeSureTable">
                                        <thead>
                                            <tr>
                                                <th>
                                                </th>
                                                <th>
                                                    作者
                                                </th>                                                
                                                <th>
                                                    出版社
                                                </th>
                                                <th>
                                                    单价（元）
                                                </th> 
												<th>
                                                    会员优惠（元）
                                                </th>
                                                <th>
                                                     数量
                                                </th>
                                                <th>
                                                    小计(元)
                                                </th> 
												<th>
                                                    配送方式
                                                </th>                                                
                                            </tr>
                                        </thead>
										<tr class="row-border">
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										</tr>
										
										
						<c:forEach items="${productList}" var="productDetail">										                                   
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
	                                        ${productDetail.press}
	                                        <br />
	                                        </td>
	                                        <td>
	                                        ${productDetail.price}
	                                        <br />
	                                        </td>
	                                        <td>
	                                        ${productDetail.vipPrice}
	                                        <br />
	                                        </td>
	                                        <td>
	                                        <label class="text-amount1">${productDetail.totalCount}</label>
	                                        <br />
	                                        </td>
	                                        <td>
	                                        <font style="font-weight: 700;color: #c00;"><label class="text-amount2">${productDetail.totalPrice}</label></font>
	                                        <br />
	                                        </td>
	                                        <td>
	                                            快递(免邮)
	                                        <br />
	                                        </td>	                                        	                                        	                                        	                                        	                                        	                                        	                                        
                                        </tr>
										<tr class="row-foot">
	                                        <td class="tube-annex" colspan="2">
	                                        <br />
	                                        给卖家留言：
	                                        <input class="messageInput" name="message" type="text"><br /><br />
	                                        </td>
	                                        
	                                        <td class="tube-count" colspan="3">
	                                        <br />
	                                        发票抬头：暂不支持
	                                        <br />
	                                        </td>
	                                        <td class="tube-count"  colspan="3">
	                                        <br />
	                                        店铺合计(含运费): ¥${productDetail.totalPrice}
	                                        <br />
	                                        <br />
	                                        </td>	                                        	                                        	                                        	                                        	                                        	                                        	                                        
                                        </tr>
						</c:forEach>                                                                                
                                    </table>
						</div>
						<div class="realPay">
							<p class="money">
							<font style="font-size:12px;">
								实付款：</font>
								<font style="font-family: Arial;font-size:22px;color:#f40;">
	                            ¥<label id="myCupTotalPrice" class="myCupPrice">${allPrice}</label>
	                            </font>
							</p>
						</div>						
                        <div>
                            <ul>
                                <li class="compare">
                                    <a rel="nofollow" id="submitSubscribe" href="javascript:submit();">
										<i>
										</i>提交订单
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