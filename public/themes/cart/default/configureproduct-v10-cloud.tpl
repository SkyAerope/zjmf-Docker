<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport"
    content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <title></title>
  <link rel="stylesheet" href="/themes/cart/default/v10/resource/element.css">
  <link rel="stylesheet" href="/themes/cart/default/v10/css/mf_cloud.css">
  <script src="/themes/clientarea/default/v10/lang/{$LanguageCheck.display_flag}.js"></script>

</head>

<body>
  <div class="template" v-cloak>
    <!-- 自己的东西 -->
    <div class="main-card mf-cloud" v-loading="loadingPrice && isInit">
      <el-tabs v-model="activeName" @tab-click="handleClick" class="top-tab">
        <!-- 快速配置 -->
        <el-tab-pane :label="lang.fast_config" name="fast" v-if="isUpdate ? activeName === 'fast' : showFast">
          <div class="con">
            <p class="com-tit">{{lang.basic_config}}</p>
            <el-form :model="params" :rules="rules" ref="orderForm" label-position="left" label-width="100px"
              hide-required-asterisk class="fast-form">
              <el-form-item :label="lang.common_cloud_label1">
                <el-tabs v-model="country" @tab-click="changeCountry" :class="{pHide: dataList.length === 1}">
                  <el-tab-pane :label="item.name" :name="String(item.id)" v-for="item in dataList" :key="item.id">
                    <el-radio-group v-model="city" @input="changeCity($event,item.city)">
                      <el-radio-button :label="c.name" v-for="(c,cInd) in item.city" :key="cInd">
                      </el-radio-button>
                    </el-radio-group>
                  </el-tab-pane>
                </el-tabs>
                <p class="s-tip">{{lang.mf_tip1}}&nbsp;<span>{{lang.mf_tip2}}</span>{{lang.mf_tip3}}</p>
              </el-form-item>
              <!-- 套餐 -->
              <p class="com-tit">{{lang.package_config}}</p>
              <el-form-item :label="lang.common_cloud_text7">
                <div class="cloud-box" v-if="recommendList.length > 0">
                  <div class="cloud-item" :class="{active: index=== cloudIndex}" v-for="(item,index) in recommendList"
                    :key="index" @click="changeRecommend(item,index)">
                    <el-tooltip class="item" effect="dark" :content="item.description" placement="top-end"
                      popper-class="com-bottom-tooltip des">
                      <div class="inner">
                        <div class="top">
                          {{item.name}}</span>
                        </div>
                        <div class="info">
                          <p><span class="name">{{lang.mf_specs}}：</span>{{item.cpu}}{{lang.mf_cores}}{{item.memory}}G
                          </p>
                          <p>
                            <span class="name">{{lang.mf_system}}：</span>{{item.system_disk_size}}GB<span
                              v-if="item.system_disk_type">，{{item.system_disk_type}}</span>
                          </p>
                          <p v-if="item.data_disk_size * 1">
                            <span class="name">{{lang.common_cloud_text1}}：</span>{{item.data_disk_size}}GB<span
                              v-if="item.data_disk_type">，{{item.data_disk_type}}</span>
                          </p>
                          <p v-if="item.bw"><span class="name">{{lang.mf_bw}}：</span>{{item.bw}}M</p>
                          <template v-else>
                            <p v-if="item.flow"><span class="name">{{lang.mf_flow}}：</span>{{item.flow}}GB</p>
                            <p v-if="item.flow===0"><span class="name">{{lang.mf_flow}}：</span>{{lang.mf_tip28}}</p>
                          </template>
                          <p v-if="baseConfig.free_disk_switch">
                            <span class="name">{{lang.mf_tip37}}：</span>
                            {{baseConfig.free_disk_size}}GB
                          </p>
                          <p v-if="item.peak_defence">
                            <span class="name">{{lang.peak_defence}}：</span>{{ item.peak_defence + 'G'}}
                          </p>
                          <p>
                            <span class="name">IPv4{{lang.shoppingCar_goodsNums}}：</span>{{item.ip_num === 0 ?
                            lang.mf_none : item.ip_num + lang.common_cloud_title43}}
                          </p>
                          <p>
                            <span class="name">IPv6{{lang.shoppingCar_goodsNums}}：</span>{{item.ipv6_num === 0 ?
                            lang.mf_none : item.ipv6_num + lang.common_cloud_title43}}
                          </p>
                          <p v-if="item.gpu_num"><span class="name">GPU{{lang.shoppingCar_goodsNums}}：</span>
                            <span :title="`${item.gpu_num}*${item.gpu_name}`">{{item.gpu_num}}*{{item.gpu_name}}</span>
                          </p>
                        </div>
                      </div>
                    </el-tooltip>
                    <p class="no-up" v-if="item.upgrade_range === 0 && baseConfig.no_upgrade_tip_show === 1">
                      <el-tooltip class="item" effect="dark" :content="lang.no_upgrade" placement="bottom"
                        popper-class="com-bottom-tooltip">
                        <img src="/themes/cart/default/v10/img/no-upgrade.svg" alt="">
                      </el-tooltip>
                    </p>
                  </div>
                </div>
                <div class="empty" v-else>
                  {{lang.mf_tip9}}
                </div>

              </el-form-item>
              <!-- 镜像 -->
              <el-form-item :label="lang.cloud_menu_5" class="image" id="image1">
                <div class="image-box">
                  <div class="image-ul">
                    <div class="image-item" v-for="(item,index) in calcImageList" :key="item.id"
                      :class="{hover: curImage===index, active: imageName === item.name}"
                      @click="changeImage(item,index)" @mouseenter="mouseenter(index)" @mouseleave="hover = false">
                      <img :src="`/themes/clientarea/default/v10/img/${item.icon}.svg`" alt="" class="icon" />
                      <div class="r-info">
                        <p class="name">{{item.name}}</p>
                        <p class="version">{{curImageId === item.id ? version:
                          lang.choose_version}}
                        </p>
                      </div>
                      <div class="version-select" v-show="(curImage === index) && hover">
                        <div class="v-item" :class="{active: ver.id === params.image_id}" v-for="(ver,v) in item.image"
                          :key="ver.id" @click="chooseVersion(ver,item.id)">
                          <el-popover placement="right" trigger="hover" popper-class="image-pup"
                            :disabled="ver.name.length < 20" :content="ver.name">
                            <span slot="reference">{{ver.name}}</span>
                          </el-popover>
                        </div>
                      </div>
                    </div>
                    <div class="empty-image" :class="{isHide: !isHide}" @click="isHide = !isHide"
                      v-show="filterIamge.length > 5">
                      <i class="el-icon-arrow-down"></i>
                    </div>
                  </div>
                </div>
                <p class="s-tip" v-if="imageName">{{imageName && (imageName.indexOf('Win') !== -1 ? lang.mf_tip26 :
                  lang.mf_tip27)}}
                </p>
                <span class="error-tip" v-show="showImage">{{lang.mf_tip6}}</span>
              </el-form-item>

              <!-- 网络配置 -->
              <p class="com-tit" v-if="baseConfig.type === 'host'">{{lang.net_config}}</p>
              <el-form-item :label="lang.network_type" v-if="baseConfig.type === 'host'">
                <el-radio-group v-model="netName" @change="changeNet">
                  <el-radio-button :label="lang.mf_normal" v-if="baseConfig.support_normal_network"></el-radio-button>
                  <el-radio-button :label="lang.mf_vpc"
                    v-if="baseConfig.support_vpc_network && !params.ipv6_num"></el-radio-button>
                </el-radio-group>
              </el-form-item>
              <template v-if="params.network_type === 'vpc'">
                <el-form-item :label="lang.cloud_menu_2"
                  v-if="params.nat_web_limit_enable || params.nat_acl_limit_enable">
                  172.16.0.0/12
                </el-form-item>
                <el-form-item :label="lang.cloud_menu_2" v-else>
                  <div class="choose-net">
                    <el-select v-model="params.vpc.id" filterable class="w-select"
                      :placeholder="`${lang.placeholder_pre2}${lang.cloud_menu_2}`">
                      <el-option value="" :label="lang.create_network"></el-option>
                      <el-option v-for="item in vpcList" :key="item.id" :label="item.name" :value="item.id">
                      </el-option>
                    </el-select>
                    <i class="el-icon-loading" v-show="vpcLoading"></i>
                    <i class="el-icon-refresh" class="refresh" @click="getVpcList" v-show="!vpcLoading"></i>
                  </div>
                  <div class="vpc" v-if="params.vpc.id === ''">
                    <el-select v-model="plan_way" class="w-select">
                      <el-option :value="0" :label="lang.auto_plan"></el-option>
                      <el-option :value="1" :label="lang.custom"></el-option>
                    </el-select>
                    <!-- 自定义vpc -->
                    <div class="custom" v-if="plan_way === 1">
                      <el-select v-model="vpc_ips.vpc1.value" @change="changeVpcIp">
                        <el-option v-for="item in vpc_ips.vpc1.select" :key="item" :label="item" :value="item">
                        </el-option>
                      </el-select>
                      <span>·</span>
                      <el-tooltip :content="vpc_ips.vpc1.tips" placement="top" effect="light">
                        <el-input-number :disabled="vpc_ips.vpc1.value === 192" v-model="vpc_ips.vpc2" :step="1"
                          :controls="false" :min="vpc_ips.min" :max="vpc_ips.max"></el-input-number>
                      </el-tooltip>
                      <span>·</span>
                      <el-tooltip :content="vpc_ips.vpc3Tips" placement="top" effect="light"
                        :disabled="!vpc_ips.vpc3Tips">
                        <el-input-number :disabled="vpc_ips.vpc6.value === 16" @blur="changeVpc3" v-model="vpc_ips.vpc3"
                          :step="1" :controls="false" :min="0" :max="255">
                        </el-input-number>
                      </el-tooltip>
                      <span>·</span>
                      <el-tooltip :content="vpc_ips.vpc4Tips" placement="top" effect="light"
                        :disabled="!vpc_ips.vpc4Tips">
                        <el-input-number :disabled="vpc_ips.vpc6.value < 25" @blur="changeVpc4" v-model="vpc_ips.vpc4"
                          :step="1" :controls="false" :min="0" :max="255">
                        </el-input-number>
                      </el-tooltip>
                      <span>/</span>
                      <el-select v-model="vpc_ips.vpc6.value" style="width: 70px" @change="changeVpcMask">
                        <el-option v-for="item in vpc_ips.vpc6.select" :key="item" :label="item" :value="item">
                        </el-option>
                      </el-select>
                    </div>
                  </div>

                </el-form-item>
                <!-- <el-form-item :label="lang.common_cloud_title3">
                  {{lang.mf_tip23}}
                </el-form-item> -->
              </template>
              <template v-if="isLogin">
                <!-- 其他配置 -->
                <p class="com-tit" id="ssh">{{lang.other_config}}</p>
                <el-form-item :label="lang.login_way">
                  <el-radio-group v-model="login_way" @change="changeLogin">
                    <!-- <el-radio-button :label="lang.security_tab1"
                      v-if="baseConfig.support_ssh_key && imageName.indexOf('Win') === -1"></el-radio-button> -->
                    <el-radio-button :label="lang.set_pas"></el-radio-button>
                    <el-radio-button :label="lang.auto_create"></el-radio-button>
                  </el-radio-group>
                  <p class="s-tip" v-if="login_way === lang.auto_create">{{lang.mf_tip5}}</p>
                  <div class="login-box" v-else>
                    <el-form-item :label="lang.login_name">
                      <el-input v-model="root_name" disabled></el-input>
                    </el-form-item>
                    <!-- ssh -->
                    <template v-if="login_way === lang.security_tab1">
                      <el-form-item :label="lang.ssh_key">
                        <el-select v-model="params.ssh_key_id" :placeholder="`${lang.placeholder_pre2}${lang.ssh_key}`">
                          <el-option v-for="item in sshList" :key="item.id" :label="item.name" :value="item.id">
                          </el-option>
                        </el-select>
                        <i class="el-icon-loading" v-show="sshLoading"></i>
                        <i class="el-icon-refresh" class="refresh" @click="getSsh" v-show="!sshLoading"></i>
                      </el-form-item>
                      <el-form-item v-show="showSsh" label=' ' class="empty-item">
                        <span class="error-tip">{{lang.placeholder_pre2}}{{lang.security_tab1}}</span>
                      </el-form-item>
                      <el-form-item label=" ">
                        <p class="s-tip jump-box">{{lang.mf_tip17}}&nbsp;&nbsp;
                          <a href="security_ssh.htm" target="_blank" class="add-ssh">
                            {{lang.mf_tip18}}
                            <img src="/themes/cart/default/v10/img/jump.svg" alt="" class="icon">
                          </a>
                        </p>
                      </el-form-item>
                    </template>
                    <!-- 密码 -->
                    <template v-if="login_way === lang.set_pas">
                      <el-form-item :label="lang.login_password" prop="password">
                        <el-popover placement="right" trigger="click" popper-class="test-pup">
                          <div class="test-password">
                            <div class="t-item">
                              <span class="dot" v-show="!hasLen"></span>
                              <i class="el-icon-check" v-show="hasLen"></i>
                              {{lang.mf_val1}}
                            </div>
                            <div class="t-item">
                              <!-- 指定范围 -->
                              <span class="dot" v-show="hasAppoint"></span>
                              <i class="el-icon-check" v-show="!hasAppoint"></i>
                              {{lang.mf_val2}}
                            </div>
                            <div class="t-item">
                              <span class="dot" v-show="hasLine"></span>
                              <i class="el-icon-check" v-show="!hasLine"></i>
                              {{lang.mf_val3}}
                            </div>
                            <div class="t-item">
                              <span class="dot" v-show="!hasMust"></span>
                              <i class="el-icon-check" v-show="hasMust"></i>
                              {{lang.mf_val4}}
                            </div>
                          </div>
                          <el-input v-model="params.password" type="password" show-password @input="changeInput"
                            :placeholder="`${lang.placeholder_pre1}${lang.login_password}`" slot="reference">
                          </el-input>
                        </el-popover>
                        <span class="error-tip" v-show="showPas">{{lang.mf_tip20}}</span>
                      </el-form-item>
                      <el-form-item :label="lang.sure_password">
                        <el-input v-model="params.re_password" type="password" show-password
                          :placeholder="`${lang.placeholder_pre1}${lang.sure_password}`">
                        </el-input>
                        <span class="error-tip" v-show="showRepass">{{lang.mf_tip19}}</span>
                      </el-form-item>

                    </template>
                  </div>
                </el-form-item>
                <el-form-item class="optional">
                  <template slot="label">
                    {{lang.cloud_name}}
                    <el-tooltip class="item" effect="light" :content="lang.mf_tip14" placement="top">
                      <i class="el-icon-warning-outline"></i>
                    </el-tooltip>
                  </template>
                  <el-input v-model="params.notes" :placeholder="lang.mf_tip15"></el-input>
                </el-form-item>
                <!-- <el-form-item :label="lang.auto_renew" class="renew">
                  <el-checkbox v-model="params.auto_renew">{{lang.open_auto_renew}}</el-checkbox>
                </el-form-item> -->
                <!-- 2023-5-23 新增 -->
                <el-form-item :label="lang.ip_mac_bind_enable" class="renew" v-if="baseConfig.ip_mac_bind_enable">
                  <el-checkbox
                    v-model="params.ip_mac_bind_enable">{{lang.mf_allow}}{{lang.ip_mac_bind_enable}}</el-checkbox>
                </el-form-item>

                <template v-if="baseConfig.nat_acl_limit_enable">
                  <el-form-item :label="lang.nat_acl_limit_enable" class="renew"
                    v-if="params.network_type === 'vpc' || (params.network_type === 'normal' && baseConfig.type === 'lightHost')">
                    <el-checkbox @change="changeNat" :disabled="baseConfig.default_nat_acl === 1"
                      v-model="params.nat_acl_limit_enable">{{lang.mf_support}}{{lang.nat_acl_limit_enable}}</el-checkbox>
                  </el-form-item>
                </template>
                <template v-if="baseConfig.nat_web_limit_enable">
                  <el-form-item :label="lang.nat_web_limit_enable" class="renew"
                    v-if="params.network_type === 'vpc' || (params.network_type === 'normal' && baseConfig.type === 'lightHost')">
                    <el-checkbox @change="changeNat" :disabled="baseConfig.default_nat_web === 1"
                      v-model="params.nat_web_limit_enable">{{lang.mf_support}}{{lang.nat_web_limit_enable}}</el-checkbox>
                  </el-form-item>
                </template>

                <el-form-item :label="lang.ipv6_num_enable" class="renew"
                  v-show="params.network_type === 'normal' && baseConfig.ipv6_num_enable">
                  <el-checkbox v-model="params.ipv6_num_enable"
                    @change="changeIpv6">{{lang.mf_allow}}{{lang.ipv6_num_enable}}</el-checkbox>
                </el-form-item>
              </template>
              <custom-goods :id="id" label-width="100px" :self_defined_field.sync="self_defined_field"
                class="custom-config" ref="customGoodRef">
              </custom-goods>
            </el-form>
          </div>
        </el-tab-pane>
        <!-- 自定义配置 -->
        <el-tab-pane :label="lang.custom_config" name="custom" :lazy="true"
          v-if="(isUpdate ? activeName === 'custom' :  true) && baseConfig.only_sale_recommend_config === 0">
          <div class="con">
            <p class="com-tit">{{lang.basic_config}}</p>
            <el-form :model="params" :rules="rules" ref="orderForm" label-position="left" label-width="100px"
              hide-required-asterisk>
              <!-- 资源包 -->
              <el-form-item :label="lang.resource_package" v-if="resourceList.length > 1">
                <el-radio-group v-model="ressourceName" @input="changeResource">
                  <el-radio-button :label="c.name" v-for="(c,cInd) in resourceList" :key="cInd">
                  </el-radio-button>
                </el-radio-group>
              </el-form-item>
              <el-form-item :label="lang.common_cloud_label1">
                <el-tabs v-model="country" @tab-click="changeCountry" :class="{hide: dataList.length === 1}">
                  <el-tab-pane :label="item.name" :name="String(item.id)" v-for="item in dataList" :key="item.id">
                    <el-radio-group v-model="city" @input="changeCity($event,item.city)">
                      <el-radio-button :label="c.name" v-for="(c,cInd) in item.city" :key="cInd">
                      </el-radio-button>
                    </el-radio-group>
                  </el-tab-pane>
                </el-tabs>
                <p class="s-tip">{{lang.mf_tip1}}&nbsp;<span>{{lang.mf_tip2}}</span>{{lang.mf_tip3}}</p>
              </el-form-item>
              <!-- 可用区 -->
              <el-form-item :label="lang.usable_area">
                <el-radio-group v-model="area_name" @input="changeArea">
                  <el-radio-button :label="c.name" v-for="(c,cInd) in calcAreaList" :key="cInd">
                  </el-radio-button>
                </el-radio-group>
                <p class="s-tip">{{lang.mf_tip10}}</p>
              </el-form-item>
              <p class="com-tit">{{lang.cloud_config}}</p>
              <!-- cpu -->
              <el-form-item label="CPU">
                <el-radio-group v-model="params.cpu" @input="changeCpu">
                  <el-radio-button :label="c.value" v-for="(c,cInd) in calcCpuList" :key="cInd">
                    {{c.value}}{{lang.mf_cores}}
                  </el-radio-button>
                </el-radio-group>
              </el-form-item>
              <!-- 内存 -->
              <template
                v-if="memoryList.length > 0  && activeName ==='custom' && (memoryType || (!memoryType && calaMemoryList.length > 0))">
                <el-form-item :label="lang.cloud_memery" class="move">
                  <!-- 单选 -->
                  <el-radio-group v-model="params.memory" v-if="memoryType" @input="changeMemory">
                    <el-radio-button :label="c.value * 1" v-for="(c,cInd) in calaMemoryList" :key="cInd + c.value"
                      :class="{'com-dis': c.disabled}">
                      {{c.value}}{{baseConfig.memory_unit}}
                    </el-radio-button>
                  </el-radio-group>
                  <!-- 拖动框 -->
                  <template v-else>
                    <el-tooltip effect="light" :content="lang.mf_range + memoryTip" placement="top-end">
                      <el-slider v-model="params.memory" show-input :show-tooltip="false" :min="calaMemoryList[0] * 1"
                        :max="calaMemoryList[calaMemoryList.length -1] * 1" :show-stops="false" @change="changeMem">
                      </el-slider>
                    </el-tooltip>
                  </template>
                  <span class="unit" v-if="!memoryType">{{baseConfig.memory_unit}}</span>
                </el-form-item>
                <el-form-item label=" " v-if="memoryList.length > 0 && memoryList[0].type !== 'radio'">
                  <div class="marks">
                    <!-- <span class="item" v-for="(item,index) in Object.keys(memMarks)">{{memMarks[item]}}GB</span> -->
                    <span class="item">{{calaMemoryList[0]}}{{baseConfig.memory_unit}}</span>
                    <span class="item">{{calaMemoryList[calaMemoryList.length
                      -1]}}{{baseConfig.memory_unit}}</span>
                  </div>
                </el-form-item>
              </template>
              <el-form-item :label="lang.cloud_memery" class="move" v-else>{{lang.no_optional_memory}}</el-form-item>
              <!-- gpu -->
              <el-form-item label="GPU" v-if="params.gpu_num">
                <!-- <el-radio-group v-model="params.gpu_num" @input="getCycleList">
                <el-radio-button :label="c.value" v-for="(c,cInd) in gpuList" :key="cInd">
                  {{c.value}}*{{gpu_name}}
                </el-radio-button>
              </el-radio-group> -->
                <el-select v-model="params.gpu_num" @change="getCycleList" style="width: 390px;">
                  <el-option v-for="item in gpuList" :key="item.value" :label="`${item.value}*${gpu_name}`"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-form-item>
              <!-- 镜像 -->
              <el-form-item :label="lang.cloud_menu_5" class="image" id="image1">
                <div class="image-box">
                  <div class="image-ul">
                    <div class="image-item" v-for="(item,index) in calcImageList" :key="item.id"
                      :class="{hover: curImage===index, active: imageName === item.name}"
                      @click="changeImage(item,index)" @mouseenter="mouseenter(index)" @mouseleave="hover = false">
                      <img :src="`/themes/clientarea/default/v10/img/${item.icon}.svg`" alt="" class="icon" />
                      <div class="r-info">
                        <p class="name">{{item.name}}</p>
                        <p class="version">{{curImageId === item.id ? version:
                          lang.choose_version}}
                        </p>
                      </div>
                      <div class="version-select" v-show="(curImage === index) && hover">
                        <div class="v-item" :class="{active: ver.id === params.image_id}" v-for="(ver,v) in item.image"
                          :key="ver.id" @click="chooseVersion(ver,item.id)">
                          <el-popover placement="right" trigger="hover" popper-class="image-pup"
                            :disabled="ver.name.length < 20" :content="ver.name">
                            <span slot="reference">{{ver.name}}</span>
                          </el-popover>
                        </div>
                      </div>
                    </div>
                    <div class="empty-image" :class="{isHide: !isHide}" @click="isHide = !isHide"
                      v-show="filterIamge.length > 5">
                      <i class="el-icon-arrow-down"></i>
                    </div>
                  </div>
                </div>
                <p class="s-tip" v-if="imageName">{{imageName && (imageName.indexOf('Win') !== -1 ? lang.mf_tip26 :
                  lang.mf_tip27)}}
                </p>
                <span class="error-tip" v-show="showImage">{{lang.mf_tip6}}</span>
              </el-form-item>
              <!-- 存储 -->
              <el-form-item :label="lang.cloud_menu_3" v-if="activeName === 'custom' && storeList.length > 0"
                class="store-item">
                <el-table :data="storeList" style="width: 100%" :row-class-name="tableRowClassName">
                  <el-table-column prop="name" :label="lang.mf_purpose" width="190">
                  </el-table-column>
                  <!-- 磁盘类型 -->
                  <el-table-column prop="disk_type" :label="lang.disk_type" min-width="200">
                    <template slot-scope="{row}">
                      <template v-if="row.index === 0">
                        <el-select v-model="params.system_disk.disk_type" :placeholder="lang.placeholder_pre2"
                          v-if="params.system_disk" :disabled="systemType.length === 1 && systemType[0].value === ''">
                          <el-option v-for="item in systemType" :key="item.value" :label="item.label"
                            :value="item.value">
                          </el-option>
                        </el-select>
                      </template>
                      <template v-else>
                        <el-input :value="lang.mf_no" disabled
                          v-if="row.index === 1 && baseConfig.free_disk_switch === 1" class="dis-input">
                        </el-input>
                        <template v-else>
                          <el-select v-model="params.data_disk[row.index - 1].disk_type"
                            :placeholder="lang.placeholder_pre2" @change="changeDataDisk($event, row.index)"
                            v-if="params.data_disk && params.data_disk.length > 0">
                            <el-option v-for="item in dataType" :key="item.value" :label="item.label"
                              :value="item.value">
                            </el-option>
                          </el-select>
                        </template>
                      </template>
                    </template>
                  </el-table-column>
                  <!-- 磁盘容量 -->
                  <el-table-column prop="size" :label="lang.disk_size" min-width="200">
                    <template slot-scope="{row}">
                      <el-input :value="params.data_disk[row.index - 1].size + 'GB'" disabled class="dis-input"
                        v-if="row.index === 1 && baseConfig.free_disk_switch === 1">GB</el-input>
                      <template v-else>
                        <template v-if="row.type==='radio'">
                          <template v-if="row.index === 0">
                            <!-- 系统盘 -->
                            <el-select v-model="params.system_disk.size" :placeholder="lang.placeholder_pre2"
                              v-if="params.system_disk" @change="getCycleList">
                              <el-option v-for="item in systemNum" :key="item.value" :label="item.label"
                                :value="item.value">
                              </el-option>
                            </el-select>
                          </template>
                          <!-- 数据盘 -->
                          <template v-else>
                            <el-select v-model="params.data_disk[row.index - 1].size"
                              :placeholder="lang.placeholder_pre2"
                              v-if="params.data_disk && params.data_disk.length > 0" @change="getCycleList">
                              <el-option v-for="item in dataNumObj[params.data_disk[row.index - 1].disk_type]"
                                :key="item.value" :label="item.label" :value="item.value">
                              </el-option>
                            </el-select>
                          </template>
                        </template>
                        <template v-else>
                          <!-- 存储是范围时 -->
                          <template v-if="row.index === 0">
                            <el-tooltip effect="light"
                              :content="lang.mf_range + systemRangTip[params.system_disk.disk_type]" placement="top">
                              <el-input-number v-model="params.system_disk.size" :min="row.min" :max="row.max"
                                @change="changeSysNum">
                              </el-input-number>
                            </el-tooltip>
                          </template>
                          <template v-if="row.index !== 0 && params.data_disk.length > 0 ">
                            <el-tooltip effect="light"
                              :content="lang.mf_range + dataRangTip[params.data_disk[row.index - 1].disk_type]"
                              placement="top">
                              <el-input-number v-model="params.data_disk[row.index - 1].size" :min="row.min"
                                :max="row.max" @change="changeDataNum($event,row.index)">
                              </el-input-number>
                            </el-tooltip>
                          </template>
                        </template>
                        GB
                      </template>
                    </template>
                  </el-table-column>
                  <el-table-column :label="lang.file_opt" width="100">
                    <template slot-scope="{row}">
                      <span v-if="baseConfig.free_disk_switch ?  row.index + 1 > 2 :  row.index + 1 > 1 "
                        class="del-data" @click="delDataDisk(row.index)">{{lang.referral_btn4}}</span>
                    </template>
                  </el-table-column>
                </el-table>
                <div class="store"
                  v-if="(this.storeList.length < this.baseConfig.disk_limit_num + 1) && dataDiskList.length > 0">
                  <span class="add-disk" @click="addDataDisk">
                    <i class="el-icon-circle-plus-outline"></i>
                    <span class="txt">{{lang.mf_add_disk}}</span>&nbsp;
                  </span>
                  {{lang.mf_tip11}}<span class="txt num">{{this.baseConfig.disk_limit_num + 1 -
                    this.storeList.length}}</span>{{lang.mf_tip12}}
                </div>
              </el-form-item>
              <!-- 网络配置 -->
              <p class="com-tit">{{lang.net_config}}</p>
              <el-form-item :label="lang.network_type" v-if="baseConfig.type === 'host'">
                <el-radio-group v-model="netName" @change="changeNet">
                  <el-radio-button :label="lang.mf_normal" v-if="baseConfig.support_normal_network"></el-radio-button>
                  <el-radio-button :label="lang.mf_vpc" v-if="baseConfig.support_vpc_network"></el-radio-button>
                </el-radio-group>
              </el-form-item>
              <template v-if="params.network_type === 'vpc'">
                <el-form-item :label="lang.cloud_menu_2"
                  v-if="params.nat_web_limit_enable || params.nat_acl_limit_enable">
                  172.16.0.0/12
                </el-form-item>
                <el-form-item :label="lang.cloud_menu_2" v-else>
                  <div class="choose-net">
                    <el-select v-model="params.vpc.id" filterable class="w-select"
                      :placeholder="`${lang.placeholder_pre2}${lang.cloud_menu_2}`">
                      <el-option value="" :label="lang.create_network"></el-option>
                      <el-option v-for="item in vpcList" :key="item.id" :label="item.name" :value="item.id">
                      </el-option>
                    </el-select>
                    <i class="el-icon-loading" v-show="vpcLoading"></i>
                    <i class="el-icon-refresh" class="refresh" @click="getVpcList" v-show="!vpcLoading"></i>
                  </div>
                  <div class="vpc" v-if="params.vpc.id === ''">
                    <el-select v-model="plan_way" class="w-select">
                      <el-option :value="0" :label="lang.auto_plan"></el-option>
                      <el-option :value="1" :label="lang.custom"></el-option>
                    </el-select>
                    <!-- 自定义vpc -->
                    <div class="custom" v-if="plan_way === 1">
                      <el-select v-model="vpc_ips.vpc1.value" @change="changeVpcIp">
                        <el-option v-for="item in vpc_ips.vpc1.select" :key="item" :label="item" :value="item">
                        </el-option>
                      </el-select>
                      <span>·</span>
                      <el-tooltip :content="vpc_ips.vpc1.tips" placement="top" effect="light">
                        <el-input-number :disabled="vpc_ips.vpc1.value === 192" v-model="vpc_ips.vpc2" :step="1"
                          :controls="false" :min="vpc_ips.min" :max="vpc_ips.max"></el-input-number>
                      </el-tooltip>
                      <span>·</span>
                      <el-tooltip :content="vpc_ips.vpc3Tips" placement="top" effect="light"
                        :disabled="!vpc_ips.vpc3Tips">
                        <el-input-number :disabled="vpc_ips.vpc6.value === 16" @blur="changeVpc3" v-model="vpc_ips.vpc3"
                          :step="1" :controls="false" :min="0" :max="255">
                        </el-input-number>
                      </el-tooltip>
                      <span>·</span>
                      <el-tooltip :content="vpc_ips.vpc4Tips" placement="top" effect="light"
                        :disabled="!vpc_ips.vpc4Tips">
                        <el-input-number :disabled="vpc_ips.vpc6.value < 25" @blur="changeVpc4" v-model="vpc_ips.vpc4"
                          :step="1" :controls="false" :min="0" :max="255">
                        </el-input-number>
                      </el-tooltip>
                      <span>/</span>
                      <el-select v-model="vpc_ips.vpc6.value" style="width: 70px" @change="changeVpcMask">
                        <el-option v-for="item in vpc_ips.vpc6.select" :key="item" :label="item" :value="item">
                        </el-option>
                      </el-select>
                    </div>
                  </div>
                </el-form-item>
              </template>
              <el-form-item :label="lang.common_cloud_title3"
                v-if="!params.nat_acl_limit_enable && !params.nat_web_limit_enable && baseConfig.default_one_ipv4">
                {{lang.mf_tip23}}
              </el-form-item>
              <!-- 线路 -->
              <el-form-item :label="lang.mf_line">
                <el-radio-group v-model="lineName" @input="changeLine">
                  <el-radio-button :label="c.name" v-for="(c,cInd) in lineList" :key="cInd">
                  </el-radio-button>
                </el-radio-group>
              </el-form-item>
              <!-- 带宽 -->
              <el-form-item :label="lang.mf_bw" v-if="lineDetail.bill_type === 'bw' && lineDetail.bw.length > 0">
                <!-- 单选 -->
                <el-radio-group v-model="bwName" v-if="lineDetail.bw[0].type === 'radio'" @input="changeBw">
                  <el-radio-button :label="c.value + 'M'" v-for="(c,cInd) in lineDetail.bw" :key="cInd">
                  </el-radio-button>
                </el-radio-group>
                <!-- 拖动框 -->
                <el-tooltip effect="light" v-else :content="lang.mf_range + bwTip" placement="top-end">
                  <el-slider v-model="params.bw" show-input :step="1" :min="lineDetail.bw[0].min_value"
                    :max="lineDetail.bw[lineDetail.bw.length - 1].max_value" @change="changeBwNum">
                  </el-slider>
                </el-tooltip>
              </el-form-item>
              <el-form-item label=" "
                v-if="lineDetail.bw && lineDetail.bw.length > 0 && lineDetail.bw[0].type !== 'radio'">
                <div class="marks">
                  <!-- <span class="item" v-for="(item,index) in Object.keys(bwMarks)">{{bwMarks[item]}}Mbps</span> -->
                  <span class="item">{{lineDetail.bw[0].min_value}}M</span>
                  <span class="item">{{lineDetail.bw[lineDetail.bw.length -1 ].max_value}}M</span>
                </div>
              </el-form-item>
              <!-- 流量 -->
              <el-form-item :label="lang.mf_flow" v-if="lineDetail.bill_type === 'flow' && lineDetail.flow.length > 0">
                <el-radio-group v-model="flowName" @input="changeFlow">
                  <el-radio-button :label="c.value > 0 ? (c.value + 'G') : lang.mf_tip28"
                    v-for="(c,cInd) in lineDetail.flow" :key="cInd">
                  </el-radio-button>
                </el-radio-group>
              </el-form-item>
              <!-- 流量类型下面的带宽，显示线路里面的flow.other_config.out_bw -->
              <el-form-item :label="lang.mf_bw" v-if="lineDetail.bill_type === 'flow'">
                <p class="flow-bw">{{showFlowBw == 0 ? lang.not_limited : showFlowBw + 'M'}}</p>
              </el-form-item>
              <!-- IPV4 -->
              <el-form-item :label="`${lang.mf_append}IPv4`" v-if="lineDetail.ip && lineDetail.ip.length >0">
                <el-radio-group v-model="params.ip_num" @change="changeIpv4">
                  <el-radio-button :label="c.value" v-for="(c,cInd) in lineDetail.ip" :key="cInd">
                    {{c.value === 0 ? lang.mf_none : c.value + lang.common_cloud_title43}}
                  </el-radio-button>
                </el-radio-group>
              </el-form-item>
              <!-- IPV6 -->
              <el-form-item :label="`${lang.mf_append}IPv6`"
                v-if="lineDetail.ipv6 && lineDetail.ipv6.length >0 && params.network_type !== 'vpc'">
                <el-radio-group v-model="params.ipv6_num" @change="changeIpv6"
                  v-if="lineDetail.ipv6[0].type === 'radio'">
                  <el-radio-button :label="c.value" v-for="(c,cInd) in lineDetail.ipv6" :key="cInd">
                    {{c.value === 0 ? lang.mf_none : c.value + lang.common_cloud_title43}}
                  </el-radio-button>
                </el-radio-group>
                <el-tooltip effect="light" v-else :content="lang.mf_range + ipv6Tip" placement="top-end">
                  <el-slider v-model="params.ipv6_num" show-input :step="1" :min="lineDetail.ipv6[0].min_value"
                    :max="lineDetail.ipv6[lineDetail.ipv6.length - 1].max_value" @change="changeIpNum('ipv6', $event)">
                  </el-slider>
                </el-tooltip>
              </el-form-item>
              <!-- 防御 -->
              <el-form-item :label="lang.mf_defense" v-if="lineDetail.defence && lineDetail.defence.length >0">
                <el-radio-group v-model="defenseName">
                  <el-radio-button :label="c.value === 0 ? lang.no_defense : (c.value + 'G')"
                    v-for="(c,cInd) in lineDetail.defence" :key="cInd" @click.native="chooseDefence($event,c)">
                  </el-radio-button>
                </el-radio-group>
              </el-form-item>

              <template v-if="isLogin">
                <!-- 其他配置 -->
                <p class="com-tit" id="ssh">{{lang.other_config}}</p>
                <el-form-item :label="lang.login_way">
                  <el-radio-group v-model="login_way" @change="changeLogin">
                    <!-- <el-radio-button :label="lang.security_tab1" v-if="baseConfig.support_ssh_key && imageName.indexOf('Win') === -1"></el-radio-button> -->
                    <el-radio-button :label="lang.set_pas"></el-radio-button>
                    <el-radio-button :label="lang.auto_create"></el-radio-button>
                  </el-radio-group>
                  <p class="s-tip" v-if="login_way === lang.auto_create">{{lang.mf_tip5}}</p>
                  <div class="login-box" v-else>
                    <el-form-item :label="lang.login_name">
                      <el-input v-model="root_name" disabled></el-input>
                    </el-form-item>
                    <!-- ssh -->
                    <template v-if="login_way === lang.security_tab1">
                      <el-form-item :label="lang.ssh_key">
                        <el-select v-model="params.ssh_key_id" :placeholder="`${lang.placeholder_pre2}${lang.ssh_key}`">
                          <el-option v-for="item in sshList" :key="item.id" :label="item.name" :value="item.id">
                          </el-option>
                        </el-select>
                        <i class="el-icon-loading" v-show="sshLoading"></i>
                        <i class="el-icon-refresh" class="refresh" @click="getSsh" v-show="!sshLoading"></i>
                      </el-form-item>
                      <el-form-item v-show="showSsh" label=' ' class="empty-item">
                        <span class="error-tip">{{lang.placeholder_pre2}}{{lang.security_tab1}}</span>
                      </el-form-item>
                      <el-form-item label=" ">
                        <p class="s-tip jump-box">{{lang.mf_tip17}}&nbsp;&nbsp;
                          <a href="security_ssh.htm" target="_blank" class="add-ssh">
                            {{lang.mf_tip18}}
                            <img src="/themes/clientarea/default/v10/img/jump.svg" alt="" class="icon">
                          </a>
                        </p>
                      </el-form-item>
                    </template>
                    <!-- 密码 -->
                    <template v-if="login_way === lang.set_pas">
                      <el-form-item :label="lang.login_password" prop="password">
                        <el-popover placement="right" trigger="click" popper-class="test-pup">
                          <div class="test-password">
                            <div class="t-item">
                              <span class="dot" v-show="!hasLen"></span>
                              <i class="el-icon-check" v-show="hasLen"></i>
                              {{lang.mf_val1}}
                            </div>
                            <div class="t-item">
                              <!-- 指定范围 -->
                              <span class="dot" v-show="hasAppoint"></span>
                              <i class="el-icon-check" v-show="!hasAppoint"></i>
                              {{lang.mf_val2}}
                            </div>
                            <div class="t-item">
                              <span class="dot" v-show="hasLine"></span>
                              <i class="el-icon-check" v-show="!hasLine"></i>
                              {{lang.mf_val3}}
                            </div>
                            <div class="t-item">
                              <span class="dot" v-show="!hasMust"></span>
                              <i class="el-icon-check" v-show="hasMust"></i>
                              {{lang.mf_val4}}
                            </div>
                          </div>
                          <el-input v-model="params.password" type="password" show-password @input="changeInput"
                            :placeholder="`${lang.placeholder_pre1}${lang.login_password}`" slot="reference">
                          </el-input>
                        </el-popover>
                        <span class="error-tip" v-show="showPas">{{lang.mf_tip20}}</span>
                      </el-form-item>
                      <el-form-item :label="lang.sure_password">
                        <el-input v-model="params.re_password" type="password" show-password
                          :placeholder="`${lang.placeholder_pre1}${lang.sure_password}`">
                        </el-input>
                        <span class="error-tip" v-show="showRepass">{{lang.mf_tip19}}</span>
                      </el-form-item>

                    </template>
                  </div>
                </el-form-item>
                <el-form-item class="optional">
                  <template slot="label">
                    {{lang.cloud_name}}
                    <el-tooltip class="item" effect="light" :content="lang.mf_tip14" placement="top">
                      <i class="el-icon-warning-outline"></i>
                    </el-tooltip>
                  </template>
                  <el-input v-model="params.notes" :placeholder="lang.mf_tip15"></el-input>
                </el-form-item>
                <!-- ssh端口 -->
                <el-form-item :label="`SSH${lang.common_cloud_label13}`" v-if="baseConfig.rand_ssh_port === 1"
                  class="optional">
                  <el-input v-model="params.port" :placeholder="lang.placeholder_pre1"></el-input>
                  <i class="el-icon-refresh" class="refresh" @click="refreshPort"></i>
                </el-form-item>
                <el-form-item v-show="showPort" label=' ' class="empty-item" style="margin-top: -.2rem;">
                  <span class="error-tip">{{lang.placeholder_pre1}}{{lang.common_cloud_label13}}</span>
                </el-form-item>
                <el-form-item :label="lang.auto_renew" class="renew">
                  <el-checkbox v-model="params.auto_renew">{{lang.open_auto_renew}}</el-checkbox>
                </el-form-item>
                <!-- 2023-5-23 新增 -->
                <el-form-item :label="lang.ip_mac_bind_enable" class="renew" v-if="baseConfig.ip_mac_bind_enable">
                  <el-checkbox
                    v-model="params.ip_mac_bind_enable">{{lang.mf_allow}}{{lang.ip_mac_bind_enable}}</el-checkbox>
                </el-form-item>

                <template v-if="baseConfig.nat_acl_limit_enable">
                  <el-form-item :label="lang.nat_acl_limit_enable" class="renew"
                    v-if="params.network_type === 'vpc' || (params.network_type === 'normal' && baseConfig.type === 'lightHost')">
                    <el-checkbox @change="changeNat" :disabled="baseConfig.default_nat_acl === 1"
                      v-model="params.nat_acl_limit_enable">{{lang.mf_support}}{{lang.nat_acl_limit_enable}}</el-checkbox>
                  </el-form-item>
                </template>
                <template v-if="baseConfig.nat_web_limit_enable">
                  <el-form-item :label="lang.nat_web_limit_enable" class="renew"
                    v-if="params.network_type === 'vpc' || (params.network_type === 'normal' && baseConfig.type === 'lightHost')">
                    <el-checkbox @change="changeNat" :disabled="baseConfig.default_nat_web === 1"
                      v-model="params.nat_web_limit_enable">{{lang.mf_support}}{{lang.nat_web_limit_enable}}</el-checkbox>
                  </el-form-item>
                </template>
              </template>
              <custom-goods :id="id" label-width="100px" :self_defined_field.sync="self_defined_field"
                class="custom-config" ref="customGoodRef">
              </custom-goods>
            </el-form>
          </div>
        </el-tab-pane>

      </el-tabs>
    </div>
    <!-- 底部 -->
    <div class="f-order">
      <div class="l-empty"></div>
      <div class="el-main">
        <div class="main-card">
          <div class="left">
            <div class="time">
              <span class="l-txt">{{lang.mf_time}}</span>
              <el-select v-model="params.duration_id" class="duration-select" popper-class="duration-pup"
                :visible-arrow="false" :placeholder="`${lang.placeholder_pre2}${lang.mf_duration}`"
                @change="changeDuration">
                <el-option v-for="item in cycleList" :key="item.id" :label="item.name" :value="item.id">
                  <span class="txt">{{item.name}}</span>
                  <span class="tip" v-if="item.discount">{{item.discount}}{{lang.mf_tip25}}</span>
                </el-option>
              </el-select>
            </div>
            <!-- <div class="num">
              <span class="l-txt">{{lang.shoppingCar_goodsNums}}</span>
              <el-input-number v-model="qty" :min="1" :max="999" @change="changQty"></el-input-number>
            </div> -->
          </div>
          <div class="mid">
            <el-popover placement="top" trigger="hover" popper-class="cur-content">
              <div class="content">
                <div class="tit">{{lang.mf_tip7}}</div>
                <div class="con">
                  <p class="c-item">
                    <span class="l-txt">{{lang.cloud_table_head_1}}：</span>
                    {{calcArea}}
                  </p>
                  <p class="c-item">
                    <span class="l-txt">{{lang.network_type}}：</span>
                    {{this.params.network_type === 'normal' ? lang.mf_normal : lang.mf_vpc}}
                  </p>
                  <p class="c-item">
                    <span class="l-txt">{{lang.usable_area}}：</span>
                    {{calcUsable}}
                  </p>
                  <p class="c-item">
                    <span class="l-txt">{{lang.ip_line}}：</span>
                    {{calcLine}}
                  </p>
                  <p class="c-item">
                    <span class="l-txt">{{lang.cloud_menu_1}}：</span>
                    {{params.cpu}}{{lang.mf_cores}}{{params.memory}}G
                  </p>
                  <p class="c-item" v-if="params.gpu_num">
                    <span class="l-txt">GPU{{lang.shoppingCar_goodsNums}}：</span>
                    {{params.gpu_num}}*{{gpu_name}}
                  </p>
                  <p class="c-item" v-if="lineType === 'bw'">
                    <span class="l-txt">{{lang.mf_bw}}：</span>
                    {{params.bw ? params.bw + 'Mbps': '--'}}
                  </p>
                  <p class="c-item">
                    <span class="l-txt">{{lang.cloud_menu_5}}：</span>
                    {{version || '--'}}
                  </p>
                  <p class="c-item" v-if="lineType === 'flow'">
                    <span class="l-txt">{{lang.mf_flow}}：</span>
                    {{params.flow ? params.flow + 'GB': (params.flow === 0 ? lang.mf_tip28 : '--')}}
                  </p>
                  <p class="c-item" v-if="lineDetail.ip && lineDetail.ip.length >0">
                    <span class="l-txt">IPv4{{lang.shoppingCar_goodsNums}}：</span>
                    {{params.ip_num === 0 ? lang.mf_none : params.ip_num + lang.common_cloud_title43}}
                  </p>
                  <p class="c-item" v-if="lineDetail.ipv6 && lineDetail.ipv6.length >0">
                    <span class="l-txt">IPv6{{lang.shoppingCar_goodsNums}}：</span>
                    {{params.ipv6_num === 0 ? lang.mf_none : params.ipv6_num + lang.common_cloud_title43}}
                  </p>
                  <p class="c-item">
                    <span class="l-txt">{{lang.mf_system}}：</span>
                    {{params.system_disk?.size}}GB
                  </p>
                  <p class="c-item"
                    v-if="(activeName === 'fast' && params.peak_defence ) || (lineDetail.defence && params.peak_defence)">
                    <span class="l-txt">{{lang.peak_defence}}：</span>
                    {{ params.peak_defence + 'G'}}
                  </p>
                  <p class="c-item" v-if="params.data_disk[0]?.size">
                    <span class="l-txt">{{lang.common_cloud_text1}}：</span>
                    {{calcDataNum}}GB
                  </p>
                </div>
              </div>
              <a class="link" slot="reference">{{lang.cur_config}}</a>
            </el-popover>
            <div class="line-empty"></div>
            <el-popover placement="top" trigger="hover" popper-class="free-content">
              <div class="content">
                <div class="tit">{{lang.config_free_details}}</div>
                <div class="con">
                  <p class="c-item" v-for="(item,index) in preview" :key="index">
                    <span class="l-txt">{{item.name}}：{{item.value}}</span>
                    <span class="price">{{commonData.prefix}}{{item.price}}</span>
                  </p>
                </div>
                <div class="bot">
                  <p class="c-item" v-if="discount || levelNum">
                    <span class="l-txt">{{lang.mf_discount}}：</span>
                    <span class="price">-{{commonData.prefix}}{{(discount * 1 + levelNum * 1 >= totalPrice * 1 *
                      qty ? totalPrice * 1 * qty : discount * 1 + levelNum * 1).toFixed(2)}}</span>
                  </p>
                  <p class="c-item">
                    <span class="l-txt">{{lang.mf_total}}：</span>
                    <span class="price">{{commonData.prefix}}{{calcTotalPrice}}</span>
                  </p>
                </div>
              </div>
              <a class="link" slot="reference">{{lang.config_free}}</a>
            </el-popover>
            <div class="bot-price" v-loading="loadingPrice">
              <div class="new">{{commonData.prefix}}<span>{{calcTotalPrice}}</span>
                <el-popover placement="top" width="200" trigger="hover" v-if="levelNum || discount"
                  popper-class="level-pup">
                  <div class="show-config-list">
                    <p v-if="levelNum">{{lang.shoppingCar_tip_text2}}：{{commonData.prefix}} {{ levelNum |
                      filterMoney }}</p>
                    <p v-if="discount">{{lang.shoppingCar_tip_text4}}：{{commonData.prefix}} {{ discount |
                      filterMoney }}</p>
                  </div>
                  <i class="el-icon-warning-outline total-icon" slot="reference"></i>
                </el-popover>
              </div>
              <div class="old">
                <div class="show" v-if="discount || levelNum ">
                  {{commonData.prefix}}{{(totalPrice * 1 * qty).toFixed(2)}}
                </div>
                <!-- 优惠码 -->
                <!-- 未使用 -->
                <el-popover placement="top" trigger="click" popper-class="discount-pup" v-model="dis_visible"
                  v-if="!discount">
                  <div class="discount">
                    <img src="/themes/cart/default/v10/img/close_icon.png" alt="" class="close"
                      @click="dis_visible = !dis_visible">
                    <div class="code">
                      <el-input v-model="promo.promo_code"
                        :placeholder="`${lang.placeholder_pre1}${lang.cloud_code}`"></el-input>
                      <button class="sure" @click="useDiscount">{{lang.referral_btn6}}</button>
                    </div>
                    <span class="error-tip" v-show="showErr">{{lang.mf_tip8}}</span>
                  </div>
                  <p class="use" slot="reference" v-show="hasDiscount">{{lang.use_discount}}</p>
                </el-popover>
                <!-- 已使用 -->
                <div class="used" v-else>
                  <span>{{promo.promo_code}}</span>
                  <i class="el-icon-circle-close" @click="canclePromo"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="right">
            <div class="buy" @click="handlerCart">{{calcCartName}}</div>
          </div>
        </div>
      </div>

    </div>
    <el-dialog title="" :visible.sync="cartDialog" custom-class="cartDialog" :show-close="false">
      <span class="tit">{{lang.product_tip}}</span>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="cartDialog = false">{{lang.product_continue}}</el-button>
        <el-button @click="goToCart">{{lang.product_settlement}}</el-button>
      </span>
    </el-dialog>
  </div>


  <!-- 通用 -->
  <script src="/themes/cart/default/v10/resource/vue.js"></script>
  <script src="/themes/cart/default/v10/resource/element.js"></script>
  <script src="/themes/cart/default/v10/utils/axios.min.js"></script>
  <script src="/themes/cart/default/v10/utils/request.js"></script>
  <script src="/themes/cart/default/v10/utils/util.js"></script>
  <script src="/themes/cart/default/v10/components/customGoods/customGoods.js"></script>
  <!-- 独有 -->

  <script src="/themes/cart/default/v10/api/mf_cloud.js"></script>
  <script src="/themes/cart/default/v10/js/mf_cloud.js"></script>
</body>

</html>
