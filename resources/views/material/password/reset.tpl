{include file='top.tpl'}


<main class="content">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-lg-push-4 col-sm-6 col-sm-push-3">
					<section class="content-inner">
						<div class="card">
							<div class="card-main">
								<div class="card-header">
									<div class="card-inner">
										<h1 class="card-heading">Change password
</h1>
									</div>
								</div>
								<div class="card-inner">
									<p class="text-center">
										<span class="avatar avatar-inline avatar-lg">
											<img alt="Login" src="/theme/material/images/users/avatar-001.jpg">
										</span>
									</p>
									
										
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="email">Email</label>
													<input class="form-control" id="email" type="text">
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<button id="reset" type="submit" class="btn btn-block btn-brand waves-attach waves-light">Reset Pssword
</button>
												</div>
											</div>
										</div>
										
										
									
								</div>
							</div>
						</div>
						<div class="clearfix">
							<p class="margin-no-top pull-left"><a class="btn btn-flat btn-brand waves-attach" href="/auth/login">Login</a></p>
							<p class="margin-no-top pull-right"><a class="btn btn-flat btn-brand waves-attach" href="/auth/register">Sign up</a></p>
						</div>
						
						
						
								
						{include file='dialog.tpl'}
						
						
						
					</section>
				</div>
			</div>
		</div>
	</main>
	
{include file='bottom.tpl'}


<script>
    $(document).ready(function(){
        function reset(){
			$("#result").modal();
            $("#msg").html("Sending now, please wait a seconds...");
            $.ajax({
                type:"POST",
                url:"/password/reset",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#result").modal();
                        $("#msg").html(data.msg);
                       // window.setTimeout("location.href='/auth/login'", 2000);
                    }else{
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#result").modal();
                    $("#msg").html(data.msg);
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                login();
            }
        });
        $("#reset").click(function(){
            reset();
        });
    })
</script>
