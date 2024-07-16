<?php /*a:8:{s:56:"/var/www/html/public/themes/clientarea/default/login.tpl";i:1720798140;s:64:"/var/www/html/public/themes/clientarea/default/includes/head.tpl";i:1720798138;s:64:"/var/www/html/public/themes/clientarea/default/includes/menu.tpl";i:1720798138;s:70:"/var/www/html/public/themes/clientarea/default/includes/pageheader.tpl";i:1720798138;s:70:"/var/www/html/public/themes/clientarea/default/includes/breadcrumb.tpl";i:1720798138;s:62:"/var/www/html/public/themes/clientarea/default/error/alert.tpl";i:1720798138;s:70:"/var/www/html/public/themes/clientarea/default/error/notifications.tpl";i:1720798138;s:66:"/var/www/html/public/themes/clientarea/default/includes/verify.tpl";i:1720798138;}*/ ?>

<!DOCTYPE html>
<html lang="zh-CN">

<head>
	<meta charset="utf-8" />
	<title><?php echo $Title; ?> | <?php echo $Setting['company_name']; ?></title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta content="<?php echo $Setting['web_seo_desc']; ?>" name="description" />
	<meta content="<?php echo $Setting['web_seo_keywords']; ?>" name="keywords" />
	<meta content="<?php echo $Setting['company_name']; ?>" name="author" />

	<!-- <link rel="shortcut icon" href="/themes/clientarea/default/assets/images/favicon.ico"> -->
<link href="/themes/clientarea/default/assets/css/bootstrap.min.css?v=<?php echo $Ver; ?>" rel="stylesheet" type="text/css" />
<link href="/themes/clientarea/default/assets/css/icons.min.css?v=<?php echo $Ver; ?>" rel="stylesheet" type="text/css" />
<link href="/themes/clientarea/default/assets/css/app.min.css?v=<?php echo $Ver; ?>" rel="stylesheet" type="text/css" />
<?php if(($load_css=load_css('custom.css'))): ?>
    <link href="<?php echo $load_css; ?>?v=<?php echo $Ver; ?>" rel="stylesheet" type="text/css" />
<?php endif; ?>
<!-- 自定义全局样式 -->
<link href="/themes/clientarea/default/assets_custom/css/global.css?v=<?php echo $Ver; ?>" rel="stylesheet" >
<link href="/themes/clientarea/default/assets_custom/css/responsive.css?v=<?php echo $Ver; ?>" rel="stylesheet">
<!-- 字体图标 -->



 <link href="/themes/clientarea/default/assets_custom/fonts/iconfont.css?v=<?php echo $Ver; ?>" rel="stylesheet"> 

<!-- JAVASCRIPT -->
<script src="/themes/clientarea/default/assets/libs/jquery/jquery.min.js?v=<?php echo $Ver; ?>"></script>
<script src="/themes/clientarea/default/assets/libs/bootstrap/js/bootstrap.bundle.min.js?v=<?php echo $Ver; ?>"></script>
<script src="/themes/clientarea/default/assets/libs/metismenu/metisMenu.min.js?v=<?php echo $Ver; ?>"></script>
<script src="/themes/clientarea/default/assets/libs/simplebar/simplebar.min.js?v=<?php echo $Ver; ?>"></script>
<script src="/themes/clientarea/default/assets/libs/node-waves/waves.min.js?v=<?php echo $Ver; ?>"></script>

<!-- <script src="/themes/clientarea/default/assets/libs/error-all/solve-error.js" type="text/javascript"></script> -->
<!-- 自定义js -->
<script src="/themes/clientarea/default/assets_custom/js/throttle.js?v=<?php echo $Ver; ?>"></script>

<link type="text/css" href="/themes/clientarea/default/assets/libs/toastr/build/toastr.min.css?v=<?php echo $Ver; ?>" rel="stylesheet" />
<script src="/themes/clientarea/default/assets/libs/toastr/build/toastr.min.js?v=<?php echo $Ver; ?>"></script>


  <script>
	var setting_web_url = ''
  var language=<?php echo json_encode($_LANG); ?>;
  </script>
	<?php $hooks=hook('client_area_head_output'); if($hooks): foreach($hooks as $item): ?>
			<?php echo $item; ?>
		<?php endforeach; ?>
	<?php endif; ?>
<style>
    .logo-lg img{
      width:150px;
      height:auto;
    }
