<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
String path=request.getContextPath(); 
String basePath=request.getScheme()
    + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>
            瑾晨书店-地址管理
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/myStyle.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/slider.css" rel="stylesheet" type="text/css" media="all"/>
        <script type="text/javascript" src="js/jquery-1.7.2.min.js">
        </script>
        <script type="text/javascript" src="js/move-top.js">
        </script>
        <script type="text/javascript" src="js/easing.js">
        </script>
        <script type="text/javascript" src="js/startstop-slider.js">
        </script>
        <script type="text/javascript" src="js/CommonUtils.js">
        </script>
        <script type="text/javascript">
            function DropDown(el) {
                this.dd = el;
                this.initEvents();
            }
            DropDown.prototype = {
                initEvents: function() {
                    var obj = this;

                    obj.dd.on('click',
                    function(event) {
                        $(this).toggleClass('active');
                        event.stopPropagation();
                    });
                }
            }

			function delAddress(addressId)
			{
				if(confirm("确定要删除吗？"))
				{
					var url = "<%=basePath%>/deleteAddress?addressId=" + addressId + "&username=${username}";
					
					location.href = url;
				}
			}
			
            $(function() {

				initLogin("${username}");
				
                var dd = new DropDown($('#dd'));

                $(document).click(function() {
                    // all dropdowns
                    $('.wrapper-dropdown-2').removeClass('active');
                });

                $("#toAddAddress").click(function() 
                {
					forwordUrl("/toAddAddress");
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
        <div class="header_slide">
            <div class="header_bottom_left">
                <div class="categories">
                    <ul>
                        <h3>
                            我的账号
                        </h3>
                        <li>
                            <a href="javascript:forwordUrl('/userInfoDetail');">
                                基本信息
                            </a>
                        </li>
                        <li>
                            <a href="javascript:forwordUrl('/toResetPassword');">
                                修改密码
                            </a>
                        </li>
                        <li>
                            <a href="javascript:forwordUrl('/toAddressManage');">
                                收货地址
                            </a>
                        </li>
                        <li>
                            <a href="javascript:forwordUrl('/toVip');">
                                vip
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="header_bottom_right">
                <div class="slider">
                    <div id="slider">
                        <div class="col span_2_of_3">
                            <div>
                                <div class="addressSubmit">
                                    <input id="toAddAddress" type="submit" value="添加地址" class="addressSubmit">
                                    <br/>
                                    <br/>
                                </div>
                                <div class="form-userinfo">
                                    <table class="tablecenter table-bordered definewidth m10">
                                        <thead>
                                            <tr>
                                                <th>
                                                    地址
                                                </th>
                                                <th>
                                                    默认地址
                                                </th>                                                
                                                <th>
                                                    操作
                                                </th>
                                            </tr>
                                        </thead>
                                        <c:choose>
                                            <c:when test="${empty addressList}">
                                                <tr>
                                                    <td align="center" colspan="3">
                                                        没有符合条件的数据
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${addressList}" var="address">
                                                    <tr>
                                                        <td>
                                                            ${address.address}
                                                        </td>
                                                        <td>
	                                                        <c:choose>
	                                                       	<c:when test="${address.defaultAddress == 1}">
	                                                       		是
	                                                       	</c:when>
	                                                       	<c:otherwise>
	                                                       		否
	                                                       	</c:otherwise>
	                                                        </c:choose>
                                                        </td>                                                        
                                                        <td>
                                                            <a href="<%=basePath%>/toModifyAddress?addressId=${address.addressId}&userId=${address.userId}&username=${username}">
                                                                修改
                                                            </a>
                                                            <a href="javascript:delAddress('${address.addressId}');">
                                                                删除
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
    <jsp:include page="bottomCommon.jsp"></jsp:include>
</body>

</html>