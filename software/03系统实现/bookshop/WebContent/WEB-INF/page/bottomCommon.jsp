<%@ page language="java" pageEncoding="UTF-8"%>
<% 
String path=request.getContextPath(); String basePath=request.getScheme()
    + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>

        <div class="footer">
            <div class="wrap">
                <div class="section group">
                    <div class="col_1_of_4 span_1_of_4">
                        <h4>
                            资讯
                        </h4>
                        <ul>
                            <li>
                                <a href="javascript:forwordUrl('/about');">
                                    关于我们
                                </a>
                            </li>
                            <li>
                                <a href="javascript:forwordUrl('/contact');">
                                    客户服务
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    高级搜索
                                </a>
                            </li>
                            <li>
                                <a href="javascript:forwordUrl('/delivery');">
                                    书籍发货
                                </a>
                            </li>
                            <li>
                                <a href="javascript:forwordUrl('/contact');">
                                    联系我们
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="col_1_of_4 span_1_of_4">
                        <h4>
                            为什么选择我们
                        </h4>
                        <ul>
                            <li>
                                <a href="javascript:forwordUrl('/about');">
                                    关于我们
                                </a>
                            </li>
                            <li>
                                <a href="javascript:forwordUrl('/contact');">
                                    客户服务
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    隐私政策
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    网站地图
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    搜索条件
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="col_1_of_4 span_1_of_4">
                        <h4>
                            我的账户
                        </h4>
                        <ul>
                            <li>
                                <a href="javascript:forwordUrl('/toLogin');">
                                    登陆
                                </a>
                            </li>
                            <li>
                                <a href="javascript:forwordUrl('/shoppingCar');">
                                    购物车
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    我的心愿
                                </a>
                            </li>
                            <li>
                                <a href="javascript:forwordUrl('/mySubscription');">
                                    追踪订单
                                </a>
                            </li>
                            <li>
                                <a href="javascript:forwordUrl('/contact');">
                                    帮助
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="col_1_of_4 span_1_of_4">
                        <h4>
                            联系我们
                        </h4>
                        <ul>
                            <li>
                                <span>
                                    123456
                                </span>
                            </li>
                        </ul>
                        <div class="social-icons">
                            <h4>
                                合作
                            </h4>
                            <ul>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/facebook.png" alt="" />
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/twitter.png" alt="" />
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/skype.png" alt="" />
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/dribbble.png" alt="" />
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <img src="images/linkedin.png" alt="" />
                                    </a>
                                </li>
                                <div class="clear">
                                </div>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="copy_right">
                <p>
                    Copyright &copy; <a href="<%=basePath%>/backstage_toLogin" target="_blank">管理员</a> All rights reserved.
                </p>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {
                $().UItoTop({
                    easingType: 'easeOutQuart'
                });

            });
        </script>
                <a href="#" id="toTop">
                    <span id="toTopHover">
                    </span>
                </a>