</style>
</head>
<body data-sidebar="dark">
	<?php if($TplName != 'login' && $TplName != 'register' && $TplName != 'pwreset' && $TplName != 'bind' && $TplName != 'loginaccesstoken'): ?>
	<header id="page-topbar">
		<div class="navbar-header">
			<div class="d-flex">
				<!-- LOGO -->
				<div class="navbar-brand-box">
					<a href="<?php echo $Setting['web_jump_url']; ?>" class="logo logo-dark">
						<?php if($Setting['logo_url_home_mini'] !=''): ?>
						<span class="logo-sm">
							<img src="<?php echo $Setting['logo_url_home_mini']; ?>" alt="" height="32">
						</span>
						<?php endif; ?>
						<span class="logo-lg">
							<img src="<?php echo $Setting['web_logo_home']; ?>" alt="" height="17">
						</span>
					</a>

					<a href="<?php echo $Setting['web_jump_url']; ?>" class="logo logo-light">
						<?php if($Setting['logo_url_home_mini'] !=''): ?>
						<span class="logo-sm" style="overflow: hidden;">
							<img src="<?php echo $Setting['logo_url_home_mini']; ?>" alt="" height="32">
						</span>
						<?php endif; ?>
						<span class="logo-lg">
							<img src="<?php echo $Setting['web_logo_home']; ?>" alt="">
						</span>
					</a>
				</div>

				<button type="button" class="btn btn-sm px-3 font-size-16 header-item waves-effect" id="vertical-menu-btn">
					<i class="fa fa-fw fa-bars"></i>
				</button>


			</div>

			<div class="d-flex">


				<div class="dropdown d-inline-block d-lg-none ml-2 phonehide">
					<button type="button" class="btn header-item noti-icon waves-effect" id="page-header-search-dropdown"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="mdi mdi-magnify"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right p-0"
						aria-labelledby="page-header-search-dropdown">

						<form class="p-3">
							<div class="form-group m-0">
								<div class="input-group">
									<input type="text" class="form-control" placeholder="Search ..." aria-label="Recipient's username">
									<div class="input-group-append">
										<button class="btn btn-primary" type="submit">
											<i class="mdi mdi-magnify"></i>
										</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>

				<!-- 多语言 -->
				<?php if($Setting['allow_user_language']): ?>
				<div class="dropdown d-inline-block">
					<button type="button" class="btn header-item waves-effect" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">
						<img id="header-lang-img" src="/upload/common/country/<?php echo $LanguageCheck['display_flag']; ?>.png" alt="Header Language" height="16">
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<!-- wyh 20210329 插件使用 -->
						<?php 
							$parse = parse_url(request()->url());
							$path=$parse['path'];
							$query=$parse['query'];
							$query = preg_replace('/&language=[a-zA-Z0-9_-]+/','',$query);
						 ?>
						<!-- item-->
						<?php if($path=="/addons"): foreach($Language as $key=>$list): ?>
								<a href="?<?php if($query): ?><?php echo $query; ?>&<?php endif; ?>language=<?php echo $key; ?>" class="dropdown-item notify-item language" data-lang="zh-cn">
									<img src="/upload/common/country/<?php echo $list['display_flag']; ?>.png" alt="user-image"
										 class="mr-1" height="12"> <span class="align-middle"><?php echo $list['display_name']; ?></span>
								</a>
							<?php endforeach; else: foreach($Language as $key=>$list): ?>
								<a href="?<?php if($query): ?><?php echo $query; ?>&<?php endif; ?>language=<?php echo $key; ?>" class="dropdown-item notify-item language" data-lang="zh-cn">
									<img src="/upload/common/country/<?php echo $list['display_flag']; ?>.png" alt="user-image"
										 class="mr-1" height="12"> <span class="align-middle"><?php echo $list['display_name']; ?></span>
								</a>
							<?php endforeach; ?>
						<?php endif; ?>

					</div>
				</div>
				<?php endif; ?>
        
				<!-- 购物车 -->
				<div class="dropdown d-none d-lg-inline-block ml-1">
					<button type="button" class="btn header-item noti-icon waves-effect">
						<a href="cart?action=viewcart"><i class="bx bx-cart-alt" style="margin-top: 8px;"></i></a>
							<!-- <?php if(count($CartShopData) != '0'): ?>
							<span class="badge badge-danger badge-pill"><?php echo count($CartShopData); ?></span>
							<?php endif; ?> -->
					</button>
				</div> 

				<!-- 消息 -->
				<div class="dropdown d-none d-lg-inline-block ml-1">
					<a href="message">
						<button type="button" class="btn header-item noti-icon waves-effect">
							<i class="bx bx-bell <?php if($Setting['unread_num']): ?>bx-tada<?php endif; ?>" style="margin-top: 8px;"></i>
							<?php if($Setting['unread_num'] != '0'): ?>
							<span class="badge badge-danger badge-pill"><?php echo $Setting['unread_num']; ?></span>
							<?php endif; ?>
						</button>
					</a>
				</div>

				<!-- 个人中心 -->
				<?php if($Userinfo): ?>
				<div class="dropdown d-inline-block">
					<button type="button" class="btn header-item waves-effect d-inline-flex align-items-center"
						id="page-header-user-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<div class="user-center_header d-inline-flex align-items-center justify-content-center"
							style="display: inline-block;width: 30px;height: 30px;font-size: 16px;">
							<?php if(preg_match("/^[0-9]*[A-Za-z]+$/is", substr($Userinfo['user']['username'],0,1))): ?> 
							  <?php echo strtoupper(substr($Userinfo['user']['username'],0,1)); elseif(preg_match("/^[\x7f-\xff]*$/", substr($Userinfo['user']['username'],0,3))): ?> 
							  <?php echo substr($Userinfo['user']['username'],0,3); else: ?>
							  <?php echo strtoupper(substr($Userinfo['user']['username'],0,1)); ?> 
							<?php endif; ?>
						</div>
						<span class="d-none d-xl-inline-block ml-1" key="t-henry"><?php echo $Userinfo['user']['username']; ?></span>
						<i class="mdi mdi-chevron-down d-none d-xl-inline-block"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<!-- item-->
						<a class="dropdown-item" href="details">
							<i class="bx bxs-user-detail font-size-16 align-middle mr-1"></i>
							<span key="t-profile"><?php echo $Lang['personal_information']; ?></span>
						</a>
						<a class="dropdown-item" href="security">
							<i class="bx bx-cog font-size-16 align-middle mr-1"></i>
							<span key="t-profile"><?php echo $Lang['security_center']; ?></span>
						</a>
						<a class="dropdown-item" href="message">
							<i class="bx bxl-messenger font-size-16 align-middle mr-1"></i>
							<span key="t-profile"><?php echo $Lang['message_center']; ?></span>
						</a>
						<?php if($Setting['certifi_open']==1): ?>
						<a class="dropdown-item" href="verified"> 
							<i class="bx bxs-id-card font-size-16 align-middle mr-1"></i>
							<span key="t-profile"><?php echo $Lang['real_name_authentications']; ?></span>
						</a>
						<?php endif; ?>
						<a class="dropdown-item text-danger" href="logout"><i
								class="bx bx-power-off font-size-16 align-middle mr-1 text-danger"></i> <span
								key="t-logout"><?php echo $Lang['log_out']; ?></span></a>
					</div>
				</div>
				<?php else: ?>
				<div class="pointer d-flex align-items-center">
					<a href="/login" class="text-dark"><?php echo $Lang['please_login']; ?></a>
				</div>
				<?php endif; ?>

			</div>
		</div>
	</header>

	<!-- ========== Left Sidebar Start ========== -->
