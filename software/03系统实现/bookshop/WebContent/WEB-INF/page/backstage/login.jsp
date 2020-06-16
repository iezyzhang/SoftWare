<%@ page language="java" pageEncoding="UTF-8"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
            + request.getServerName() + ":" + request.getServerPort()  
            + path;  
%>

<html>
<head>
<title>瑾晨书屋后台系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>

<style type="text/css">

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow:hidden;
}

</style>
<script type="text/javascript">

$(function() 
{
	// 所有提示文字隐藏
	$("#loginError").hide();
	
	$("#adminName").focus(function()
	{
		$("#loginError").hide();
	});	
	
});

function reset()
{
	$("#adminName").val("");
	$("#password").val("");
	
	$("#loginError").hide();
}

function submit()
{
	$("#submitForm").submit();
}

// 校验用户名和密码
function submitCheck()
{
		var resultCode = "";
	
		// 先去校验用户名和密码
		$.ajax(
		{
			url:"<%=basePath%>/backstage_checkAdminLoginInfo",
			adminName: $("#adminName").val(),
			data:{adminName:$("#adminName").val(),password: $("#password").val()},
			type:'POST',
			async: false,
			success: (function(data)
			{
				// 获取校验结果
				resultCode = data;
				alert(resultCode);
			}),
			error:(function(xhr)
			{
				alert('请求有问题\n'+xhr.responseText);
			})
		});
		
	  // 如果正确，直接放通	
      if(resultCode == "1")
	  {
	  	$("#loginError").hide();
	  }
	  else
	  {
	    // 如果不正确，返回false  
	  	$("#loginError").show();
	  	return false;
	  }
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

</script>
</head>

<body onLoad="MM_preloadImages('images/login_09_1.gif','images/login_10_1.gif')">

<form id="submitForm" name="submitForm" method="post" action="<%=basePath%>/backstage_login"  onsubmit="return submitCheck();">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#02395f">&nbsp;</td>
  </tr>
  <tr>
    <td height="607" align="center" background="images/login_02.gif"><table width="974" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="331" background="images/login_01.jpg">&nbsp;</td>
      </tr>
      <tr>
        <td height="116"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="393" height="116" background="images/login_05.gif">&nbsp;</td>
            <td width="174"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="81" background="images/login_06.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <label id="loginError">
                        <font style="height:1;font-size:9pt; color:red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户名或密码不正确</font>
                    </label>
                  <tr>
                    <td width="24%"><div align="center">
                    <font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">用户</font>
                    </div></td>
                    <td width="76%" height="25"><input value="admin_hebin" id="adminName" type="text" name="adminName" style="width:125px; height:20px; background:#32a2e3; font-size:12px; border:solid 1px #0468a7; color:#14649f;"></td>
                  </tr>
                  <tr>
                    <td><div align="center"><font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">密码</font></div></td>
                    <td height="25"><input value="123456" id="password" type="password" name="textfield2"  style="width:125px; height:20px; background:#32a2e3; font-size:12px; border:solid 1px #0468a7; color:#14649f;"></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="35"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="50" height="35"><img src="images/login_08.gif" width="50" height="35"></td>
                    <td width="46"><a href="javascript:submit();"><img src="images/login_09.gif" name="Image1" width="46" height="35" border="0" id="Image1" onMouseOver="MM_swapImage('Image1','','images/login_09_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                    <td width="45"><a href="javascript:reset();"><img src="images/login_10.gif" name="Image2" width="45" height="35" border="0" id="Image2" onMouseOver="MM_swapImage('Image2','','images/login_10_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                    <td width="33"><img src="images/login_11.gif" width="33" height="35"></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
            <td width="407" background="images/login_07.gif">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="160" background="images/login_12.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td bgcolor="#02609c">&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>
