<%@ page language="java" pageEncoding="UTF-8"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
            + request.getServerName() + ":" + request.getServerPort()  
            + path;  
%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <script type="text/javascript" src="../Js/jquery.js"></script>
    <script type="text/javascript" src="../Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="../Js/bootstrap.js"></script>
    <script type="text/javascript" src="../Js/ckform.js"></script>
    <script type="text/javascript" src="../Js/common.js"></script>

    <style type="text/css">
        body {
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }


    </style>
</head>
<body>
<form action="index.html" method="post" class="definewidth m20">
<table class="table table-bordered table-hover m10">
    <tr>
        <td width="10%" class="tableleft">ä¸çº§</td>
        <td>
            <select name="parentid">
            <option value="0">ä¸çº§èå</option><option value='1'   />&nbsp;ç³»ç»ç®¡ç</option><option value='7'   />&nbsp;æä¿¡çç®¡ç</option>            </select>
        </td>
    </tr>
    <tr>
        <td class="tableleft">åç§°</td>
        <td><input type="text" name="name"/></td>
    </tr>
    <tr>
        <td class="tableleft">Group</td>
        <td><input type="text" name="group"/></td>
    </tr>
    <tr>
        <td class="tableleft">Model</td>
        <td><input type="text" name="module"/></td>
    </tr>
    <tr>
        <td class="tableleft">Action</td>
        <td><input type="text" name="action"/></td>
    </tr>
    <tr>
        <td class="tableleft">å¤æ³¨</td>
        <td><input type="text" name="remark"/></td>
    </tr>
    <tr>
        <td class="tableleft">ç¶æ</td>
        <td>
            <input type="radio" name="status" value="0" checked/> å¯ç¨
            <input type="radio" name="status" value="1"/> ç¦ç¨
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="submit" class="btn btn-primary" type="button">ä¿å­</button> &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">è¿ååè¡¨</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>
    $(function () {       
		$('#backid').click(function(){
				window.location.href="index.html";
		 });

    });
</script>