<?php if($Userinfo): ?>
<div class="vertical-menu">
	<div data-simplebar class="h-100">
		<!--- Sidemenu -->
		<div id="sidebar-menu" class="menu-js">
			<!-- Left Menu Start -->
			<ul class="metismenu list-unstyled" id="side-menu">
			
				<!-- 临时菜单 -->
				<!-- <li>
					<a href="/credit" class="waves-effect">
						<i class="bx bx-home-circle"></i>
						<span>信用额度</span>
					</a>
				</li> -->
				<!-- 临时菜单 -->
				<?php foreach($Nav as $nv): ?>
				<li>
					<a href="<?php if($nv['child']): ?>javascript: ;<?php else: ?><?php echo $nv['url']; ?><?php endif; ?>" class="<?php if($nv['child']): ?>has-arrow<?php endif; ?> waves-effect">
						<?php if($nv['fa_icon']): ?><i class="<?php echo $nv['fa_icon']; ?>"></i><?php endif; if((isset($nv['tag']))): ?>
							<?php echo $nv['tag']; ?>
						<?php endif; ?>
						<span><?php echo $nv['name']; ?></span>
					</a>
					<?php if($nv['child']): ?>
					<ul class="sub-menu mm-collapse" aria-expanded="false">
						<?php foreach($nv['child'] as $subnav): ?>
						<li>
							<a href="<?php if($subnav['child']): ?>javascript: ;<?php else: ?><?php echo $subnav['url']; ?><?php endif; ?>"
								class="<?php if($subnav['child']): ?>has-arrow<?php endif; ?> waves-effect">
								<?php if($subnav['fa_icon']): ?><i class="<?php echo $subnav['fa_icon']; ?>"></i><?php endif; if((isset($subnav['tag']))): ?>
									<?php echo $subnav['tag']; ?>
								<?php endif; ?>
								<span><?php echo $subnav['name']; ?></span>
							</a>
							<?php if($subnav['child']): ?>
							<ul class="sub-menu" aria-expanded="false">
								<?php foreach($subnav['child'] as $submenu): ?>
								<li>
									<a href="<?php if($submenu['child']): ?>javascript: ;<?php else: ?><?php echo $submenu['url']; ?><?php endif; ?>"
										class="<?php if($submenu['child']): ?>has-arrow<?php endif; ?> waves-effect">
										<?php if($submenu['fa_icon']): ?><i class="<?php echo $submenu['fa_icon']; ?>"></i><?php endif; if((isset($submenu['tag']))): ?>
											<?php echo $submenu['tag']; ?>
										<?php endif; ?>
										<span><?php echo $submenu['name']; ?></span>
									</a>
								</li>
								<!-- Nav Level 3 -->
								<?php endforeach; ?>
							</ul>
							<?php endif; ?>
						</li>
						<!-- Nav Level 2 -->
						<?php endforeach; ?>
					</ul>
					<?php endif; ?>
				</li>
				<!-- Nav Level 1 -->
				<?php endforeach; ?>
			</ul>
		</div>
		<!-- Sidebar -->
	</div>
