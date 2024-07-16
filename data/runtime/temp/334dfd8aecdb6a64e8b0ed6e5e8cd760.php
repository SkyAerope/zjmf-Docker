<?php /*a:3:{s:49:"/var/www/html/public/themes/web/zjmf/contact.html";i:1720798140;s:55:"/var/www/html/public/themes/web/zjmf/common/header.html";i:1720798140;s:55:"/var/www/html/public/themes/web/zjmf/common/footer.html";i:1720798140;}*/ ?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>联系我们 - <?php echo $setting['company_name']; ?></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="智简魔方" />
  <meta name="keywords" content="智简魔方" />
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

	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script type="text/javascript" src="https://api.map.baidu.com/api?v=1.0&&type=webgl&ak=klRLuWrAe7qeuesBs9GpN0fMVvPsaADM"></script>
  <section class="page-hero tos space2x">
			    	<div class="container page-hero-text">
			    		<div class="row">
			    			<div class="col-sm-6">
			    				<h2>联系我们</h2>
			    				<p class="hero-slogan">质量为本、客户为根、勇于拼搏、务实创新</p>
			    			</div>
			    		</div>
			    	</div>
			</section>
			<section class="pages-tabs">
				<div class="pages-tabsFix">
				    <div class="container">
							<div class="tabs-item">
							<a href="about.html">关于我们</a>
					    </div>
							<!-- <div class="tabs-item">
							<a href="news.html">新闻中心</a>
					    </div> -->
					    <div class="tabs-item active">
							<a href="contact.html">联系我们</a>
					    </div>


				    </div>
				</div>
			</section>
		</div>
		<div id="contact-info" class="space2x">
			<div class="container">
			    <div class="head-top text-center">
			<h2 class="head-title">联系我们</h2>
		</div>

				<div class="row">
					<div class="col-md-4">
						<div class="info-box" style="height: 265px;">
							<!-- <div class="info-title phone-icon">售前咨询</div> -->
							<div class="info-title">
								<div style="display: flex;align-items: center;">
									<img style="width: 48px;height:48px;" src="<?php echo $setting['web_view']; ?>/assets/img/newImg/qq.png" alt="">
									<span style="margin-left: 15px;">售前咨询</span>
								</div>
							</div>
							<div class="info-details">

								<p>我们有优质的客户团队专业提供售前的产品及技术咨询服务。</p>
								<p><a href="#" onclick="consultingService()">咨询QQ></a></p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="info-box" style="height: 265px;">
							<!-- <div class="info-title chat-icon">售后技术</div> -->
							<div class="info-title">
								<div style="display: flex;align-items: center;">
									<img style="width: 48px;height:48px;" src="<?php echo $setting['web_view']; ?>/assets/img/newImg/info.png" alt="">
									<span style="margin-left: 15px;">售后技术</span>
								</div>
							</div>
							<div class="info-details">
								<p>提供7*24小时技术支持服务，全方位为您提供专业的技术保障，您无需担心自身没有经验、没有技术的问题。</p>
								<p><a href="#" onclick="consultingService()">咨询QQ></a></p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="info-box" style="height: 265px;">
							<!-- <div class="info-title location-icon">OEM合作</div> -->
							<div class="info-title">
								<div style="display: flex;align-items: center;">
									<img style="width: 48px;height:48px;" src="<?php echo $setting['web_view']; ?>/assets/img/newImg/phone.png" alt="">
									<span style="margin-left: 15px;">OEM合作</span>
								</div>
							</div>
							<div class="info-details">
								<p>寻求更多认同行业合伙人，我们珍惜与每一位客户的每一次真诚合作，也坚信每一次双赢合作是对我们最高，最好的检验。</p>
								<p>咨询电话：<a class="zixun-phone" href="#"><?php echo $setting['company_phone']; ?></a></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ditu">
			<div class="container" style="height: 700px;">
				<div id="containerBaidu"></div> 
			</div>
		</div>
			<!-- <div id="extra-info" class="container-fluid" style="margin-top: 50px;">
				<div class="container">
					<div class="row">
						<div class="col-md-6">
							<div class="text-holder">
								<p style="font-size: 20px; font-weight: bold;color: #FFFFFF;">不是下一个商业宝藏,不是下一个商业宝藏</p>
								<p style="font-size: 20px; font-weight: bold;color: #FFFFFF;">很难说企业云服务,很难说企业云服务</p>

								<div style="opacity: 0.7;margin-top: 20px;">
								<p>2020年受疫情催化、国家层面政策加持，推进数据中心加速建设。云计算、大数据、移动互联、人工智能技术的发展带来了企业云服务的新蓝海。
									前天错过了百度、腾讯、阿里；昨天，你错过了小米、美团、滴滴<br>
									今天，请不要再错过我们，万亿市场，你来不来？</p>
								</div>
							</div>
						</div>
						<div class="col-md-6 link-holder">
							<div class="tld-graphic">
								<div>支持云厂商</div>
								<div>支持云资源</div>
								<div>适用人群</div>
							</div>
							<a href="#" class="ybtn ybtn-header-color lijiJiion">立即加入</a>
						</div>
					</div>
				</div>
			</div> -->

			<script type="text/javascript">
				var company_map = '<?php echo $setting['map']; ?>'
					,map_str = [];
				if(company_map)
				{
					map_str = company_map.split(',');
				}
				// 百度地图API功能
				var map = new BMapGL.Map("containerBaidu");
				var point = new BMapGL.Point(map_str[0],map_str[1]);
				map.centerAndZoom(point, 18);
				map.enableScrollWheelZoom(true); 
				
				var marker = new BMapGL.Marker(point);  // 创建标注
				map.addOverlay(marker);              // 将标注添加到地图中
				// var opts = {
				// 	width : 200,     // 信息窗口宽度
				// 	height: 100,     // 信息窗口高度
				// 	title : "重科智谷" , // 信息窗口标题
				// }
				// var infoWindow = new BMapGL.InfoWindow("地址：重庆科学技术研究院二期B栋19层", opts);  // 创建信息窗口对象 
				// marker.addEventListener("click", function(){          
				// 	map.openInfoWindow(infoWindow, point); //开启信息窗口
				// }); 
				
				function consultingService(){
					let qq='<?php echo $setting['company_qq']; ?>'
					// console.log(123123,qq)
					if(qq){
						let url='https://wpa.qq.com/msgrd?v=3&uin='+qq+'&site=qq&menu=yes'
						window.open(url)
					}
				}
				
			</script>
			<style>
				#containerBaidu {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
			</style>


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