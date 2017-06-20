	<!-- /.page-section -->	
		<div class="page-section section-blue section-center">
	        <div class="container">
	            <h2 align="center" class="section-title">使用Fast云加速，开启新的体验！</h2>
	                <a href="/user/code"><button class="btn btn-primary-light btn-lg" type="submit">立即体验<i class="zmdi zmdi-long-arrow-right"></i></button></a>
	        </div>
	    </div>
	    <!-- /.page-section -->		

	    <div class="page-footer">
	        <footer class="footer-nav">
	            <div class="container">
	                <div class="row">
	                    <div class="col-xs-3">
	                        <h4>产品服务</h4>
	                        <ul>
	                            <li><a href="/code">邀请码</a></li>
	                            <li><a href="/user/shop">包年包月</a></li>
	                            <li><a href="/user/shop">按线计费</a></li>
	                            <li><a href="/user/shop">体验套餐 </a></li>
	                        </ul>
	                    </div>
	                    <div class="col-xs-3">
	                        <h4>产品特性</h4>
	                        <ul>
	                            <li><a href="/features">云加速</a></li>
	                            <li><a href="/datacenter">数据中心</a></li>
	                            <li><a href="/panel">控制面板</a></li>
	                            <li><a href="/sla">服务保证</a></li>
	                        </ul>
	                    </div>
	                    <div class="col-xs-3">
	                        <h4>软件与教程</h4>
	                        <ul>
	                            <li><a href="/help">帮助文档</a></li>
								<li><a href="/client">软件下载</a></li>
	                            <li><a href="/faq">常见问题</a></li>
	                            <li><a href="/user/node">线路状态</a></li>
	                        </ul>
	                    </div>
		                <div class="col-xs-3">
	                        <h4>关于与公告</h4>
	                        <ul>
	                            <li><a href="/about">关于我们</a></li>
	                                <li><a href="/contact">联系我们</a></li>
	                                <li><a href="/user/announcement">公告信息</a></li>
	                                <li><a href="/aff">推介计划</a></li>
	                        </ul>
	                    </div>
	                </div>
	            </div>
	        </footer>
	        <footer class="footer-bottom">
	            <div class="container">
	                <div class="row">
	                    <div class="col-lg-6 col-lg-push-6 col-xs-12">
	                        <ul class="nav">
	                            <li><a href="/tos">服务条款</a></li>
	                            <li><a href="/faq">常见问题</a></li>
	                            <li><a href="/use_policy">使用政策</a></li>
	                        </ul>
	                        <ul class="social">
	                            <li><a href="https://t.me/joinchat/AAAAAEGwXe8s8Ro5-oahng" class="btn btn-primary btn-circle btn-icon btn-outline btn-sm"><i class="fa fa-user-plus"></i></a></li>
	                        </ul>
	                    </div>
	                    <div class="col-lg-6 col-lg-pull-6 col-xs-12">
	                        <p class="footer-copyright">
		                        <footer class="ui-footer">
									<div class="container">
										Powered By shadowsocks &  <a style="color: #616366;  " href="/staff">SS-panel-V3-mod</a> & Fast云加速.
										{if $config["enable_analytics_code"] == 'true'}{include file='analytics.tpl'}{/if}
									</div>
								</footer>
	                        </p>
	                    </div>
	                </div>
	            </div>
	        </footer>
	    </div>
	    <!-- /.page-footer -->
	</div>

	<div class="modal fade" id="tryscreen" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	            <h4 class="modal-title" id="myModalLabel">Qrcode</h4>
	         </div>
	         <div class="modal-body" id="qrcode"></div>
	      </div><!-- /.modal-content -->
	</div><!-- /.modal -->

	<!-- Scripts -->
	<script src="/theme/material/js/fast-ssr/jquery.min.js"></script>
	<script src="/theme/material/js/fast-ssr/core.min.js"></script>
	<script src="/theme/material/js/fast-ssr/main.js"></script>
	<script src="/theme/material/js/fast-ssr/global.js"></script>
</body>
</html>
