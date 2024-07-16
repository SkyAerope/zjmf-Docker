<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport"
    content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <title></title>
  <link rel="stylesheet" href="/themes/clientarea/default/v10/resource/element.css">
  <link rel="stylesheet" href="/themes/clientarea/default/v10/css/cloudTop.css">
  <link rel="stylesheet" href="/themes/clientarea/default/v10/css/cloudDetail.css">
  <script src="/themes/clientarea/default/v10/lang/{$LanguageCheck.display_flag}.js"></script>
  <script src="/themes/clientarea/default/v10/utils/pagination.js"></script>
  <script src="/themes/clientarea/default/v10/components/flowPacket/flowPacket.js"></script>
  <style>
    [v-cloak] {
      display: none;
    }
  </style>
</head>

<body>
  <div class="template" id="product_detail_cloud" v-cloak>
    <!-- 自己的东西 -->
    <div class="main-card">
      <div class="card-top">
        <div class="top-operation">
          <div class="operation-row1">
            <img @click="goBack" class="back-img" src="/themes/clientarea/default/v10/img/back.png" />
            <span class="top-product-name">{{hostData.product_name}}</span>
            <div class="host-status" @click="goPay" :class="hostData.status">{{hostData.status_name}}</div>
            <span class="top-area">
              <img class="country-img" :src="'/upload/common/country/' + cloudData.data_center.iso +'.png'">
              <span class="country">{{cloudData.data_center.country_name}}</span>
              <span class="city">{{cloudData.data_center.city}}</span>
            </span>
          </div>
          <div class="operation-row2">
            <div class="row2-left">
              <span class="name">{{hostData.name}}</span>
              <span class="ip">
                {{ipDetails.dedicate_ip}}
                <el-popover placement="top" trigger="hover" v-if="ipDetails.ip_num > 1">
                  <div class="ips">
                    <p v-for="(item,index) in allIp" :key="index">
                      {{item}}
                      <i class="el-icon-document-copy base-color" @click="copyIp(item)"></i>
                    </p>
                  </div>
                  <span slot="reference" class="base-color">
                    ({{ipDetails.ip_num}})
                  </span>
                </el-popover>
                <i class="el-icon-document-copy base-color" v-if="ipDetails.ip_num > 0" @click="copyIp(allIp)"></i>
              </span>
            </div>
            <div class="row2-right" v-show="hostData.status == 'Active' && !initLoading">
              <!-- 停用-->
              <span class="refund" v-if="financeConfig.cancel_control">
                <!-- <span class="refund-status"
                v-if="refundData && refundData.status != 'Cancelled' && refundData.status != 'Reject'">{{refundStatus[refundData.domainstatus]}}</span> -->
                <span class="refund-stop-btn" v-if="refundData.is_cancel"
                  @click="quitRefund">{{lang.common_cloud_btn8}}</span>
                <span class="refund-btn" @click="showRefund" v-else>{{lang.common_cloud_btn9}}</span>
              </span>

              <!-- 控制台 -->
              <!-- <img class="console-img" src="/plugins/server/mf_cloud/template/clientarea/img/cloudDetail/console.png" :title="lang.common_cloud_text8" @click="doGetVncUrl" v-show="status != 'operating'"> -->
              <!-- 开关机 -->
              <span class="on-off">
                <el-popover placement="bottom" v-model="onOffvisible" trigger="click">
                  <div class="sure-remind">
                    <span class="text">{{lang.common_cloud_text9}}</span>
                    <span class="status">{{status == 'on'?lang.common_cloud_text11:lang.common_cloud_text10}} </span>
                    <span>?</span>
                    <!-- 关机确认 -->
                    <span class="sure-btn" v-if="status == 'on'" @click="doPowerOff">{{lang.common_cloud_btn10}}</span>
                    <!-- 开机确认 -->
                    <span class="sure-btn" v-else @click="doPowerOn">{{lang.common_cloud_btn10}}</span>
                  </div>
                  <img :src="'/themes/clientarea/default/v10/img/'+status+'.png'" :title="statusText"
                    v-show="(status != 'operating') && (status != 'fault')" slot="reference">
                </el-popover>
                <i class="el-icon-loading" :title="lang.common_cloud_text12" v-show="status == 'operating'"></i>
                <img :src="'/themes/clientarea/default/v10/img/'+status+'.png'" :title="statusText"
                  v-show="status == 'fault'">
              </span>

              <div class="info-box" v-if="cloudData.type !== 'hyperv'">
                <div class="cpu-box">
                  <span style="min-width: 50px; display: inline-block;">{{cpu_realData.cpu_usage}}%</span>
                  <span class="green-div"><span class="percentage-div"
                      :style="{width: cpu_realData.cpu_usage +'%'}"></span></span>
                  <span>CPU</span>
                </div>
                <div class="memory-box">
                  <span style="min-width: 50px; display: inline-block;"
                    v-if="cpu_realData.memory_usage != -1">{{cpu_realData.memory_usage}}%</span>
                  <span style="min-width: 50px; display: inline-block;" v-else> -- </span>
                  <span class="green-div" v-if="cpu_realData.memory_usage != -1"><span class="percentage-div"
                      :style="{width: cpu_realData.memory_usage + '%'}"></span></span>
                  <span class="green-div" v-else><span class="percentage-div" :style="{width:'0%'}"></span></span>
                  <span>{{lang.cloud_memery}}</span>
                </div>
              </div>
              <!-- 重启 -->
              <!-- <span class="restart">
              <el-popover placement="bottom" v-model="rebotVisibel" trigger="click">
                <div class="sure-remind">
                  <span class="text">{{lang.common_cloud_text9}}</span>
                  <span class="status">{{lang.common_cloud_text13}}</span>
                  <span>?</span>
                  <span class="sure-btn" @click="doReboot">{{lang.common_cloud_btn10}}</span>
                </div>
                <img src="/plugins/server/mf_cloud/template/clientarea/img/cloudDetail/restart.png" :title="lang.common_cloud_text13" v-show="status != 'operating'" slot="reference">
              </el-popover>
            </span> -->

              <!-- 救援模式 -->
              <img class="fault" src="/themes/clientarea/default/v10/img/fault.png"
                v-show="isRescue && status != 'operating'" :title="lang.common_cloud_text14">
            </div>
          </div>
          <div class="operation-row3" v-show="hostData.status == 'Active'">
            <!-- 有备注 -->
            <span class="yes-notes" v-if="financeConfig.remark" @click="doEditNotes">
              <i class="el-icon-edit notes-icon"></i>
              <span class="notes-text">{{financeConfig.remark}}</span>
            </span>
            <!-- 无备注 -->
            <span class="no-notes" v-else @click="doEditNotes">
              {{lang.cloud_add_notes + ' +'}}
            </span>

          </div>
        </div>
        <div class="refund-msg">
          <!-- 停用成功 -->
          <div class="refund-success" v-if="refundData && refundData.status == 'Suspending'">
            ({{lang.common_cloud_tip6}}{{refundData.create_time | formateTime}}{{lang.common_cloud_tip7}}
            {{refundData.type=='Endofbilling'?lang.common_cloud_tip8:lang.common_cloud_tip9}}，{{lang.common_cloud_tip13}}<span
              v-if="refundData.type=='Endofbilling'">{{hostData.due_time |
              formateTime}}</span>{{refundData.type=='Endofbilling'?
            lang.common_cloud_tip10:lang.common_cloud_tip11}} {{lang.common_cloud_tip12}})
          </div>
          <!-- 停用失败 -->
          <div class="refund-fail" v-if="refundData && refundData.status == 'Reject'">
            ({{lang.common_cloud_tip6}}{{refundData.create_time | formateTime}}{{lang.common_cloud_tip7}}
            {{refundData.type=='Endofbilling'?lang.common_cloud_tip8:lang.common_cloud_tip9}}
            {{lang.common_cloud_tip14}}，
            <el-popover placement="top-start" trigger="hover">
              <span>{{refundData.reject_reason}}</span>
              <span class="reason-text" slot="reference">{{lang.common_cloud_text15}}</span>
            </el-popover>

            )
          </div>
        </div>
        <div class="top-msg">
          <!-- 实例信息 -->
          <div class="msg-l">
            <div class="l-t">
              <div class="l-t-l">
                <span class="l-t-l-text">{{lang.appstore_text305}}</span>
              </div>
              <!-- 模拟物理机运行 -->
              <div class="r-t-r">
                <span>{{lang.simulate_physical}}：</span>
                <el-switch :value="rescueStatusData.simulate_physical_machine" active-color="#0052D9"
                  @change="physicalChange" :active-value="1" :inactive-value="0">
                </el-switch>
                <el-popover placement="top" trigger="hover" popper-class="physicalPop">
                  <div class="sure-remind">{{lang.simulate_physical_tip}}</div>
                  <div class="help" slot="reference">?</div>
                </el-popover>
              </div>
            </div>
            <div class="l-b">
              <div class="info-item">
                <div class="label">CPU:</div>
                <div class="value">
                  {{cloudData.cpu}}{{lang.common_cloud_text30}}
                </div>
              </div>
              <div class="info-item">
                <div class="label">GPU:</div>
                <div class="value">
                  <span :title="cloudData.gpu">{{cloudData.gpu || '--'}}</span>
                </div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.common_cloud_label14}}:</div>
                <div class="value">{{rescueStatusData.username}}</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.common_cloud_text31}}:</div>
                <div class="value">
                  {{cloudData.memory}}{{configData?.config?.memory_unit}}
                </div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.cloud_os}}:</div>
                <div class="value" :title="cloudData.image?.name">
                  {{ cloudData.image?.name}}
                </div>
              </div>
              <div class="info-item">
                <div class="label" v-if="cloudData.ssh_key?.id > 0">
                  {{lang.security_tab1}}:
                </div>
                <div class="label" v-else>{{lang.common_cloud_label7}}:</div>
                <div class="value" v-if="cloudData.ssh_key?.id === 0">
                  <span v-show="isShowPass">
                    {{rescueStatusData.password}}
                  </span>
                  <span v-show="!isShowPass"> {{passHidenCode}} </span>
                  <img class="eyes"
                    :src="isShowPass?'/themes/clientarea/default/v10/img/pass-show.png':'/themes/clientarea/default/v10/img/pass-hide.png'"
                    @click="isShowPass=!isShowPass" />
                  <i class="el-icon-document-copy" style="
                        font-size: 14px;
                        margin-left: 3px;
                        cursor: pointer;
                        color: #0052d9;
                      " @click="copyPass(rescueStatusData.password)"></i>
                </div>
                <div class="value" v-else>
                  <span style="color: #0058ff; cursor: pointer" @click="goSSHpage">{{cloudData.ssh_key?.name}}</span>
                </div>
              </div>
              <div class="info-item" v-if="cloudData.line?.bill_type === 'flow'">
                <div class="label">{{lang.mf_flow}}:</div>
                <div class="value" v-if="cloudData.flow !==0">
                  {{cloudData.flow}}G
                </div>
                <div class="value" v-else>{{lang.mf_tip28}}</div>
              </div>
              <div class="info-item" v-else>
                <div class="label">{{lang.mf_bw}}:</div>
                <div class="value">{{cloudData.bw}}Mbps</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.common_cloud_label13}}:</div>
                <div class="value">{{rescueStatusData.port}}</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.peak_defence}}:</div>
                <div class="value">
                  <span v-if="cloudData.peak_defence * 1">{{cloudData.peak_defence}}G</span>
                  <span v-else>{{lang.no_defense}}</span>
                </div>
              </div>
              <div class="info-item">
                <div class="label">IPv4{{lang.shoppingCar_goodsNums}}:</div>
                <div class="value">
                  <template v-if="ipDetails.ip_num - cloudData.ipv6_num <= 0">
                    {{lang.mf_none}}
                  </template>
                  <template v-else>{{ipDetails.ip_num - cloudData.ipv6_num}}{{lang.mf_one}}</template>
                </div>
              </div>
              <div class="info-item">
                <div class="label">IPv6{{lang.shoppingCar_goodsNums}}:</div>
                <div class="value">
                  <template v-if="cloudData.ipv6_num === 0">
                    {{lang.mf_none}}
                  </template>
                  <template v-else>{{cloudData.ipv6_num}}{{lang.mf_one}}</template>
                </div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.common_cloud_title15}}:</div>
                <div class="value">
                  {{rescueStatusData.ip_num}}{{lang.mf_one}}
                </div>
              </div>
              <div class="info-item" v-for="(item,index) in self_defined_field" :key="item.id">
                <div class="label">{{item.field_name}}:</div>
                <div class="value">
                  <span v-if="item.field_type === 'password'">
                    <span v-if="!item.hidenPass && item.value">{{item.value.replace(/./g, '*')}}</span>
                    <span v-else>{{item.value || '--'}}</span>
                  </span>
                  <span v-else-if="item.field_type === 'textarea'" class="word-pre">{{item.value || '--'}}</span>
                  <span v-else>{{item.value || '--'}}</span>
                </div>
                <img class="eyes" v-if="item.field_type === 'password' && item.value"
                  :src="item.hidenPass ? '/themes/clientarea/default/v10/img/pass-show.png' : '/themes/clientarea/default/v10/img/pass-hide.png'"
                  @click="item.hidenPass=! item.hidenPass" />
                <i class="el-icon-document-copy"
                  v-if="(item.field_type === 'password' || item.field_type === 'link') && item.value" style="
                    font-size: 14px;
                    margin-left: 3px;
                    cursor: pointer;
                    color: #0052d9;
                  " @click="copyPass(item.value)"></i>
              </div>
            </div>
          </div>
          <!-- 付款信息 -->
          <div class="msg-r">
            <div class="r-t">
              <div class="r-t-l">
                <span class="r-t-l-text">{{lang.cloud_pay_title}}</span>
                <span @click="applyCashback" class="common-cashback" v-if="isShowCashBtn">{{lang.apply_cashback}}</span>
              </div>
              <!-- 续费 -->
              <div class="r-t-r" v-show="hostData.status == 'Active'">
                <span>{{lang.common_cloud_text16}}：</span>
                <el-switch v-model="isShowPayMsg" active-color="#0052D9" @change="autoRenewChange">
                </el-switch>
                <el-popover placement="top" trigger="hover">
                  <div class="sure-remind">
                    {{lang.common_cloud_tip15}}
                  </div>
                  <div class="help" slot="reference">?</div>
                </el-popover>
              </div>
            </div>
            <div class="r-b">
              <div class="row">
                <div class="row-l">
                  <div class="label">{{lang.cloud_due_time}}:</div>
                  <div class="value" :class="isRead?'red':''">{{hostData.due_time | formateTime}}</div>
                </div>
                <div class="row-r">
                  <div class="label">{{lang.cloud_creat_time}}:</div>
                  <div class="value">{{hostData.active_time | formateTime}}</div>
                </div>
              </div>
              <div class="row">
                <div class="row-l">
                  <div class="label">{{lang.cloud_pay_style}}:</div>
                  <div class="value">{{hostData.billing_cycle_name + lang.common_cloud_text17}}</div>
                </div>
                <div class="row-r">
                  <div class="label">{{lang.cloud_first_pay}}:</div>
                  <div class="value">{$Detail.currency.prefix}{{hostData.first_payment_amount
                    }}{$Detail.currency.suffix}</div>
                </div>
              </div>
              <div class="row">
                <div class="row-l">
                  <div class="label">{{lang.cloud_re_text}}:</div>
                  <div class="value">{$Detail.currency.prefix}{{showRenewPrice}}{$Detail.currency.suffix}
                  </div>
                  <!--  || 'Suspended' -->
                  <span v-show="hostData.status == 'Active' || hostData.status == 'Suspended'"
                    v-loading="renewBtnLoading" class="renew-btn" @click="showRenew"
                    v-if="!refundData || refundData || (refundData && refundData.status=='Cancelled') || (refundData && refundData.status=='Reject')">{{lang.cloud_re_btn}}</span>
                  <span v-show="hostData.status == 'Active'" class="renew-btn-disable"
                    v-else>{{lang.cloud_re_btn}}</span>
                </div>
                <div class="row-r">
                  <div class="label">{{lang.cloud_code}}:</div>
                  <div class="value" :title="codeString">{{codeString?codeString:'--'}}</div>
                </div>
              </div>

            </div>
          </div>
        </div>

        <el-tabs class="tabs" v-model="activeName" @tab-click="handleClick"
          v-show="hostData.status == 'Active' && !initLoading">
          <el-tab-pane :label="lang.common_cloud_tab1" name="1" v-if="cloudData.type !== 'hyperv'">
            <el-select class="time-select" v-model="chartSelectValue" @change="chartSelectChange">
              <el-option value='1' :label="lang.common_cloud_label15"></el-option>
              <el-option value='2' :label="lang.common_cloud_label16"></el-option>
              <el-option value='3' :label="lang.common_cloud_label17"></el-option>
            </el-select>

            <div class="echart-main">
              <!-- cpu用量图 -->
              <div id="cpu-echart" class="my-echart" v-loading="echartLoading1"></div>
              <!-- 网络带宽 -->
              <div id="bw-echart" class="my-echart" v-loading="echartLoading2"></div>
              <!-- 磁盘IO -->
              <div id="disk-io-echart" class="my-echart" v-loading="echartLoading3"></div>
              <!-- 内存用量 -->
              <div id="memory-echart" class="my-echart" v-loading="echartLoading4"></div>
            </div>
          </el-tab-pane>
          <el-tab-pane :label="lang.common_cloud_tab2" name="2">
            <!-- 管理 -->
            <div class="manage-content">
              <!-- 第一行 -->
              <el-row>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top">
                      <el-select v-model="powerStatus">
                        <el-option v-for="item in powerList" :key="item.id" :value="item.value"
                          :label="item.label"></el-option>
                      </el-select>
                      <div class="item-top-btn" @click="showPowerDialog" v-loading="loading1">
                        {{lang.common_cloud_btn10}}
                      </div>
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip16}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="getVncUrl" v-loading="loading2">
                      {{lang.common_cloud_btn11}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip17}}</div>
                      <div class="bottom-row">{{lang.common_cloud_tip18}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="showRePass">
                      {{lang.common_cloud_btn12}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip19}}</div>
                      <div class="bottom-row">{{lang.common_cloud_tip20}}</div>
                    </div>
                  </div>
                </el-col>

              </el-row>
              <!-- 第二行 -->
              <el-row>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="showRescueDialog" v-if="!isRescue">
                      {{lang.common_cloud_btn13}}
                    </div>
                    <div class="item-top-btn" @click="showQuitRescueDialog" v-else>
                      {{lang.common_cloud_btn14}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip21}}</div>
                      <div class="bottom-row">{{lang.common_cloud_tip22}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="showReinstall">
                      {{lang.common_cloud_btn15}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip23}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="showUpgrade">
                      {{lang.common_cloud_btn16}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip24}}</div>
                    </div>
                  </div>
                </el-col>
              </el-row>
              <!-- 第三行 -->
              <el-row>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" style="background: #eee;cursor: not-allowed;color: #999;">
                      {{lang.common_cloud_btn17}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip25}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" style="background: #eee;cursor: not-allowed;color: #999;">
                      {{lang.common_cloud_btn18}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip26}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" style="background: #eee;cursor: not-allowed;color: #999;">
                      {{lang.common_cloud_btn19}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip27}}</div>
                    </div>
                  </div>
                </el-col>
              </el-row>
            </div>
          </el-tab-pane>
          <el-tab-pane :label="lang.common_cloud_tab3" name="3">
            <div class="disk-top-operation" v-if="!isPackage">
              <el-button v-if="trueDiskLength != 0" type="primary" class="btn1"
                @click="showExpansion">{{lang.common_cloud_btn20}}</el-button>
            </div>
            <div class="no-disk" v-if="diskList.length == 0">
              <span class="text">{{lang.common_cloud_text18}}</span>
              <span class="text2">{{lang.common_cloud_text19}}</span>
            </div>
            <div class="yes-disk" v-else>
              <div class="main-table">
                <el-table v-loading="diskLoading" :data="diskList" style="width: 100%">
                  <el-table-column prop="name" :label="lang.common_cloud_label18" min-width="400" align="left">
                  </el-table-column>
                  <el-table-column prop="create_time" width="400" :label="lang.common_cloud_label19" align="left">
                    <template slot-scope="scope">
                      {{scope.row.create_time | formateTime}}
                    </template>
                  </el-table-column>
                  <el-table-column prop="size" :label="lang.common_cloud_label20" width="200" align="left"
                    :show-overflow-tooltip="true">
                    <template slot-scope="scope">
                      <span>{{scope.row.size + 'G'}}</span>
                    </template>
                  </el-table-column>
                  <el-table-column prop="op" :label="lang.common_cloud_label30" width="90" align="left"
                    :show-overflow-tooltip="true">
                    <template slot-scope="scope">
                      <span class="text-btn" v-if="scope.row.type2 === 'data' && scope.row.status === 0"
                        @click="handelMount(scope.row.id)">{{lang.common_cloud_title16}}</span>
                      <span class="text-btn" v-if="scope.row.type2 === 'data' && scope.row.status === 1"
                        @click="handelUnload(scope.row.id)">{{lang.common_cloud_title17}}</span>
                    </template>
                  </el-table-column>
                </el-table>
              </div>
            </div>
            <span v-show="dataDiskList.length > 0 && !isPackage" class="buy-btn"
              @click="showDg">{{lang.common_cloud_btn22}}</span>
          </el-tab-pane>
          <el-tab-pane :label="lang.common_cloud_tab4" name="4">
            <div class="net">
              <div class="title top-box">
                <span>{{lang.common_cloud_title3}}</span>
                <div class="flow-btn" type="primary" @click="showIpDia" v-if="!isPackage">{{lang.common_cloud_title18}}
                </div>
              </div>
              <div class="main_table">
                <el-table v-loading="netLoading" :data="netDataList" style="width: 100%;margin-bottom: 20px;">
                  <el-table-column prop="ip" :label="lang.common_cloud_label21" min-width="200" align="left">
                  </el-table-column>
                  <el-table-column prop="gateway" width="400" :label="lang.common_cloud_label22" align="left">
                  </el-table-column>
                  <el-table-column prop="subnet_mask" width="400" :label="lang.common_cloud_label23" align="left">
                  </el-table-column>
                </el-table>
                <pagination :page-data="netParams" @sizechange="netSizeChange" @currentchange="netCurrentChange">
                </pagination>
              </div>
              <!-- ipv6 -->
              <div class="main_table" style="margin-top: 20px;" v-if="cloudData.network_type !== 'vpc'">
                <el-table v-loading="ipv6Loading" :data="ipv6DataList" style="width: 100%;margin-bottom: 0.2rem">
                  <el-table-column prop="ipv6" :label="lang.ipv6_address" min-width="200" align="left">
                  </el-table-column>
                  <el-table-column prop="gateway" min-width="200" :label="lang.common_cloud_label22" align="left">
                    <template slot-scope="{row}">
                      {{row.gateway || '--'}}
                    </template>
                  </el-table-column>
                  <el-table-column prop="subnet_mask" min-width="200" :label="lang.common_cloud_label23" align="left">
                    <template slot-scope="{row}">
                      {{row.subnet_mask || '--'}}
                    </template>
                  </el-table-column>
                </el-table>
                <pagination :page-data="ipv6Params" v-if="ipv6Params.total" @sizechange="ipv6SizeChange"
                  @currentchange="netCurrentChange">
                </pagination>
              </div>
              <template v-if="cloudData.network_type === 'vpc'">
                <div class="title top-box">
                  <span>{{lang.common_cloud_title19}}</span>
                  <div class="flow-btn" type="primary" @click="handelAddVpc">{{lang.common_cloud_title20}}</div>
                </div>
                <div class="main_table">
                  <el-table v-loading="vpcLoading" :data="vpcDataList" style="width: 100%;margin-bottom: 20px;">
                    <el-table-column prop="name" min-width="300" :label="lang.common_cloud_title21" align="left">
                    </el-table-column>
                    <el-table-column prop="ips" width="300" :label="lang.common_cloud_title22" align="left">
                    </el-table-column>
                    <el-table-column min-width="300" :label="lang.common_cloud_title23" align="left">
                      <template slot-scope="scope">
                        <el-tooltip placement="top" v-if="scope.row.host.length > 1">
                          <div slot="content">
                            <template v-for="items in scope.row.host">
                              {{items.name}}<br />
                            </template>
                          </div>
                          <span v-if="scope.row.host.length > 1">{{scope.row.host[0].name}}...</span>
                        </el-tooltip>
                        <span v-else-if="scope.row.host.length === 1">{{scope.row.host[0].name }}</span>
                        <span v-else>--</span>
                      </template>
                    </el-table-column>
                    <el-table-column width="200" :label="lang.common_cloud_label30" align="left">
                      <template slot-scope="scope">
                        <span class="text-btn" @click="handelEngine(scope.row)">{{lang.common_cloud_title24}}</span>
                        <span class="text-btn" @click="handDelVpc(scope.row.id)">{{lang.common_cloud_title25}}</span>
                      </template>
                    </el-table-column>
                  </el-table>
                  <pagination :page-data="vpcParams" @sizechange="vpcSizeChange" @currentchange="vpcCurrentChange">
                  </pagination>
                </div>
              </template>
              <template v-if="cloudData.type !== 'hyperv'">
                <div class="title flow-box">
                  {{lang.common_cloud_title4}}
                  <div type="primary" @click="buyPackage" v-if="flowData.total?.includes('GB') && flowData.flow_plugin"
                    size="small" class="flow-btn">
                    {{lang.buy_package}}
                  </div>
                </div>
                <div class="flow-content">
                  <div class="flow-item">
                    <div class="flow-label">{{lang.common_cloud_label24}}:</div>
                    <div class="flow-value">{{flowData.total}}</div>
                  </div>
                  <div class="flow-item">
                    <div class="flow-label">{{lang.common_cloud_label25}}:</div>
                    <div class="flow-value">{{flowData.leave}}</div>
                  </div>
                  <div class="flow-item">
                    <div class="flow-label">{{lang.common_cloud_label26}}:</div>
                    <div class="flow-value">{{flowData.reset_flow_date}}</div>
                  </div>
                </div>
                <el-select class="time-select" v-model="chartSelectValue" @change="chartSelectChange">
                  <el-option value='1' :label="lang.common_cloud_label15"></el-option>
                  <el-option value='2' :label="lang.common_cloud_label16"></el-option>
                  <el-option value='3' :label="lang.common_cloud_label17"></el-option>
                </el-select>
                <div class="echart-main">
                  <!-- 网络带宽 -->
                  <div id="bw2-echart" class="my-echart" v-loading="echartLoading2"></div>
                </div>
              </template>


            </div>
          </el-tab-pane>
          <!-- nat转发建站 -->
          <el-tab-pane :label="calcNat" name="nat" v-if="cloudData.nat_acl_limit || cloudData.nat_web_limit">
            <div class="main-content" v-if="cloudData.nat_acl_limit > 0">
              <div class="content-top">
                <div class="top-title">NAT{{lang.nat_acl}} （{{aclList.length}}/{{cloudData.nat_acl_limit}}）</div>
                <div class="top-btn nat-btn" @click="showCreateNat('acl')"
                  v-if="aclList.length < cloudData.nat_acl_limit">{{lang.invoice_text47}}{{lang.nat_acl}}</div>
              </div>
              <div class="main-table">
                <el-table v-loading="aclLoading" :data="aclList" style="width: 100%;">
                  <el-table-column prop="id" label="ID" width="100">
                  </el-table-column>
                  <el-table-column prop="name" :label="lang.common_cloud_title21" :show-overflow-tooltip="true">
                  </el-table-column>
                  <el-table-column prop="ip" :label="lang.forward_ip_port" :show-overflow-tooltip="true"
                    min-width="150">
                  </el-table-column>
                  <el-table-column prop="int_port" :label="lang.int_port" width="150" :show-overflow-tooltip="true">
                  </el-table-column>
                  <el-table-column prop="protocol" :label="lang.protocol" width="150" :show-overflow-tooltip="true">
                    <template slot-scope="{row}">
                      {{calcProtocol(row.protocol)}}
                    </template>
                  </el-table-column>
                  <el-table-column width="100" :label="lang.common_cloud_label30" align="left">
                    <template slot-scope="{row, $index}">
                      <span class="text-btn" @click="handDelacl(row)"
                        v-if="$index !== aclList.length - 1">{{lang.common_cloud_title25}}</span>
                    </template>
                  </el-table-column>
                </el-table>
              </div>
            </div>
            <div class="main-content" v-if="cloudData.nat_web_limit > 0">
              <div class="content-top">
                <div class="top-title">NAT{{lang.nat_web}} （{{webList.length}}/{{cloudData.nat_web_limit}}）</div>
                <div class="top-btn nat-btn" @click="showCreateNat('web')"
                  v-if="webList.length < cloudData.nat_web_limit">{{lang.invoice_text47}}{{lang.nat_web}}
                </div>
              </div>
              <div class="main-table">
                <el-table v-loading="webLoading" :data="webList" style="width: 100%;">
                  <el-table-column prop="id" label="ID" width="100">
                  </el-table-column>
                  <el-table-column prop="domain" :label="lang.domain" :show-overflow-tooltip="true">
                  </el-table-column>
                  <el-table-column prop="ext_port" :label="lang.ext_port" width="150" :show-overflow-tooltip="true">
                  </el-table-column>
                  <el-table-column prop="int_port" :label="lang.int_port" width="150" :show-overflow-tooltip="true">
                  </el-table-column>
                  <el-table-column width="100" :label="lang.common_cloud_label30" align="left">
                    <template slot-scope="{row}">
                      <span class="text-btn" @click="handDelweb(row)">{{lang.common_cloud_title25}}</span>
                    </template>
                  </el-table-column>
                </el-table>
              </div>
            </div>
          </el-tab-pane>

          <el-tab-pane :label="cloudData.type === 'hyperv' ? lang.common_cloud_title5 : lang.common_cloud_tab5"
            name="5">
            <!-- 备份 -->
            <!-- 启用备份 -->
            <div class="main-content" v-if="cloudData.backup_num > 0">
              <div class="content-top">
                <div class="top-title">{{lang.common_cloud_title5}} （{{dataList1.length}}/{{cloudData.backup_num}}）
                </div>
                <div class="top-btn" @click="showCreateBs('back')">{{lang.common_cloud_btn23}}</div>
              </div>
              <div class="main-table">
                <el-table v-loading="backLoading" :data="dataList1" style="width: 100%;">
                  <el-table-column prop="name" :label="lang.common_cloud_label27" width="300" align="left">
                  </el-table-column>
                  <el-table-column prop="create_time" width="300" :label="lang.common_cloud_label28" align="left">
                    <template slot-scope="scope">
                      {{scope.row.create_time | formateTime}}
                    </template>
                  </el-table-column>
                  <el-table-column prop="notes" :label="lang.common_cloud_label29" min-width="400" align="left"
                    :show-overflow-tooltip="true">
                  </el-table-column>
                  <el-table-column prop="type" :label="lang.common_cloud_label30" width="150" align="left">
                    <template slot-scope="scope">
                      <el-popover placement="top-start" trigger="hover" v-if="scope.row.status === 1">
                        <div class="operation">
                          <div class="operation-item" @click="showhyBs('back',scope.row)">{{lang.common_cloud_btn24}}
                          </div>
                          <div class="operation-item" @click="showDelBs('back',scope.row)">{{lang.common_cloud_btn25}}
                          </div>
                        </div>
                        <span class="more-operation" slot="reference">
                          <div class="dot"></div>
                          <div class="dot"></div>
                          <div class="dot"></div>
                        </span>
                      </el-popover>
                      <div v-else><i class="el-icon-loading"></i>{{lang.common_cloud_title31}}</div>
                    </template>
                  </el-table-column>
                </el-table>
              </div>
            </div>
            <!-- 没有启用备份 -->
            <div class="no-bs no-back" v-else>
              <span class="no-bs-title">{{lang.common_cloud_title5}}</span>
              <div class="no-bs-content">
                <span class="text">{{lang.common_cloud_text20}}</span>
                <div class="btn" v-if="configObj.backup_enable == 1" @click="openBs('back')">{{lang.common_cloud_btn26}}
                </div>
              </div>
            </div>
            <!-- 快照 -->
            <template v-if="cloudData.type !== 'hyperv'">
              <div class="main-content" v-if="cloudData.snap_num > 0">
                <div class="content-top">
                  <div class="top-title">{{lang.common_cloud_title6}} （{{dataList2.length}}/{{cloudData.snap_num}}）
                  </div>
                  <div class="top-btn" @click="showCreateBs('snap')">{{lang.common_cloud_btn27}}</div>
                </div>
                <div class="main-table">
                  <el-table v-loading="snapLoading" :data="dataList2" style="width: 100%;">
                    <el-table-column prop="name" :label="lang.common_cloud_label31" width="300" align="left">
                    </el-table-column>
                    <el-table-column prop="create_time" width="300" :label="lang.common_cloud_label28" align="left">
                      <template slot-scope="scope">
                        {{scope.row.create_time | formateTime}}
                      </template>
                    </el-table-column>
                    <el-table-column prop="notes" :label="lang.common_cloud_label29" min-width="400" align="left"
                      :show-overflow-tooltip="true">
                    </el-table-column>
                    <el-table-column prop="type" :label="lang.common_cloud_label30" width="150" align="left">
                      <template slot-scope="scope">
                        <el-popover placement="top-start" trigger="hover" v-if="scope.row.status === 1">
                          <div class="operation">
                            <div class="operation-item" @click="showhyBs('snap',scope.row)">{{lang.common_cloud_btn24}}
                            </div>
                            <div class="operation-item" @click="showDelBs('snap',scope.row)">{{lang.common_cloud_btn25}}
                            </div>
                          </div>
                          <span class="more-operation" slot="reference">
                            <div class="dot"></div>
                            <div class="dot"></div>
                            <div class="dot"></div>
                          </span>
                        </el-popover>
                        <div v-else><i class="el-icon-loading"></i>{{lang.common_cloud_title31}}</div>
                      </template>
                    </el-table-column>
                  </el-table>
                </div>
              </div>
              <div class="no-bs no-snap" v-else>
                <span class="no-bs-title">{{lang.common_cloud_title6}}</span>
                <div class="no-bs-content">
                  <span class="text">{{lang.common_cloud_text21}}</span>
                  <div class="btn" v-if="configObj.snap_enable == 1" @click="openBs('snap')">{{lang.common_cloud_btn26}}
                  </div>
                </div>
              </div>
            </template>

          </el-tab-pane>
          <el-tab-pane :label="lang.common_cloud_tab6" name="6">
            <div class="log">
              <div class="main_table">
                <el-table v-loading="logLoading" :data="logDataList" style="width: 100%;margin-bottom: 20px;">
                  <el-table-column prop="id" :label="lang.common_cloud_label32" width="400" align="left">
                  </el-table-column>
                  <el-table-column prop="create_time" width="400" :label="lang.common_cloud_label33" align="left">
                    <template slot-scope="scope">
                      <span>{{scope.row.create_time | formateTime}}</span>
                    </template>
                  </el-table-column>
                  <el-table-column prop="description" :label="lang.common_cloud_label34" min-width="400" align="left"
                    :show-overflow-tooltip="true">
                  </el-table-column>
                </el-table>
                <pagination :page-data="logParams" @sizechange="logSizeChange" @currentchange="logCurrentChange">
                </pagination>
              </div>
            </div>
          </el-tab-pane>
        </el-tabs>


        <!-- 修改备注弹窗 -->
        <div class="notes-dialog">
          <el-dialog width="620px" :visible.sync="isShowNotesDialog" :show-close=false @close="notesDgClose">
            <div class="dialog-title">
              {{hostData.notes?lang.common_cloud_title7:lang.common_cloud_title8}}
            </div>
            <div class="dialog-main">
              <div class="label">{{lang.common_cloud_label29}}</div>
              <el-input class="notes-input" v-model="notesValue"></el-input>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="subNotes">{{lang.common_cloud_btn28}}</div>
              <div class="btn-no" @click="notesDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 重装系统弹窗 -->
        <div class="reinstall-dialog">
          <el-dialog width="620px" :visible.sync="isShowReinstallDialog" :show-close=false @close="reinstallDgClose">
            <div class="dialog-title">
              {{lang.common_cloud_title9}}
            </div>
            <div class="dialog-main">
              <div class="label">{{lang.common_cloud_label6}}</div>
              <div class="os-content">
                <!-- 镜像组选择框 -->
                <el-select class="os-select os-group-select" v-model="reinstallData.osGroupId"
                  @change="osSelectGroupChange">
                  <img class="os-group-img" :src="osIcon" slot="prefix" alt="">
                  <el-option v-for="item in calcImageList" :key='item.id' :value="item.id" :label="item.name">
                    <div class="option-label">
                      <img class="option-img" :src="'/themes/clientarea/default/v10/img/' + item.name + '.svg'" alt="">
                      <span class="option-text">{{item.name}}</span>
                    </div>
                  </el-option>
                </el-select>
                <!-- 镜像实际选择框 -->
                <el-select class="os-select" v-model="reinstallData.osId" @change="osSelectChange">
                  <el-option v-for="item in osSelectData" :key="item.id" :value="item.id"
                    :label="item.name +'-' + commonData.currency_prefix + item.price"></el-option>
                </el-select>
              </div>
              <div class="label">{{lang.common_cloud_label7}}</div>
              <div class="pass-content">
                <el-select class="pass-select" v-model="reinstallData.type">
                  <el-option value="pass" :label="lang.common_cloud_label7"></el-option>
                  <el-option value="key" v-if="configObj.support_ssh_key === 1" label="ssh"></el-option>
                </el-select>
                <el-popover placement="top-start" width="200" trigger="hover" :content="lang.common_cloud_tip33">
                  <i class="el-icon-question help-icon" slot="reference"></i>
                </el-popover>
                <el-input class="pass-input" v-model="reinstallData.password" :placeholder="lang.ticket_label12"
                  v-show="reinstallData.type=='pass'">
                  <div class="pass-btn" slot="suffix" @click="autoPass">{{lang.common_cloud_btn1}}</div>
                </el-input>
                <div class="key-select" v-show="reinstallData.type=='key'">
                  <el-select v-model="reinstallData.ssh_key_id">
                    <el-option v-for="item in sshKeyData" :key="item.id" :value="item.id"
                      :label="item.name"></el-option>
                  </el-select>
                </div>
              </div>
              <div class="label">{{lang.common_cloud_label13}}</div>
              <el-input class="pass-input" v-model="reinstallData.port" :placeholder="lang.ticket_label12"
              :disabled="configObj.rand_ssh_port === 2">
              <div class="pass-btn" slot="suffix" @click="autoPort" :class="{hide: configObj.rand_ssh_port === 2}">
                {{lang.common_cloud_btn1}}
              </div>
            </el-input>

              <template v-if="cloudConfig.reinstall_sms_verify === 1">
                <div class="label">{{lang.ticket_label19}}</div>
                <el-input class="pass-input" v-model="reinstallData.code" :placeholder="lang.account_tips33">
                  <div class="pass-btn" slot="suffix" v-if="isSendCodeing">{{sendTime}}{{lang.account_tips54}}</div>
                  <div class="pass-btn" slot="suffix" v-loading="sendFlag" @click="sendCode" v-else>
                    {{lang.account_tips55}}</div>
                </el-input>
              </template>

              <div class="pay-img" v-show="isPayImg">
                {{lang.common_cloud_tip28}},{{commonData.currency_prefix + payMoney + lang.common_cloud_text26}}
                <el-popover placement="top-start" width="200" trigger="hover">
                  <div class="show-config-list">{{lang.shoppingCar_tip_text2}}：{$Detail.currency.prefix}{{
                    payDiscount }}</div>
                  <div class="show-config-list">{{lang.common_cloud_text28}}：{$Detail.currency.prefix}{{ payCodePrice
                    }}</div>
                  <i class="el-icon-warning-outline total-icon" slot="reference" v-if="isShowLevel || isShowPromo"></i>
                </el-popover>

                <span class="img-buy-btn" @click="payImg">{{lang.common_cloud_btn5}}</span>
              </div>

              <div class="alert">
                <el-alert :title="errText" type="error" show-icon :closable="false" v-show="errText">
                </el-alert>
                <div class="remind" v-show="!errText">{{lang.common_cloud_tip29}}</div>
              </div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="doReinstall">{{lang.common_cloud_btn28}}</div>
              <div class="btn-no" @click="reinstallDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>
        <!-- 加入安全组 -->
        <el-dialog width="680px" :visible.sync="safeDialogShow" :show-close=false @close="safeClose"
          class="safe-dialog">
          <div class="dialog-title">{{lang.add_to_group}}</div>
          <div class="dialog-main">
            <div class="safe-main-card">
              <div class="safe-box">
                <span>{{lang.choose_group}}：</span>
                <el-select v-model="safeID">
                  <el-option v-for="item in safeOptions" :key="item.id" :label="item.name" :value="item.id">
                  </el-option>
                </el-select>
              </div>
            </div>
          </div>
          <div class="dialog-footer">
            <div class="btn-ok" @click="subAddSafe">{{lang.finance_text70}}</div>
            <div class="btn-no" @click="safeClose">{{lang.finance_text71}}</div>
          </div>
        </el-dialog>
        <!-- 续费弹窗 -->
        <div class="renew-dialog">
          <el-dialog width="690px" :visible.sync="isShowRenew" :show-close=false @close="renewDgClose">
            <div class="dialog-title">
              {{lang.common_cloud_title10}}
            </div>
            <div class="dialog-main">
              <div class="renew-content">
                <div class="renew-item" :class="renewActiveId==item.id?'renew-active':''" v-for="item in renewPageData"
                  :key="item.id" @click="renewItemChange(item)">
                  <div class="item-top">{{item.billing_cycle}}</div>
                  <div class="item-bottom" v-if="isShowPromo && renewParams.isUseDiscountCode">
                    {$Detail.currency.prefix}{{item.base_price.toFixed(2)}}</div>
                  <div class="item-bottom" v-else>{$Detail.currency.prefix}{{item.price.toFixed(2)}}</div>
                  <div class="item-origin-price" v-if="item.price < item.base_price && !renewParams.isUseDiscountCode">
                    {$Detail.currency.prefix}{{item.base_price.toFixed(2)}}</div>
                  <i class="el-icon-check check" v-show="renewActiveId==item.id"></i>
                </div>
              </div>
              <div class="pay-content">
                <div class="pay-price">
                  <div class="money" v-loading="renewLoading">
                    <span class="text">{{lang.common_cloud_label11}}:</span>
                    <span>{$Detail.currency.prefix}{{renewParams.totalPrice | filterMoney}}</span>
                    <el-popover placement="top-start" width="200" trigger="hover"
                      v-if="(isShowLevel && renewParams.clDiscount*1 > 0) || (isShowPromo && renewParams.isUseDiscountCode) || ( isShowCash && renewParams.customfield.voucher_get_id)">
                      <div class="show-config-list">
                        <p v-if="isShowLevel && renewParams.clDiscount*1 > 0">
                          {{lang.shoppingCar_tip_text2}}：{$Detail.currency.prefix} {{ renewParams.clDiscount |
                          filterMoney}}</p>
                        <p v-if="isShowPromo && renewParams.isUseDiscountCode">
                          {{lang.shoppingCar_tip_text4}}：{$Detail.currency.prefix} {{ renewParams.code_discount |
                          filterMoney }}</p>
                        <p v-if="isShowCash && renewParams.customfield.voucher_get_id">
                          {{lang.common_cloud_text29}}：{$Detail.currency.prefix} {{ renewParams.cash_discount |
                          filterMoney}}</p>
                      </div>
                      <i class="el-icon-warning-outline total-icon" slot="reference"></i>
                    </el-popover>
                    <p class="original-price"
                      v-if="renewParams.customfield.promo_code && renewParams.totalPrice != renewParams.base_price">
                      {$Detail.currency.prefix} {{ renewParams.base_price | filterMoney}}</p>
                    <p class="original-price"
                      v-if="!renewParams.customfield.promo_code && renewParams.totalPrice != renewParams.original_price">
                      {$Detail.currency.prefix} {{ renewParams.original_price | filterMoney}}</p>

                    <!-- 暂时隐藏 -->
                    <!-- <div class="code-box">
                    // 代金券
                    <cash-coupon ref="cashRef" v-show="isShowCash && !cashObj.code"
                      :currency_prefix="commonData.currency_prefix" @use-cash="reUseCash" scene='renew'
                      :product_id="[product_id]" :price="renewParams.original_price"></cash-coupon>
                    // 优惠码
                    <discount-code v-show="isShowPromo && !renewParams.customfield.promo_code"
                      @get-discount="getRenewDiscount(arguments)" scene='renew' :product_id="product_id"
                      :amount="renewParams.base_price" :billing_cycle_time="renewParams.duration"></discount-code>
                  </div> -->
                    <div class="code-number-text">
                      <div class="discount-codeNumber" v-show="renewParams.customfield.promo_code">{{
                        renewParams.customfield.promo_code }}<i class="el-icon-circle-close remove-discountCode"
                          @click="removeRenewDiscountCode()"></i></div>
                      <div class="cash-codeNumber" v-show="cashObj.code">{{ cashObj.code }}<i
                          class="el-icon-circle-close remove-discountCode" @click="reRemoveCashCode()"></i></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="subRenew">{{lang.common_cloud_btn30}}</div>
              <div class="btn-no" @click="renewDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>
        <!-- 新增VPC网络 -->
        <el-dialog width="680px" :visible.sync="isShowAddVpc" :show-close=false @close="addVpcClose"
          class="addVpc-dialog">
          <div class="dialog-title">{{lang.common_cloud_title20}}</div>
          <div class="dialog-main">
            <div class="vpc-main-card">
              <div class="vpc-item">
                <span class="vpc-leabel">{{lang.common_cloud_title32}}：</span>
                <span class="vpc-value">{{vpcName}}</span>
              </div>
              <div class="vpc-item">
                <span class="vpc-leabel">{{lang.common_cloud_title33}}：</span>
                <el-select v-model="plan_way" class="w-select">
                  <el-option :value="0" :label="lang.auto_plan"></el-option>
                  <el-option :value="1" :label="lang.custom"></el-option>
                </el-select>
              </div>
              <div class="vpc-item" v-if="plan_way === 1">
                <span class="vpc-leabel">{{lang.common_cloud_title34}}：</span>
                <div class="vpc">
                  <!-- 自定义vpc -->
                  <div class="custom">
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
                    <el-select v-model="vpc_ips.vpc6.value" style="width: .7rem" @change="changeVpcMask">
                      <el-option v-for="item in vpc_ips.vpc6.select" :key="item" :label="item" :value="item">
                      </el-option>
                    </el-select>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="dialog-footer">
            <div class="btn-ok" @click="subAddVpc">{{lang.subaccount_text31}}</div>
            <div class="btn-no" @click="addVpcClose">{{lang.subaccount_text32}}</div>
          </div>
        </el-dialog>
        <!-- 分配主机 -->
        <el-dialog width="680px" :visible.sync="isShowengine" :show-close=false @close="engineClose"
          class="engine-dialog">
          <div class="dialog-title">{{lang.common_cloud_title35}}</div>
          <div v-loading="isSubmitEngine">
            <div class="dialog-main">
              <div class="label">{{lang.common_cloud_title36}}</div>
              <div class="engine-main-card">
                <div class="engine-box">
                  <span>{{lang.common_cloud_title37}}：</span>
                  <el-select v-model="engineID" clearable filterable remote reserve-keyword
                    :placeholder="lang.common_cloud_title38" :remote-method="remoteMethod"
                    :loading="engineSearchLoading">
                    <el-option v-for="item in productOptions" :key="item.id" :label="item.name" :value="item.id">
                    </el-option>
                  </el-select>
                </div>
              </div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="subAddEngine">{{lang.subaccount_text31}}</div>
              <div class="btn-no" @click="engineClose">{{lang.subaccount_text32}}</div>
            </div>
          </div>
        </el-dialog>
        <!-- 新增附加IP -->
        <el-dialog width="680px" :visible.sync="isShowIp" :show-close="false" @close="ipClose" class="ip-dialog">
          <div class="dialog-title">{{lang.common_cloud_title39}}</div>
          <div class="dialog-main">
            <!-- ipv4 -->
            <div class="label" v-if="ipValueData.length > 0">
              {{lang.common_cloud_title40}} {{ipDetails.ip_num - cloudData.ipv6_num}}
              {{lang.common_cloud_title43 + ',' +
              lang.common_cloud_title41}}：{{cloudData.ip_num}}{{lang.common_cloud_title43
              + ',' +lang.common_cloud_title42}}
            </div>
            <div class="ip-main-card">
              <div class="ip-item" :class="ipValue === item.value ? 'active' : ''" v-for="item in ipValueData"
                :key="item.value" @click="selectIpValue(item.value)">
                {{item.value}} {{lang.common_cloud_title43}}
              </div>
            </div>
            <!-- ipv6 -->
            <template v-if="ipv6ValueData.length > 0 && cloudData.network_type !== 'vpc'">
              <div class="label">
                {{lang.cur_ipv6}} {{cloudData.ipv6_num}}
                {{lang.common_cloud_title43 + ',' +
                lang.common_cloud_title41}}：{{cloudData.ipv6_num}}{{lang.common_cloud_title43
                + ',' +lang.cur_ipv6_tip}}
              </div>
              <div class="ip-main-card">
                <div class="ip-item" :class="ipv6Value === item.value ? 'active' : ''" v-for="item in ipv6ValueData"
                  :key="item.value" @click="selectIpv6Value(item.value)">
                  {{item.value}} {{lang.common_cloud_title43}}
                </div>
              </div>
            </template>
          </div>
          <div class="dialog-footer">
            <span class="text">{{lang.common_cloud_title44}}:</span>
            <span class="num" v-loading="ipPriceLoading">
              {{commonData.currency_prefix}}{{ipMoney >=0 ? ipMoney : 0}}
              <el-popover placement="top-start" width="200" trigger="hover">
                <div class="show-config-list">
                  {{lang.common_cloud_text27}}：{{commonData.currency_prefix}}{{
                  ipDiscountkDisPrice }}
                </div>
                <div class="show-config-list">
                  {{lang.common_cloud_text28}}：{{commonData.currency_prefix}}{{
                  ipCodePrice }}
                </div>
                <i class="el-icon-warning-outline total-icon" slot="reference" v-if="isShowLevel || isShowPromo"></i>
              </el-popover>
            </span>
            <el-button class="btn-ok" @click="subAddIp" :loading="submitLoaing">{{lang.finance_text74}}</el-button>
            <div class="btn-no" @click="ipClose">{{lang.finance_text75}}</div>
          </div>
        </el-dialog>
        <!-- 停用弹窗（删除实例） -->
        <div class="refund-dialog">
          <el-dialog width="680px" :visible.sync="isShowRefund" :show-close=false @close="refundDgClose">
            <div class="dialog-title">
              {{refundPageData.allow_refund == 1?lang.common_cloud_title11:lang.common_cloud_title12}}
            </div>
            <div class="dialog-main">
              <div class="label">{{lang.common_cloud_label35}}</div>
              <div class="host-content">
                <div class="host-item">
                  <div class="left">{{lang.common_cloud_label36}}:</div>
                  <div class="right">
                    <div class="right-row">
                      <div class="right-row-item">{{cloudData.cpu}} {{lang.common_cloud_text285}}CPU</div>
                      <div class="right-row-item">{{(cloudData.memory) + 'GB' + lang.common_cloud_text286}}</div>
                      <div class="right-row-item">{{cloudData.system_disk.size}} GB {{lang.common_cloud_text287}}</div>
                      <div class="right-row-item">{{cloudData.bw}} M {{lang.common_cloud_text288}}</div>
                    </div>
                  </div>
                </div>
                <div class="host-item">
                  <div class="left">{{lang.common_cloud_label37}}:</div>
                  <div class="right">{{hostData.active_time | formateTime}}</div>
                </div>
                <div class="host-item" v-if="refundPageData.allow_refund == 1">
                  <div class="left">{{lang.common_cloud_label38}}:</div>
                  <div class="right">{{commonData.currency_prefix + refundPageData.host.first_payment_amount}}</div>
                </div>
              </div>
              <div class="label">{{lang.common_cloud_label39}}</div>
              <el-select v-if="refundPageData.reason_custom == 0" v-model="refundParams.suspend_reason" multiple>
                <el-option v-for="item in refundPageData.reasons" :key="item.id" :value="item.id"
                  :label="item.content"></el-option>
              </el-select>
              <el-input v-else v-model="refundParams.suspend_reason"></el-input>
              <div class="label">{{lang.common_cloud_label40}}</div>
              <el-select v-model="refundParams.type">
                <el-option value="Endofbilling" :label="lang.common_cloud_label41"></el-option>
                <el-option value="Immediate" :label="lang.common_cloud_label42"></el-option>
              </el-select>
              <div class="label" v-if="refundPageData.allow_refund == 1">{{lang.common_cloud_label43}}</div>
              <div class="amount-content" v-if="refundPageData.allow_refund == 1">
                {$Detail.currency.prefix}{{refundParams.type=='Immediate'?refundPageData.host.amount:'0.00'}}</div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="subRefund">{{refundPageData.allow_refund == 1? lang.common_cloud_btn31:
                lang.common_cloud_btn32}}</div>
              <div class="btn-no" @click="refundDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 重置密码弹窗 -->
        <div class="repass-dialog">
          <el-dialog width="680px" :visible.sync="isShowRePass" :show-close=false @close="rePassDgClose">
            <div class="dialog-title">
              {{lang.common_cloud_title13}}
              <span class="second-title">{{lang.common_cloud_text23}}</span>
            </div>
            <div class="dialog-main">
              <div class="label">
                {{lang.common_cloud_label7}}
                <el-popover placement="top-start" width="200" trigger="hover" :content="lang.common_cloud_tip33">
                  <i class="el-icon-question" slot="reference"></i>
                </el-popover>

              </div>
              <el-input class="pass-input" v-model="rePassData.password" :placeholder="lang.ticket_label12">
                <div class="pass-btn" slot="suffix" @click="autoPass">{{lang.common_cloud_btn1}}</div>
              </el-input>

              <el-input style="margin-top: 20px;" class="pass-input" v-model="rePassData.code"
                :placeholder="lang.account_tips33" v-if="cloudConfig.reset_password_sms_verify === 1">
                <div class="pass-btn" slot="suffix" v-if="isSendCodeing">{{sendTime}}{{lang.account_tips54}}</div>
                <div class="pass-btn" slot="suffix" v-loading="sendFlag" @click="sendCode" v-else>
                  {{lang.account_tips55}}
                </div>
              </el-input>

              <div class="alert" v-show="powerStatus=='off'">
                <div class="title">{{lang.common_cloud_tip30}}</div>
                <div class="row"><span class="dot"></span> {{lang.common_cloud_tip31}}</div>
                <div class="row"><span class="dot"></span> {{lang.common_cloud_tip32}}
                </div>
              </div>
              <el-checkbox v-model="rePassData.checked"
                v-show="powerStatus=='off'">{{lang.common_cloud_text24}}</el-checkbox>
              <div class="alert-err-text">
                <el-alert :title="errText" type="error" show-icon :closable="false" v-show="errText">
                </el-alert>
              </div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="rePassSub" v-loading="loading5">{{lang.common_cloud_btn28}}</div>
              <div class="btn-no" @click="rePassDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 救援系统弹窗 -->
        <div class="rescue-dialog">
          <el-dialog width="680px" :visible.sync="isShowRescue" :show-close=false @close="rescueDgClose">
            <div class="dialog-title">
              {{lang.common_cloud_tab7}}
              <span class="second-title">{{lang.common_cloud_tip34}}</span>
            </div>
            <div class="dialog-main">
              <div class="label">{{lang.common_cloud_tab8}}</div>
              <el-select class="os-select" v-model="rescueData.type">
                <img class="os-img"
                  :src="'/themes/clientarea/default/v10/img/' + (rescueData.type==1?'Windows':'Linux') + '.svg'"
                  slot="prefix" alt="">
                <el-option value="1" label="Windows">
                  <div class="os-item">
                    <img class="item-os-img" src="/themes/clientarea/default/v10/img/Windows.svg" alt="">
                    <span class="item-os-text">Windows</span>
                  </div>
                </el-option>
                <el-option value="2" label="Linux">
                  <div class="os-item">
                    <img class="item-os-img" src="/themes/clientarea/default/v10/img/Linux.svg" alt="">
                    <span class="item-os-text">Linux</span>
                  </div>
                </el-option>
              </el-select>
              <div class="label">{{lang.common_cloud_tab9}}</div>
              <el-input class="pass-input" v-model="rescueData.password" :placeholder="lang.ticket_label12">
                <div class="pass-btn" slot="suffix" @click="autoPass">{{lang.common_cloud_btn1}}</div>
              </el-input>
              <div class="alert">
                <el-alert :title="errText" type="error" show-icon :closable="false" v-show="errText">
                </el-alert>
                <div class="remind" v-show="!errText">{{lang.common_cloud_tip29}}</div>
              </div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="rescueSub" v-loading="loading3">{{lang.withdraw_btn1}}</div>
              <div class="btn-no" @click="rescueDgClose">{{lang.withdraw_btn2}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 确认退出救援模式弹窗 -->
        <div class="quitRescu">
          <el-dialog width="680px" :visible.sync="isShowQuit" :show-close=false @close="quitDgClose">
            <div class="dialog-title">
              {{lang.common_cloud_btn14}}
            </div>
            <div class="dialog-main">
              {{lang.common_cloud_btn33}}
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="reQuitSub">{{lang.common_cloud_btn34}}</div>
              <div class="btn-no" @click="quitDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 升降级弹窗 -->
        <div class="upgrade-dialog">
          <el-dialog width="950px" :visible.sync="isShowUpgrade" :show-close=false @close="upgradeDgClose">
            <div class="dialog-title">
              {{lang.common_cloud_btn16}}
            </div>
            <div class="dialog-main">
              <!-- 自定义 -->
              <el-form ref="orderForm" label-position="left" label-width="100px" hide-required-asterisk
                v-if="!isPackage">
                <!-- cpu -->
                <el-form-item label="CPU">
                  <el-radio-group v-model="params.cpu" @input="changeCpu">
                    <el-radio-button :label="c.value" v-for="(c,cInd) in calcCpuList" :key="cInd">
                      {{c.value}}{{lang.mf_cores}}
                    </el-radio-button>
                  </el-radio-group>
                </el-form-item>
                <!-- 内存 -->
                <el-form-item :label="lang.cloud_memery" v-if="memoryList.length > 0" class="move">
                  <!-- 单选 -->
                  <el-radio-group v-model="params.memory" v-if="memoryType" @input="changeMemory">
                    <el-radio-button :label="c.value" v-for="(c,cInd) in calaMemoryList" :key="cInd"
                      :class="{'com-dis': c.disabled}">
                      {{c.value}}{{memory_unit}}
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
                  <span class="unit" v-if="!memoryType">{{memory_unit}}</span>
                </el-form-item>
                <!-- 带宽 -->
                <el-form-item :label="lang.mf_bw" v-if="lineDetail.bill_type === 'bw' && lineDetail.bw.length > 0">
                  <!-- 单选 -->
                  <el-radio-group v-model="bwName" v-if="lineDetail.bw[0].type === 'radio'" @input="changeBw">
                    <el-radio-button :label="c.value + 'M'" v-for="(c,cInd) in lineDetail.bw" :key="cInd">
                    </el-radio-button>
                  </el-radio-group>
                  <!-- 拖动框 -->
                  <el-tooltip effect="light" v-else :content="lang.mf_range + bwTip" placement="top">
                    <el-slider v-model="params.bw" show-input :step="1" :min="lineDetail.bw[0].min_value"
                      :max="lineDetail.bw[lineDetail.bw.length - 1].max_value" @change="changeBwNum">
                    </el-slider>
                  </el-tooltip>
                </el-form-item>
                <el-form-item label=" " v-if="lineDetail.bw && lineDetail.bw[0].type !== 'radio'">
                  <div class="marks">
                    <span class="item" v-for="(item,index) in Object.keys(bwMarks)">{{bwMarks[item]}}MB</span>
                  </div>
                </el-form-item>
                <!-- 流量 -->
                <el-form-item :label="lang.mf_flow"
                  v-if="lineDetail.bill_type === 'flow' && lineDetail.flow.length > 0">
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
                <!-- 防御 -->
                <el-form-item :label="lang.mf_defense" v-if="lineDetail.defence && lineDetail.defence.length >0">
                  <el-radio-group v-model="defenseName" @input="changeDefence">
                    <el-radio-button :label="c.value == 0 ? lang.no_defense : (c.value + 'G')"
                      v-for="(c,cInd) in lineDetail.defence" :key="cInd">
                    </el-radio-button>
                  </el-radio-group>
                </el-form-item>
              </el-form>
              <!-- 套餐升降级 -->
              <div class="package-box" v-else>
                <div class="cur-package">
                  <p class="tit">{{lang.cur_config}}</p>
                  <div class="cloud-item active">
                    <div class="top">
                      {{recommend_config.name}}<span class="des">（{{recommend_config.description}}）</span>
                    </div>
                    <div class="info">
                      <p><span
                          class="name">{{lang.mf_specs}}：</span>{{recommend_config.cpu}}{{lang.mf_cores}}{{recommend_config.memory}}G
                      </p>
                      <p>
                        <span class="name">{{lang.mf_system}}：</span>{{recommend_config.system_disk_size}}GB<span
                          v-if="recommend_config.system_disk_type">，{{recommend_config.system_disk_type}}</span>
                      </p>
                      <p v-if="recommend_config.data_disk_size * 1">
                        <span class="name">{{lang.common_cloud_text1}}：</span>{{recommend_config.data_disk_size}}GB<span
                          v-if="recommend_config.data_disk_type">，{{recommend_config.data_disk_type}}</span>
                      </p>
                      <p v-if="recommend_config.bw"><span class="name">{{lang.mf_bw}}：</span>{{recommend_config.bw}}M
                      </p>
                      <template v-else>
                        <p v-if="recommend_config.flow"><span
                            class="name">{{lang.mf_flow}}：</span>{{recommend_config.flow}}GB</p>
                        <p v-if="recommend_config.flow===0"><span class="name">{{lang.mf_flow}}：</span>{{lang.mf_tip28}}
                        </p>
                      </template>
                      <p v-if="configData.free_disk_switch">
                        <span class="name">{{lang.mf_tip37}}：</span>
                        {{configData.free_disk_size}}GB
                      </p>
                      <p v-if="recommend_config.peak_defence">
                        <span class="name">{{lang.peak_defence}}：</span>{{ recommend_config.peak_defence + 'G'}}
                      </p>
                      <p>
                        <span class="name">IPv4{{lang.shoppingCar_goodsNums}}：</span>{{recommend_config.ip_num === 0 ?
                        lang.mf_none : recommend_config.ip_num + lang.common_cloud_title43}}
                      </p>
                      <p>
                        <span class="name">IPv6{{lang.shoppingCar_goodsNums}}：</span>{{recommend_config.ipv6_num === 0 ?
                        lang.mf_none : recommend_config.ipv6_num + lang.common_cloud_title43}}
                      </p>
                      <p v-if="recommend_config.gpu_num"><span class="name">GPU{{lang.shoppingCar_goodsNums}}：</span>
                        <span :title="`${recommend_config.gpu_num}*${recommend_config.gpu_name}`">{{cloudData.gpu ||
                          '--'}}</span>
                      </p>
                    </div>
                  </div>
                </div>
                <div class="package-list">
                  <p class="tit">{{lang.can_upgrade}}</p>
                  <div class="cloud-item" :class="{active: recommend_config_id=== item.id}"
                    v-for="(item,index) in recommendList" :key="index" @click="changeRecommend(item)">
                    <div class="top">
                      {{item.name}}<span class="des">（{{item.description}}）</span>
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
                      <p v-if="configData.free_disk_switch">
                        <span class="name">{{lang.mf_tip37}}：</span>
                        {{configData.free_disk_size}}GB
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
                </div>
              </div>
            </div>

            <div class="dialog-footer">
              <div class="footer-top">
                <div class="money-text">{{lang.common_cloud_btn37}}：</div>
                <div class="money" v-loading="upgradePriceLoading">
                  <span class="money-num">{$Detail.currency.prefix} {{ upParams.totalPrice | filterMoney}}</span>
                  <el-popover placement="top-start" width="200" trigger="hover"
                    v-if="isShowLevel || (isShowPromo && upParams.isUseDiscountCode) || isShowCash">
                    <div class="show-config-list">
                      <p v-if="isShowLevel">{{lang.shoppingCar_tip_text2}}：{$Detail.currency.prefix} {{
                        upParams.clDiscount | filterMoney }}</p>
                      <p v-if="isShowPromo && upParams.isUseDiscountCode">
                        {{lang.shoppingCar_tip_text4}}：{$Detail.currency.prefix} {{ upParams.code_discount |
                        filterMoney}}</p>
                      <p v-if="isShowCash && upParams.customfield.voucher_get_id">
                        {{lang.shoppingCar_tip_text5}}：{$Detail.currency.prefix}
                        {{ upParams.cash_discount | filterMoney}}</p>
                    </div>
                    <i class="el-icon-warning-outline total-icon" slot="reference"></i>
                  </el-popover>
                  <p class="original-price" v-if="upParams.totalPrice != upParams.original_price">
                    {$Detail.currency.prefix} {{ upParams.original_price | filterMoney}}</p>
                  <!-- <div class="code-box">
                  // 代金券
                  <cash-coupon ref="cashRef" v-show="isShowCash && !cashObj.code"
                    :currency_prefix="commonData.currency_prefix" @use-cash="upUseCash" scene='upgrade'
                    :product_id="[product_id]" :price="upParams.original_price"></cash-coupon>
                  //优惠码
                  <discount-code v-show="isShowPromo && !upParams.customfield.promo_code  "
                    @get-discount="getUpDiscount(arguments)" scene='upgrade' :product_id="product_id"
                    :amount="upParams.original_price" :billing_cycle_time="hostData.billing_cycle_time"></discount-code>
                </div> -->
                  <div class="code-number-text">
                    <div class="discount-codeNumber" v-show="upParams.customfield.promo_code">{{
                      upParams.customfield.promo_code }}<i class="el-icon-circle-close remove-discountCode"
                        @click="removeUpDiscountCode()"></i></div>
                    <div class="cash-codeNumber" v-show="cashObj.code">{{ cashObj.code }}<i
                        class="el-icon-circle-close remove-discountCode" @click="upRemoveCashCode()"></i></div>
                  </div>
                </div>
              </div>
              <div class="footer-bottom">
                <div class="btn-ok" @click="upgradeSub" v-loading="loading4">{{lang.security_btn5}}</div>
                <div class="btn-no" @click="upgradeDgClose">{{lang.security_btn6}}</div>
              </div>
            </div>
          </el-dialog>
        </div>

        <!-- 订购磁盘弹窗 -->
        <div class="dg-dialog">
          <el-dialog width="912px" :visible.sync="isShowDg" :show-close=false @close="dgClose">
            <div class="dialog-title">
              {{lang.common_cloud_btn22}}
            </div>
            <!-- 当前配置磁盘 -->
            <div class="disk-card disk-old" v-if="oldDiskList2.length > 0">
              <div class="disk-label">{{lang.common_cloud_btn38}}</div>
              <div class="disk-main-card">
                <div class="old-disk-item" v-for="item in oldDiskList2" :key="item.id">
                  <span class="disk-item-text">{{item.name}}</span>
                  <span class="disk-item-size">{{item.size + 'G'}}</span>
                  <i class="el-icon-remove-outline del" v-if="item.type2 !== 'system'"
                    @click="delOldSize2(item.id)"></i>
                </div>
              </div>
            </div>
            <!-- 新增磁盘 -->
            <div class=" disk-card disk-new">
              <div class="disk-label">{{lang.common_cloud_btn39}}</div>
              <div class="disk-main-card" v-if="moreDiskData.length > 0">
                <div class="new-disk-item" v-for="(item,i) in moreDiskData" :key="i">
                  <template v-if="item.selectList.length > 0 && (item.selectList[0].type !== 'radio')">
                    <span class="item-name">{{lang.common_cloud_btn40}}{{item.index}}</span>
                    <el-select v-model="item.type" :placeholder="lang.placeholder_pre2"
                      @change="(val)=>changeType(val,item)" style="margin-right: 20px;">
                      <el-option v-for="(items,index) in item.selectList[0].disk_typeList" :key="index" :value="items"
                        :label="items"></el-option>
                    </el-select>
                    <el-tooltip effect="light" :content="lang.mf_range + item.selectList[0][item.type].tips"
                      placement="top">
                      <el-input-number v-model="item.size" :min="item.selectList[0][item.type].min_value"
                        :max="item.selectList[0][item.type].max_value" @change="changeDataNum($event,item)">
                      </el-input-number>
                    </el-tooltip>
                    <span class="disk-item-size" style="margin-left: 10px; margin-right: 50px;">G</span>
                    <i class="el-icon-remove-outline del" @click="delMoreDisk(item.index)"></i>
                    <i class="el-icon-circle-plus-outline add" v-show="item.index === moreDiskData.length"
                      @click="addMoreDisk"></i>
                  </template>
                  <template v-if="item.selectList.length > 0 && item.selectList[0].type === 'radio'">
                    <span class="item-name">{{lang.common_cloud_btn40}}{{item.index}}</span>
                    <el-select v-model="item.type" style="margin-left: 50px;" @change="(val)=>addTypeChange(val,item)">
                      <el-option v-for="(items,index) in item.selectList[0].disk_typeList" :key="index" :value="items"
                        :label="items"></el-option>
                    </el-select>
                    <el-select v-model="item.size" style="margin-left: 50px;">
                      <el-option v-for="(itemss,index) in item.selectList[0][item.type]" :key="index"
                        :value="itemss.value" :label="itemss.value + 'G'"></el-option>
                    </el-select>
                    <i class="el-icon-remove-outline del" @click="delMoreDisk(item.index)"></i>
                    <i class="el-icon-circle-plus-outline add" v-show="item.index === moreDiskData.length"
                      @click="addMoreDisk"></i>
                  </template>
                  <template v-if="item.selectList.length === 0">
                    {{lang.common_cloud_btn67}}
                  </template>
                </div>
              </div>
              <div class="disk-main-card" v-if="moreDiskData.length === 0">
                <div class="no-disk-btn" @click="addMoreDisk">
                  <i class="el-icon-circle-plus-outline add"></i>
                  <span>{{lang.mf_add_disk}}</span>
                </div>
              </div>
            </div>
            <div class="dialog-footer">
              <span class="text">{{lang.common_cloud_btn41}}:</span>
              <span class="num" v-loading="diskPriceLoading">
                {$Detail.currency.prefix}{{moreDiskPrice}}
                <el-popover placement="top-start" width="200" trigger="hover">
                  <div class="show-config-list">{{lang.shoppingCar_tip_text2}}：{$Detail.currency.prefix}{{
                    moreDiscountkDisPrice }}</div>
                  <div class="show-config-list">{{lang.common_cloud_text28}}：{$Detail.currency.prefix}{{
                    moreCodePrice }}</div>
                  <i class="el-icon-warning-outline total-icon" slot="reference" v-if="isShowLevel || isShowPromo"></i>
                </el-popover>
              </span>
              <div class="btn-ok" @click="toCreateDisk">{{lang.common_cloud_btn28}}</div>
              <div class="btn-no" @click="dgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 扩容磁盘弹窗 -->
        <div class="kr-dialog">
          <el-dialog width="841px" :visible.sync="isShowExpansion" :show-close=false @close="krClose">
            <div class="dialog-title">
              {{lang.common_cloud_btn42}}
            </div>
            <div class="dialog-main">
              <div class="label">{{lang.common_cloud_btn43}}</div>
              <div class="disk-main-card">
                <div class="old-disk-item" v-for="item in oldDiskList" :key="item.id">
                  <template
                    v-if="item.type2 ==='data' && item.selectList.length > 0 && (item.selectList[0].type === 'total' || item.selectList[0].type === 'step')">
                    <span class="disk-item-text" :title="item.name">{{item.name}}</span>
                    <span class="disk-item-size">{{item.min_value + 'G'}}</span>
                    <el-slider :min="item.min_value" :step="item.selectList[0].step" :max="item.max_value"
                      v-model="item.size" :disabled="item.is_free === 1"
                      @change="(val)=>sliderChange(val,item)"></el-slider>
                    <span class="item-max-size">{{item.max_value}}G</span>
                  </template>
                  <template
                    v-if="item.type2 ==='data' && item.selectList.length > 0 && item.selectList[0].type === 'radio'">
                    <span class="disk-item-text" :title="item.name">{{item.name}}</span>
                    <span class="disk-item-size">{{item.min_value + 'G'}}</span>
                    <el-select v-model="item.size" style="margin-left: 50px;" :disabled="item.is_free === 1">
                      <el-option v-for="items in item.selectList" :key="items.id" :value="items.value"
                        :label="items.value + 'G'"></el-option>
                    </el-select>
                  </template>
                  <template v-if="item.selectList.length === 0">
                    <span class="disk-item-text" :title="item.name">{{item.name}}</span>
                    {{lang.common_cloud_btn68}}
                  </template>
                </div>
              </div>
            </div>
            <div class="dialog-footer">
              <span class="text">{{lang.common_cloud_btn44}}:</span>
              <span class="num" v-loading="diskPriceLoading">
                {$Detail.currency.prefix}{{expansionDiskPrice}}
                <el-popover placement="top-start" width="200" trigger="hover">
                  <div class="show-config-list">{{lang.shoppingCar_tip_text2}}：{$Detail.currency.prefix}{{
                    expansionDiscount }}</div>
                  <div class="show-config-list">{{lang.common_cloud_text28}}：{$Detail.currency.prefix}{{
                    expansionCodePrice }}</div>
                  <i class="el-icon-warning-outline total-icon" slot="reference" v-if="isShowLevel || isShowPromo"></i>
                </el-popover>
              </span>
              <div class="btn-ok" @click="subExpansion">{{lang.common_cloud_btn28}}</div>
              <div class="btn-no" @click="krClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>
        <!-- 创建备份/快照弹窗 -->
        <div class="create-bs-dialog">
          <el-dialog width="680px" :visible.sync="isShwoCreateBs" :show-close=false @close="bsCgClose">
            <div class="dialog-title">
              {{isBs? lang.common_cloud_btn45 :lang.common_cloud_btn46}}
            </div>
            <div class="title-second-text">
              {{lang.common_cloud_btn47}}{{isBs? lang.common_cloud_btn45
              :lang.common_cloud_btn46}}{{lang.common_cloud_btn48}}
            </div>
            <div class="dialog-main">
              <div class="label">{{lang.common_cloud_tab3}}</div>
              <el-select v-model="createBsData.disk_id">
                <el-option v-for="item in allDiskList" :key="item.id" :value="item.id" :label="item.name"></el-option>
              </el-select>
              <div class="label">{{lang.invoice_text139}}</div>
              <el-input v-model="createBsData.name"></el-input>
              <div class="alert">
                <el-alert :title="errText" type="error" show-icon :closable="false" v-show="errText">
                </el-alert>
              </div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="subCgBs" v-loading="cgbsLoading">{{lang.finance_label25}}</div>
              <div class="btn-no" @click="bsCgClose">{{lang.common_cloud_text181}}</div>
            </div>
          </el-dialog>
        </div>
        <!-- 还原备份、快照弹窗 -->
        <div class="restore-dialog">
          <el-dialog width="680px" :visible.sync="isShowhyBs" :show-close=false @close="bshyClose">
            <div class="dialog-title">
              {{lang.common_cloud_btn49}}
            </div>
            <div class="dialog-main">
              <span>{{lang.common_cloud_btn50}}{{restoreData.cloud_name}}{{lang.common_cloud_btn51}}</span>
              <span>{{restoreData.time |
                formateTime}}{{lang.common_cloud_btn52}}{{isBs?lang.common_cloud_btn53:lang.common_cloud_btn54}}</span>
              <span>{{lang.common_cloud_btn55}}{{isBs?lang.common_cloud_btn53:lang.common_cloud_btn54}}</span>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="subhyBs" v-loading="loading3">{{lang.common_cloud_btn56}}</div>
              <div class="btn-no" @click="bshyClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>
        <!-- 删除备份、快照弹窗 -->
        <div class="del-dialog">
          <el-dialog width="680px" :visible.sync="isShowDelBs" :show-close=false @close="delBsClose">
            <div class="dialog-title">
              <i class="el-icon-warning-outline"></i>
              {{isBs?lang.common_cloud_btn57:lang.common_cloud_btn58}}
            </div>
            <div class="dialog-main">
              <span class="row-1">{{isBs?lang.common_cloud_btn57:lang.common_cloud_btn58}}{{delData.name}}</span>
              <span
                class="row-2">{{lang.common_cloud_btn59}}{{delData.cloud_name}}{{lang.common_cloud_btn51}}{{delData.time
                |
                formateTime}}{{lang.common_cloud_btn52}}{{isBs?lang.common_cloud_btn53:lang.common_cloud_btn54}}{{lang.common_cloud_btn60}}</span>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="subDelBs" v-loading="loading4">{{lang.common_cloud_btn61}}</div>
              <div class="btn-no" @click="delBsClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 开启备份/快照弹窗 -->
        <div class="bs-dialog">
          <el-dialog width="620px" :visible.sync="isShowOpenBs" :show-close=false @close="bsopenDgClose">
            <div class="dialog-title">
              {{isBs?lang.common_cloud_btn62:lang.common_cloud_btn63}}
            </div>
            <div class="dialog-main">
              <!-- 备份下拉框 -->
              <el-select v-model="bsData.backNum" v-show="isBs" @change="bsSelectChange">
                <el-option v-for="item in backup_config" :key="item.id" :value="item.num"
                  :label="item.num + lang.common_cloud_text3 + commonData.currency_prefix + item.price + '/' + bsData.duration"></el-option>
              </el-select>
              <!-- 快照下拉框 -->
              <el-select v-model="bsData.snapNum" v-show="!isBs" @change="bsSelectChange">
                <el-option v-for="item in snap_config" :key="item.id" :value="item.num"
                  :label="item.num + lang.common_cloud_text4 + commonData.currency_prefix + item.price  + '/' + bsData.duration"></el-option>
              </el-select>
              <span
                class="num">{{lang.common_cloud_text2}}{{isBs?bsData.backNum:bsData.snapNum}}{{lang.mf_one}}{{isBs?lang.common_cloud_title5:lang.common_cloud_btn54}}</span>
              <span class="price" v-loading="bsDataLoading">
                {{commonData.currency_prefix + bsData.money}}
                <el-popover placement="top-start" width="200" trigger="hover">
                  <div class="show-config-list">{{lang.common_cloud_text27}}：{$Detail.currency.prefix}{{
                    bsData.moneyDiscount.toFixed(2) }}</div>
                  <div class="show-config-list">{{lang.common_cloud_text28}}：{$Detail.currency.prefix}{{
                    bsData.codePrice.toFixed(2) }}</div>
                  <i class="el-icon-warning-outline total-icon" slot="reference" v-if="isShowLevel || isShowPromo"></i>
                </el-popover>

              </span>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="bsopenSub">{{lang.common_cloud_btn28}}</div>
              <div class="btn-no" @click="bsopenDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 电源操作确认弹窗 -->
        <div class="power-dialog">
          <el-dialog width="620px" :visible.sync="isShowPowerChange" :show-close=false @close="powerDgClose">
            <div class="dialog-title">
              {{lang.common_cloud_text34}}{{powerTitle}}{{lang.common_cloud_text35}}
            </div>
            <div class="dialog-main">
              <div class="label">{{lang.common_cloud_text36}}</div>
              <div class="value">{{hostData.name}}</div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="toChangePower()">{{lang.common_cloud_btn28}}</div>
              <div class="btn-no" @click="powerDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 自动续费确认弹窗 -->
        <div class="power-dialog">
          <el-dialog width="620px" :visible.sync="isShowAutoRenew" :show-close=false :close-on-click-modal=false>
            <div class="dialog-title">
              {{lang.common_cloud_text37}}{{isShowPayMsg? lang.common_cloud_text38 :
              lang.common_cloud_text39}}{{lang.auto_renew}}
            </div>
            <div class="dialog-main">
              <div class="label">{{lang.fin_host}}</div>
              <div class="value">{{hostData.name}}</div>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="doAutoRenew">{{lang.common_cloud_btn28}}</div>
              <div class="btn-no" @click="autoRenewDgClose">{{lang.common_cloud_btn29}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 创建nat 转发建站 -->
        <div class="create-bs-dialog create-nat">
          <el-dialog width="680px" :visible.sync="natDialog" :show-close=false @close="bsCgClose">
            <div class="dialog-title">
              {{lang.invoice_text47}}{{natType === 'acl' ? lang.nat_acl :lang.nat_web}}
            </div>
            <div class="dialog-main">
              <el-form :model="natForm" :rules="natRules" ref="natForm" label-width="100px">
                <el-form-item :label="lang.security_label1" prop="name" v-if="natType === 'acl'">
                  <el-input v-model="natForm.name"
                    :placeholder="`${lang.placeholder_pre1}${lang.security_label1}`"></el-input>
                </el-form-item>
                <el-form-item :label="lang.domain" prop="domain" v-if="natType === 'web'">
                  <el-input v-model="natForm.domain" :placeholder="`${lang.placeholder_pre1}${lang.domain}`"></el-input>
                </el-form-item>
                <el-form-item :label="lang.ext_port">
                  <el-input :value="natType === 'web' ? 80 : `${lang.nat_tip1}`" disabled></el-input>
                </el-form-item>
                <el-form-item :label="lang.int_port" prop="int_port">
                  <el-input-number :value="natForm.int_port" :controls="false" :min="1" :max="65535" :precision="0"
                    :placeholder="`${lang.int_port}(1-65535)`" @input="changeIntPort">
                  </el-input-number>
                </el-form-item>
                <el-form-item :label="lang.protocol" prop="protocol" v-if="natType === 'acl'">
                  <el-select v-model="natForm.protocol" :placeholder="`${lang.placeholder_pre2}${lang.protocol}`">
                    <el-option v-for="item in protocolArr" :key="item.value" :value="item.value"
                      :label="item.label"></el-option>
                  </el-select>
                </el-form-item>
              </el-form>
            </div>
            <div class="dialog-footer">
              <div class="btn-ok" @click="submitNat" v-loading="submitLoaing">{{lang.ticket_btn6}}</div>
              <div class="btn-no" @click="bsCgClose">{{lang.ticket_btn9}}</div>
            </div>
          </el-dialog>
        </div>

        <!-- 模拟物理机运行 -->
        <div class="repass-dialog">
          <el-dialog width="680px" :visible.sync="physicalVisible" :show-close="false" @close="rePassDgClose">
            <div class="dialog-title">
              {{physicalTitle}}
            </div>
            <div class="dialog-main">
              <div class="alert" v-show="powerStatus=='off'">
                <div class="title">{{lang.common_cloud_tip30}}</div>
                <div class="row">
                  <span class="dot"></span> {{lang.common_cloud_tip31}}
                </div>
                <div class="row">
                  <span class="dot"></span> {{lang.common_cloud_tip32}}
                </div>
              </div>
              <el-checkbox v-model="physicalChecked" v-show="powerStatus=='off'">
                {{lang.common_cloud_text24}}
              </el-checkbox>
              <div class="alert-err-text">
                <el-alert :title="errText" type="error" show-icon :closable="false" v-show="errText">
                </el-alert>
              </div>
            </div>
            <div class="dialog-footer">
              <el-button type="primary" class="btn-ok" @click="handlePhysical" :loading="submitLoaing">
                {{lang.common_cloud_btn28}}
              </el-button>
              <div class="btn-no" @click="physicalVisible = false">
                {{lang.common_cloud_btn29}}
              </div>
            </div>
          </el-dialog>
        </div>

        <!-- <pay-dialog ref="topPayDialog" @payok="paySuccess" @paycancel="payCancel"></pay-dialog> -->
        <!-- 申请返现 -->
        <!-- <cash-back :id="id" :show-cash="isShowCashDialog" @cancledialog="cancleDialog" @showbtn="showBtn"></cash-back> -->
        <!-- 购买流量包 -->
        <flow-packet :id="id" :show-package="showPackage" @cancledialog="cancleDialog" v-if="showPackage"
          :currency_prefix="commonData.currency_prefix" @sendPackId="handlerPay">
        </flow-packet>
      </div>
    </div>
  </div>

  <!-- 通用 -->
  <!-- <script src="/themes/clientarea/default/v10/utils/common.js"></script> -->
  <script src="/themes/clientarea/default/v10/resource/vue.js"></script>
  <script src="/themes/clientarea/default/v10/resource/element.js"></script>
  <script src="/themes/clientarea/default/v10/utils/axios.min.js"></script>
  <script src="/themes/clientarea/default/v10/utils/request.js"></script>
  <script src="/themes/clientarea/default/v10/utils/util.js"></script>


  <!-- 独有 -->
  <script>
    const currency_prefix = `{$Detail.currency.prefix}`
  </script>
  <script src="/themes/clientarea/default/v10/api/cloud_api.js"></script>
  <script src="/themes/clientarea/default/v10/resource/echarts.min.js"></script>
  <script src="/themes/clientarea/default/v10/js/cloud_details.js"></script>
</body>

</html>
