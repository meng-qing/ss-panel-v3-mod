


{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">Connection Regulations</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-md-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>In order to operate safely, we regulate access to specific sites that obtain IP without permission and do tracking acts. If you access to the site listed below, the connection will be automatically disconnected.</p>
								<p>About privacy: Just by installing a filter inside the server, access information such as customer's traffic and IP is not recorded and monitored at all. Please use with confidence.</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$rules->render()}
						<table class="table">
						    <tr>
						        <th>ID</th>
						        <th>Name</th>
						        <th>Description</th>
							<th>Notation</th>
							<th>Type</th>
								
						    </tr>
						    {foreach $rules as $rule}
						        <tr>
								<td>#{$rule->id}</td>
								<td>{$rule->name}</td>
								<td>{$rule->text}</td>
								<td>{$rule->regex}</td>
								{if $rule->type == 1}
									<td>Data packet plaintext matching</td>
								{/if}		
								{if $rule->type == 2}
									<td>Data packet hex matching</td>
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