</div>
<?php else: ?>
<div class="vertical-menu menu-js">
	<div data-simplebar class="h-100">
		<!--- Sidemenu -->
		<div id="sidebar-menu" class="menu-js">
			<!-- Left Menu Start -->
			<ul class="metismenu list-unstyled" id="side-menu">
				<li>
					<a href="/clientarea" class="waves-effect">
						<i class="bx bx-home-circle"></i>
						<span>首页</span>
					</a>
				</li>
				<li>
					<a href="/login" class="waves-effect">
						<i class="bx bx-user"></i>
						<span>登录</span>
					</a>
				</li>
				<li>
					<a href="/register" class="waves-effect">
						<i class="bx bx-user"></i> 
						<span>注册</span>
					</a>
				</li>
				<li>
					<a href="/cart" class="waves-effect">
						<i class="bx bx-cart-alt"></i>
						<span>订购产品</span>
					</a>
				</li>
				<li>				
					<a href="/news" class="waves-effect">
						<i class="bx bx-detail"></i>
						<span>新闻中心</span>
					</a>
				</li>
				<li>				
					<a href="/knowledgebase" class="waves-effect">
						<i class="bx bx-detail"></i>
						<span>帮助中心</span>
					</a>
				</li>
				<li>				
					<a href="/downloads" class="waves-effect">
						<i class="bx bx-download"></i>
						<span>资源下载</span>
					</a>
				</li>
			</ul>
		</div>
		<!-- Sidebar -->
	</div>
</div>
<?php endif; ?>


	<div class="main-content">
		<div class="page-content">
			<?php if($TplName != 'clientarea'): ?>
			
<div class="container-fluid">
    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <?php if($TplName == 'viewbilling'): ?>
                <h4 class="mb-0 font-size-18"><?php echo $Title; ?> - <?php echo $Get['id']; ?></h4>
                <?php else: ?>
                <div style="display:flex;">
                    
                    <a href="javascript:history.go(-1)" class="backBtn" style="display: none;"><i class="bx bx-chevron-left" style="font-size: 32px;margin-top: 1px;color: #555b6d;"></i></a>
                    <h4 class="mb-0 font-size-18"><?php echo $Title; ?></h4>
                </div>
                <?php endif; ?>
                <div class="page-title-right">
	                <?php if(!$ShowBreadcrumb): ?>
                    <ol class="breadcrumb m-0">
    <li class="breadcrumb-item"><a href="javascript: void(0);"><?php echo $Lang['title_clientarea']; ?></a></li>
    <li class="breadcrumb-item active"><?php echo $Title; ?></li>
</ol>
                    <?php endif; ?>
                </div>

            </div>
        </div>
    </div>
    <!-- end page title -->    
</div>
<script>
    $(function(){
        $('.backBtn').hide()
    })
</script>
			<?php endif; ?>
			<div class="container-fluid">
				<?php endif; if($ErrorMsg): ?>
<!-- <div class="alert alert-danger mb-4">
	<div class="alert-body"></div>
</div> -->
<script type="text/javascript">
	$(function () {
		toastr.error('');
	});
</script>
<?php endif; if($SuccessMsg): ?>
<script type="text/javascript">
	$(function () {
		toastr.success('');
		setTimeout(function () {
			var url = '[url]'
			if (url) {
				location.href = url
			}
		}, 500);
	});
</script>
<?php endif; ?>
  
 
<script src="/themes/clientarea/default/assets/js/crypto-js.min.js" type="text/javascript"></script>
<script src="/themes/clientarea/default/assets/js/public.js" type="text/javascript"></script>

<style>
		.logo.text-center img{height:50px;}
    .list-inline-item .icon {
        width: 2rem;
        height: 2rem;
    }
    .social-list-item {
        border: none;
    }
    .input-group-prepend {
        width: 100px;
    }
	.allow_login_code_captcha{display:none;}
	.auth-full-bg .bg-overlay {
		background: url(/themes/clientarea/default/assets_custom/img/new-background.jpg)no-repeat left top / 100% 1400px;
		background-size: cover;
		opacity:1;
	}
  .form-control,.input-group-append{
    height: 46px;
  }
