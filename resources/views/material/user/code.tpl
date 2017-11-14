












{if $pmw!=''}
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										{$pmw}
									</div>
									
								</div>
							</div>
						</div>
					</div>
					{/if}



	<!-- <main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">Recharge</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">
					 <div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">Recharge code</p>
										<p>Account Balance：{$user->money} USD</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="code">Recharge code</label>
											<input class="form-control" id="code" type="text">
										</div>
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="code-update" ><span class="icon">check</span>&nbsp;Recharge</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div> 
					
					{if $pmw!=''}
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										{$pmw}
									</div>
									
								</div>
							</div>
						</div>
					</div>
					{/if}
					

					
					{include file='dialog.tpl'}
				</div>
			</section>
		</div>
	</main> -->









<script>
	$(document).ready(function () {
		$("#code-update").click(function () {
			$.ajax({
				type: "POST",
				url: "code",
				dataType: "json",
				data: {
					code: $("#code").val()
				},
				success: function (data) {
					if (data.ret) {
						$("#result").modal();
						$("#msg").html(data.msg);
						window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
					} else {
						$("#result").modal();
						$("#msg").html(data.msg);
						window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
					}
				},
				error: function (jqXHR) {
					$("#result").modal();
					$("#msg").html("error：" + jqXHR.status);
				}
			})
		})
		
		$("#urlChange").click(function () {
			$.ajax({
				type: "GET",
				url: "code/f2fpay",
				dataType: "json",
				data: {
					time: timestamp
				},
				success: function (data) {
					if (data.ret) {
						$("#readytopay").modal();
					}
				}
				
			})
		});
		
		$("#readytopay").on('shown.bs.modal', function () {
			$.ajax({
				type: "POST",
				url: "code/f2fpay",
				dataType: "json",
				data: {
						//amount: $("#type").find("option:selected").val()
						amount: $("#type").val()
					},
				success: function (data) {
					$("#readytopay").modal('hide');
					if (data.ret && data.amount >= 6) {
						$("#qrcode").html(data.qrcode);
						$("#info").html("您的订单金额为："+data.amount+"元。");
						$("#mobile").attr("href", data.mobile);
						$("#alipay").modal();
					} else {
						$("#result").modal();
						data.msg = "二维码生成失败，充值金额至少为6元！";
						$("#msg").html(data.msg);
					}
				},
				error: function (jqXHR) {
					$("#readytopay").modal('hide');
					$("#result").modal();
					$("#msg").html(data.msg+"  发生了错误。");
				}
			})
		});


	timestamp = {time()}; 
		
		
	function f(){
		$.ajax({
			type: "GET",
			url: "code_check",
			dataType: "json",
			data: {
				time: timestamp
			},
			success: function (data) {
				if (data.ret) {
					clearTimeout(tid);
					$("#alipay").modal('hide');
					$("#result").modal();
					$("#msg").html("Recharge success！");
					window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
				}
			}
		});
		tid = setTimeout(f, 1000); //循环调用触发setTimeout
	}
	setTimeout(f, 1000);
})
</script>

