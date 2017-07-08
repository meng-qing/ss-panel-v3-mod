{include file='header.tpl'}
	

	<div class="page-banner page-banner-subpage p-b-0">
		<div class="container">
			<div class="banner-slogan banner-slogan-hero">
                <h1 class="slogan-title text-center">邀请码</h1>
                <div class="card">
						<div class="card-main">
							<div class="card-inner" align="center">
								<p style="font-size: 24px">{$config["appName"]} 的邀请码，不定期发放。没有邀请码请联系站长</p>
								<p style="font-size:24px;"><a href="https://t.me/mengqing" style="color:pink;" title="联系站长">站长telegram</a><!-- <a href="https://t.me/joinchat/AAAAAEGwXe8s8Ro5-oahng" style="color:pink;" title="加入Telegram群组">&nbsp;&nbsp;加入Telegram群组</a> --><a href="#" style="color:pink;" title="站长qq">&nbsp;&nbsp;站长qq: 2695043718</a></p>
								<p style="font-size:150%;line-height:100%;color: pink;">使用虚假信息或者重复注册的一律做删除账号处理！7天内无使用记录或7天内未签到的账号一律删除</p>
							</div>
						</div>
					</div>
			</div>
            <div class="banner-tabs tabs-responsive">
	
</div> 		
</div>
</div>
	<!-- /.page-banner -->

<div class="page-section section-center">
<div class="container">
		<main class="content">
		
		<div class="container">
				<section class="content-inner margin-top-no">
				
					
				
					
					
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner margin-bottom-no">
								<h2><p class="card-heading">邀请码</p></h2>
								<div class="card-table">
									<div class="table-responsive">
										<table class="table">
											<thead>
											<tr>
												<th>###</th>
												<th>邀请码 (点击邀请码进入注册页面)</th>
												<th>状态</th>
											</tr>
											</thead>
											<tbody>
											{foreach $codes as $code}
											<tr>
												<td>{$code->id}</td>
												<td><a href="/auth/register?code={$code->code}">{$code->code}</a></td>
												<td>可用</td>
											</tr>
											{/foreach}
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				
					
					
					
							
			
			
		</div>
	</main>
</div>
</div>








{include file='footer.tpl'}