</style>
<script type="text/javascript">
    var mk = '<?php echo $Setting['msfntk']; ?>';
</script>
<div class="container-fluid p-0">
    <?php if($Setting['login_header']): ?>
    <div class="text-center"><?php echo $Setting['login_header']; ?></div>
    <?php endif; ?>
    <div class="row no-gutters">

        <div class="col-xl-7 bglogo">
            <div class="auth-full-bg pt-lg-5 p-4">
                <div class="w-100">
				
					<?php if($Setting['custom_login_background_img']): ?>
                    <div class="bg-overlay" style="background: url(<?php echo $Setting['custom_login_background_img']; ?>) center no-repeat !important; background-size:cover !important;"></div>
					<?php else: ?>
                    <div class="bg-overlay"></div>
					<?php endif; ?>
                    <div class="d-flex h-100 flex-column justify-content-center">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="text-center">
                                    <div dir="ltr">
                                        <div class="owl-carousel owl-theme auth-review-carousel"
                                            id="auth-review-carousel">
                                            <div class="item">
                                                <div class="py-3">
                                                    <h1 class="text-white text-left">
                                                        <?php echo $Setting['custom_login_background_char']; ?></h1>
                                                    <p class="text-white-50 text-left">
                                                        <?php echo $Setting['custom_login_background_description']; ?></p>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end col -->

        <div class="col-xl-5">
            <div class="auth-full-page-content p-md-5 p-4">
                <div class="login_right mx-auto">
                    <div class="d-flex flex-column h-100">
                        <div class="my-auto">
                            <div  class="logo text-center" >
                              <a href="<?php echo $Setting['web_jump_url']; ?>"><img  src="<?php echo $Setting['web_logo']; ?>" alt="" class="cursor"></a>
                            </div>
                            <ul class="affs-nav nav nav-tabs nav-tabs-custom nav-justified" role="tablist">

								<!-- 手机 -->
								<?php if($Login['allow_login_phone']==1): ?>
									<li class="nav-item">
										<a class="nav-link fs-14 bg-transparent <?php if($Get['action']=="phone" || $Get['action']=="phone_code" || !$Get['action']): ?>active<?php endif; ?>" data-toggle="tab" href="#phone" role="tab" aria-selected="false"><?php echo $Lang['mobile_login']; ?>
										</a>
									</li>
								<?php endif; if($Login['allow_login_email']==0 && $Login['allow_id']==1): ?>
									<li class="nav-item">
										<a class="nav-link fs-14 bg-transparent <?php if(($Login['allow_login_phone']==0 && $Login['allow_id'] == 1)): ?>active<?php endif; ?>" data-toggle="tab" href="#email" role="tab" aria-selected="false"><?php echo $Lang['id_login']; ?></a>
									</li>
								<?php endif; ?>

								<!-- 邮箱 -->
                                <?php if($Login['allow_login_email']): ?>
                                <li class="nav-item">
                                    <a class="nav-link fs-14 bg-transparent <?php if(($Login['allow_login_phone']==0 && $Login['allow_login_email'] == 1  && $Login['allow_id'] == 0) || $Get['action']=="email"): ?>active<?php endif; ?> " data-toggle="tab" href="#email" role="tab" aria-selected="true"><?php echo $Lang['email_login']; ?></a>
                                </li>
                                <?php endif; ?>
                                
                            </ul>

                            <div class="mt-4">
								<div class="tab-content">
									<?php if($Login['allow_login_email'] || $Login['allow_id']): ?>
									<div id="email" class="tab-pane  <?php if(($Login['allow_login_phone']==0 && ($Login['allow_login_email'] == 1  || $Login['allow_id'] == 1)) || $Get['action']=="email"): ?>active<?php endif; ?>" role="tabpanel">
										<form method="post" action="/login?action=email" onsubmit="return encryptPass('emailPwdInp');" ><input type="hidden" name="token" value="<?php echo $Token; ?>">										
											<div class="form-group">
												<label for="username"><?php if($Login['allow_login_email']): ?><?php echo $Lang['mailbox']; else: ?>ID<?php endif; ?></label>
												<input type="text" class="form-control" id="emailInp" name="email" value="<?php echo $Post['email']; ?>" placeholder="<?php echo $Lang['please_enter_your']; if($Login['allow_login_email']): ?><?php echo $Lang['mailbox']; if($Login['allow_id']==1): ?><?php echo $Lang['ors']; ?><?php endif; ?><?php endif; if($Login['allow_id']==1): ?>ID<?php endif; ?>">
											</div>
											<div class="form-group">
												<div class="d-flex justify-content-between">
													<label for="userpassword"><?php echo $Lang['password']; ?></label>
												</div>
												<input type="password" class="form-control" id="emailPwdInp" name="password" placeholder="<?php echo $Lang['please_enter_password']; ?>">
											</div>
											<?php if($Login['allow_login_email_captcha']==1 && $Login['is_captcha']==1): if($Verify['is_captcha']==1): if(top=='top'): ?>
