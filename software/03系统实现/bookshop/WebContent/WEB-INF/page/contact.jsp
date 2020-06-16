<%@ page language="java" pageEncoding="UTF-8" %>
<% String path=request.getContextPath(); String basePath=request.getScheme()
+ "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>
        联系我们
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all"
    />
    <script type="text/javascript" src="js/jquery-1.7.2.min.js">
    </script>
    <script type="text/javascript" src="js/move-top.js">
    </script>
    <script type="text/javascript" src="js/easing.js">
    </script>
    <!--引用百度地图API-->
<style type="text/css">
    html,body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>

    <script type="text/javascript" src="js/CommonUtils.js"></script>    
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

                    $(function() 
                    {

						initLogin("${username}");
						
                        var dd = new DropDown($('#dd'));

                        $(document).click(function() {
                            // all dropdowns
                            $('.wrapper-dropdown-2').removeClass('active');
                        });

                    });
   </script>
    
</head>
<body>
 <input type="hidden" id="menuColor" value="contact"/>
    <div class="wrap">
        <div class="header">
            
        <jsp:include page="topCommon.jsp"></jsp:include>
            
        </div>
        <div class="main">
            <div class="content">
                <div class="section group">
                    <div class="col span_2_of_3">
                        <div class="contact-form">
                            <h2>
                                联系我们
                            </h2>
                            <form method="post" action="#">
                                <div>
                                    <span>
                                        <label>
                                            姓名
                                        </label>
                                    </span>
                                    <span>
                                        <input name="userName" type="text" class="textbox">
                                    </span>
                                </div>
                                <div>
                                    <span>
                                        <label>
                                            邮箱
                                        </label>
                                    </span>
                                    <span>
                                        <input name="userEmail" type="text" class="textbox">
                                    </span>
                                </div>
                                <div>
                                    <span>
                                        <label>
                                            公司名称
                                        </label>
                                    </span>
                                    <span>
                                        <input name="userPhone" type="text" class="textbox">
                                    </span>
                                </div>
                                <div>
                                    <span>
                                        <label>
                                            主题
                                        </label>
                                    </span>
                                    <span>
                                        <textarea name="userMsg">
                                        </textarea>
                                    </span>
                                </div>
                                <div>
                                    <span>
                                        <input type="submit" value="提交" class="myButton">
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col span_1_of_3">
                        <div class="contact_info">
                            <h3>
                                如何找到我们
                            </h3>
                            <!--百度地图容器-->
 						 <div style="width:300px;height:300px;border:#ccc solid 1px;" id="dituContent"></div>
                       	
                        </div>
                        <div class="company_address">
                            <h3>
                                公司信息 :
                            </h3>
                            <p>
                                深圳市,
                            </p>
                            <p>
                                福田区,
                            </p>
                            <p>
                               荣超商务中心a座
                            </p>
                            <p>
                                电话:(0755) 333 666 444
                            </p>
                            <p>
                                传真: (000) 000 00 00 0
                            </p>
                            <p>
                                Email:
                                <span>
                                    800@126.com
                                </span>
                            </p>
                            <p>
                                友情链接:
                                <span>
                                    Facebook
                                </span>
                                ,
                                <span>
                                    Twitter
                                </span>
                            </p>
                        </div>
                    </div>
                    <script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMarker();//向地图中添加marker
    }
    
    //创建地图函数：
    function createMap(){
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(114.061997,22.54904);//定义一个中心点坐标
        map.centerAndZoom(point,17);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局
    }
    
    //地图事件设置函数：
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }
    
    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
	var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
	map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
	var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
	map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
	var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
	map.addControl(ctrl_sca);
    }
    
    //标注点数组
    var markerArr = [{title:"我的标记",content:"我的备注",point:"114.060982|22.549123",isOpen:0,icon:{w:21,h:21,l:0,t:0,x:6,lb:5}}
		 ];
    //创建marker
    function addMarker(){
        for(var i=0;i<markerArr.length;i++){
            var json = markerArr[i];
            var p0 = json.point.split("|")[0];
            var p1 = json.point.split("|")[1];
            var point = new BMap.Point(p0,p1);
			var iconImg = createIcon(json.icon);
            var marker = new BMap.Marker(point,{icon:iconImg});
			var iw = createInfoWindow(i);
			var label = new BMap.Label(json.title,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
			marker.setLabel(label);
            map.addOverlay(marker);
            label.setStyle({
                        borderColor:"#808080",
                        color:"#333",
                        cursor:"pointer"
            });
			
			(function(){
				var index = i;
				var _iw = createInfoWindow(i);
				var _marker = marker;
				_marker.addEventListener("click",function(){
				    this.openInfoWindow(_iw);
			    });
			    _iw.addEventListener("open",function(){
				    _marker.getLabel().hide();
			    })
			    _iw.addEventListener("close",function(){
				    _marker.getLabel().show();
			    })
				label.addEventListener("click",function(){
				    _marker.openInfoWindow(_iw);
			    })
				if(!!json.isOpen){
					label.hide();
					_marker.openInfoWindow(_iw);
				}
			})()
        }
    }
    //创建InfoWindow
    function createInfoWindow(i){
        var json = markerArr[i];
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
        return iw;
    }
    //创建一个Icon
    function createIcon(json){
        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
        return icon;
    }
    
    initMap();//创建和初始化地图
</script>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="bottomCommon.jsp"></jsp:include>
</body>

</html>