





{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">ユーザーページ</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="ui-card-wrap">

						<div class="col-lg-6 col-md-6">

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">最新のお知らせ</p>
										<p>その他お知らせは<a href="/user/announcement"/>こちら</a></p>
										{if $ann != null}
										<p>{$ann->content}</p>
										{/if}
									</div>

								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">All-in-One</p>
										<p>这里为您提供了自动化地配置文件生成，包含了所有 Shadowsocks 服务器的信息，方便您在诸多的服务器中快速添加，快速切换。</p>
										<nav class="tab-nav margin-top-no">
											<ul class="nav nav-list">
												<li class="active">
													<a class="waves-attach" data-toggle="tab" href="#all_windows"><i class="icon icon-lg">desktop_windows</i>&nbsp;Windows</a>
												</li>
												<li>
													<a class="waves-attach" data-toggle="tab" href="#all_mac"><i class="icon icon-lg">laptop_mac</i>&nbsp;MacOS</a>
												</li>
												<li>
													<a class="waves-attach" data-toggle="tab" href="#all_ios"><i class="icon icon-lg">laptop_mac</i>&nbsp;iOS</a>
												</li>
												<li>
													<a class="waves-attach" data-toggle="tab" href="#all_android"><i class="icon icon-lg">android</i>&nbsp;Android</a>
												</li>
												<li>
													<a class="waves-attach" data-toggle="tab" href="#all_router"><i class="icon icon-lg">router</i>&nbsp;路由器</a>
												</li>
											</ul>
										</nav>
										<div class="card-inner">
											<div class="tab-content">
												<div class="tab-pane fade active in" id="all_windows">
													<p><a href="/ssr-download/ssr-win.7z">下载</a>，解压，运行程序，然后您有三种方式导入所有节点<br>
														(1)下载<a href="/user/getpcconf?without_mu=0">这个</a>或者<a  href="/user/getpcconf?without_mu=1">这个（无单端口多用户）</a>，右键小飞机 服务器 -- 从配置文件导入服务器，选择这个文件，<br>
														(2)点击<a class="copy-text" data-clipboard-text="{$android_add}">这里</a>或者<a class="copy-text" data-clipboard-text="{$android_add_without_mu}">这个（无单端口多用户）</a>，然后右键小飞机 -- 从剪贴板复制地址<br>
														(3)(推荐)右键小飞机--服务器--SSR服务器订阅设置，将订阅地址设置为下面的地址，其他参数留空，确定之后再更新 SSR 服务器订阅。<br>
														然后选择一个合适的服务器，系统代理模式选”全局模式”，代理规则选“绕过局域网和大陆”，然后即可上网。</p>

													<p>SSR 订阅地址：<br>
														普通端口地址：<code>{$baseUrl}/link/{$ssr_sub_token}?mu=0</code><br>
														单端口多用户端口地址：<code>{$baseUrl}/link/{$ssr_sub_token}?mu=1</code>
													</p>
												</div>
												<div class="tab-pane fade" id="all_mac">
													<p><a href="/ssr-download/ssr-mac.dmg">下载</a>，安装，然后下载<a href="/user/getpcconf?without_mu=0">这个</a>或者<a  href="/user/getpcconf?without_mu=1">这个（无单端口多用户）</a>，运行程序，小飞机上右键 服务器列表 子菜单 的 “导入服务器配置文件...” 导入这个文件，然后选择一个合适的服务器，更新一下PAC，然后开启系统代理即可上网。</p>
												</div>
												<div class="tab-pane fade" id="all_ios">
													<p>推荐下载<a href="https://itunes.apple.com/cn/app/shadowrocket/id932747118?mt=8">Shadowrocket</a>，然后在 Safari 中点击<a id="android_add" href="{$android_add}">这个</a>或者<a id="android_add_without_mu" href="{$android_add_without_mu}">这个（无单端口多用户）</a>，然后点击确定，就可以批量添加节点。</p>
													<STRIKE><p>iOS 下载<a href="/link/{$ios_token}">这个</a>，导入到 Surge 中，然后就可以随意切换服务器上网了。</p></STRIKE>
												</div>
												<div class="tab-pane fade" id="all_android">
													<p><a href="/ssr-download/ssr-android.apk">下载</a>，安装，然后在手机上默认浏览器中点击<a id="android_add" href="{$android_add}">这个</a>或者<a id="android_add_without_mu" href="{$android_add_without_mu}">这个（无单端口多用户）</a>，然后点击确定，批量添加完节点，然后路由选择绕过大陆，右上角开启就可以上网了。同时提供一个 ACL 地址，<a href="/link/{$acl_token}">长按复制地址</a>到客户端里应用即可。</p>
													<p>SSR 订阅地址，您可以在节点列表处添加订阅来自动更新节点：<br>
														普通端口地址：<code>{$baseUrl}/link/{$ssr_sub_token}?mu=0</code><br>
														单端口多用户端口地址：<code>{$baseUrl}/link/{$ssr_sub_token}?mu=1</code>
													</p>
												</div>
												<div class="tab-pane fade" id="all_router">
													<p>路由器 刷入<a href="http://www.right.com.cn/forum/thread-161324-1-1.html">这个固件</a>，然后 SSH 登陆路由器，执行以下命令<br>
													<code>wget -O- {$baseUrl}/link/{$router_token} | bash && echo -e "\n0 */3 * * * wget -O- {$baseUrl}/link/{$router_token} | bash\n">> /etc/storage/cron/crontabs/admin && killall crond && crond </code><br>
													或者这个不含单端口多用户的<br>
													<code>wget -O- {$baseUrl}/link/{$router_token_without_mu} | bash && echo -e "\n0 */3 * * * wget -O- {$baseUrl}/link/{$router_token_without_mu} | bash\n">> /etc/storage/cron/crontabs/admin && killall crond && crond </code><br>
													执行完毕以后就可以到路由器的设置面板里随意选择 Shadowsocks 服务器进行连接了。</p>
												</div>
											</div>
										</div>
										<div class="card-action">
											<div class="card-action-btn pull-left">
												<p><a class="btn btn-brand btn-flat waves-attach" href="/user/url_reset"><span class="icon">close</span>&nbsp;重置所有链接</a></p>
											</div>
										</div>
									</div>

								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">アカウント状況</p>
										<dl class="dl-horizontal">
											<p><dt>プラン名</dt>
											<dd>{$user->class}</dd></p>

											<p><dt>プラン有効期限</dt>
											<dd>{$user->class_expire}</dd></p>

										</dl>
									</div>

								</div>
							</div>




						</div>

						<div class="col-lg-6 col-md-6">



							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">

										<div id="traffic_chart" style="height: 300px; width: 100%;"></div>

										<script src="//cdn.staticfile.org/canvasjs/1.7.0/canvasjs.js"></script>
										<script type="text/javascript">
											var chart = new CanvasJS.Chart("traffic_chart",
											{
												title:{
													text: "データ使用状況",
													fontFamily: "Impact",
													fontWeight: "normal"
												},

												legend:{
													verticalAlign: "bottom",
													horizontalAlign: "center"
												},
												data: [
												{
													//startAngle: 45,
													indexLabelFontSize: 20,
													indexLabelFontFamily: "Garamond",
													indexLabelFontColor: "darkgrey",
													indexLabelLineColor: "darkgrey",
													indexLabelPlacement: "outside",
													type: "doughnut",
													showInLegend: true,
													dataPoints: [
														{if $user->transfer_enable != 0}
														{
															y: {$user->last_day_t/$user->transfer_enable*100}, legendText:"已用 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}", indexLabel: "已用 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}"
														},
														{
															y: {($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100}, legendText:"今日 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}", indexLabel: "今日 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}"
														},
														{
															y: {($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100}, legendText:"残り {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}", indexLabel: "残り {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}"
														}
														{/if}
													]
												}
												]
											});

											chart.render();
										</script>

									</div>

								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">接続情報</p>
											<dl class="dl-horizontal">
												<p><dt>ポート</dt>
												<dd>{$user->port}</dd></p>

												<p><dt>パスワード</dt>
												<dd>{$user->passwd}</dd></p>

												<p><dt>暗号化</dt>
												<dd>{$user->method}</dd></p>

												<p><dt>プロトコル</dt>
												<dd>{$user->protocol}</dd></p>

												<p><dt>Obfuscation</dt>
												<dd>{$user->obfs}</dd></p>

												<p><dt>前回使用</dt>
												<dd>{$user->lastSsTime()}</dd></p>
											</dl>
									</div>

								</div>
							</div>




						{if $enable_duoshuo=='true'}

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">讨论区</p>
											<div class="ds-thread" data-thread-key="0" data-title="index" data-url="{$baseUrl}/user/"></div>
											<script type="text/javascript">
											var duoshuoQuery = {

											short_name:"{$duoshuo_shortname}"


											};
												(function() {
													var ds = document.createElement('script');
													ds.type = 'text/javascript';ds.async = true;
													ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
													ds.charset = 'UTF-8';
													(document.getElementsByTagName('head')[0]
													 || document.getElementsByTagName('body')[0]).appendChild(ds);
												})();
											</script>
									</div>

								</div>
							</div>

						{/if}

						{include file='dialog.tpl'}

					</div>


				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}

<script src="/theme/material/js/shake.js/shake.js"></script>


<script>

$(function(){
	new Clipboard('.copy-text');
});

$(".copy-text").click(function () {
	$("#result").modal();
	$("#msg").html("已复制到您的剪贴板，请您继续接下来的操作。");
});

{if $geetest_html == null}


window.onload = function() {
    var myShakeEvent = new Shake({
        threshold: 15
    });

    myShakeEvent.start();

    window.addEventListener('shake', shakeEventDidOccur, false);

    function shakeEventDidOccur () {
		if("vibrate" in navigator){
			navigator.vibrate(500);
		}

        $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
					$("#result").modal();
                    $("#msg").html(data.msg);
                },
                error: function (jqXHR) {
					$("#result").modal();
                    $("#msg").html("发生错误：" + jqXHR.status);
                }
            });
    }
};


