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
              <!-- <span class="name">{{hostData.name}}</span> -->
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
              <!-- <span class="all-ip" @click="showAllIp" v-if="allIps.length > 1">{{lang.domain_look}}{{lang.all_ips}}</span> -->
            </div>
            <div class="row2-right" v-show="hostData.status == 'Active' && !initLoading">
              <!-- 停用-->
              <span class="refund" v-if="financeConfig.cancel_control">
                <!-- <span class="refund-status" v-if="refundData && refundData.status != 'Cancelled' && refundData.status != 'Reject'">{{refundStatus[refundData.status]}}</span> -->
                <span class="refund-stop-btn" v-if="refundData.is_cancel"
                  @click="quitRefund">{{lang.common_cloud_btn8}}</span>
                <span class="refund-btn" @click="showRefund" v-else>{{lang.common_cloud_btn9}}</span>
              </span>

              <!-- 控制台 -->
              <!-- <img class="console-img" src="/plugins/server/mf_dcim/template/clientarea/img/cloudDetail/console.png" :title="lang.common_cloud_text8" @click="doGetVncUrl" v-show="status != 'operating'"> -->
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
              <!-- 重启 -->
              <!-- <span class="restart">
                <el-popover placement="bottom" v-model="rebotVisibel" trigger="click">
                  <div class="sure-remind">
                    <span class="text">{{lang.common_cloud_text9}}</span>
                    <span class="status">{{lang.common_cloud_text13}}</span>
                    <span>?</span>
                    <span class="sure-btn" @click="doReboot">{{lang.common_cloud_btn10}}</span>
                  </div>
                  <img src="/plugins/server/mf_dcim/template/clientarea/img/cloudDetail/restart.png" :title="lang.common_cloud_text13" v-show="status != 'operating'" slot="reference">
                </el-popover>
              </span> -->

              <!-- 救援模式 -->
              <img class="fault" src="/themes/clientarea/default/v10/img/fault.png"
                v-show="isRescue && status != 'operating'" :title="lang.common_cloud_text14">
            </div>
          </div>
          <div class="operation-row3" v-show="hostData.status == 'Active'">
            <!-- 有备注 -->
            <span class="yes-notes" v-if="hostData.notes" @click="doEditNotes">
              <i class="el-icon-edit notes-icon"></i>
              <span class="notes-text">{{hostData.notes}}</span>
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
            {{refundData.type=='Expire'?lang.common_cloud_tip8:lang.common_cloud_tip9}}，{{lang.common_cloud_tip13}}<span
              v-if="refundData.type=='Expire'">{{hostData.due_time | formateTime}}</span> {{refundData.type=='Expire'?
            lang.common_cloud_tip10:lang.common_cloud_tip11}} {{lang.common_cloud_tip12}})
          </div>
          <!-- 停用失败 -->
          <div class="refund-fail" v-if="refundData && refundData.status == 'Reject'">
            ({{lang.common_cloud_tip6}}{{refundData.create_time | formateTime}}{{lang.common_cloud_tip7}}
            {{refundData.type=='Expire'?lang.common_cloud_tip8:lang.common_cloud_tip9}} {{lang.common_cloud_tip14}}，
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
            </div>
            <div class="l-b">
              <div class="info-item">
                <div class="label">CPU:</div>
                <div class="value" :title="cloudData.model_config?.cpu">{{cloudData.model_config?.cpu}}</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.peak_defence}}:</div>
                <div class="value">
                  <span v-if="cloudData.peak_defence * 1">{{cloudData.peak_defence}}G</span>
                  <span v-else>{{lang.no_defense}}</span>
                </div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.common_cloud_label14}}:</div>
                <div class="value" :title="rescueStatusData.username">{{rescueStatusData.username}}</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.common_cloud_text31}}:</div>
                <div class="value" :title="cloudData.model_config?.memory">{{cloudData.model_config?.memory}}</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.cloud_os}}:</div>
                <div class="value" :title="cloudData.image?.name">{{ cloudData.image?.name}}</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.login_pass}}:</div>
                <div class="value">
                  <span v-show="isShowPass"> {{rescueStatusData.password}} </span>
                  <span v-show="!isShowPass"> {{passHidenCode}} </span>
                  <img class="eyes"
                    :src="isShowPass?'/themes/clientarea/default/v10/img/pass-show.png':'/themes/clientarea/default/v10/img/pass-hide.png'"
                    @click="isShowPass=!isShowPass" />
                  <i class="el-icon-document-copy"
                    style="font-size: 14px; margin-left: 3px; cursor: pointer; color: #0052D9;"
                    @click="copyPass(rescueStatusData.password)"></i>
                </div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.mf_disk}}:</div>
                <div class="value" :title="cloudData.model_config?.disk">{{cloudData.model_config?.disk}}</div>
              </div>
              <div class="info-item" v-if="cloudData.line?.bill_type === 'flow'">
                <div class="label">{{lang.mf_flow}}:</div>
                <div class="value" v-if="cloudData.flow !==0">{{cloudData.flow}}G</div>
                <div class="value" v-else>{{lang.mf_tip28}}</div>
              </div>
              <div class="info-item" v-else>
                <div class="label">{{lang.mf_bw}}:</div>
                <div class="value">
                  {{cloudData.bw === 'NC' ? cloudData.bw_show ? cloudData.bw_show : lang.actual_bw : (cloudData.bw +
                  'Mbps')
                  }}
                </div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.common_cloud_label13}}:</div>
                <div class="value">{{rescueStatusData.port}}</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.mf_gpu}}:</div>
                <div class="value" :title="cloudData.model_config?.gpu">{{cloudData.model_config?.gpu || '--'}}</div>
              </div>
              <div class="info-item">
                <div class="label">{{lang.common_cloud_title15}}:</div>
                <div class="value">{{rescueStatusData.ip_num}}{{lang.common_cloud_title43}}</div>
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
                  v-if="(item.field_type === 'password' || item.field_type === 'link') && item.value"
                  style="font-size: 14px; margin-left: 3px; cursor: pointer; color: #0052D9;"
                  @click="copyPass(item.value)"></i>
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
              <div class="r-t-r" v-show="hostData.status == 'Active' || 'Suspended'">
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
                  <div class="value">{{commonData.currency_prefix + hostData.first_payment_amount +
                    commonData.currency_suffix}}</div>
                </div>
              </div>
              <div class="row">
                <div class="row-l">
                  <div class="label">{{lang.cloud_re_text}}:</div>
                  <div class="value">{{commonData.currency_prefix + showRenewPrice + commonData.currency_suffix}}
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

          <!-- 统计图表 -->
          <el-tab-pane :label="lang.common_cloud_tab1" name="1" v-if="cloudConfig.manual_resource === 0">
            <el-select class="time-select" v-model="chartSelectValue" @change="chartSelectChange">
              <el-option value='1' :label="lang.common_cloud_tab12"></el-option>
              <el-option value='2' :label="lang.common_cloud_tab13"></el-option>
              <el-option value='3' :label="lang.common_cloud_tab14"></el-option>
            </el-select>
            <div class="echart-main">
              <!-- 网络带宽 -->
              <div id="bw-echart" class="my-echart" v-loading="echartLoading"></div>
            </div>
          </el-tab-pane>
          <el-tab-pane :label="lang.common_cloud_tab2" name="2">
            <div class="manage-content">
              <!-- 第一行 -->
              <el-row>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="showPowerDialog('on')" v-loading="loading1">
                      {{lang.common_cloud_text10}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_label45}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="showPowerDialog('off')" v-loading="loading2">
                      {{lang.common_cloud_text11}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_label46}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="showPowerDialog('rebot')" v-loading="loading3">
                      {{lang.common_cloud_text13}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_label47}}</div>
                    </div>
                  </div>
                </el-col>
              </el-row>
              <!-- 第二行 -->
              <el-row>
                <el-col :span="8">
                  <div class="manage-item" :class="{dis: cloudConfig.manual_resource}">
                    <div class="item-top-btn" @click="getVncUrl" v-loading="loading4">
                      {{lang.common_cloud_btn11}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip17}}</div>
                      <div class="bottom-row">{{lang.common_cloud_tip18}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item" :class="{dis: cloudConfig.manual_resource}">
                    <div class="item-top-btn" @click="showRePass">
                      {{lang.common_cloud_title13}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip19}}</div>
                      <div class="bottom-row">{{lang.common_cloud_tip20}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item" :class="{dis: cloudConfig.manual_resource}">
                    <div class="item-top-btn" @click="showRescueDialog">
                      {{lang.common_cloud_text14}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip21}}</div>
                      <div class="bottom-row">{{lang.common_cloud_tip22}}</div>
                    </div>
                  </div>
                </el-col>
              </el-row>
              <!-- 第三行 -->
              <el-row>
                <el-col :span="8" v-if="cloudConfig.manual_resource === 0">
                  <div class="manage-item">
                    <div class="item-top-btn" @click="showUpgrade">
                      {{lang.common_cloud_btn16}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip24}}</div>
                    </div>
                  </div>
                </el-col>
                <el-col :span="8">
                  <div class="manage-item" :class="{dis: cloudConfig.manual_resource}">
                    <div class="item-top-btn" @click="showReinstall">
                      {{lang.common_cloud_btn15}}
                    </div>
                    <div class="item-bottom">
                      <div class="bottom-row">{{lang.common_cloud_tip23}}</div>
                    </div>
                  </div>
                </el-col>
              </el-row>
            </div>
          </el-tab-pane>
          <el-tab-pane :label="lang.common_cloud_tab4" name="4" v-if="cloudConfig.manual_resource === 0">
            <div class="net">
              <div class="title">
                <span>{{lang.common_cloud_title3}}</span>
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
                <pagination :page-data="netParams" v-if="netParams.total" @sizechange="netSizeChange"
                  @currentchange="netCurrentChange">
                </pagination>
              </div>
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

            </div>
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
                <pagination :page-data="logParams" v-if="logParams.total" @sizechange="logSizeChange"
                  @currentchange="logCurrentChange">
                </pagination>
              </div>
            </div>
          </el-tab-pane>
        </el-tabs>

        <!-- 所有IP -->
        <!-- <div class="notes-dialog all-ip-dialog">
          <el-dialog width="5.2rem" :visible.sync="ipDialog" :show-close=false>
            <div class="dialog-title">
              {{lang.all_ips}}
            </div>
            <div class="dialog-main">
              <p class="ip-item" v-for="(item,index) in allIps" :key="index">{{item}}</p>
            </div>
            <div class="dialog-footer">
              <div class="btn-no" @click="ipDialog = false">{{lang.appstore_text307}}</div>
            </div>
          </el-dialog>
        </div> -->
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

                </el-select>
                <el-popover placement="top-start" width="200" trigger="hover" :content="lang.common_cloud_tip33">
                  <i class="el-icon-question help-icon" slot="reference"></i>
                </el-popover>
                <el-input class="pass-input" v-model="reinstallData.password" :placeholder="lang.ticket_label12"
                  v-show="reinstallData.type=='pass'">
                  <div class="pass-btn" slot="suffix" @click="autoPass">{{lang.common_cloud_btn1}}</div>
                </el-input>
                <div class="key-select" v-show="reinstallData.type=='key'">
                  <el-select v-model="reinstallData.key">
                    <el-option v-for="item in sshKeyData" :key="item.id" :value="item.id"></el-option>
                  </el-select>
                </div>
              </div>
              <div class="label">{{lang.common_cloud_label13}}</div>
              <el-input class="pass-input" v-model="reinstallData.port" :placeholder="lang.ticket_label12">
                <div class="pass-btn" slot="suffix" @click="autoPort">{{lang.common_cloud_btn1}}</div>
              </el-input>
              <template v-if="isWindows">
                <div class="label">{{lang.op_tips2}}</div>
                <el-radio-group v-model="reinstallData.part_type">
                  <el-radio :label="0">{{lang.op_tips3}}</el-radio>
                  <el-radio :label="1">{{lang.op_tips4}}</el-radio>
                </el-radio-group>
              </template>
              <template v-if="cloudConfig.reinstall_sms_verify === 1">
                <div class="label">{{lang.ticket_label19}}</div>
                <el-input class="pass-input" v-model="reinstallData.code" :placeholder="lang.account_tips33">
                  <div class="pass-btn" slot="suffix" v-if="isSendCodeing">{{sendTime}}{{lang.account_tips54}}</div>
                  <div class="pass-btn" slot="suffix" v-loading="sendFlag" @click="sendCode" v-else>
                    {{lang.account_tips55}}
                  </div>
                </el-input>
              </template>

              <div class="pay-img" v-show="isPayImg">
                {{lang.common_cloud_tip28}},{{commonData.currency_prefix + payMoney + '/次'}}
                <el-popover placement="top-start" width="200" trigger="hover">
                  <div class="show-config-list">{{lang.shoppingCar_tip_text2}}：{{commonData.currency_prefix}}{{
                    payDiscount }}</div>
                  <div class="show-config-list">{{lang.common_cloud_text28}}：{{commonData.currency_prefix}}{{
                    payCodePrice }}</div>
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
                    {{commonData.currency_prefix + item.base_price}}</div>
                  <div class="item-bottom" v-else>{{commonData.currency_prefix + item.price}}</div>
                  <div class="item-origin-price" v-if="item.price < item.base_price && !renewParams.isUseDiscountCode">
                    {{commonData.currency_prefix + item.base_price}}</div>
                  <i class="el-icon-check check" v-show="renewActiveId==item.id"></i>
                </div>
              </div>
              <div class="pay-content">
                <div class="pay-price">
                  <div class="money" v-loading="renewLoading">
                    <span class="text">{{lang.common_cloud_label11}}:</span>
                    <span>{{commonData.currency_prefix}}{{renewParams.totalPrice | filterMoney}}</span>
                    <el-popover placement="top-start" width="200" trigger="hover"
                      v-if="(isShowLevel && renewParams.clDiscount*1 > 0) || (isShowPromo && renewParams.isUseDiscountCode) || ( isShowCash && renewParams.customfield.voucher_get_id)">
                      <div class="show-config-list">
                        <p v-if="isShowLevel">{{lang.shoppingCar_tip_text2}}：{{commonData.currency_prefix}} {{
                          renewParams.clDiscount | filterMoney}}</p>
                        <p v-if="isShowPromo && renewParams.isUseDiscountCode">
                          {{lang.shoppingCar_tip_text4}}：{{commonData.currency_prefix}} {{ renewParams.code_discount |
                          filterMoney }}</p>
                        <p v-if="isShowCash && renewParams.customfield.voucher_get_id">
                          {{lang.common_cloud_text29}}：{{commonData.currency_prefix}} {{ renewParams.cash_discount |
                          filterMoney}}</p>
                      </div>
                      <i class="el-icon-warning-outline total-icon" slot="reference"></i>
                    </el-popover>
                    <p class="original-price"
                      v-if="renewParams.customfield.promo_code && renewParams.totalPrice != renewParams.base_price">
                      {{commonData.currency_prefix}} {{ renewParams.base_price | filterMoney}}</p>
                    <p class="original-price"
                      v-if="!renewParams.customfield.promo_code && renewParams.totalPrice != renewParams.original_price">
                      {{commonData.currency_prefix}} {{ renewParams.original_price | filterMoney}}</p>
                    <!-- <div class="code-box">
                      <cash-coupon ref="cashRef" v-show="isShowCash && !cashObj.code" :currency_prefix="commonData.currency_prefix" @use-cash="reUseCash" scene='renew' :product_id="[product_id]" :price="renewParams.original_price"></cash-coupon>
                      <discount-code v-show="isShowPromo && !renewParams.customfield.promo_code" @get-discount="getRenewDiscount(arguments)" scene='renew' :product_id="product_id" :amount="renewParams.base_price" :billing_cycle_time="renewParams.duration"></discount-code>
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
                    <span class="mr-5 ml-5">·</span>
                    <el-tooltip :content="vpc_ips.vpc3Tips" placement="top" effect="light"
                      :disabled="!vpc_ips.vpc3Tips">
                      <el-input-number :disabled="vpc_ips.vpc6.value === 16" @blur="changeVpc3" v-model="vpc_ips.vpc3"
                        :step="1" :controls="false" :min="0" :max="255">
                      </el-input-number>
                    </el-tooltip>
                    <span class="mr-5 ml-5">·</span>
                    <el-tooltip :content="vpc_ips.vpc4Tips" placement="top" effect="light"
                      :disabled="!vpc_ips.vpc4Tips">
                      <el-input-number :disabled="vpc_ips.vpc6.value < 25" @blur="changeVpc4" v-model="vpc_ips.vpc4"
                        :step="1" :controls="false" :min="0" :max="255">
                      </el-input-number>
                    </el-tooltip>
                    <span class="mr-5 ml-5">/</span>
                    <el-select v-model="vpc_ips.vpc6.value" style="width: 70px" @change="changeVpcMask">
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
        <el-dialog width="680px" :visible.sync="isShowIp" :show-close=false @close="ipClose" class="ip-dialog">
          <div class="dialog-title">{{lang.common_cloud_title3}}</div>
          <div class="dialog-main">
            <div class="label">{{lang.common_cloud_title40}} {{netDataList.length}}
              {{lang.common_cloud_title43}},{{lang.common_cloud_title45}}</div>
            <div class="ip-main-card">
              <div class="ip-item" :class="ipValue === item.value ? 'active' : ''" v-for="item in ipValueData"
                :key="item.value" @click="selectIpValue(item.value)">
                {{item.value}} {{lang.common_cloud_title43}}
              </div>
            </div>
          </div>
          <div class="dialog-footer">
            <span class="text">{{lang.common_cloud_title44}}:</span>
            <span class="num" v-loading="ipPriceLoading">
              {{commonData.currency_prefix}}{{ipMoney >=0 ? ipMoney : 0}}
              <el-popover placement="top-start" width="200" trigger="hover">
                <div class="show-config-list">{{lang.common_cloud_text27}}：{{commonData.currency_prefix}}{{
                  ipDiscountkDisPrice }}</div>
                <div class="show-config-list">{{lang.common_cloud_text28}}：{{commonData.currency_prefix}}{{ ipCodePrice
                  }}</div>
                <i class="el-icon-warning-outline total-icon" slot="reference" v-if="isShowLevel || isShowPromo"></i>
              </el-popover>
            </span>
            <div class="btn-ok" @click="subAddIp">{{lang.finance_text74}}</div>
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
                      <div class="right-row-item">CPU：{{cloudData.model_config?.cpu}}</div>
                      <div class="right-row-item">{{lang.common_cloud_text286}}：{{cloudData.model_config?.memory}}</div>
                      <div class="right-row-item">{{lang.mf_system}}：{{cloudData.model_config?.disk}}</div>
                      <div class="right-row-item">{{lang.common_cloud_text288}}：{{cloudData.bw}} M </div>
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
                {{commonData.currency_prefix}}{{refundParams.type=='Immediate'?refundPageData.host.amount:'0.00'}}</div>
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
                  {{lang.account_tips55}}</div>
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
              <el-form ref="orderForm" label-position="left" label-width="100px" hide-required-asterisk>

                <!-- 灵活机型独有 -->
                <template v-if="packageObj.id > 0 ">
                  <!-- 内存 -->
                  <template v-if="curPackageDetails.optional_memory.length > 0">
                    <el-form-item :label="lang.memory_optional">
                      <div class="opt-content">
                        <span class="opt-item" v-for="(item, index) in curPackageDetails.optional_memory" :key="item.id"
                          :class="{active: item.checked, dis:calcConfigDisabled(item) }"
                          @click="checkOption('optional_memory', item, calcConfigDisabled(item))">
                          {{item.value}}
                        </span>
                        <div class="tip-box">
                          <span class="tip"
                            v-if="curPackageDetails.mem_max_num !== 0">{{lang.mf_dcim_tip1}}{{calcMemoryNum}}{{lang.mf_dcim_tip2}}</span>
                          <span class="tip"
                            v-if="curPackageDetails.mem_max_num !== 0 && curPackageDetails.mem_max !== 0">，</span>
                          <span class="tip"
                            v-if="curPackageDetails.mem_max !== 0">{{lang.mf_dcim_tip4}}{{curPackageDetails.mem_max}}G{{lang.cloud_memery}}</span>
                        </div>
                      </div>
                    </el-form-item>
                    <!-- 循环添加配置 -->
                    <template v-if="packageObj.optional_memory.length > 0">
                      <el-form-item :label="item.value" v-for="item in packageObj.optional_memory" :key="item.id">
                        <el-input-number v-model="item.num" @change="getCycleList" :min="1" :max="calcMemMax(item)"
                          :precision="0" :controls="false" class="config-number"></el-input-number>
                      </el-form-item>
                    </template>
                  </template>
                  <!-- 硬盘 -->
                  <template v-if="curPackageDetails.optional_disk.length > 0">
                    <el-form-item :label="lang.disk_optional">
                      <div class="opt-content">
                        <span class="opt-item" v-for="(item, index) in curPackageDetails.optional_disk" :key="item.id"
                          :class="{active: item.checked, dis: item.fix || calcDiskDisabled(item)}"
                          @click="checkOption('optional_disk', item, item.fix || calcDiskDisabled(item))">
                          {{item.value}}
                        </span>
                        <div class="tip-box">
                          <span class="tip">{{lang.mf_dcim_tip7}}，</span>
                          <span class="tip"
                            v-if="curPackageDetails.disk_max_num !== 0">{{lang.mf_dcim_tip8}}{{calcDiskNum}}{{lang.mf_dcim_tip3}}。</span>
                          <span class="tip">{{lang.mf_dcim_tip9}}</span>
                        </div>
                      </div>
                    </el-form-item>
                    <!-- 循环添加配置 -->
                    <template v-if="packageObj.optional_disk.length > 0">
                      <el-form-item :label="item.value" v-for="item in packageObj.optional_disk" :key="item.id">
                        <el-input-number v-model="item.num" @change="getCycleList" :min="item.min || 1"
                          :max="calcDiskMax(item)" :precision="0" :controls="false"
                          class="config-number"></el-input-number>
                      </el-form-item>
                    </template>
                  </template>
                </template>
                <!-- 灵活机型独有 end -->

                <!-- 固定机型增值选配 -->
                <template v-if="cloudData.model_config.id">
                  <!-- 内存 -->
                  <template v-if="curPackageDetails.optional_memory.length > 0">
                    <el-form-item :label="lang.add_memory">
                      <div class="opt-content" v-if="packageObj.optional_memory.length > 0">
                        <div class="opt-item" v-for="(item, index) in packageObj.optional_memory" :key="index">
                          <el-select v-model="packageObj.optional_memory[index].id"
                            :placeholder="`${lang.placeholder_pre2}${lang.cloud_memery}`"
                            @change="changeMemory($event, index)">
                            <el-option v-for="item in curPackageDetails.optional_memory" :key="item.id"
                              :label="item.value" :value="item.id" :class="{active: item.checked}"
                              :disabled="calcConfigDisabled(item, packageObj.optional_memory[index].num)">
                            </el-option>
                          </el-select>
                          <el-input-number v-model="packageObj.optional_memory[index].num" @change="getCycleList"
                            :min="1" :max="calcMemMax(item)" :precision="0" class="config-number">
                          </el-input-number>
                          <i class="el-icon-remove-outline del" @click="delConfig('optional_memory', index)"></i>
                        </div>
                      </div>
                      <div class="tip-box">
                        <p class="add" @click="checkOption('optional_memory')" v-if="showAddMemory">
                          <i class="el-icon-circle-plus-outline icon"></i>
                          <span>{{lang.increase_memory}}</span>
                        </p>
                        <span class="tip" v-if="curPackageDetails.mem_max_num !== 0">{{lang.mf_dcim_tip1}}<span
                            class="num">{{calcMemoryNum}}</span> {{lang.mf_dcim_tip2}}</span>
                        <span class="tip"
                          v-if="curPackageDetails.mem_max_num !== 0 && curPackageDetails.mem_max !== 0">，</span>
                        <span class="tip" v-if="curPackageDetails.mem_max !== 0">{{lang.mf_dcim_tip4}}<span
                            class="num">{{calcMemoryCapacity}}G</span>{{lang.cloud_memery}}</span>
                      </div>
                    </el-form-item>
                  </template>

                  <!-- 硬盘 -->
                  <template v-if="curPackageDetails.optional_disk.length > 0">
                    <el-form-item :label="lang.add_disk">
                      <div class="opt-content" v-if="packageObj.optional_disk.length > 0">
                        <div class="opt-item" v-for="(item, index) in packageObj.optional_disk" :key="index">
                          <el-select v-model="packageObj.optional_disk[index].id"
                            :placeholder="`${lang.placeholder_pre2}`" @change="getCycleList" :disabled="item.fix">
                            <el-option v-for="item in curPackageDetails.optional_disk" :key="item.id"
                              :label="item.value" :value="item.id" :disabled="calcDiskDisabled(item)">
                            </el-option>
                          </el-select>
                          <el-input-number v-model="packageObj.optional_disk[index].num" @change="getCycleList" :min="1"
                            :max="calcDiskMax(item)" :precision="0" class="config-number">
                          </el-input-number>
                          <i class="el-icon-remove-outline del" @click="delConfig('optional_disk', index)"
                            v-if="!item.fix"></i>
                        </div>
                      </div>
                      <div class="tip-box">
                        <p class="add" @click="checkOption('optional_disk')" v-if="showAddDisk">
                          <i class="el-icon-circle-plus-outline icon"></i>
                          <span>{{lang.increase_disk}}</span>
                        </p>
                        <span class="tip">{{lang.mf_dcim_tip7}}，</span>
                        <span class="tip" v-if="curPackageDetails.disk_max_num !== 0">{{lang.mf_dcim_tip8}}<span
                            class="num">{{calcDiskNum}}</span>{{lang.mf_dcim_tip3}}。</span>
                        <span class="tip">{{lang.mf_dcim_tip9}}</span>
                      </div>
                    </el-form-item>
                  </template>
                  <!-- 显卡 -->
                  <template v-if="curPackageDetails.optional_gpu.length > 0">
                    <el-form-item :label="lang.add_gpu">
                      <div class="opt-content" v-if="packageObj.optional_gpu.length > 0">
                        <div class="opt-item" v-for="(item, index) in packageObj.optional_gpu" :key="index">
                          <el-select v-model="packageObj.optional_gpu[index].id"
                            :placeholder="`${lang.placeholder_pre2}`" @change="getCycleList">
                            <el-option v-for="item in curPackageDetails.optional_gpu" :key="item.id" :label="item.value"
                              :value="item.id" :disabled="calcGpuDisabled(item)">
                            </el-option>
                          </el-select>
                          <el-input-number v-model="packageObj.optional_gpu[index].num" @change="getCycleList" :min="1"
                            :max="calcGpuMax(item)" :precision="0" class="config-number">
                          </el-input-number>
                          <i class="el-icon-remove-outline del" @click="delConfig('optional_gpu', index)"></i>
                        </div>
                      </div>
                      <div class="tip-box">
                        <p class="add" @click="checkOption('optional_gpu')" v-if="showAddGpu">
                          <i class="el-icon-circle-plus-outline icon"></i>
                          <span>{{lang.increase_gpu}}</span>
                        </p>
                        <span class="tip" v-if="curPackageDetails.max_gpu_num !== 0">{{lang.mf_dcim_tip1}}<span
                            class="num">{{calcGpuNum}}</span>{{lang.mf_dcim_tip12}}</span>
                      </div>
                    </el-form-item>
                  </template>
                </template>

                <el-form-item :label="lang.common_cloud_title15" v-if="!showFlexIp && packageObj.id > 0">
                  <span class="only-show">
                    {{params.ip_num}}{{lang.mf_one}}
                  </span>
                  <span
                    class="only-show-tip">{{lang.mf_dcim_tip10}}{{lang.common_cloud_title15}}{{lang.common_cloud_btn16}}。{{lang.mf_dcim_tip11}}</span>
                </el-form-item>
                <!-- IP数量 -->
                <el-form-item :label="lang.common_cloud_title15" v-if="showFlexIp">
                  <el-radio-group v-model="ipName" @input="changeIp($event)">
                    <!-- calcIpUnit(c.value) -->
                    <!-- :disabled="cloudData.model_config.id > 0 && disabledIp(c.value)" -->
                    <el-radio-button :label="c.desc" v-for="(c,cInd) in calcIPList" :key="cInd">
                    </el-radio-button>
                  </el-radio-group>
                </el-form-item>
                <!-- 带宽 -->
                <!-- 灵活机型 -->
                <el-form-item :label="lang.mf_bw" v-if="!showFlexBw && packageObj.id > 0">
                  <span class="only-show">
                    {{params.bw}}M
                  </span>
                  <span
                    class="only-show-tip">{{lang.mf_dcim_tip10}}{{lang.mf_bw}}{{lang.common_cloud_btn16}}。{{lang.mf_dcim_tip11}}</span>
                </el-form-item>
                <template v-if="showFlexBw">
                  <el-form-item :label="lang.mf_bw" v-if="lineDetail.bill_type === 'bw' && lineDetail.bw.length > 0">
                    <!-- 单选 -->
                    <el-radio-group v-model="params.bw" v-if="lineDetail.bw[0].type === 'radio'" @input="changeBw">
                      <el-radio-button :label="c.value === 'NC' ? 'NC' : c.value * 1" v-for="(c,cInd) in calcBwRange"
                        :key="cInd" :class="{'com-dis': c.disabled}">
                        {{c.value === 'NC' ? c.value_show == '' ? lang.actual_bw : c.value_show : (c.value + 'M')}}
                      </el-radio-button>
                    </el-radio-group>
                    <!-- 拖动框 -->
                    <el-tooltip effect="light" v-else :content="lang.mf_range + bwTip" placement="top-end">
                      <div class="slider-box" v-if="calcBwRange.length > 0">
                        <el-slider v-model="params.bw" :step="1" :show-tooltip="false" :min="calcBwRange[0] * 1"
                          :max="calcBwRange[calcBwRange.length -1] * 1" @change="changeBwNum">
                        </el-slider>
                        <el-input-number v-model="params.bw" @change="changeBwNum" :min="calcBwRange[0] * 1"
                          :max="calcBwRange[calcBwRange.length -1] * 1" size="small">
                        </el-input-number>
                      </div>
                    </el-tooltip>
                  </el-form-item>
                  <el-form-item label=" " v-if="lineDetail.bw && lineDetail.bw[0].type !== 'radio'">
                    <div class="marks">
                      <!-- <span class="item" v-for="(item,index) in Object.keys(bwMarks)">{{bwMarks[item]}}Mbps</span> -->
                      <span class="item">{{calcBwRange[0]}}M</span>
                      <span class="item">{{calcBwRange[calcBwRange.length - 1]}}M</span>
                    </div>
                  </el-form-item>
                </template>
                <!-- 流量 -->
                <el-form-item :label="lang.mf_flow"
                  v-if="lineDetail.bill_type === 'flow' && lineDetail.flow.length > 0">
                  <el-radio-group v-model="params.flow" @input="changeFlow">
                    <el-radio-button :label="c.value * 1" v-for="(c,cInd) in calcFlowList" :key="cInd">
                      {{c.value > 0 ? (c.value + 'G') : lang.mf_tip28}}
                    </el-radio-button>
                  </el-radio-group>
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
            </div>

            <div class="dialog-footer">
              <div class="footer-top">
                <div class="money-text">{{lang.common_cloud_btn37}}：</div>
                <div class="money" v-loading="upgradePriceLoading">
                  <span class="money-num">{{commonData.currency_prefix }} {{ (upParams.totalPrice * 1).toFixed(2) |
                    filterMoney}}</span>
                  <el-popover placement="top-start" width="200" trigger="hover"
                    v-if="isShowLevel || (isShowPromo && upParams.isUseDiscountCode) || isShowCash">
                    <div class="show-config-list">
                      <p v-if="isShowLevel">{{lang.shoppingCar_tip_text2}}：{{commonData.currency_prefix}} {{
                        upParams.clDiscount | filterMoney }}</p>
                      <p v-if="isShowPromo && upParams.isUseDiscountCode">
                        {{lang.shoppingCar_tip_text4}}：{{commonData.currency_prefix}} {{ upParams.code_discount |
                        filterMoney}}</p>
                      <p v-if="isShowCash && upParams.customfield.voucher_get_id">
                        {{lang.shoppingCar_tip_text5}}：{{commonData.currency_prefix}}
                        {{ upParams.cash_discount | filterMoney}}</p>
                    </div>
                    <i class="el-icon-warning-outline total-icon" slot="reference"></i>
                  </el-popover>
                  <p class="original-price" v-if="upParams.totalPrice != upParams.original_price">
                    {{commonData.currency_prefix}} {{ (upParams.original_price * 1).toFixed(2) | filterMoney}}</p>
                  <div class="code-box">
                    <!-- 代金券 -->
                    <!-- <cash-coupon ref="cashRef" v-show="isShowCash && !cashObj.code"
                      :currency_prefix="commonData.currency_prefix" @use-cash="upUseCash" scene='upgrade'
                      :product_id="[product_id]" :price="upParams.original_price"></cash-coupon> -->
                    <!-- 优惠码 -->
                    <!-- <discount-code v-show="isShowPromo && !upParams.customfield.promo_code  "
                      @get-discount="getUpDiscount(arguments)" scene='upgrade' :product_id="product_id"
                      :amount="upParams.original_price"
                      :billing_cycle_time="hostData.billing_cycle_time"></discount-code> -->
                  </div>
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
                <div class="btn-ok" @click="upgradeSub" v-loading="loading4">{{lang.finance_btn6}}</div>
                <div class="btn-no" @click="upgradeDgClose">{{lang.finance_btn7}}</div>
              </div>
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
  <script src="/themes/clientarea/default/v10/api/dcim.js"></script>
  <script src="/themes/clientarea/default/v10/resource/echarts.min.js"></script>
  <script src="/themes/clientarea/default/v10/js/dcimDetail.js"></script>
</body>

</html>
