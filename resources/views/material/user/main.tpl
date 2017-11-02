<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta content="IE=edge" http-equiv="X-UA-Compatible">
	<meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
	<meta name="theme-color" content="#ff9800">
	<title>{$config["appName"]}</title>

	
	
	<!-- css -->
	<link href="/theme/material/css/base.min.css" rel="stylesheet">
	<link href="/theme/material/css/project.min.css" rel="stylesheet">
	<link href="//fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	

	
	<!-- favicon -->
	<link rel="shortcut icon" href="/img/logo.ico">
	<!-- ... -->
	<style>
		.pagination {
			display:inline-block;
			padding-left:0;
			margin:20px 0;
			border-radius:4px
		}
		.pagination>li {
			display:inline
		}
		.pagination>li>a,.pagination>li>span {
			position:relative;
			float:left;
			padding:6px 12px;
			margin-left:-1px;
			line-height:1.42857143;
			color:#337ab7;
			text-decoration:none;
			background-color:#fff;
			border:1px solid #ddd
		}
		.pagination>li:first-child>a,.pagination>li:first-child>span {
			margin-left:0;
			border-top-left-radius:4px;
			border-bottom-left-radius:4px
		}
		.pagination>li:last-child>a,.pagination>li:last-child>span {
			border-top-right-radius:4px;
			border-bottom-right-radius:4px
		}
		.pagination>li>a:focus,.pagination>li>a:hover,.pagination>li>span:focus,.pagination>li>span:hover {
			color:#23527c;
			background-color:#eee;
			border-color:#ddd
		}
		.pagination>.active>a,.pagination>.active>a:focus,.pagination>.active>a:hover,.pagination>.active>span,.pagination>.active>span:focus,.pagination>.active>span:hover {
			z-index:2;
			color:#fff;
			cursor:default;
			background-color:#337ab7;
			border-color:#337ab7
		}
		.pagination>.disabled>a,.pagination>.disabled>a:focus,.pagination>.disabled>a:hover,.pagination>.disabled>span,.pagination>.disabled>span:focus,.pagination>.disabled>span:hover {
			color:#777;
			cursor:not-allowed;
			background-color:#fff;
			border-color:#ddd
		}
		.pagination-lg>li>a,.pagination-lg>li>span {
			padding:10px 16px;
			font-size:18px
		}
		.pagination-lg>li:first-child>a,.pagination-lg>li:first-child>span {
			border-top-left-radius:6px;
			border-bottom-left-radius:6px
		}
		.pagination-lg>li:last-child>a,.pagination-lg>li:last-child>span {
			border-top-right-radius:6px;
			border-bottom-right-radius:6px
		}
		.pagination-sm>li>a,.pagination-sm>li>span {
			padding:5px 10px;
			font-size:12px
		}
		.pagination-sm>li:first-child>a,.pagination-sm>li:first-child>span {
			border-top-left-radius:3px;
			border-bottom-left-radius:3px
		}
		.pagination-sm>li:last-child>a,.pagination-sm>li:last-child>span {
			border-top-right-radius:3px;
			border-bottom-right-radius:3px
		}
		.pager {
			padding-left:0;
			margin:20px 0;
			text-align:center;
			list-style:none
		}
		.pager li {
			display:inline
		}
		.pager li>a,.pager li>span {
			display:inline-block;
			padding:5px 14px;
			background-color:#fff;
			border:1px solid #ddd;
			border-radius:15px
		}
		.pager li>a:focus,.pager li>a:hover {
			text-decoration:none;
			background-color:#eee
		}
		.pager .next>a,.pager .next>span {
			float:right
		}
		.pager .previous>a,.pager .previous>span {
			float:left
		}
		.pager .disabled>a,.pager .disabled>a:focus,.pager .disabled>a:hover,.pager .disabled>span {
			color:#777;
			cursor:not-allowed;
			background-color:#fff
		}

		
		
		
		
		.pagination>li>a,
		.pagination>li>span {
		  border: 1px solid white;
		}
		.pagination>li.active>a {
		  background: #f50057;
		  color: #fff;
		}
		
		.pagination>li>a {
		  background: white;
		  color: #000;
		}
		
		
		.pagination > .active > a, .pagination > .active > a:focus, .pagination > .active > a:hover, .pagination > .active > span, .pagination > .active > span:focus, .pagination > .active > span:hover {
			color: #fff;
			background-color: #000;
			border-color: #000;
		}

		.pagination>.active>span {
		  background-color: #f50057;
		  color: #fff;
		  border-color: #fff;
		}
		
		
		
		.pagination > .disabled > span {
		  border-color: #fff;
		}
		
		
		pre {
			white-space: pre-wrap;
			word-wrap: break-word;
		}
		
		.progress-green .progress-bar {
			background-color: #f0231b;
		}
		
		.progress-green {
			background-color: #000;
		}
		
		.progress-green .progress-bar {
			background-color: #ff0a00;
		}
		
		.page-orange .ui-content-header {
			background-image: url(/theme/material/css/images/bg/amber.jpg);
		}
		
		.content-heading {
			font-weight: 300;
			color: #fff;
		}
				
	</style>
	
	
	
