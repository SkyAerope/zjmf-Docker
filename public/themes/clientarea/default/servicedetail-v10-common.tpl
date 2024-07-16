<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport"
    content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <title></title>
  <link rel="stylesheet" href="/themes/clientarea/default/v10/resource/element.css">
  <link rel="stylesheet" href="/themes/clientarea/default/v10/css/cloudTop.css">
  <link rel="stylesheet" href="/themes/clientarea/default/v10/css/common_product_detail.css">
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
  <div class="template" id="product_detail_common" v-cloak>
    <!-- 自己的东西 -->
    <div class="main-card common_product_detail">
      <div class="main-card-title">
        <div class="left">
          <img @click="goBack" class="back-img" src="/themes/clientarea/default/v10/img/back.png" />
          <span class="title">{{host.name}}</span>
          <span class="tag" @click="goPay" :class="host.status" v-if="hostData?.status"
            :style="'color:'+status[hostData.status]?.color + ';background:' + status[hostData.status]?.bgColor">{{status[hostData.status].text}}</span>
          <!-- <span class="up-authorization" @click="handelUpLicense" v-loading="upgradeLoading"
            v-if="hostData?.status && hostData.status === 'Active'">{{lang.common_cloud_btn16}}</span> -->
        </div>
        <span class="on-off">
          <img
            :src="'/themes/clientarea/default/v10/img/'+postPowerStatus+'.png'"
            :title="statusText" v-show="(postPowerStatus != 'operating') && (postPowerStatus != 'fault')"
            slot="reference" />
          <i class="el-icon-loading" :title="lang.common_cloud_text12" v-show="postPowerStatus == 'operating'"></i>
          <img
            :src="'/themes/clientarea/default/v10/img/'+postPowerStatus+'.png'"
            :title="statusText" v-show="postPowerStatus == 'fault'" />
        </span>
      </div>
      <!-- 备注 -->
      <div class="notes">
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
      <div class="finance-info">
        <div class="status-box">
          <p class="s-tit">{{lang.menu_3}}</p>
          <template>
            <!-- 财务信息 -->
            <p class="stop-info"
              v-if="(refundInfo?.status === 'Suspending' || refundInfo?.status === 'Suspend' || refundInfo?.status === 'Suspended') && refundInfo.type === 'Expire'">
              <span class="info">({{lang.common_cloud_text222}}{{refundInfo.create_time |
                formateTime}}{{lang.common_cloud_text223}}{{host.due_time |
                formateTime}}{{lang.common_cloud_text224}})</span>
            </p>
            <p class="stop-info" v-if="refundInfo?.status === 'Reject'">
              <span class="info reject">({{lang.common_cloud_text222}}{{refundInfo.create_time |
                formateTime}}{{lang.common_cloud_text225}}
                <el-tooltip class="item" :content="refundInfo.reject_reason" placement="top">
                  <a href="javascript:;">{{lang.common_cloud_text226}}</a>
                </el-tooltip>
                )
              </span>
            </p>
          </template>
        </div>
        <div class="box">
          <div class="item">
            <span class="label">{{lang.active_time}}：</span>
            <span>{{hostData.active_time | formateTime}}</span>
          </div>
          <div class="item">
            <span class="label">{{lang.common_cloud_label38}}：</span>
            <span>{{commonData.currency_prefix}}{{hostData.first_payment_amount}}{{commonData.currency_suffix}}</span>
            <span @click="applyCashback" class="common-cashback" v-if="isShowCashBtn">{{lang.apply_cashback}}</span>
          </div>
          <div class="item">
            <span class="label">{{lang.common_cloud_text144}}：</span>
            <span>{{hostData.due_time | formateTime}}</span>

          </div>
          <div class="item">
            <span class="label">{{lang.finance_label12}}：</span>
            <span>{{hostData.name}}</span>
          </div>
          <div class="item" v-if="host.dedicatedip">
            <span class="label">{{lang.da_ip}}：</span>
            <span>{{host.dedicatedip}}</span>
          </div>
          <div class="item" v-if="host.username">
            <span class="label">{{lang.common_cloud_label14}}：</span>
            <span>{{host.username}}</span>
          </div>
          <div class="item" v-if="host.password">
            <span class="label">{{lang.common_cloud_label7}}：</span>
            <span v-if="isShowPass">{{host.password}}</span>
            <span v-else>*******</span>
            <img class="eyes"
              :src="isShowPass?'/themes/clientarea/default/v10/img/pass-show.png':'/themes/clientarea/default/v10/img/pass-hide.png'"
              @click="isShowPass=!isShowPass" />
            <i class="el-icon-document-copy" style="font-size: 14px; margin-left: 3px; cursor: pointer; color: #0052D9;"
              @click="copyPass(host.password)"></i>
          </div>
          <div class="item" v-if="host.os">
            <span class="label">{{lang.cloud_os}}：</span>
            <span>{{host.os}}</span>
          </div>

          <div class="item">
            <span class="label">{{lang.finance_label26}}：</span>
            <span>{{commonData.currency_prefix}}{{showRenewPrice}}{{commonData.currency_suffix}}/{{hostData.billing_cycle_name}}</span>
            <!-- 非tingyong -->

            <template v-if="hostData?.status==='Active' || hostData?.status==='Suspended'">

              <span class="renew btn" @click="showRenew"
                v-if="(!refundInfo || refundInfo || (refundInfo && refundInfo.status=='Cancelled') || (refundInfo && refundInfo.status=='Reject')) && (host.billing_cycle !== 'onetime' && host.billing_cycle !== 'free')">{{lang.cloud_re_btn}}</span>
              <span class="disabeld btn" v-else>{{lang.cloud_re_btn}}</span>
              <!-- <span class="war btn"
                v-if="refundInfo && refundInfo.status != 'Cancelled' && refundInfo.status != 'Reject'">{{refundStatus[refundInfo.status]}}</span> -->
               <!-- 取消停用 -->
                <span class="war btn refund-stop-btn"v-if="refundData.is_cancel"
                @click="cancelRefund">{{lang.common_cloud_btn8}}</span>
              <span class="cancel btn" @click="stop_use" v-if="!refundData.is_cancel">{{lang.common_cloud_title12}}</span>
            </template>
          </div>
          <div class="item" v-show="hostData.status == 'Active'">
            <span class="label">{{lang.auto_renew}}：</span>
            <el-switch :value="isShowPayMsg" active-color="#0052D9" :active-value="1" :inactive-value="0"
              @change="changeAutoStatus">
            </el-switch>
            <el-popover placement="top" trigger="hover">
              <div class="sure-remind">{{lang.common_cloud_tip15}}</div>
              <div class="help" slot="reference">?</div>
            </el-popover>
          </div>
          <div class="item">
            <span class="label">{{lang.cloud_code}}：</span>
            <span v-if="promo_code.length > 0">
              <span v-for="(item,index) in promo_code" :key="item">{{item}}
                <span v-if="index !== 0">;</span>
              </span>
            </span>
            <span v-else>--</span>
          </div>
          <div class="item">

          </div>
        </div>
      </div>
      <!-- 基础信息 -->
      <el-tabs class="tabs" v-model="activeName" @tab-click="handleClick"
        v-show="hostData.status == 'Active' && !initLoading">
        <el-tab-pane :label="lang.common_cloud_text227" name="0">
          <div class="basic-info">
            <div class="box">
              <div class="item" v-for="(item,index) in firstInfo" :key="index"
                :class="{'last_item': (firstInfo.length + self_defined_field.length) % 2 !== 0 && index  === firstInfo.length - 2 && self_defined_field.length === 0}">
                <p @mouseenter="e=>checkWidth(e,index)" @mouseout="hideTip(index)" v-if="!item.show" class="name">
                  {{item.option_name}}
                </p>
                <el-tooltip class="item" :content="item.option_name" placement="top" v-if="item.show">
                  <p class="name">{{item.option_name}}</p>
                </el-tooltip>

                <div class="r-info">
                  <span class="s-item" v-if="item.option_type === 'quantity' || item.option_type === 'quantity_range'">
                    {{item.qty}}
                  </span>
                  <span class="s-item" v-for="(el,ind) in item.subs" :key="ind">
                    <img :src="`/upload/common/country/${el.country}.png`" alt="" v-if="item.option_type ==='area'">
                    <template v-if="item.option_type ==='area'">
                      {{calcCountry(el.country)}}&nbsp;-
                    </template>
                    {{el.option_name}}
                  </span>
                  <span>{{item.unit}}</span>
                </div>
              </div>
              <div class="item" v-for="(item,index) in self_defined_field" :key="item.id"
                :class="{'last_item': (firstInfo.length + self_defined_field.length) % 2 !== 0 && (index + firstInfo.length) === (firstInfo.length + self_defined_field.length) - 2}">
                <p class="name">{{item.field_name}}</p>
                <div class="r-info">
                  <span class="s-item ">
                    <span v-if="item.field_type === 'password'">
                      <span v-if="!item.hidenPass && item.value">{{item.value.replace(/./g, '*')}}</span>
                      <span v-else>{{item.value || '--'}}</span>
                    </span>
                    <span v-else-if="item.field_type === 'textarea'" class="word-pre">{{item.value || '--'}}</span>
                    <span v-else>{{item.value || '--'}}</span>
                    <img class="eyes" v-if="item.field_type === 'password' && item.value"
                      :src="item.hidenPass ? '/themes/clientarea/default/v10/img/pass-show.png' :
                      '/themes/clientarea/default/v10/img/pass-hide.png'"
                      @click="item.hidenPass=! item.hidenPass" />
                    <i class="el-icon-document-copy"
                      v-if="(item.field_type === 'password' || item.field_type === 'link') && item.value"
                      style="font-size: 14px; margin-left: 3px; cursor: pointer; color: #0052D9;"
                      @click="copyPass(item.value)"></i>
                  </span>
                </div>
              </div>
            </div>
          </div>
        </el-tab-pane>
        <template v-if="chartData.length > 0">
          <el-tab-pane :label="lang.common_cloud_tab1" name="1">
            <el-select class="time-select" v-model="chartSelectValue" @change="chartSelectChange">
              <el-option value='1' :label="lang.common_cloud_label15"></el-option>
              <el-option value='2' :label="lang.common_cloud_label16"></el-option>
              <el-option value='3' :label="lang.common_cloud_label17"></el-option>
            </el-select>
            <div class="echart-main">
              <div class="echart-item" :class="{'has-select': item.select.length > 0}" v-for="(item,index) in chartData"
                :key="index" v-loading="item.loading">
                <el-select v-if="item.select.length > 0" v-model="item.selectValue" @change="getChartList">
                  <el-option v-for="items in item.select" :key="items.value" :value="items.value"
                    :label="items.name"></el-option>
                </el-select>
                <div :id="`${index}-echart`" class="my-echart"></div>
              </div>
            </div>
          </el-tab-pane>
        </template>
        <template v-if="powerList.length > 0">
          <el-tab-pane :label="lang.common_cloud_tab2" name="2">
            <!-- 管理 -->
            <div class="manage-content">
              <div class="manage-item">
                <div class="item-top">
                  <el-select v-model="powerStatus">
                    <el-option v-for="item in powerList" :key="item.func" :value="item.func"
                      :label="item.name"></el-option>
                  </el-select>
                  <div class="item-top-btn" @click="showPowerDialog" v-loading="loading1">
                    {{lang.common_cloud_btn10}}
                  </div>
                </div>
                <div class="item-bottom">
                  <div class="bottom-row">{{lang.common_cloud_tip16}}</div>
                </div>
              </div>
              <div class="manage-item" v-for="item in consoleList" :key="item.func">
                <div class="item-top-btn" @click="handelConsole(item)">
                  {{item.name}}
                </div>
                <div class="item-bottom">
                  <template v-if="item.func === 'crack_pass'">
                    <div class="bottom-row">{{lang.common_cloud_tip19}}</div>
                    <div class="bottom-row">{{lang.common_cloud_tip20}}</div>
                  </template>
                  <template v-if="item.func === 'reinstall'">
                    <div class="bottom-row">{{lang.common_cloud_tip23}}</div>
                  </template>
                  <template v-if="item.func === 'vnc'">
                    <div class="bottom-row">{{lang.common_cloud_tip17}}</div>
                    <div class="bottom-row">{{lang.common_cloud_tip18}}</div>
                  </template>
                </div>
              </div>

            </div>
          </el-tab-pane>
        </template>
        <el-tab-pane v-for="(item,index) in client_area" :label="item.name" :name="index + 3 + ''"
          :key="index + item.name">
          <div v-if="activeName === index + 3 + ''" :id="`arae-${index + 3 + ''}`" :key="index + item.name"></div>
        </el-tab-pane>
        <!-- 日志 -->
        <el-tab-pane :label="lang.common_cloud_tab6" name="log">
          <div class="log">
            <div class="main_table">
              <el-table v-loading="logLoading" :data="logDataList" style="width: 100%; margin-bottom: 20px">
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


      <!-- 续费弹窗 -->
      <div class="renew-dialog">
        <el-dialog width="690px" :visible.sync="isShowRenew" :show-close=false @close="renewDgClose">
          <div class="dialog-title">{{lang.common_cloud_text179}}</div>
          <div class="dialog-main">
            <div class="renew-content">
              <div class="renew-item" v-for="(item,index) in renewPageData" :key="index"
                :class="renewActiveId == index ? 'renew-active' : ''" @click="renewItemChange(item,index)">
                <div class="item-top">{{item.billing_cycle}}</div>
                <div class="item-bottom" v-if="isShowPromo && isUseDiscountCode">{{commonData.currency_prefix +
                  item.base_price}}</div>
                <div class="item-bottom" v-else>{{commonData.currency_prefix + item.price}}</div>
                <div class="item-origin-price" v-if="item.price*1 < item.base_price*1 && !isUseDiscountCode">
                  {{commonData.currency_prefix + item.base_price}}
                </div>
                <i class="el-icon-check check" v-show="renewActiveId == index"></i>
              </div>
            </div>
          </div>
          <div class="pay-content">
            <div class="pay-price">
              <div class="money" v-loading="renewLoading">
                <span
                  class="text">{{lang.common_cloud_label11}}:</span><span>{{commonData.currency_prefix}}{{renewParams.totalPrice
                  | filterMoney}}</span>
                <el-popover placement="top-start" width="200" trigger="hover"
                  v-if="(isShowLevel && renewParams.clDiscount*1 > 0) || (isShowPromo && isUseDiscountCode) || ( isShowCash && customfield.voucher_get_id)">
                  <div class="show-config-list">
                    <p v-if="isShowLevel && renewParams.clDiscount*1 > 0">
                      {{lang.shoppingCar_tip_text2}}：{{commonData.currency_prefix}} {{renewParams.clDiscount |
                      filterMoney}}
                    </p>
                    <p v-if="isShowPromo && isUseDiscountCode">
                      {{lang.shoppingCar_tip_text4}}：{{commonData.currency_prefix}} {{ renewParams.code_discount |
                      filterMoney }}
                    </p>
                    <p v-if="isShowCash && customfield.voucher_get_id">
                      {{lang.shoppingCar_tip_text5}}：{{commonData.currency_prefix}} {{ renewParams.cash_discount |
                      filterMoney}}
                    </p>
                  </div>
                  <i class="el-icon-warning-outline total-icon" slot="reference"></i>
                </el-popover>
                <p class="original-price"
                  v-if="customfield.promo_code && renewParams.totalPrice != renewParams.base_price">
                  {{commonData.currency_prefix}} {{ renewParams.base_price | filterMoney}}
                </p>
                <p class="original-price"
                  v-if="!customfield.promo_code && renewParams.totalPrice != renewParams.original_price">
                  {{commonData.currency_prefix}} {{ renewParams.original_price | filterMoney}}
                </p>
                <!-- <div class="code-box">
                  <cash-coupon ref="cashRef" v-show=" isShowCash && !cashObj.code"
                    :currency_prefix="commonData.currency_prefix" @use-cash="reUseCash" scene='renew'
                    :product_id="[product_id]" :price="renewParams.original_price"></cash-coupon>
                  <discount-code v-show="isShowPromo && !customfield.promo_code" @get-discount="getDiscount(arguments)"
                    scene='renew' :product_id="product_id" :amount="renewParams.base_price"
                    :billing_cycle_time="renewParams.duration"></discount-code>
                </div> -->
                <div class="code-number-text">
                  <div class="discount-codeNumber" v-show="customfield.promo_code">{{ customfield.promo_code }}<i
                      class="el-icon-circle-close remove-discountCode" @click="removeDiscountCode()"></i></div>
                  <div class="cash-codeNumber" v-show="cashObj.code">{{ cashObj.code }}<i
                      class="el-icon-circle-close remove-discountCode" @click="reRemoveCashCode()"></i></div>
                </div>
              </div>
            </div>
          </div>
          <div class="dialog-footer">
            <el-button class="btn-ok" @click="subRenew" :loading="loading">{{lang.common_cloud_text180}}</el-button>
            <div class="btn-no" @click="renewDgClose">{{lang.common_cloud_text181}}</div>
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
                <el-option v-for="item in osData.subs" :key='item.os' :value="item.os" :label="item.os">
                  <div class="option-label">
                    <img class="option-img"
                      :src="'/themes/clientarea/default/v10/img/' + item.os + '.svg'"
                      alt="">
                    <span class="option-text">{{item.os}}</span>
                  </div>
                </el-option>
              </el-select>
              <!-- 镜像实际选择框 -->
              <el-select class="os-select" v-model="reinstallData.osId" @change="osSelectChange">
                <el-option v-for="item in osSelectData" :key="item.id" :value="item.id"
                  :label="item.option_name"></el-option>
              </el-select>
            </div>
            <div class="alert">
              <el-alert :title="errText" type="error" show-icon :closable="false" v-show="errText">
              </el-alert>
            </div>
          </div>
          <div class="dialog-footer">
            <div class="btn-ok" @click="doReinstall">{{lang.common_cloud_btn28}}</div>
            <div class="btn-no" @click="reinstallDgClose">{{lang.common_cloud_btn29}}</div>
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

            <!-- <el-input style="margin-top: 20px;" class="pass-input" v-model="rePassData.code" :placeholder="lang.account_tips33" v-if="cloudConfig.reset_password_sms_verify === 1">
          <div class="pass-btn" slot="suffix" v-if="isSendCodeing">{{sendTime}}{{lang.account_tips54}}</div>
          <div class="pass-btn" slot="suffix" v-loading="sendFlag" @click="sendCode" v-else>{{lang.account_tips55}}
          </div>
        </el-input> -->
            <!-- <div class="alert" v-show="powerStatus=='off'">
          <div class="title">{{lang.common_cloud_tip30}}</div>
          <div class="row"><span class="dot"></span> {{lang.common_cloud_tip31}}</div>
          <div class="row"><span class="dot"></span> {{lang.common_cloud_tip32}}
          </div>
        </div> -->
            <!-- <el-checkbox v-model="rePassData.checked" v-show="powerStatus=='off'">{{lang.common_cloud_text24}}</el-checkbox> -->
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
            <div class="btn-ok" @click="toChangePower">{{lang.common_cloud_btn28}}</div>
            <div class="btn-no" @click="powerDgClose">{{lang.common_cloud_btn29}}</div>
          </div>
        </el-dialog>
      </div>

      <!-- 停用弹窗 -->
      <el-dialog :title="refundDialog.allow_refund == 1 ? lang.common_cloud_title11 : lang.common_cloud_title12"
        :visible.sync="refundVisible" class="refundDialog" :show-close="false">
        <el-form :model="refundForm" label-position="top">
          <p class="tit">{{lang.common_cloud_label35}}</p>
          <div class="info">
            <div class="des">
              <div class="item">
                <p class="s-tit">{{lang.common_cloud_label36}}：</p>
                <div class="config">
                  <div class="s-item" v-for="(item,index) in configoptions" :key="index" style="display: flex;">
                    <p class="name">{{item.option_name}}：</p>
                    <div class="r-info">
                      <span class="s-item"
                        v-if="item.option_type === 'quantity' || item.option_type === 'quantity_range'">
                        {{item.qty}}
                      </span>
                      <span class="s-item" v-for="(el,ind) in item.subs" :key="ind">
                        <img :src="`/upload/common/country/${el.country}.png`" alt="" v-if="item.option_type ==='area'"
                          style="width: 20px;">
                        {{el.option_name}}
                      </span>
                    </div>
                    <span>{{item.unit}}</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <p class="s-tit">{{lang.common_cloud_label37}}: </p>
                <div class="right">{{hostData.active_time | formateTime}}</div>
              </div>
              <div class="item" v-if="refundDialog.allow_refund == 1">
                <p class="s-tit">{{lang.common_cloud_label38}}: </p>
                <div class="config">
                  {{commonData.currency_prefix}}{{refundDialog?.host?.first_payment_amount}}
                </div>
              </div>
            </div>
          </div>
          <el-form-item :label="lang.common_cloud_label39">
            <el-select v-model="refundForm.arr" v-if="refundDialog.reason_custom == 0" style="width: 100%;" multiple>
              <el-option :label="item.content" :value="item.id" v-for="item in refundDialog.reasons"
                :key="item.id"></el-option>
            </el-select>
            <el-input v-model="refundForm.suspend_reason" v-else :placeholder="lang.common_cloud_label44"></el-input>
          </el-form-item>
          <el-form-item :label="lang.common_cloud_label40">
            <el-select v-model="refundForm.type" @change="changeReson">
              <el-option :label="lang.common_cloud_label41" value="Endofbilling"></el-option>
              <el-option :label="lang.common_cloud_label42" value="Immediate"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <p class="tit" v-if="refundDialog.allow_refund == 1">{{lang.common_cloud_label43}}</p>
        <p class="money" v-if="refundDialog.allow_refund == 1">{{commonData.currency_prefix}}{{refundMoney}}</p>
        <div slot="footer" class="dialog-footer">
          <el-button type="primary" @click="submitRefund" :loading="loading">{{refundDialog.allow_refund ===1 ?
            lang.common_cloud_btn31 : lang.common_cloud_btn32}}</el-button>
          <el-button @click="refundVisible = false">{{lang.common_cloud_btn29}}</el-button>
        </div>
      </el-dialog>

      <!-- 不允许退款 -->

      <el-dialog title="" :visible.sync="noRefundVisible" class="no-allow" :show-close="false">
        <img :src="`/themes/clientarea/default/v10/img/close.png`" alt="">
        <span class="tit">{{lang.common_cloud_btn64}}</span>
        <span class="des">{{lang.common_cloud_btn65}}<br />{{lang.common_cloud_btn66}}</span>
        <span slot="footer" class="dialog-footer">
          <el-button type="primary" @click="noRefundVisible = false">{{lang.common_cloud_btn34}}</el-button>
        </span>
      </el-dialog>

      <!-- 支付弹窗 -->
      <!-- <pay-dialog ref="payDialog" @payok="paySuccess" @paycancel="payCancel"></pay-dialog> -->
      <!-- 修改备注弹窗 -->
      <div class="notes-dialog">
        <el-dialog width="620px" :visible.sync="isShowNotesDialog" :show-close=false @close="notesDgClose">
          <div class="dialog-title">
            {{hostData.notes ? lang.common_cloud_title7 : lang.common_cloud_text183}}
          </div>
          <div class="dialog-main">
            <div class="label">{{lang.common_cloud_text184}}</div>
            <el-input class="notes-input" v-model="notesValue"></el-input>
          </div>
          <div class="dialog-footer">
            <div class="btn-ok" @click="subNotes">{{lang.common_cloud_text185}}</div>
            <div class="btn-no" @click="notesDgClose">{{lang.common_cloud_btn29}}</div>
          </div>
        </el-dialog>
      </div>

      <!-- 自动续费 -->
      <el-dialog :visible.sync="dialogVisible" width="620px;" custom-class="autoDialog" :show-close="false">
        <span class="title">{{autoTitle}}</span>
        <div class="dialog-main">
          <div class="label">{{lang.fin_host}}</div>
          <div class="value">{{hostData.name}}</div>
        </div>
        <div slot="footer" class="dialog-footer">
          <div type="primary" @click="changeAuto" class="btn-ok">{{lang.common_cloud_btn28}}</div>
          <div @click="dialogVisible = false" class="btn-no">{{lang.common_cloud_btn29}}</div>
        </div>
      </el-dialog>

      <!-- 申请返现 -->
      <!-- <cash-back :id="id" :show-cash="isShowCashDialog" @cancledialog="cancleDialog" @showbtn="showBtn"></cash-back> -->

      <!-- 升降级弹窗 -->
      <el-dialog class="up-License" :visible.sync="upLicenseDialogShow" width="1200px" :show-close="false"
        :close-on-click-modal="false">
        <div class="license-title">{{lang.common_cloud_btn16}}</div>
        <div class="license-box">
          <el-tabs v-model="licenseActive" @tab-click="handleTabClick">
            <el-tab-pane :label="lang.common_cloud_text228" name="1" v-if="isShowUp">
              <div class="lincense-div">
                <div class="now-lincense">
                  <div class="lincense-text">{{lang.common_cloud_text229}}</div>
                  <div class="lincense-content">
                    <div class="content-title">{{upgradeHost.name}}</div>
                    <div class="content-box">
                      <div class="content-item" v-for="(item,index) in upgradeConfig" :key="index + 'upgradeConfig'">
                        {{item.option_name}}
                        <span
                          v-if="item.option_type ==='quantity_range' || item.option_type ==='quantity'">{{item.qty}}</span>
                        <span v-else>{{item.sub_name}}</span>
                        {{item.unit}}
                      </div>
                      <div class="content-item" v-for="(item,index) in upgradeSon_host"
                        :key="index + 'upgradeSon_host'">
                        {{lang.common_cloud_text162}}
                        <span>{{lang.common_cloud_text163}}</span>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 升级列表 -->
                <div class="can-upLincense">
                  <div class="lincense-text">{{lang.common_cloud_text230}}</div>
                  <div class="canUp-box">
                    <div class="canUp-content">
                      <div class="canUp-name" v-for="(item,index) in upgradeList" :key="index"
                        @click="selectUpItem(index)" :class="selectUpIndex === index ? 'select-content' : ''">
                        {{item.common_product?.name}}
                      </div>
                    </div>
                    <div class="config-box">
                      <div class="l-config">
                        <!-- <div class="description" v-html="calStr" v-if="calStr"></div> -->
                        <!-- 自定义配置项 -->
                        <div class="config-item" v-for="(item,index) in configoptions" :key="index">
                          <p class="config-tit">{{item.option_name}}</p>
                          <!-- 配置项 -->
                          <div class="config-way">
                            <!-- 下拉单选/多选 -->
                            <el-select v-model="configForm[item.id]" :placeholder="lang.please_select"
                              v-if="item.option_type === 'select' || item.option_type ==='multi_select'"
                              :multiple="item.option_type ==='multi_select'" collapse-tags @change="changeItem(item)">
                              <el-option v-for="(item,index) in item.subs" :key="index" :label="item.option_name"
                                :value="item.id">
                              </el-option>
                            </el-select>
                            <!-- 是否 -->
                            <el-switch v-model="configForm[item.id]" v-if="item.option_type ==='yes_no'"
                              active-color="#0052D9" :active-value="calcSwitch(item,true)"
                              :inactive-value="calcSwitch(item,false)" @change="changeConfig(false)">
                            </el-switch>
                            <!-- 数据输入 -->
                            <el-input-number v-model.number="configForm[item.id]" :min="item.qty_min"
                              :max="item.qty_max" v-if="item.option_type ==='quantity'"
                              @change="(val)=>fatherChange(val,item)">
                            </el-input-number>
                            <!-- 数量拖动 -->
                            <div class="slider" v-if="item.option_type ==='quantity_range'">
                              <span class="min">{{item.qty_min}}~</span>
                              <span class="max">{{item.qty_max}}</span>
                              <el-slider show-input :show-input-controls="false"
                                v-if="configForm[item.id] && configForm[item.id].length !==0"
                                v-model.number="configForm[item.id][0]" @change="(val)=>fatherChange(val,item)"
                                :min="item.qty_min" :max="item.qty_max" :step="item.subs[0]?.qty_change || 1">
                              </el-slider>
                            </div>
                            <!-- 点击单选 -->
                            <div class="click-select" v-if="item.option_type ==='radio'">
                              <div class="item" v-for="(el,index) in item.subs" :key="index"
                                :class="{'com-active': el.id === configForm[item.id]}"
                                @click="changeClick(item.id, el)">
                                {{el.option_name}}
                                <i class="el-icon-check"></i>
                              </div>
                            </div>
                            <!-- 区域选择 -->
                            <div class="area-box" v-if="item.option_type ==='area'">
                              <p class="tit">{{lang.account_label4}}</p>
                              <div class="country">
                                <div class="item" v-for="(el,index) in filterCountry[item.id]" :key="index"
                                  :class="{'com-active': index  === curCountry[item.id] }"
                                  @click="changeCountry(item.id,index)">
                                  <img :src="`/upload/common/country/${el[0].country}.png`" alt="">
                                  <span>{{calcCountry(el[0].country)}}</span>
                                  <i class="el-icon-check"></i>
                                </div>
                              </div>
                              <p class="tit">{{lang.city}}</p>
                              <div class="city">
                                <div class="item" v-for="(el,index) in filterCountry[item.id][curCountry[item.id]]"
                                  :key="index" :class="{'com-active': el.id  === configForm[item.id] }"
                                  @click="changeCity(el, item.id)">
                                  <img :src="`/upload/common/country/${el.country}.png`" alt="">
                                  <span>{{el.option_name}}</span>
                                  <i class="el-icon-check"></i>
                                </div>
                              </div>
                            </div>
                            <!-- 后缀单位 -->
                            <span class="unit">{{item.unit}}</span>
                          </div>
                          <!-- 描述 -->
                          <!-- <p class="des" v-if="item.option_type !== 'area' && item.description" v-html="calcDes(item.description)"> -->
                          </p>
                        </div>
                        <!-- 周期 -->
                        <div class="config-item">
                          <p class="config-tit">{{lang.cycle}}</p>
                          <div class="onetime cycle" v-if="basicInfo.pay_type && basicInfo.pay_type === 'onetime'">
                            <div class="item com-active">
                              <p class="name">{{lang.common_cloud_text6}}</p>
                              <p class="price">{{commonData.currency_prefix}}{{onetime}}</p>
                              <i class="el-icon-check"></i>
                            </div>
                          </div>
                          <div class="onetime cycle" v-if="basicInfo.pay_type && basicInfo.pay_type === 'free'">
                            <div class="item com-active">
                              <p class="name">{{lang.product_free}}</p>
                              <p class="price">{{commonData.currency_prefix}}0.00</p>
                              <i class="el-icon-check"></i>
                            </div>
                          </div>
                          <div class="cycle"
                            v-if="basicInfo.pay_type && (basicInfo.pay_type === 'recurring_prepayment' || basicInfo.pay_type === 'recurring_postpaid')">
                            <div class="item" v-for="(item,index) in custom_cycles" :key="index"
                              @click="changeCycle(item,index)" :class="{'com-active': index === curCycle }">
                              <p class="name">{{item?.name}}</p>
                              <p class="price">{{commonData.currency_prefix}}{{((item.cycle_amount !== '' ?
                                item.cycle_amount : item.amount) * 1).toFixed(2) | filterMoney}}</p>
                              <i class="el-icon-check"></i>
                            </div>
                          </div>
                        </div>
                        <div class="sub-box">
                          <!-- 循环展示子商品 -->
                          <div class="sub-item" v-for="(sub,index) in upSon" :key="index">
                            <div class="pro-tit">{{basicInfo?.name}}-{{sub.basicInfo?.name}}</div>
                            <el-switch v-model="sub.open" class="sub-switch" active-color="#0052D9"
                              @change="changeSub"></el-switch>
                            <div v-show="sub.open">
                              <!-- <div class="description" v-html="calcDes(sub.basicInfo?.order_page_description)" v-if="sub.basicInfo?.order_page_description"></div> -->
                              <!-- 自定义配置项 -->
                              <div class="config-item" v-for="(item,index) in sub.configoptions" :key="index">
                                <p class="config-tit">{{item.option_name}}</p>
                                <!-- 配置项 -->
                                <div class="config-way">
                                  <!-- 下拉单选/多选 -->
                                  <el-select v-model="sonConfigForm[index][item.id]" :placeholder="lang.please_select"
                                    v-if="item.option_type === 'select' || item.option_type ==='multi_select'"
                                    :multiple="item.option_type ==='multi_select'" collapse-tags
                                    @change="changeItem(item)">
                                    <el-option v-for="(item,index) in item.subs" :key="index" :label="item.option_name"
                                      :value="item.id">
                                    </el-option>
                                  </el-select>
                                  <!-- 是否 -->
                                  <el-switch v-model="sonConfigForm[index][item.id]" v-if="item.option_type ==='yes_no'"
                                    active-color="#0052D9" :active-value="calcSwitch(item,true)"
                                    :inactive-value="calcSwitch(item,false)" @change="changeConfig(false)">
                                  </el-switch>
                                  <!-- 数据输入 -->
                                  <el-input-number :disabled="sub.basicInfo.configoption_id > 0"
                                    v-model.number="sonConfigForm[index][item.id]" :min="item.qty_min"
                                    :max="item.qty_max" v-if="item.option_type ==='quantity'"
                                    @change="changeConfig(false)">
                                  </el-input-number>
                                  <!-- 数量拖动 -->
                                  <div class="slider" v-if="item.option_type ==='quantity_range'">
                                    <span class="min">{{item.qty_min}}~</span>
                                    <span class="max">{{item.qty_max}}</span>
                                    <el-slider show-input :show-input-controls="false"
                                      :disabled="sub.basicInfo.configoption_id > 0"
                                      v-if="sonConfigForm[index][item.id] && sonConfigForm[index][item.id].length !=0"
                                      v-model.number="sonConfigForm[index][item.id][0]"
                                      @change="(val)=>changeSonNum(val,item)" :min="item.qty_min" :max="item.qty_max"
                                      :step="item.subs[0]?.qty_change || 1">
                                    </el-slider>
                                  </div>
                                  <!-- 点击单选 -->
                                  <div class="click-select" v-if="item.option_type ==='radio'">
                                    <div class="item" v-for="(el,index) in item.subs" :key="index"
                                      :class="{'com-active': el.id === sonConfigForm[index][item.id]}"
                                      @click="changeClick(item.id, el)">
                                      {{el.option_name}}
                                      <i class="el-icon-check"></i>
                                    </div>
                                  </div>
                                  <!-- 区域选择 -->
                                  <div class="area-box" v-if="item.option_type ==='area'">
                                    <p class="tit">{{lang.account_label4}}</p>
                                    <div class="country">
                                      <div class="item" v-for="(el,aInd) in sonCountry[index][item.id]" :key="aInd"
                                        :class="{'com-active': aInd  === sonCurCountry[0][item.id *1] }"
                                        @click="changeSubCountry(item.id,index,aInd)">
                                        <img :src="`/upload/common/country/${el[0].country}.png`" alt="">
                                        <span>{{calcCountry(el[0].country)}}</span>
                                        <i class="el-icon-check"></i>
                                      </div>
                                    </div>
                                    <p class="tit">{{lang.city}}</p>
                                    <div class="city">
                                      <div class="item"
                                        v-for="(el,aInd) in sonCountry[index][item.id][sonCurCountry[0][item.id]]"
                                        :key="aInd" :class="{'com-active': el.id  === sonConfigForm[index][item.id] }"
                                        @click="changeSubCity(el, item.id, index, aInd)">
                                        <img :src="`/upload/common/country/${el.country}.png`" alt="">
                                        <span>{{el.option_name}}</span>
                                        <i class="el-icon-check"></i>
                                      </div>
                                    </div>
                                  </div>
                                  <!-- 后缀单位 -->
                                  <span class="unit">{{item.unit}}</span>
                                </div>
                                <!-- 描述 -->
                                <!-- <p class="des" v-if="item.option_type !== 'area' && item.description" v-html="calcDes(item.description)"> -->
                                </p>
                              </div>
                              <!-- 周期 -->
                              <!-- 当父商品的付费类型为周期的时候，子商品的周期不可选择，与父商品同步 -->
                              <div class="config-item"
                                :class="{sync: basicInfo.pay_type === 'recurring_prepayment' || basicInfo.pay_type === 'recurring_postpaid'}">
                                <p class="config-tit">{{lang.cycle}} <span v-if="sub.basicInfo.free"
                                    style="font-size: 14px;color: #999;">{{lang.common_cloud_text190}}</span></p>
                                <div class="onetime cycle" v-if="sub.basicInfo.pay_type === 'onetime'">
                                  <!-- <p>{{lang.product_onetime_free}}：{{commonData.currency_prefix}}{{sub.onetime}}</p> -->
                                  <div class="item com-active">
                                    <p class="name">{{lang.common_cloud_text6}}</p>
                                    <p class="price">{{commonData.currency_prefix}}{{sub.onetime}}</p>
                                    <i class="el-icon-check"></i>
                                  </div>
                                </div>
                                <div class="onetime cycle" v-if="sub.basicInfo.pay_type === 'free'">
                                  <!-- <p>{{lang.product_free}}</p> -->
                                  <div class="item com-active">
                                    <p class="name">{{lang.product_free}}</p>
                                    <p class="price">{{commonData.currency_prefix}}0.00</p>
                                    <i class="el-icon-check"></i>
                                  </div>
                                </div>
                                <div class="cycle"
                                  v-if="sub.basicInfo.pay_type === 'recurring_prepayment' || sub.basicInfo.pay_type === 'recurring_postpaid'">
                                  <div class="item" v-for="(item,ind) in sub.custom_cycles" :key="item.id"
                                    @click="changeSubCycle(item,ind,index)"
                                    :class="{'com-active': ind === sonCurCycle[index] }">
                                    <p class="name">{{item.name}}</p>
                                    <p class="price">{{commonData.currency_prefix}}{{((item.cycle_amount !== '' ?
                                      item.cycle_amount : item.amount) * 1).toFixed(2) | filterMoney}}</p>
                                    <i class="el-icon-check"></i>
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
            </el-tab-pane>
            <el-tab-pane :label="lang.common_cloud_text231" name="2">
              <div class="lincense-div">
                <div class="now-lincense">
                  <div class="lincense-text">{{lang.common_cloud_text229}}</div>
                  <div class="lincense-content">
                    <div class="content-title">{{upgradeHost.name}}</div>
                    <div class="content-box">
                      <div class="content-item" v-for="(item,index) in upgradeConfig" :key="index + 'upgradeConfig'">
                        {{item.option_name}}
                        <span
                          v-if="item.option_type ==='quantity_range' || item.option_type ==='quantity'">{{item.qty}}</span>
                        <span v-else>{{item.sub_name}}</span>
                        {{item.unit}}
                      </div>
                      <div class="content-item" v-for="(item,index) in upgradeSon_host"
                        :key="index + 'upgradeSon_host'">
                        {{lang.common_cloud_text162}}
                        <span>{{lang.common_cloud_text163}}</span>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 升级列表 -->
                <div class="can-upLincense">
                  <div class="lincense-text">{{lang.common_cloud_text232}}</div>
                  <div class="canUp-box">
                    <div class="canUp-content">
                      <div class="canUp-name select-content">{{lang.common_cloud_text233}}</div>
                    </div>
                    <div class="config-box">
                      <div class="l-config">
                        <!-- <div class="description" v-html="calStr" v-if="calStr"></div> -->
                        <!-- 自定义配置项 -->
                        <div class="config-item" v-for="(item,index) in configoptions" :key="index">
                          <p class="config-tit">{{item.option_name}}</p>
                          <!-- 配置项 -->
                          <div class="config-way"
                            v-if="(item.son_product_id > 0 && isBuyServe) || item.son_product_id === 0">
                            <!-- 下拉单选/多选 -->
                            <el-select v-model="configForm[item.id]" :placeholder="lang.please_select"
                              v-if="item.option_type === 'select' || item.option_type ==='multi_select'"
                              :multiple="item.option_type ==='multi_select'" collapse-tags @change="changeItem(item)">
                              <el-option v-for="(item,index) in item.subs" :key="index" :label="item.option_name"
                                :value="item.id">
                              </el-option>
                            </el-select>
                            <!-- 是否 -->
                            <el-switch v-model="configForm[item.id]" v-if="item.option_type ==='yes_no'"
                              active-color="#0052D9" :active-value="calcSwitch(item,true)"
                              :inactive-value="calcSwitch(item,false)" @change="changeConfig(false)">
                            </el-switch>
                            <!-- 数据输入 -->
                            <el-input-number v-model.number="configForm[item.id]" :min="item.qty_min"
                              :max="item.qty_max" v-if="item.option_type ==='quantity'"
                              @change="(val)=>fatherChange(val,item)">
                            </el-input-number>
                            <!-- 数量拖动 -->
                            <div class="slider" v-if="item.option_type ==='quantity_range'">
                              <span class="min">{{item.qty_min}}~</span>
                              <span class="max">{{item.qty_max}}</span>
                              <el-slider show-input :show-input-controls="false"
                                v-if="configForm[item.id] && configForm[item.id].length !==0"
                                v-model.number="configForm[item.id][0]" @change="(val)=>fatherChange(val,item)"
                                :min="item.qty_min" :max="item.qty_max" :step="item.subs[0]?.qty_change || 1">
                              </el-slider>
                            </div>
                            <!-- 点击单选 -->
                            <div class="click-select" v-if="item.option_type ==='radio'">
                              <div class="item" v-for="(el,index) in item.subs" :key="index"
                                :class="{'com-active': el.id === configForm[item.id]}"
                                @click="changeClick(item.id, el)">
                                {{el.option_name}}
                                <i class="el-icon-check"></i>
                              </div>
                            </div>
                            <!-- 区域选择 -->
                            <div class="area-box" v-if="item.option_type ==='area'">
                              <p class="tit">{{lang.account_label4}}</p>
                              <div class="country">
                                <div class="item" v-for="(el,index) in filterCountry[item.id]" :key="index"
                                  :class="{'com-active': index  === curCountry[item.id] }"
                                  @click="changeCountry(item.id,index)">
                                  <img :src="`/upload/common/country/${el[0].country}.png`" alt="">
                                  <span>{{calcCountry(el[0].country)}}</span>
                                  <i class="el-icon-check"></i>
                                </div>
                              </div>
                              <p class="tit">{{lang.city}}</p>
                              <div class="city">
                                <div class="item" v-for="(el,index) in filterCountry[item.id][curCountry[item.id]]"
                                  :key="index" :class="{'com-active': el.id  === configForm[item.id] }"
                                  @click="changeCity(el, item.id)">
                                  <img :src="`/upload/common/country/${el.country}.png`" alt="">
                                  <span>{{el.option_name}}</span>
                                  <i class="el-icon-check"></i>
                                </div>
                              </div>
                            </div>
                            <!-- 后缀单位 -->
                            <span class="unit">{{item.unit}}</span>
                          </div>
                          <!-- 描述 -->
                          <!-- <p class="des" v-if="item.option_type !== 'area' && item.description" v-html="calcDes(item.description)"> -->
                          </p>
                        </div>
                        <!-- 周期 -->
                        <!-- <div class="config-item">
                      <p class="config-tit">{{lang.com_config.cycle}}</p>
                      <div class="onetime cycle" v-if="basicInfo.pay_type && basicInfo.pay_type === 'onetime'">
                        <div class="item com-active">
                          <p class="name">{{lang.common_cloud_text6}}</p>
                          <p class="price">{{commonData.currency_prefix}}{{onetime}}</p>
                          <i class="el-icon-check"></i>
                        </div>
                      </div>
                      <div class="onetime cycle" v-if="basicInfo.pay_type && basicInfo.pay_type === 'free'">
                        <div class="item com-active">
                          <p class="name">{{lang.product_free}}</p>
                          <p class="price">{{commonData.currency_prefix}}0.00</p>
                          <i class="el-icon-check"></i>
                        </div>
                      </div>
                      <div class="cycle"
                        v-if="basicInfo.pay_type && (basicInfo.pay_type === 'recurring_prepayment' || basicInfo.pay_type === 'recurring_postpaid')">
                        <div class="item" v-for="(item,index) in custom_cycles" :key="index"
                          @click="changeCycle(item,index)" :class="{'com-active': index === curCycle }">
                          <p class="name">{{item?.name}}</p>
                          <p class="price">{{commonData.currency_prefix}}{{((item.cycle_amount !== '' ?
                            item.cycle_amount : item.amount) * 1).toFixed(2) | filterMoney}}</p>
                          <i class="el-icon-check"></i>
                        </div>
                      </div>
                    </div> -->
                        <div class="sub-box">
                          <!-- 循环展示子商品 -->
                          <div class="sub-item" v-for="(sub,index) in upSon" :key="index">
                            <div class="pro-tit">{{basicInfo?.name}}-{{sub.basicInfo?.name}}</div>
                            <el-switch v-model="sub.open" class="sub-switch" active-color="#0052D9"
                              @change="changeSub"></el-switch>
                            <div v-show="sub.open">
                              <!-- <div class="description" v-html="calcDes(sub.basicInfo?.order_page_description)" v-if="sub.basicInfo?.order_page_description"></div> -->
                              <!-- 自定义配置项 -->
                              <div class="config-item" v-for="(item,index) in sub.configoptions" :key="index">
                                <p class="config-tit">{{item.option_name}}</p>
                                <!-- 配置项 -->
                                <div class="config-way">
                                  <!-- 下拉单选/多选 -->
                                  <el-select v-model="sonConfigForm[index][item.id]" :placeholder="lang.please_select"
                                    v-if="item.option_type === 'select' || item.option_type ==='multi_select'"
                                    :multiple="item.option_type ==='multi_select'" collapse-tags
                                    @change="changeItem(item)">
                                    <el-option v-for="(item,index) in item.subs" :key="index" :label="item.option_name"
                                      :value="item.id">
                                    </el-option>
                                  </el-select>
                                  <!-- 是否 -->
                                  <el-switch v-model="sonConfigForm[index][item.id]" v-if="item.option_type ==='yes_no'"
                                    active-color="#0052D9" :active-value="calcSwitch(item,true)"
                                    :inactive-value="calcSwitch(item,false)" @change="changeConfig(false)">
                                  </el-switch>
                                  <!-- 数据输入 -->
                                  <el-input-number :disabled="sub.basicInfo.configoption_id > 0"
                                    v-model.number="sonConfigForm[index][item.id]" :min="item.qty_min"
                                    :max="item.qty_max" v-if="item.option_type ==='quantity'"
                                    @change="changeConfig(false)">
                                  </el-input-number>
                                  <!-- 数量拖动 -->
                                  <div class="slider" v-if="item.option_type ==='quantity_range'">
                                    <span class="min">{{item.qty_min}}~</span>
                                    <span class="max">{{item.qty_max}}</span>
                                    <el-slider show-input :show-input-controls="false"
                                      :disabled="sub.basicInfo.configoption_id > 0"
                                      v-if="sonConfigForm[index][item.id] && sonConfigForm[index][item.id].length !=0"
                                      v-model.number="sonConfigForm[index][item.id][0]"
                                      @change="(val)=>changeSonNum(val,item)" :min="item.qty_min" :max="item.qty_max"
                                      :step="item.subs[0]?.qty_change || 1">
                                    </el-slider>
                                  </div>
                                  <!-- 点击单选 -->
                                  <div class="click-select" v-if="item.option_type ==='radio'">
                                    <div class="item" v-for="(el,index) in item.subs" :key="index"
                                      :class="{'com-active': el.id === sonConfigForm[index][item.id]}"
                                      @click="changeClick(item.id, el)">
                                      {{el.option_name}}
                                      <i class="el-icon-check"></i>
                                    </div>
                                  </div>
                                  <!-- 区域选择 -->
                                  <div class="area-box" v-if="item.option_type ==='area'">
                                    <p class="tit">{{lang.account_label4}}</p>
                                    <div class="country">
                                      <div class="item" v-for="(el,index) in filterCountry[item.id]" :key="index"
                                        :class="{'com-active': index  === curCountry[item.id] }"
                                        @click="changeCountry(item.id,index)">
                                        <img :src="`/upload/common/country/${el[0].country}.png`" alt="">
                                        <span>{{calcCountry(el[0].country)}}</span>
                                        <i class="el-icon-check"></i>
                                      </div>
                                    </div>
                                    <p class="tit">{{lang.city}}</p>
                                    <div class="city">
                                      <div class="item" v-for="el in filterCountry[item.id][curCountry[item.id]]"
                                        :class="{'com-active': el.id  === configForm[item.id] }"
                                        @click="changeCity(el, item.id)">
                                        <img :src="`/upload/common/country/${el.country}.png`" alt="">
                                        <span>{{el.option_name}}</span>
                                        <i class="el-icon-check"></i>
                                      </div>
                                    </div>
                                  </div>
                                  <!-- 后缀单位 -->
                                  <span class="unit">{{item.unit}}</span>
                                </div>
                                <!-- 描述 -->
                                <!-- <p class="des" v-if="item.option_type !== 'area' && item.description" v-html="calcDes(item.description)"> -->
                                </p>
                              </div>
                              <!-- 周期 -->
                              <!-- 当父商品的付费类型为周期的时候，子商品的周期不可选择，与父商品同步 -->
                              <div class="config-item"
                                :class="{sync: basicInfo.pay_type === 'recurring_prepayment' || basicInfo.pay_type === 'recurring_postpaid'}">
                                <p class="config-tit">{{lang.cycle}} <span v-if="sub.basicInfo.free"
                                    style="font-size: 14px;color: #999;">{{lang.common_cloud_text190}}</span></p>
                                <div class="onetime cycle" v-if="sub.basicInfo.pay_type === 'onetime'">
                                  <div class="item com-active">
                                    <p class="name">{{lang.common_cloud_text6}}</p>
                                    <p class="price">{{commonData.currency_prefix}}{{sub.onetime}}</p>
                                    <i class="el-icon-check"></i>
                                  </div>
                                </div>
                                <div class="onetime cycle" v-if="sub.basicInfo.pay_type === 'free'">
                                  <div class="item com-active">
                                    <p class="name">{{lang.product_free}}</p>
                                    <p class="price">{{commonData.currency_prefix}}0.00</p>
                                    <i class="el-icon-check"></i>
                                  </div>
                                </div>
                                <div class="cycle"
                                  v-if="sub.basicInfo.pay_type === 'recurring_prepayment' || sub.basicInfo.pay_type === 'recurring_postpaid'">
                                  <div class="item" v-for="(item,ind) in sub.custom_cycles" :key="item.id"
                                    @click="changeSubCycle(item,ind,index)"
                                    :class="{'com-active': ind === sonCurCycle[index] }">
                                    <p class="name">{{item.name}}</p>
                                    <p class="price">{{commonData.currency_prefix}}{{((item.cycle_amount !== '' ?
                                      item.cycle_amount : item.amount) * 1).toFixed(2) | filterMoney}}</p>
                                    <i class="el-icon-check"></i>
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
            </el-tab-pane>
          </el-tabs>
        </div>
        <div slot="footer" class="dialog-footer">
          <div class="footer-price">
            <div class="lincense-price">{{lang.common_cloud_text174}}：<span class="blue-text"
                v-loading="upPriceLoading">{{commonData.currency_prefix}} {{upData.totalPrice | filterMoney}}</span>
            </div>
            <div class="footer-btnbox">
              <el-button type="primary" @click="handelUpConfirm"
                :loading="upBtnLoading">{{lang.common_cloud_text175}}</el-button>
              <el-button @click="upLicenseDialogShow = false">{{lang.common_cloud_text176}}</el-button>
            </div>
          </div>
        </div>
      </el-dialog>
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
  <script src="/themes/clientarea/default/v10/api/common_product_detail.js"></script>
  <script src="/themes/clientarea/default/v10/resource/echarts.min.js"></script>
  <script src="/themes/clientarea/default/v10/js/common_product_detail.js"></script>
</body>

</html>