<div class="form-group allow_login_email_captcha">
    <label >图形验证码</label>
    <div class="input-group">
      <input  <?php if([id]=='[id]'): ?>id="captcha_allow_login_email_captcha[id]"<?php else: ?>id="captcha_allow_login_email_captcha"<?php endif; ?> type="text" name="captcha" class="form-control "  placeholder="请输入验证码" />
      <div class="input-group-append">
        <img  <?php if([id]=='[id]'): ?>id="allow_login_email_captcha[id]"<?php else: ?>id="allow_login_email_captcha"<?php endif; ?>   width="120px" class="border pointer" alt="验证码" onClick="getVerify('allow_login_email_captcha')">
      </div>
    </div>
</div>
<?php else: ?>

<div class="form-group row">
  <label class="col-sm-3 col-form-label text-right">图形验证码</label>
  <div class="col-sm-8">
    <div class="input-group">
      <input <?php if([id]=='[id]'): ?>id="captcha_allow_login_email_captcha[id]"<?php else: ?>id="captcha_allow_login_email_captcha"<?php endif; ?> type="text" name="captcha" class="form-control "  placeholder="请输入验证码" />
      <div class="input-group-append">
        <img <?php if([id]=='[id]'): ?>id="allow_login_email_captcha[id]"<?php else: ?> id="allow_login_email_captcha"<?php endif; ?>  width="120px" class="border pointer" alt="验证码" onClick="getVerify('allow_login_email_captcha','[id]')">
      </div>
    </div>
  </div>
</div>
<?php endif; ?>



<script>
  getVerify('allow_login_email_captcha','[id]')

</script>
<?php endif; ?>
											<?php endif; ?>				
                      <div class="d-flex justify-content-between">
													<label for="userpassword"></label>
														<a href="pwreset" class="text-primary mr-0"><?php echo $Lang['forget_the_password']; ?></a>
												</div>							
											<div class="mt-3">
												<?php if($Login['second_verify_action_home_login']==1): ?>
												<!--二次登录验证-->
												<button class="btn btn-primary py-2 fs-14 btn-block waves-effect waves-light  d-flex justify-content-center align-items-center"
													type="button"  onclick="loginBefore('email');"><?php echo $Lang['sign_in']; ?></button>
												<?php else: ?>
												<button class="btn btn-primary py-2 fs-14 btn-block waves-effect waves-light d-flex justify-content-center align-items-center"
													type="submit"><?php echo $Lang['sign_in']; ?></button>
												<?php endif; ?>												
											</div>
										</form>
									</div>
									<?php endif; if($Login['allow_login_phone']): ?>
									<div id="phone" class="tab-pane <?php if($Get['action']=="phone" || $Get['action']=="phone_code" || !$Get['action']): ?>active<?php endif; ?>" role="tabpanel">
										<form method="post" action="/login?action=phone" onsubmit="return encryptPass('phonePwdInp');" ><input type="hidden" name="token" value="<?php echo $Token; ?>">
											<div class="form-group">
												<label for="username"><?php echo $Lang['phone_number']; ?></label>
												<div class="input-group">
													<?php if($Login['allow_login_register_sms_global']==1): ?>
													<div class="input-group-prepend">
														<select class="form-control select2 select2-hidden-accessible"
															data-select2-id="1" tabindex="-1" aria-hidden="true"
															name="phone_code"  value="<?php echo $Post['phone_code']; ?>"  id="phoneCodeSel">
															<?php foreach($SmsCountry as $list): ?>
															<option value="<?php echo $list['phone_code']; ?>" <?php if($list['phone_code']=="+86"): ?>selected <?php endif; ?>>
																<?php echo $list['link']; ?>
															</option>
															<?php endforeach; ?>
														</select>
													</div>
													<?php endif; ?>
													<input type="text" class="form-control" id="phoneInp" name="phone"  value="<?php echo $Post['phone']; ?>"  placeholder="<?php echo $Lang['please_enter_your_mobile_phone_number']; ?>">
												</div>
											</div>
											<div class="form-group allow_login_phone_captcha">
												<div class="d-flex justify-content-between">
													<label for="userpassword"><?php echo $Lang['password']; ?></label>
												</div>
												<input type="password" class="form-control" id="phonePwdInp" name="password" placeholder="<?php echo $Lang['please_enter_password']; ?>">
											</div>
											<?php if($Login['allow_login_phone_captcha']==1 && $Login['is_captcha']==1): if($Verify['is_captcha']==1): if(top=='top'): ?>
