





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
										<p>端末別に全てのサーバー情報を自動的にアップデートするファイルを公開しています。</p>
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
													<a class="waves-attach" data-toggle="tab" href="#all_router"><i class="icon icon-lg">router</i>&nbsp;Router</a>
												</li>
											</ul>
										</nav>
										<div class="card-inner">
											<div class="tab-content">
												<div class="tab-pane fade active in" id="all_windows">
													<p>Shadowsocksクライアントは<a href="/ssr-download/ssr-win.7z">こちら。</a>インストール後に2つの方法で全てのサーバー情報を読み込みます。<br>
														(1)下記購読<a href="/user/getpcconf?without_mu=0">URL</a>をコピー。SSアプリのメニュー欄の "Import SSR links from clipboard..."をクリック<br>

														(2)下記メニュー欄にあるSSアプリのアイコンを右クリック。"Servers Subscribe"→"Subscribe setting..." を選択。下記購読URLを入力して"Add"をクリック。"Mode"は "Global Mode", "Proxy rule"は "Bypass Lan&China" の設定でご利用下さい。</p>


														


													<p>SSR サブスクリプションアドレス：<br>
														<code>{$baseUrl}/link/{$ssr_sub_token}?mu=0</code>
													</p>
												</div>
												<div class="tab-pane fade" id="all_mac">
													<p>Shadowsocksクライアントは<a href="/ssr-download/ssr-mac.dmg">こちら。</a>インストール後に2つの方法で全てのサーバー情報を読み込みます。</p>
													<p>(1) <a href="/user/getpcconf?without_mu=0">こちら</a>からファイルをダウンロード。SSアプリのメニュー欄の "Import Bunch Json File...."をクリックして、ダウンロードしたファイルをアップロード。これで全てのサーバーが読み込まれます。</p>
													<p>(2) メニューバーにあるSSアプリのアイコンをクリック。"Edit Subscribe Feed" をクリック。下記購読URLを入力、グループ名は任意、その他空欄で"Ok"をクリック。"Global Mode" の設定でご利用下さい。</p>
													<p>SSR サブスクリプションアドレス：<br>
														<code>{$baseUrl}/link/{$ssr_sub_token}?mu=0</code>
													</p>
												</div>



												<div class="tab-pane fade" id="all_ios">
													<p>アップルストアから<a href="https://itunes.apple.com/jp/app/shadowrocket/id932747118?mt=8">Shadowrocket（有料）</a>をダウンロード。Safariから<a id="android_add" href="{$android_add}">ここ</a>をクリック。Shadowrocketで開くとサーバーが読み込まれます。</p>
													<p>サーバーを個別に読み込みたい場合はサーバー一覧からサーバーを選択してQRコードをスキャンして下さい。</p>
												</div>



												<div class="tab-pane fade" id="all_android">
													<p>Shadowsocksクライアントは<a href="/ssr-download/ssr-android.apk">こちら。</a>ブラウザからこのページを立ち上げて<a id="android_add" href="{$android_add}">ここ</a>をクリック。全てのサーバー情報が読み込まれます。プロキシ方式は「LAN及び中国本土のアドレスを迂回する」を選択してご利用下さい。</p>


													<p>SSR サブスクリプションアドレス（サーバー一覧から自動更新サーバーを講読出来ます）：<br>
														<code>{$baseUrl}/link/{$ssr_sub_token}?mu=0</code>
													</p>
												</div>




												<div class="tab-pane fade" id="all_router">
<p>ルーターに<a href="http://www.right.com.cn/forum/thread-161324-1-1.html">ファームウェア</a>をインストール。SSHでルーターにアクセスして、下記のコマンドを入力して下さい。<br>
													<code>wget -O- {$baseUrl}/link/{$router_token_without_mu} | bash && echo -e "\n0 */3 * * * wget -O- {$baseUrl}/link/{$router_token_without_mu} | bash\n">> /etc/storage/cron/crontabs/admin && killall crond && crond </code><br>
													コマンド終了後に、ルーターの操作画面からお好みのShadowsocksサーバーを選択して接続出来ます。</p>
												</div>
											</div>
										</div>
										<div class="card-action">
											<div class="card-action-btn pull-left">
												<p><a class="btn btn-brand btn-flat waves-attach" href="/user/url_reset"><span class="icon">close</span>&nbsp;全てのリンクをリセットする</a></p>
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
															y: {$user->last_day_t/$user->transfer_enable*100}, legendText:"使用済み {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}", indexLabel: "使用済み {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}"
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
