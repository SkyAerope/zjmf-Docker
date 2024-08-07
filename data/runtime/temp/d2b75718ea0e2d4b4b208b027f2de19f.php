<?php /*a:3:{s:47:"/var/www/html/public/themes/web/zjmf/index.html";i:1720798140;s:55:"/var/www/html/public/themes/web/zjmf/common/header.html";i:1720798140;s:55:"/var/www/html/public/themes/web/zjmf/common/footer.html";i:1720798140;}*/ ?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>首页 - <?php echo $setting['company_name']; ?></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="" />
  <meta name="keywords" content="DiCloud" />
  <link href="<?php echo $setting['web_view']; ?>/assets/css/all.min.css" rel="stylesheet">
  <link href="<?php echo $setting['web_view']; ?>/assets/css/base.css" rel="stylesheet">
  <link href="<?php echo $setting['web_view']; ?>/assets/css/fontawesome.css" rel="stylesheet">
  <script src="<?php echo $setting['web_view']; ?>/assets/js/jquery.min.js"></script>
  <script src="<?php echo $setting['web_view']; ?>/assets/js/scripts.min.js"></script>
  <script type="text/javascript">
    $(function(){
      $(".menu_down").hover(function (){  
            $(this).find('ul').show();  
        },function (){  
            $(this).find('ul').hide();    
        }); 
    })
  </script>

</head>

<body>
   <div class="header hasBottom">
  <div class="container">
    <nav class="zjmf navbar navbar-default">
      <div class="row">
        <div class="navbar-header rel idx-1">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" style="background-image:url(<?php echo $setting['web_logo']; ?>)" href="/"></a>
          <div class="login pull-right visible-xs-block">
            <ul>
              
              <li class="pull-left">
                <a href="<?php echo $setting['web_url']; ?>/login"><?php echo $Lang['login']; ?></a>
              </li>
              <li class="pull-left">
                <a href="<?php echo $setting['web_url']; ?>/register"><?php echo $Lang['register']; ?></a>
              </li>
              
            </ul>
          </div>
        </div>
        <div class="navbar-collapse collapse" id="bs-example-navbar-collapse-1" aria-expanded="false" style="height: 1px;">
          <ul class="nav navbar-nav">

            <?php foreach($www_top as $key =>$val): ?>
              <li class="<?php if((in_array($val['nav_type'],[1,2]))): ?> dropdown static <?php endif; ?>">
              <!-- ------------一级菜单 ---start------------------- -->
              <?php if((!isset($val['son']))): ?>
              <a href="<?php echo $val['url']; ?>"><?php echo $val['name']; ?></a>
              <?php endif; if((isset($val['son']))): ?>
              <a href="#" data-toggle="dropdown" class="dropdown-toggle"><?php echo $val['name']; ?><span class="caret"></span></a>
              <?php endif; ?>
              <!-- ------------一级菜单 ---end------------------- -->

              <!-- -----------二级菜单 ---start------------------- -->
              <?php if((isset($val['son']))): if((in_array($val['nav_type'],[1,2]))): ?>
                      <ul class="dropdown-menu fullwidth">
                        <?php foreach($val['son'] as $k =>$v): ?>
                        <li class="w<?php echo count($val['son']); ?>">
                          <dl>
                            <dt><?php echo $v['name']; ?></dt>
                            <!-- 一级分组-商品分组 | 商品分组-商品  三级菜单 -->
                            <?php if((isset($v['son']))): foreach($v['son'] as $vs_k => $vs_v): ?>
                            <dd>
                              <a href="<?php echo $vs_v['url']; ?>"><?php echo $vs_v['name']; ?></a>
                            </dd>
                            <?php endforeach; ?>
                            <?php endif; ?>
                          </dl>
                        </li>
                        <?php endforeach; ?>
                      </ul>
                  <?php endif; if((!in_array($val['nav_type'],[1,2]))): ?>
                    <ul class="dropdown-menu fullwidth noLeft">
                      <?php foreach($val['son'] as $k =>$v): ?>
                        <li class="w50">
                          <?php if((!isset($v['son']))): ?>
                            <a href="<?php echo $v['url']; ?>" <?php if((isset($v['tag']))): ?> <?php echo $v['tag']; ?> <?php endif; ?>><?php echo $v['name']; ?></a>
                          <?php endif; if((isset($v['son']))): ?>
                            <a href="#" <?php if((isset($v['tag']))): ?> <?php echo $v['tag']; ?> <?php endif; ?>><?php echo $v['name']; ?><span class="caret"></span></a>
                          <?php endif; if((isset($v['son']))): ?>
                            <ul>
                              <?php foreach($v['son'] as $vs_k => $vs_v): ?>
                                  <li>
                                      <a href="<?php echo $vs_v['url']; ?>" <?php if((isset($vs_v['tag']))): ?> <?php echo $vs_v['tag']; ?> <?php endif; ?>><?php echo $vs_v['name']; ?></a>
                                  </li>
                              <?php endforeach; ?>
                            </ul>
                          <?php endif; ?>
                        </li>
                      <?php endforeach; ?>
                    </ul>
                  <?php endif; ?>

              <?php endif; ?>
              <!-- ------------二级菜单 ---end------------------- -->
            </li>
            <?php endforeach; ?>
            
            
          </ul>
          <ul class="nav navbar-nav navbar-right visible-lg-block">
           
           <?php if($userInfo): ?>
           <li class=""><a href="<?php echo $setting['web_url']; ?>/clients.html#/user-center">控制台</a></li>
            <li class="register">
              <a href="<?php echo $setting['web_url']; ?>/logout">退出账户</a>
            </li>
           <?php else: ?>
            <li class=""><a href="<?php echo $setting['web_url']; ?>/login"><?php echo $Lang['login']; ?></a></li>
            <li class="register">
              <a href="<?php echo $setting['web_url']; ?>/register"><?php echo $Lang['register']; ?></a>
            </li>
           <?php endif; ?>
          </ul>
        </div>
      </div>
    </nav>
  </div>