<div class="form-group allow_login_phone_captcha">
    <label >图形验证码</label>
    <div class="input-group">
      <input  <?php if([id]=='[id]'): ?>id="captcha_allow_login_phone_captcha[id]"<?php else: ?>id="captcha_allow_login_phone_captcha"<?php endif; ?> type="text" name="captcha" class="form-control "  placeholder="请输入验证码" />
      <div class="input-group-append">
        <img  <?php if([id]=='[id]'): ?>id="allow_login_phone_captcha[id]"<?php else: ?>id="allow_login_phone_captcha"<?php endif; ?>   width="120px" class="border pointer" alt="验证码" onClick="getVerify('allow_login_phone_captcha')">
      </div>
    </div>
</div>
<?php else: ?>

<div class="form-group row">
  <label class="col-sm-3 col-form-label text-right">图形验证码</label>
  <div class="col-sm-8">
    <div class="input-group">
      <input <?php if([id]=='[id]'): ?>id="captcha_allow_login_phone_captcha[id]"<?php else: ?>id="captcha_allow_login_phone_captcha"<?php endif; ?> type="text" name="captcha" class="form-control "  placeholder="请输入验证码" />
      <div class="input-group-append">
        <img <?php if([id]=='[id]'): ?>id="allow_login_phone_captcha[id]"<?php else: ?> id="allow_login_phone_captcha"<?php endif; ?>  width="120px" class="border pointer" alt="验证码" onClick="getVerify('allow_login_phone_captcha','[id]')">
      </div>
    </div>
  </div>
</div>
<?php endif; ?>



<script>
  getVerify('allow_login_phone_captcha','[id]')

</script>
<?php endif; ?>
											<?php endif; if($Login['allow_login_code_captcha']==1 && $Login['is_captcha']==1): if($Verify['is_captcha']==1): if(top=='top'): ?>
<div class="form-group allow_login_code_captcha">
    <label >图形验证码</label>
    <div class="input-group">
      <input  <?php if([id]=='[id]'): ?>id="captcha_allow_login_code_captcha[id]"<?php else: ?>id="captcha_allow_login_code_captcha"<?php endif; ?> type="text" name="captcha" class="form-control "  placeholder="请输入验证码" />
      <div class="input-group-append">
        <img  <?php if([id]=='[id]'): ?>id="allow_login_code_captcha[id]"<?php else: ?>id="allow_login_code_captcha"<?php endif; ?>   width="120px" class="border pointer" alt="验证码" onClick="getVerify('allow_login_code_captcha')">
      </div>
    </div>
</div>
<?php else: ?>

<div class="form-group row">
  <label class="col-sm-3 col-form-label text-right">图形验证码</label>
  <div class="col-sm-8">
    <div class="input-group">
      <input <?php if([id]=='[id]'): ?>id="captcha_allow_login_code_captcha[id]"<?php else: ?>id="captcha_allow_login_code_captcha"<?php endif; ?> type="text" name="captcha" class="form-control "  placeholder="请输入验证码" />
      <div class="input-group-append">
        <img <?php if([id]=='[id]'): ?>id="allow_login_code_captcha[id]"<?php else: ?> id="allow_login_code_captcha"<?php endif; ?>  width="120px" class="border pointer" alt="验证码" onClick="getVerify('allow_login_code_captcha','[id]')">
      </div>
    </div>
  </div>
</div>
<?php endif; ?>



<script>
  getVerify('allow_login_code_captcha','[id]')