$(document).ready(function () {
	$("#checkin").click(function () {
		$.ajax({
			type: "POST",
			url: "/user/checkin",
			dataType: "json",
			success: function (data) {
				$("#checkin-msg").html(data.msg);
				$("#checkin-btn").hide();
				$("#result").modal();
				$("#msg").html(data.msg);
			},
			error: function (jqXHR) {
				$("#result").modal();
				$("#msg").html("发生错误：" + jqXHR.status);
			}
		})
	})
})


{else}


window.onload = function() {
    var myShakeEvent = new Shake({
        threshold: 15
    });

    myShakeEvent.start();

    window.addEventListener('shake', shakeEventDidOccur, false);

    function shakeEventDidOccur () {
		if("vibrate" in navigator){
			navigator.vibrate(500);
		}

        c.show();
    }
};



var handlerPopup = function (captchaObj) {
	c = captchaObj;
	captchaObj.onSuccess(function () {
		var validate = captchaObj.getValidate();
		$.ajax({
			url: "/user/checkin", // 进行二次验证
			type: "post",
			dataType: "json",
			data: {
				// 二次验证所需的三个值
				geetest_challenge: validate.geetest_challenge,
				geetest_validate: validate.geetest_validate,
				geetest_seccode: validate.geetest_seccode
			},
			success: function (data) {
				$("#checkin-msg").html(data.msg);
				$("#checkin-btn").hide();
				$("#result").modal();
				$("#msg").html(data.msg);
			},
			error: function (jqXHR) {
				$("#result").modal();
				$("#msg").html("发生错误：" + jqXHR.status);
			}
		});
	});
	// 弹出式需要绑定触发验证码弹出按钮
	captchaObj.bindOn("#checkin");
	// 将验证码加到id为captcha的元素里
	captchaObj.appendTo("#popup-captcha");
	// 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
};

initGeetest({
	gt: "{$geetest_html->gt}",
	challenge: "{$geetest_html->challenge}",
	product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
	offline: {if $geetest_html->success}0{else}1{/if} // 表示用户后台检测极验服务器是否宕机，与SDK配合，用户一般不需要关注
}, handlerPopup);



{/if}


</script>