</div>
   		<script src="https://cdnjs.loli.net/ajax/libs/Swiper/4.5.0/js/swiper.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.loli.net/ajax/libs/Swiper/4.5.0/css/swiper.min.css" />

		<section class="wrap-main-swiper">
			<div class="swiper-container">
			    <div class="swiper-wrapper">
			        <div class="swiper-slide banner1">
				        <div class="content-slide container">
							<p class="slogan">服务器租用托管行业<br/>创新企业</p>
							<p class="sub-slogan pt20">不断革新服务器租用的产品和服务<br/>为用户提供个性化的主机租用和网络应用解决方案</p>
							<p class="event-title pt20">全自动化操作，30分钟上线服务器。</p>
							<p class="pt50 hidden"><a href="#" class="btn btn-outline-success btn-lg">查看更多</a></p>
						</div>
				    </div>
			        <div class="swiper-slide banner2">
				        <div class="content-slide container">
							<p class="slogan">轻服务器上线<br/> 带来完美用户体验</p>
							<p class="sub-slogan pt20">强大管理平台,可自主重启、重装系统、配置环境<br/> 平台数据安全多副本备份，设备数据自主管控</p>
							<p class="event-title pt20">全中文控制面板，可以便捷快速的控制你的服务器。</p>
							<p class="pt50 hidden"><a href="#" class="btn btn-outline-success btn-lg">查看更多</a></p>
						</div>
				    </div>
			        <div class="swiper-slide banner3">
				        <div class="content-slide container">
							<p class="slogan">因为专注所以专业<br/>致力于行业领跑者</p>
							<p class="sub-slogan pt20">降低中小企业上云门槛<br/>安全合规，让您的业务轻松上云</p>
							<p class="event-title pt20">专业的售前团队已经做好准备，随时为您提供全面的售前服务支持</p>
							<p class="pt50 hidden"><a href="#" class="btn btn-outline-success btn-lg">查看更多</a></p>
						</div>
				    </div>
			    </div>
			    <!-- 如果需要分页器 -->
			    <div class="swiper-pagination"></div>

			    <!-- 如果需要导航按钮 -->
	    	    <div class="swiper-btn-prev">
			        <i class="fa fa-angle-left"></i>
			    </div>
	    	    <div class="swiper-btn-next">
			        <i class="fa fa-angle-right"></i>
	    	    </div>
			</div>
		</section>
			<script type="text/javascript">
	$(document).ready(function () {     
		var mySwiper = new Swiper ('.swiper-container', {
			// 如果需要分页器
			pagination: {
				el: '.swiper-pagination',
			},
			// 如果需要前进后退按钮
			navigation: {
				nextEl: '.swiper-btn-next',
				prevEl: '.swiper-btn-prev',
			},
			autoplay: {
				delay: 6000,
				disableOnInteraction: false,
			},		
			loop: true,
			keyboardControl: false,
			paginationClickable: true,
			calculateHeight: true
		});
	});      
	</script>