</script>
<?php endif; ?>
											<?php endif; ?>
                      
											<div class="form-group allow_login_code_captcha">
												<label for="code"><?php echo $Lang['verification_code']; ?></label>
												<div class="input-group">
													<input type="text" class="form-control" id="phoneCodeInp" name="code"  value="<?php echo $Post['code']; ?>" placeholder="<?php echo $Lang['please_enter_code']; ?>">
													<div class="input-group-append"  style="height:46px;">
														<button class="btn btn-primary" type="button" style="line-height:33px;"  onclick="getCode(this,'login_send','allow_login_code_captcha')"><?php echo $Lang['get_code']; ?></button>
													</div>
												</div>
											</div>

											
											
											<div class="d-flex justify-content-between align-items-center">
												<div onclick="phoneCheck(this,'allow_login_phone_captcha')" class="text-primary mr-0 pointer" <?php if($Get['action']=="phone_code"): ?> style="display:none;" <?php endif; ?>>
													<?php echo $Lang['verification_code_login']; ?>
												</div>
												<div onclick="phoneCheck(this,'allow_login_code_captcha')" class="text-primary mr-0 pointer" <?php if($Get['action']!="phone_code"): ?> style="display:none;" <?php endif; ?>>
													<?php echo $Lang['password_login']; ?>
												</div>
                        <a href="pwreset" class="text-primary mr-0"><?php echo $Lang['forget_the_password']; ?></a> 
											</div>
											<div class="mt-3">
												<?php if($Login['second_verify_action_home_login']==1): ?>
												<!--二次登录验证-->
												<button class="btn btn-primary py-2 fs-14 btn-block waves-effect waves-light  justify-content-center align-items-center allow_login_phone_captcha" type="button"  onclick="loginBefore('phone');"><?php echo $Lang['sign_in']; ?></button>
												<button class="btn btn-primary py-2 fs-14 btn-block waves-effect waves-light  justify-content-center align-items-center allow_login_code_captcha" type="submit"><?php echo $Lang['sign_in']; ?></button>
												<?php else: ?>
                      
												<button class="btn btn-primary py-2 fs-14 btn-block waves-effect waves-light  justify-content-center align-items-center"
													type="submit"><?php echo $Lang['sign_in']; ?></button>
												<?php endif; ?>												
											</div>
										</form>
									</div>
									<?php endif; ?>
								</div>
                            </div>

                            <?php if($Oauth): ?>
                            <div class="mt-4 text-center">
                                <h5 class="font-size-14 mb-3"><?php echo $Lang['use_other_login']; ?></h5>

                                <ul class="list-inline">
                                    <?php foreach($Oauth as $list): ?>
                                    <li class="list-inline-item">
                                        <a href="<?php echo $list['url']; ?>" class="social-list-item text-white" target="blank">
                                            <?php echo $list['img']; ?>
                                        </a>
                                    </li>
                                    <?php endforeach; ?>
                                </ul>
                            </div>
                            <?php endif; ?>

                            <div class="mt-5 text-center">
                                <p><?php echo $Lang['no_account_yet']; ?> <a href="register" class="font-weight-medium text-primary"> <?php echo $Lang['register_now']; ?> </a>
                                </p>
                            </div>

                        </div>

                    </div>


                </div>
            </div>
        </div>
        <!-- end col -->
    </div>

    <?php if($Setting['login_footer']): ?>
    <div class="text-center"><?php echo $Setting['login_footer']; ?></div>
    <?php endif; ?>
    <!-- end row -->
</div>
<!-- end container-fluid -->

<?php if($Login['second_verify_action_home_login']==1): ?>
<!--登录二次验证 模态框-->
<div class="modal fade" id="secondVerifyModal" tabindex="-1" role="dialog" aria-labelledby="secondVerifyModal"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"><?php echo $Lang['secondary_verification']; ?></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="<?php echo $Token; ?>" />
					<input type="hidden" value="closed" name="action" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right"><?php echo $Lang['verification_method']; ?></label>
						<div class="col-sm-8">
							<select class="form-control" class="second_type" name="type" id="secondVerifyType">
								
							</select>
						</div>
					</div>
            	<!--忘记密码-->
                       
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right"><?php echo $Lang['verification_code']; ?></label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="secondVerifyCode" class="form-control" placeholder="<?php echo $Lang['please_enter_code']; ?>" />
								<div class="input-group-append" style="height:46px;" id="getCodeBox">
									<button class="btn btn-secondary"  type="button"  onclick="getCode(this,'login/second_verify_send')"  style="line-height:33px;" type="button"><?php echo $Lang['get_code']; ?></button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-light" data-dismiss="modal"><?php echo $Lang['cancel']; ?></button>
				<button type="button" class="btn btn-primary mr-2" id="secondVerifySubmit"><?php echo $Lang['determine']; ?></button>
			</div>
		</div>
	</div>
</div>
<?php endif; ?>

<script type="text/javascript">
<?php if($Get['action']=="phone_code"): ?> 
phoneCheck("","allow_login_phone_captcha")
<?php else: ?> 
phoneCheck("","allow_login_code_captcha")
<?php endif; ?>

</script>
<?php if($TplName != 'login' && $TplName != 'register' && $TplName != 'pwreset' && $TplName != 'bind' && $TplName != 'loginaccesstoken'): ?>
</div>
</div>
</div>

<footer class="footer">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-6">
				&copy; <?php echo $Setting['company_name']; ?>.
			</div>
			<div class="col-sm-6">
				<div class="text-sm-right d-none d-sm-block">
					
				</div>
			</div>
		</div>
	</div>
</footer>
<?php endif; ?>
<script src="/themes/clientarea/default/assets/js/app.js?v=<?php echo $Ver; ?>"></script>
<?php $hooks=hook('client_area_footer_output'); if($hooks): foreach($hooks as $item): ?>
		<?php echo $item; ?>
	<?php endforeach; ?>
<?php endif; ?>
</body>

</html>