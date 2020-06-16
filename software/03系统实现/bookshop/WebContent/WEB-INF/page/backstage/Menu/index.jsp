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
<form class="form-inline definewidth m20" action="index.html" method="get">
    èååç§°ï¼
    <input type="text" name="menuname" id="menuname"class="abc input-default" placeholder="" value="">&nbsp;&nbsp; 
    <button type="submit" class="btn btn-primary">æ¥è¯¢</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addnew">æ°å¢èå</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>èåæ é¢</th>
        <th>GROUP</th>
        <th>MODEL</th>
        <th>ACTION</th>
        <th>ç¶æ</th>
        <th>ç®¡çæä½</th>
    </tr>
    </thead>
	     <tr>
            <td colspan="5">ç³»ç»ç®¡ç</td>
            <td><a href="edit.html">ç¼è¾</a></td>
        </tr>
        <tr>
                <td>æºæç®¡ç</td>
                <td>Admin</td>
                <td>Merchant</td>
                <td>index</td>
                <td>0</td>
                <td><a href="edit.html">ç¼è¾</a></td>
            </tr><tr>
                <td>æéç®¡ç</td>
                <td>Admin</td>
                <td>Node</td>
                <td>index</td>
                <td>0</td>
                <td><a href="edit.html">ç¼è¾</a></td>
            </tr><tr>
                <td>è§è²ç®¡ç</td>
                <td>Admin</td>
                <td>Role</td>
                <td>index</td>
                <td>0</td>
                <td><a href="edit.html">ç¼è¾</a></td>
            </tr><tr>
                <td>ç¨æ·ç®¡ç</td>
                <td>Admin</td>
                <td>User</td>
                <td>index</td>
                <td>0</td>
                <td><a href="edit.html">ç¼è¾</a></td>
            </tr><tr>
                <td>èåç®¡ç</td>
                <td>Admin</td>
                <td>Menu</td>
                <td>index</td>
                <td>0</td>
                <td><a href="edit.html">ç¼è¾</a></td>
            </tr><tr>
            <td colspan="5">æä¿¡çç®¡ç</td>
            <td><a href="edit.html">ç¼è¾</a></td>
        </tr>
        <tr>
                <td>æ¹æ¬¡ç®¡ç</td>
                <td>Admin</td>
                <td>LabelSet</td>
                <td>index</td>
                <td>0</td>
                <td><a href="edit.html">ç¼è¾</a></td>
            </tr><tr>
                <td>æä¿¡çæ¥è¯¢</td>
                <td>Admin</td>
                <td>Label</td>
                <td>index</td>
                <td>0</td>
                <td><a href="edit.html">ç¼è¾</a></td>
            </tr><tr>
                <td>æä¿¡ççæ</td>
                <td>Admin</td>
                <td>Label</td>
                <td>apply</td>
                <td>1</td>
                <td><a href="edit.html">ç¼è¾</a></td>
            </tr></table>

</body>
</html>
<script>
    $(function () {
        

		$('#addnew').click(function(){

				window.location.href="add.html";
		 });


    });
	
</script>