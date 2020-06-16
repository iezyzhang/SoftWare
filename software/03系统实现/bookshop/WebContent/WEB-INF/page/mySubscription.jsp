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
		   		var addressId = $("input[name='chooseAddress']:checked").val();
		   		$("#address").val(address);
		   		$("#submitForm").submit();
		   }
			
		   function toCofirm(a,b,c){
			   var r=confirm("您确定收货吗？")
               
			   if (r==true)
			     {
				   $.ajax(
				            {
				                url: "<%=basePath%>/backstage_acceptGoods",
				                type: "get",
				                dataType: "json",
				                data: {"productId":a,"subscriptionId":b,"changeStatus":c},
				                success: function (result) {
				                    if(result=='1'){
				                    	location.reload();
				                    }else{
				                    		alert("false");
				                    }
				                   
				                },
				                error: function (xhr, status, p3, p4) {
				                  
				                    alert("false");
				                }
				            });
				
			     	return true;
			     }
			  	 else
			     {
			    		return false;
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
						<h1 style="font-size: 14px;color: #333;font-weight: 700;">我的订单</h1>
                                    <table class="tablecenter makeSureTable">
                                        <thead>
                                            <tr>
                                                <th>
                                                </th>
                                                <th>
                                                   单价（元）
                                                </th>                                                
                                                <th>
                                                    数量
                                                </th>
                                                <th>
                                                    操作
                                                </th> 
												<th>
                                                    实付款
                                                </th>
                                                <th>
                                                     订单状态
                                                </th>
                                                <th>
                                                    确认收货
                                                </th> 
                                            </tr>
                                        </thead>
                                        
                                     <c:forEach items="${subList}" var="subDetail">
										<tr class="row-border">
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										</tr>                                        
										<tr class="row-info">
	                                        <td>
	                                            <a href="<%=basePath%>/productDetail?productId=${subDetail.productId}&username=${username}"
	                                            target="_blank">
	                                                <img src='userimages/${subDetail.iconUrl}' style="width: 50px;display: block;height: 50px;"/>
	                                            </a>
		                                           <a href="<%=basePath%>/productDetail?productId=${subDetail.productId}&username=${username}"
		                                                                  target="_blank" title="${subDetail.productName}">
		                                                                      <font style="font-size: 1.5em;">${subDetail.productName}</font>
		                                           </a>
	                                        </td>
	                                        <td>
	                                        ${subDetail.price} &nbsp;
	                                        <label id="marketPrice">
	                                        	&yen;${subDetail.marketPrice}
	                                        </label>	                                        
	                                        <br />
	                                        </td>	                                        
	                                        <td>
	                                         ${subDetail.totalCount}
	                                         <br /><br /><br /><br />
	                                        </td>
	                                        <td>
	                                      
	                                         <a href="#"><font style="font-size: 1.3em;">退款/退货</font></a>
	                                        
	                                        
	                                        <br />
	                                        </td>
	                                        
	                                        <td>
	                                        ${subDetail.totalPrice}
	                                       
	                                        <br />
	                                        </td>
	                                        
	                                        <td>
	                                        <font style="color:#f40;">${subDetail.statusString}</font>
	                                        <br />
	                                        </td>
	                                        <td>
	                                        	<c:choose>
	                                        		<c:when test="${subDetail.status < 3 }">
	                                        			未发货
	                                        		</c:when>
	                                        		<c:when test="${subDetail.status == 5}">
	                                        			<a id="makeSureRecive" target="_blank" href="<%=basePath%>/toAddComment?productId=${subDetail.productId}&subscriptionId=${subDetail.subscriptionId}&username=${username}"><font style="font-size: 1.3em;">评价</font></a>
	                                        		</c:when>
	                                        		<c:when test="${subDetail.status == 6}">
	                                        			已评价
	                                        		</c:when>	                                        		
	                                        		<c:otherwise>
														<a id="makeSureRecive"  href="#" onclick="return toCofirm('${subDetail.productId}','${subDetail.subscriptionId}','5')"><font style="font-size: 1.3em;" >确认收货</font></a>	                                        	
	                                        		</c:otherwise>
	                                        	</c:choose>
	                                        </td>	                                        
                                        </tr>
										<tr class="row-foot">
	                                        <td class="tube-annex" colspan="2">
	                                        <br />
	                                        给卖家留言：${subDetail.message}
	                                        <label></label>
	                                        </td>
	                                        <td class="tube-annex" colspan="2">
	                                        <br />
	                                        订单号：
	                                        <br />
	                                        </td>
	                                        <td class="tube-annex" colspan="1">
	                                        <br />
	                                        ${subDetail.subscriptionId}
	                                        <br />
	                                        </td>	                                        
	                                        <td class="tube-count"  colspan="2">
	                                        <br />
	                                        店铺合计(含运费): ¥${subDetail.totalPrice}
	                                        <br />
	                                        <br />
	                                        </td>	                                        	                                        	                                        	                                        	                                        	                                        	                                        
                                        </tr>                                        
                                     </c:forEach>
                                     
                                        

                                    </table>
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