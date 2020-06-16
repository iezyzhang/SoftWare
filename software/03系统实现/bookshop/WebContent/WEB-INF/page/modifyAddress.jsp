<%@ page language="java" pageEncoding="UTF-8" %>
<% 
String path=request.getContextPath(); 
String basePath=request.getScheme()
    + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML>
<html>
    
    <head>
        <title>
            瑾晨书店-修改地址
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/slider.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/myStyle.css" rel="stylesheet" type="text/css" media="all"/>
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
            function DropDown(el) 
            {
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

            $(function() {

				// 所有提示文字隐藏
				$("#addressError").hide();
				
				initLogin("${username}");
				
                var dd = new DropDown($('#dd'));

                $(document).click(function() {
                    // all dropdowns
                    $('.wrapper-dropdown-2').removeClass('active');
                });
                
                var defaultAddress = "${defaultAddress}";
				
				if (defaultAddress == 1)
				{
					$("#defaultAddress1").attr("checked",'checked');
				}
				else
				{
					$("#defaultAddress2").attr("checked",'checked');
				}				
            });
            
	// 提交校验，若校验失败，则不能提交
	function submitCheck()
	{
		var address = $("#address").val();
		
		if (null == address || address == "")
		{
			$("#addressError").show();
			return false;
		}
		else
		{
			$("#addressError").hide();
		}
	};
	
 	$(function()
 	{
		$("#reset").click(function()
		{
			$("#addressError").hide();
		});
		
		 		// 默认地址
		$('input[name="defaultAddressR"]').change(function()
		{
				// 获取
				$("#defaultAddress").val($(this).val());
		});
	});
        </script>
    </head>
    
    <body>
    <input type="hidden" id="menuColor" value="index"/>
        <div class="wrap">
            <div class="header">

				<jsp:include page="topCommon.jsp"></jsp:include>
				
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
		                         <div class="form-userinfo">
		                            <h2>
		                                	修改收货地址
		                            </h2>
		                            <form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/modifyAddress?addressId=${addressId}&userId=${userId}&username=${username}"  onsubmit="return submitCheck();">
                                    <div>
                                        <span>
                                            <label>
                                                默认地址:
                                            </label>
                                        </span>
                                        <span>
                                            <input id="defaultAddress1" name="defaultAddressR" type="radio" class="textbox" value="1"/>是
                                            <input id="defaultAddress2" name="defaultAddressR" type="radio" class="textbox" value="0"/>否
                                            <input id="defaultAddress" name="defaultAddress" type="hidden" value="${defaultAddress}"/>
                                        </span>
                                    </div>		                                
		                                
		                                <div>
		                                    <span>
		                                        <label>
		                                            地址信息:
		                                        </label>
		                                        <label id="addressError">
		                                            <font color="red">地址不能为空</font>
		                                        </label>		                                        
		                                    </span>
		                                    <span>
		                                        <input id="address" name="address" type="text" class="textbox" value="${address}">
		                                    </span>
		                                </div>
		                                <div>
		                                    <span>
		                                        <input id="reset" type="reset" value="重置" class="myButton">
		                                        <input id="submit" type="submit" value="提交" class="myButton">
		                                    </span>
		                                    <span>
		                                        
		                                    </span>
		                                </div>
		                            </form>
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