<!-- 
		<section class="home-event-mod hidden-xs">
			<div class="container">
				<div class="c-grid">
					<div class="c-g-4">
						<a href="ssl.html" class="item">
							<h2 class="item-title">扶持计划</h2>
							<div class="item-text">助力于赋能企业，降低 IT 成本和研发成本</div>
						</a>
					</div>
					<div class="c-g-4">
						<a href="" class="item">
							<h2 class="item-title">最新促销活动</h2>
							<div class="item-text">最新活动专区，您可了解当前所有优惠活动</div>
						</a>
					</div>
					<div class="c-g-4">
						<a href="" class="item">
							<h2 class="item-title">高防服务器</h2>
							<div class="item-text">Anycast近源清洗，智能人机识别，多维度攻击防护</div>
						</a>
					</div>
					<div class="c-g-4">
						<a href="" class="item">
							<h2 class="item-title">CNNIC会员单位</h2>
							<div class="item-text">数据中心覆盖全国地域，为您提供稳定，高速的体验</div>
						</a>
					</div>
				</div>
			</div>
		</section> -->


		<section class="space">
			<div class="newHome-service">
				<div class="container">
					<div class="host-model pb60">
					  <div class="hometitleSpan tac"><span>提供安全合规的云计算服务</span></div>
					  <div class="tac" style="margin-bottom: 30px;"><span style="font-size: 16px;color: #999999;">计算、存储、监控、安全，完善的云产品满足你业务的全面需求</span></div>
					  <div class="newHome-service-div row">
						<div class="col-md-4 col-sm-12">
							<div class="service-div-content">
								<div class="service-div-img">
									<img class="sslImg" src="<?php echo $setting['web_view']; ?>/assets/img/newImg/ssl_home.png" alt="">
								</div>
								<div class="service-div-text">
									<div>SSL</div>
									<div>实现网站HTTPS化，使网站可信，防劫持，防篡改，防监听。并对云上证书进行统一生命周期管理，简化证书部署</div>
								</div>
								<div class="service-div-btn">
									<div class="understand-btn">
										<a href="ssl.html">了解更多</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-sm-12">
							<div class="service-div-content">
								<div class="service-div-img">
									<img class="cloudServerImg" src="<?php echo $setting['web_view']; ?>/assets/img/newImg/cloud_server.png" alt="">
								</div>
								<div class="service-div-text">
									<div>云服务器</div>
									<div>实现网站HTTPS化，使网站可信，防劫持，防篡改，防监听。并对云上证书进行统一生命周期管理，简化证书部署</div>
								</div>
								<div class="service-div-btn">
									<div class="understand-btn">
										<a href="cloud.html">了解更多</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-sm-12">
							<div class="service-div-content">
								<div class="service-div-img">
									<img class="standAloneServerImg" src="<?php echo $setting['web_view']; ?>/assets/img/newImg/stand_alone_server.png" alt="">
								</div>
								<div class="service-div-text">
									<div>独立服务器</div>
									<div>实现网站HTTPS化，使网站可信，防劫持，防篡改，防监听。并对云上证书进行统一生命周期管理，简化证书部署</div>
								</div>
								<div class="service-div-btn">
									<div class="understand-btn">
										<a href="server.html">了解更多</a>
									</div>
								</div>
							</div>
						</div>
					  </div>
				  </div>
				</div>
			  </div>
		</section>
		<section class="space">
			<div class="newHomePage">
				<div class="container" style="height: 100%;">
					<div class="newHomePageBackground">
						<div style="text-align: center;">
							<div style="font-size: 30px;font-weight: 400;color: #fff;">严苛标准打造强悍性能体验</div>
							<div style="font-size: 14px;font-weight: 400;color: #77798F;margin:20px 0px 30px;">高标准设备、架构与灾备机制，为您提供全面而立体的保障</div>
						</div>
						<div class="row">
							<div class="newHomebackground col-md-4 col-sm-12">
								<div>
									<img src="<?php echo $setting['web_view']; ?>/assets/img/newImg/homePage_usability.png" alt="">
								</div>
								<div>
									<div style="font-size: 18px;font-weight: 400;color: #868797;">服务可用性</div>
									<div style="font-size: 24px;font-weight: 400;color: #868797;">99.9%</div>
								</div>
							</div>
							<div class="newHomebackground col-md-4 col-sm-12">
								<div>
									<img src="<?php echo $setting['web_view']; ?>/assets/img/newImg/homePage_copy.png" alt="">
								</div>
								<div>
									<div style="font-size: 18px;font-weight: 400;color: #868797;">服务可用性</div>
									<div style="font-size: 24px;font-weight: 400;color: #868797;">99.9%</div>
								</div>
							</div>
							<div class="newHomebackground col-md-4 col-sm-12">
								<div>
									<img src="<?php echo $setting['web_view']; ?>/assets/img/newImg/homePage_data.png" alt="">
								</div>
								<div>
									<div style="font-size: 18px;font-weight: 400;color: #868797;">服务可用性</div>
									<div style="font-size: 24px;font-weight: 400;color: #868797;">99.9%</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="space">
			<div class="pro-appScenario">
				<div class="container">
				  <div class="host-model pb60">
					<div class="appScenario row">
					  <div class="col-md-4">
						<div>
						  <img src="<?php echo $setting['web_view']; ?>/assets/img/newImg/newHomedeploy.png" alt="">
						</div>
						<div>
						  	<p style="font-size: 20px;font-weight: 400;color: #000000;margin:20px 0px;">
							<span style="font-weight: bold;">快速部署-</span>Rapid deployment
							</p>
						  	<span style="font-size: 16px;font-weight: 400;color: #666666;line-height: 26px;">专业成熟的一站式行业云解决方案， 解决用户快速应用云计算</span>
						</div>
					  </div>
					  <div class="col-md-4">
						<div>
						  <img src="<?php echo $setting['web_view']; ?>/assets/img/newImg/newHomesupport.png" alt="">
						</div>
						<div>
							<p style="font-size: 20px;font-weight: 400;color: #000000;margin:20px 0px;"><span style="font-weight: bold;">技术支援-</span>Technical support</p>
							<span style="font-size: 16px;font-weight: 400;color: #666666;line-height: 26px;">技术支援团队7X24小时在线随时为您效劳。 通过多种方式快速解决遇到的问题</span>
						</div>
					  </div>
					  <div class="col-md-4">
						<div>
						  <img src="<?php echo $setting['web_view']; ?>/assets/img/newImg/newHomeservice.png" alt="">
						</div>
						<div>
						  <p style="font-size: 20px;font-weight: 400;color: #000000;margin:20px 0px;"><span style="font-weight: bold;">服务能力-</span>Service capability</p>
						  <span style="font-size: 16px;font-weight: 400;color: #666666;line-height: 26px;">快速响应用户需求，提供专业、贴心、 高效的售后服务</span>
						</div>
					  </div>
					</div>
				  </div>
				</div>
			  </div>
		</section>
		<section class="space2x" style="position: relative;">
			<div class="bg-holder overlay" style="background-image:url(<?php echo $setting['web_view']; ?>/assets/img/group.jpg);background-position: center top;"></div>
			<div class="container">
				<div class="row text-center">
					<div class="col-lg-8 col-lg-offset-2">
						<p class="fs-3 fs-sm-4 text-light">深受各行业优秀企业的信赖</p>
						<p style="font-size: 14px;font-weight: 400;color: #77798F;">为企业提供核心技术支持，助力企业全面实现智能转型。</p>
					</div>
				</div>
			</div>
		</section>
		<section>
			<div class="map-service">
				<div class="cloud-product">
				  <!-- <p class="cloud-product-title"><span>您的业务可以遍布世界各地</span></p> -->
				  <div class="module-title">
					您的业务可以拓展全球
					<p>网络使人类缩进距离  云计算让文明更上一层楼</p>
				  </div>
				</div>
				<div class="auto map-service-wrapper">
				  <div class="map-service-box clearfix">
					<div class="world-map-wrapper">
					  <div class="world-map">
						<div class="region-list postition-1">
						  <div class="area-box"><span class="dot"></span><span></span></div>
						</div>
						<div class="region-list postition-2 underline-node">
						  <div class="area-box"><span class="dot"></span><span></span></div>
						  <div class="show-regin"></div>
						</div>
						<div class="region-list postition-3">
						  <div class="area-box"><span class="dot"></span><span></span></div>
						</div>
						<div class="region-list postition-4">
						  <div class="area-box"><span class="dot"></span><span></span></div>
						</div>
						<div class="region-list postition-5">
						  <div class="area-box"><span class="dot"></span><span></span></div>
						</div>
						<div class="region-list active postition-6 online-node">
						  <div class="area-box">
							  <img style="width: 18px;height:18px;;" src="<?php echo $setting['web_view']; ?>/assets/img/newImg/stars.png" alt="">
						  </div>
						  <div class="show-regin"></div>
						</div>
						<!-- <div class="region-position-introduce postition-introduce-6">华北</div> -->
						<div class="region-list postition-7 online-node">
						  <div class="area-box"><span class="dot"></span><span></span></div>
						  <div class="show-regin"></div>
						</div>
						<!-- <div class="region-position-introduce postition-introduce-7">华东</div> -->
						<div class="region-list postition-8 online-node">
						  <div class="area-box"><span class="dot"></span><span></span></div>
						  <div class="show-regin"></div>
						</div>
						<!-- <div class="region-position-introduce postition-introduce-8">香港</div> -->
						<div class="region-list active postition-9 online-node">
						  <div class="area-box"><span class="dot"></span><span class="pulse"></span></div>
						  <div class="show-regin"></div>
						</div>
						<!-- <div class="region-position-introduce postition-introduce-9">华南</div> -->
					  </div>
					</div>
				  </div>
				</div>
			
			</div>
		</section>

		<!-- <section class="product space2x">
			<div class="container">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1 text-center">
						<h2 class="section-title">性能强大、安全、稳定的云产品</h2>
						<div class="section-subtitle"><?php echo $setting['company_name']; ?>通过提供多样云服务为您提供无忧的上云体验机会</div>
					</div>
				</div>
				<div class="row productions-brife">
					<div class="col-sm-4">
						<div class="productions-brife-item-can">
							<div class="productions-brife-item-img">
		                    <div class="productions-brife-item-img-under">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/index-compass1.png" alt="">
		                    </div>
		                    <div class="productions-brife-item-img-move">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/index-compass2.png" alt="">
		                    </div>
		          </div>
							<div class="productions-brife-item-sec">
		                    <h1><?php echo $setting['company_name']; ?> NAT</h1>
		                    <h2 class="the-script-of-title">共享IP虚拟服务器 (NAT)</h2>
		                    <p class="the-script-of-detail"><?php echo $setting['company_name']; ?>数据中心覆盖全国多地域，为您提供稳定，高速，高性价比的NAT云服务器，<?php echo $setting['company_name']; ?>NAT 使用快速内存和高性能 CPU，为您提供稳定支持，并以较低时延实现更快的结果</p>
		                    <a href="nat/shcn2/index.html" class="btn btn-primary ">了解详情</a>
		          </div>

						</div>
					</div>
					<div class="col-sm-4">
						<div class="productions-brife-item-can">
							<div class="productions-brife-item-img">
		                    <div class="productions-brife-item-img-under">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/index-clever1.png" alt="">
		                    </div>
		                    <div class="productions-brife-item-img-move">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/index-clever2.png" alt="">
		                    </div>
		          </div>
							<div class="productions-brife-item-sec">
		                    <h1><?php echo $setting['company_name']; ?> VDS</h1>
		                    <h2 class="the-script-of-title">虚拟专用服务器(VDS)</h2>
		                    <p class="the-script-of-detail"><?php echo $setting['company_name']; ?> VDS同时兼具虚拟机弹性和物理机性能及特性,<?php echo $setting['company_name']; ?> VDS 具有 独享套餐硬件资源，具有物理资源独享、部署更灵活、配置更丰富、性价比更高等特点</p>
		                    <a href="products/compass.html" class="btn btn-primary ">了解详情</a>
		          </div>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="productions-brife-item-can">
							<div class="productions-brife-item-img">
		                    <div class="cabernet-show-run-can">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/cabe_1.png" alt="">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/cabe_2.png" class="top-of-cabe" alt="">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/cabe_3.png" alt="" class="bottom-of-cabe">
		                    </div>
		                    <div class="cabernet-show-run">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/cabeCir.png" alt="" class="cabe-1">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/cabeCir.png" alt="" class="cabe-2">
		                        <img src="<?php echo $setting['web_view']; ?>/assets/img/index/cabeCir.png" alt="" class="cabe-3">
		                    </div>
		                </div>
										<div class="productions-brife-item-sec">
					                    <h1><?php echo $setting['company_name']; ?> 独立服务器</h1>
					                    <h2 class="the-script-of-title">服务器租用/托管</h2>
					                    <p class="the-script-of-detail">T3+级别数据中心，具备完善的机房设施，安全稳定的网络有效保证高品质网络环境和充足的带宽资源，高品质的网络环境和丰富的带宽资源</p>
					                   <a href="products/compass.html" class="btn btn-primary ">了解详情</a>
					         </div>
						</div>
					</div>
				</div>
			</div>
		</section> -->

		<!-- <section class="solution space2x bg-white">
			<div class="container">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1 text-center">
						<h2 class="section-title">支持多业务场景的解决方案</h2>
						<div class="section-subtitle"><?php echo $setting['company_name']; ?>以技术为驱动，通过提供领先的云服务，为客户、行业和社会创造更大的价值</div>
					</div>
				</div>
				<div class="row">

					<div class="col-sm-3">
						<div class="solutions-brife-item">
							<div class="solutions-brife-item-img">
											 <img src="<?php echo $setting['web_view']; ?>/assets/img/index/in_se_finance.png" alt="">
									 </div>
									 <div class="solutions-brife-item-sec">
											 <h3>金融</h3>
											 <p>帮助金融行业有效应对数字化转型、业务复杂度加深、运维难度增大等问题，提升运维效率，节约成本。</p>
											 <a href="/register">立刻注册</a>
									 </div>
										</div>
					</div>

					<div class="col-sm-3">
						<div class="solutions-brife-item">
							<div class="solutions-brife-item-img">
											 <img src="<?php echo $setting['web_view']; ?>/assets/img/index/in_se_munu.png" alt="">
									 </div>
									 <div class="solutions-brife-item-sec">
										 <h3>制造</h3>
														 <p>支持制造业便捷管理 IT 资源，提高资源使用效率，减少 IT 建设投入。</p>
											 <a href="/register">立刻注册</a>
									 </div>
		                </div>
					</div>

					<div class="col-sm-3">
						<div class="solutions-brife-item">
							<div class="solutions-brife-item-img">
											 <img src="<?php echo $setting['web_view']; ?>/assets/img/index/in_se_energy.png" alt="">
									 </div>
									 <div class="solutions-brife-item-sec">
										 <h3>能源</h3>
										 <p>为能源企业数字化转型、微服务容器化上云提供平台级支撑。实现企业物理资源池化管理，提升资源利用率，节约企业运营成本。</p>
										<a href="/register">立刻注册</a>
									 </div>
		                </div>
					</div>

					<div class="col-sm-3">
						<div class="solutions-brife-item">
							<div class="solutions-brife-item-img">
											 <img src="<?php echo $setting['web_view']; ?>/assets/img/index/in_se_cloud.png" alt="">
									 </div>
									 <div class="solutions-brife-item-sec">
										 <h3>开发测试云</h3>
										 <p>提供与多种代码仓库集成，支持版本管理，为业务上线提供灰度发布和一键回滚，随取随用，按需使用。</p>
										<a href="/register">立刻注册</a>
									 </div>
		                </div>
					</div>

					<div class="col-sm-3">
						<div class="solutions-brife-item">
							<div class="solutions-brife-item-img">
											 <img src="<?php echo $setting['web_view']; ?>/assets/img/index/in_se_con.png" alt="">
									 </div>
									 <div class="solutions-brife-item-sec">
										 <h3>微服务架构</h3>
										 <p>帮助企业加速应用开发微服务化进程，有效降低客户的应用开发运维成本，提高业 务上线敏捷度和效率。</p>
										<a href="/register">立刻注册</a>
										 </div>
		                </div>
					</div>


					<div class="col-sm-3">
						<div class="solutions-brife-item">
							<div class="solutions-brife-item-img">
											 <img src="<?php echo $setting['web_view']; ?>/assets/img/index/in_se_shop.png" alt="">
									 </div>
									 <div class="solutions-brife-item-sec">
										 <h3>智能化运维</h3>
										 <p>提升从应用部署，到弹性应对各类业务流量突发性变化等的运维效率，节约企业 IT 运维成本，提升效能，打造智能化容器云平台。</p>
										<a href="/register">立刻注册</a>
									 </div>
		                </div>
					</div>


					<div class="col-sm-3">
						<div class="solutions-brife-item">
							<div class="solutions-brife-item-img">
											 <img src="<?php echo $setting['web_view']; ?>/assets/img/index/in_se_learn.png" alt="">
									 </div>
									 <div class="solutions-brife-item-sec">
										 <h3>分布式深度学习平台</h3>
										 <p>支持最新机器学习和深度学习算法框架，可最高效地将海量企业数据转化为算力，为用户提供从数据处理、模型训练到服务托管的一站式体验。</p>
											<a href="/register">立刻注册</a>
									 </div>
		                </div>
					</div>

					<div class="col-sm-3">
						<div class="solutions-brife-item">
							<div class="solutions-brife-item-img">
											 <img src="<?php echo $setting['web_view']; ?>/assets/img/index/clever.png" alt="">
									 </div>
									 <div class="solutions-brife-item-sec">
											 <h3>云存储</h3>
											 <p>对象存储提供数据跨多架构、多设备冗余存储，为用户数据提供异地容灾和资源隔离功能，为每一个对象实现高达99.9999999999%的数据持久性。</p>
											<a href="/register">立刻注册</a>
									 </div>
		                </div>
					</div>

				</div>
			</div>
		</section> -->

		<!--<section class="section-news space2x">
			<div class="container">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1 text-center">
						<h2 class="section-title">新闻动态 & 技术支持</h2>
						<div class="section-subtitle">为您提供行业资讯、活动公告、产品发布，以及汇聚前沿的云计算技术</div>
					</div>
				</div>
				<div class="row helpMenu"  id="helpMenu">

				</div>
			</div>
		</section>
		
		<section class="home-cases space2x bg-white">
			<div class="container">
				<div class="head-top text-center">
					<h2 class="head-title">合作伙伴</h2>
				</div>
				<div class="info-box">
					<div class="info-item">
						<img src="<?php echo $setting['web_view']; ?>/assets/img/logo/telecom.svg">
					</div>
					<div class="info-item">
						<img src="<?php echo $setting['web_view']; ?>/assets/img/logo/qcloud.svg">
					</div>
					<div class="info-item">
						<img src="<?php echo $setting['web_view']; ?>/assets/img/logo/hkix.svg">
					</div>
					<div class="info-item">
						<img src="<?php echo $setting['web_view']; ?>/assets/img/logo/kt.svg">
					</div>
					<div class="info-item">
						<img src="<?php echo $setting['web_view']; ?>/assets/img/logo/ntt.png" style="opacity: .4">
					</div>
					<div class="info-item">
						<img src="<?php echo $setting['web_view']; ?>/assets/img/logo/telia.svg">
					</div>
				</div>
			</div>
		</section> -->

  <section class="foot">
	<div class="container">
		<div class="foot-item">
			<div class="foot-info">
				<div class="foot-text">即刻加入我们</div>
        <div class="foot-text-two">一起进入智能化世界，开启云服务之旅，让您的业务飞速拓展</div>
				<a href="/register" class="btn btn-default">立即注册</a>
			</div>
		</div>
	</div>