</head>
<body class="page-orange">
	<header class="header header-orange header-transparent header-waterfall ui-header">
		<ul class="nav nav-list pull-left">
			<div>
				<a data-toggle="menu" href="#ui_menu">
					<span class="icon icon-lg text-white">menu</span>
				</a>
			</div>
		</ul>
		
		<ul class="nav nav-list pull-right">
			<div class="dropdown margin-right">
				<a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown">
				{if $user->isLogin}
					<span class="access-hide">{$user->user_name}</span>
					<span class="avatar avatar-sm"><img alt="alt text for John Smith avatar" src="{$user->gravatar}"></span>
					</a>
					<ul class="dropdown-menu dropdown-menu-right">
						<li>
							<a class="padding-right-lg waves-attach" href="/user/"><span class="icon icon-lg margin-right">account_box</span>ユーザーページ</a>
						</li>
						<li>
							<a class="padding-right-lg waves-attach" href="/user/logout"><span class="icon icon-lg margin-right">exit_to_app</span>ログアウト</a>
						</li>
					</ul>
				{else}
					<span class="access-hide">未登录</span>
					<span class="avatar avatar-sm"><img alt="alt text for John Smith avatar" src="/theme/material/images/users/avatar-001.jpg"></span>
					</a>
					<ul class="dropdown-menu dropdown-menu-right">
						<li>
							<a class="padding-right-lg waves-attach" href="/auth/login"><span class="icon icon-lg margin-right">account_box</span>ログイン</a>
						</li>
						<li>
							<a class="padding-right-lg waves-attach" href="/auth/register"><span class="icon icon-lg margin-right">pregnant_woman</span>新規登録</a>
						</li>
					</ul>
				{/if}
					
			</div>
		</ul>
	</header>
	<nav aria-hidden="true" class="menu menu-left nav-drawer nav-drawer-md" id="ui_menu" tabindex="-1">
		<div class="menu-scroll">
			<div class="menu-content">
				<a class="menu-logo" href="/" style="font-size:16px;" ><i class="icon icon-lg">person_pin_circle</i>&nbsp;ユーザーメニュー</a>
				<ul class="nav">
					<li>
						<a class="waves-attach" data-toggle="collapse" href="#ui_menu_me">マイアカウント</a>
						<ul class="menu-collapse collapse in" id="ui_menu_me">
							<li>
								<a href="/user">
									<i class="icon icon-lg">recent_actors</i>&nbsp;ホーム
								</a>
							</li>
							
							
							<li>
								<a href="/user/edit">
									<i class="icon icon-lg">sync_problem</i>&nbsp;アカウント情報の編集
								</a>
							</li>
							
							<li>
								<a href="/user/announcement">
									<i class="icon icon-lg">announcement</i>&nbsp;お知らせ
								</a>
							</li>
							
							
							{if $config['enable_donate']=='true'}
							<li>
								<a href="/user/donate">
									<i class="icon icon-lg">attach_money</i>&nbsp;捐赠公示
								</a>
							</li>
							{/if}
							
							
						</ul>
						
						
						<a class="waves-attach" data-toggle="collapse" href="#ui_menu_use">SSサービス</a>
						<ul class="menu-collapse collapse in" id="ui_menu_use">
							<li>
								<a href="/user/node">
									<i class="icon icon-lg">router</i>&nbsp;サーバー一覧
								</a>
							</li>
							
							<li>
								<a href="/user/trafficlog">
									<i class="icon icon-lg">traffic</i>&nbsp;使用状況
								</a>
							</li>

							<li><a href="/user/detect"><i class="icon icon-lg">account_balance</i>&nbsp;接続ルール</a></li>
						</ul>
						
						<a class="waves-attach" data-toggle="collapse" href="#ui_menu_trade">サポート</a>
						<ul class="menu-collapse collapse in" id="ui_menu_trade">
							{if $config['enable_wecenter']=='true'}
							<li>
								<a href="{$config["wecenter_url"]}" target="_blank">
									<i class="icon icon-lg">help</i>&nbsp;问答系统
								</a>
							</li>
							{/if}
							
							<li>
								<a href="/user/ticket">
									<i class="icon icon-lg">question_answer</i>&nbsp;チケットを発行
								</a>
							</li>
						</ul>

						
						<a class="waves-attach" data-toggle="collapse" href="#ui_menu_help">支払い</a>
						<ul class="menu-collapse collapse in" id="ui_menu_help">
						
						
							<li>
								<a href="/user/shop">
									<i class="icon icon-lg">shop</i>&nbsp;購入する
								</a>
							</li>
							
							<li><a href="/user/bought"><i class="icon icon-lg">shopping_cart</i>&nbsp;購入履歴</a></li>
							
							


							<li>
								<a href="/user/code">
									<i class="icon icon-lg">code</i>&nbsp;追加購入
								</a>
							</li>
						</ul>
						
						{if $user->isAdmin()}
							<li>
								<a href="/admin">
									<i class="icon icon-lg">person_pin</i>&nbsp;管理面板
								</a>
							</li>
						{/if}


						

						
					</li>
				</ul>
			</div>
		</div>
	</nav>
