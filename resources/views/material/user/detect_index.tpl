


{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">公開接続ルール</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-md-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>サーバーを安全に運営する為に、IPを無断入手したり、トラッキング行為をしてくる特定のサイトへのアクセスを規制しています。下記一覧のサイトへアクセスした場合自動的に接続が切断されます。</p>
								<p>プライバシーについて：サーバー内部にフィルターを設置しているだけで、お客様のトラフィックやIP等のアクセス情報は一切記録・モニタリングしておりません。安心してご利用下さい。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$rules->render()}
						<table class="table">
						    <tr>
						        <th>ID</th>
						        <th>名称</th>
						        <th>説明</th>
							<th>表記</th>
							<th>タイプ</th>
								
						    </tr>
						    {foreach $rules as $rule}
						        <tr>
								<td>#{$rule->id}</td>
								<td>{$rule->name}</td>
								<td>{$rule->text}</td>
								<td>{$rule->regex}</td>
								{if $rule->type == 1}
									<td>数据包明文匹配</td>
								{/if}		
								{if $rule->type == 2}
									<td>数据包 hex 匹配</td>
								{/if}								
						        </tr>
						    {/foreach}
						</table>
						{$rules->render()}
					</div>
							
			</div>
			
			
			
		</div>
	</main>






{include file='user/footer.tpl'}