</section>
<div class="footer">
  <div class="container">
    <div class="row">
      <div class="col-md-3">
        <div class="address-holder">
          <a href="/index.html">
            <div class="phone" id="company-logo-wrapper">
              <img id="company-logo" src="<?php echo $setting['web_logo']; ?>" />
            </div>
          </a>
          <p class="mt-4 text-foot"><?php echo $setting['company_profile']; ?></p>       
         
        </div>
      </div>
      <?php foreach($www_bottom as $key => $val): ?>
        <div class="col-md-2">
          <div class="footer-menu-holder">
            <h4><?php echo $val['name']; ?></h4>
            <?php if((isset($val['son']))): ?>
              <ul class="footer-menu">
                <?php foreach($val['son'] as $k => $v): ?>
                  <li><a href="<?php echo $v['url']; ?>" <?php if((isset($v['tag']))): ?> <?php echo $v['tag']; ?> <?php endif; ?>><?php echo $v['name']; ?></a></li>
                <?php endforeach; ?>
              </ul>
            <?php endif; ?>

          </div>
        </div>
      <?php endforeach; ?>
      
            <div class="col-md-3">
        <div class="footer-menu-holder">
          <h4>联系我们</h4>
       <div class="phone footer-contact-list"><i class="fas fa-phone"></i><span><?php echo $setting['company_phone']; ?></span></div>
          <div class="email footer-contact-list"><i class="fas fa-envelope"></i><span><?php echo $setting['company_email']; ?></span></div>
          <div class="address footer-contact-list">
            <i class="fas fa-map-marker"></i>
            <span><?php echo $setting['company_address']; ?></span>
          </div>
          <!-- <div class="icp footer-contact-list">
            <i class="fas fa-map-marker"></i>
            <span><?php echo $setting['company_record']; ?></span>
          </div> -->
          </div>
    </div>
    
    </div>
    <div class="friendlyLink row">
      <div class="friendlyLink-title col-md-2 col-sm-12">友情链接</div>
      <div class="friendlyLinkDiv col-md-10 col-sm-12">
        <?php foreach($f_links as $k => $v): ?>
          <span><a href="<?php echo $v['domain']; ?>" <?php echo $v['link_tag']; ?>><?php echo $v['name']; ?></a></span>
        <?php endforeach; ?>
      </div>
    </div>
    
    
  </div>
  <div class="beianNumber">
    <div class="beianNumber-des">
      Copyright 2002-2021 <?php echo $setting['company_name']; ?> All Rights Reserved.
    </div>
  </div>
</div>

</body>

</html>