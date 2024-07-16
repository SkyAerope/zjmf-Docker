<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport"
    content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <title></title>
  <link rel="stylesheet" href="/themes/cart/default/v10/resource/element.css">
  <link rel="stylesheet" href="/themes/cart/default/v10/css/common_product.css">
  <script src="/themes/clientarea/default/v10/lang/{$LanguageCheck.display_flag}.js"></script>

</head>

<body>
  <div class="template" v-cloak>
    <!-- 自己的东西 -->
    <div class="main-card common-config">
      <!-- <div class="pro-tit">{{basicInfo.name}}</div> -->
      <div class="common-box">
        <div class="l-config">
          <div class="description" v-html="calStr" v-if="calStr"></div>
          <!-- 自定义配置项 -->
          <div class="config-item" v-for="item in configoptions" :key="item.id">
            <p class="config-tit">{{item.option_name}}</p>
            <template v-if="item.option_type === 'os'">
              <!-- 镜像组选择框 -->
              <el-select class="os-select os-group-select" v-model="osGroupId"
                @change="(e)=>osSelectGroupChange(e,item)">
                <img class="os-group-img" :src="osIcon" slot="prefix" alt="">
                <el-option v-for="items in item.subs" :key='items.os' :value="items.os" :label="items.os">
                  <div class="option-label">
                    <img class="option-img"
                      :src="'/themes/cart/default/v10/img/' + items.os + '.svg'"
                      alt="">
                    <span class="option-text">{{items.os}}</span>
                  </div>
                </el-option>
              </el-select>
              <!-- 镜像实际选择框 -->
              <el-select class="os-select" v-model="configForm[item.id]" @change="osSelectChange">
                <el-option v-for="os in osSelectData" :key="os.id" :value="os.id" :label="os.option_name"></el-option>
              </el-select>
            </template>
            <!-- 配置项 -->
            <div class="config-way">
              <!-- 下拉单选/多选 -->
              <el-select v-model="configForm[item.id]" :placeholder="lang.please_select"
                v-if="item.option_type === 'select' || item.option_type ==='multi_select'"
                :multiple="item.option_type ==='multi_select'" collapse-tags @change="changeItem(item)">
                <el-option v-for="item in item.subs" :key="item.id" :label="item.option_name" :value="item.id">
                </el-option>
              </el-select>
              <!-- 是否 -->
              <el-switch v-model="configForm[item.id]" v-if="item.option_type ==='yes_no'" active-color="#0052D9"
                :active-value="calcSwitch(item,true)" :inactive-value="calcSwitch(item,false)"
                @change="changeConfig(false)">
              </el-switch>
              <!-- 数据输入 -->
              <el-input-number v-model="configForm[item.id]" :min="item.qty_min" :max="item.qty_max"
                v-if="item.option_type ==='quantity'" @change="changeConfig(false)">
              </el-input-number>
              <!-- 数量拖动 -->
              <div class="slider" v-if="item.option_type ==='quantity_range'">
                <span class="min">{{item.qty_min}}</span>
                <el-slider v-model="configForm[item.id][0]" @change="changeConfig(false)" :min="item.qty_min"
                  :max="item.qty_max">
                </el-slider>
                <span class="max">{{item.qty_max}}</span>
                <el-input-number v-model="configForm[item.id][0]" :controls="false" :min="item.qty_min"
                  :max="item.qty_max" @change="changeNum($event, item.id)"></el-input-number>
              </div>

              <!-- 点击单选 -->
              <div class="click-select" v-if="item.option_type ==='radio'">
                <div class="item" v-for="el in item.subs" :key="el.id"
                  :class="{'com-active': el.id === configForm[item.id]}" @click="changeClick(item.id, el)">
                  {{el.option_name}}
                  <i class="el-icon-check"></i>
                </div>
              </div>

              <!-- 区域选择 -->

              <div class="area-box" v-if="item.option_type ==='area'">
                <p class="tit">{{lang.account_label4}}</p>
                <div class="country">
                  <div class="item" v-for="(el,index) in filterCountry[item.id]" :key="index"
                    :class="{'com-active': index  === curCountry[item.id] }" @click="changeCountry(item.id,index)">
                    <img :src="`/upload/common/country/${el[0].country}.png`" alt="">
                    <span>{{calcCountry(el[0].country)}}</span>
                    <i class="el-icon-check"></i>
                  </div>
                </div>
                <p class="tit">{{lang.city}}</p>
                <div class="city">
                  <div class="item" v-for="el in filterCountry[item.id][curCountry[item.id]]"
                    :class="{'com-active': el.id  === configForm[item.id] }" @click="changeCity(el, item.id)">
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
            <p class="des" v-if="item.option_type !== 'area' && item.description" v-html="calcDes(item.description)">
            </p>
          </div>
          <!-- 周期 -->
          <div class="config-item">
            <p class="config-tit">{{lang.cycle}}</p>
            <div class="onetime cycle" v-if="basicInfo.pay_type === 'onetime'">
              <!-- <p>{{lang.product_onetime_free}}：{{commonData.prefix}}{{onetime}}</p> -->
              <div class="item com-active">
                <p class="name">{{lang.common_cloud_text6}}</p>
                <!-- <p class="price">{{commonData.prefix}}{{onetime}}</p> -->
                <i class="el-icon-check"></i>
              </div>
            </div>
            <div class="onetime cycle" v-if="basicInfo.pay_type === 'free'">
              <!-- <p>{{lang.product_free}}</p> -->
              <div class="item com-active">
                <p class="name">{{lang.product_free}}</p>
                <!-- <p class="price">{{commonData.prefix}}0.00</p> -->
                <i class="el-icon-check"></i>
              </div>
            </div>
            <div class="cycle"
              v-if="basicInfo.pay_type === 'recurring_prepayment' || basicInfo.pay_type === 'recurring_postpaid'">
              <div class="item" v-for="(item,index) in custom_cycles" :key="item.id" @click="changeCycle(item,index)"
                :class="{'com-active': index === curCycle }">
                <p class="name" style="margin-bottom: 0;">{{item.name}}</p>

                <!-- <p class="price">{{commonData.prefix}}{{((item.cycle_amount !== '' ? item.cycle_amount :
                  item.amount) * 1).toFixed(2) | filterMoney}}</p> -->
                <i class="el-icon-check"></i>
              </div>
            </div>
          </div>

          <div class="config-item" v-show="is_show_custom">
            <p class="config-tit">{{lang.other_config}}</p>
            <custom-goods :id="id" :self_defined_field.sync="self_defined_field" :is_show_custom.sync="is_show_custom"
              class="custom-config" ref="customGoodRef">
            </custom-goods>
          </div>

        </div>
        <!-- 配置预览 -->
        <div class="order-right" :class="{'is-scroll': isScroll}">
          <div class="right-main">
            <div class="right-title">
              {{lang.product_preview}}
            </div>
            <div class="info">
              <p class="des">
                <span>{{basicInfo.name}}</span>
                <!-- <span v-if="base_price*1">{{commonData.prefix}}{{ Number(base_price).toFixed(2) |
                filterMoney}}</span> -->
              </p>
              <p class="des" v-for="(item,index) in showInfo" :key="index">
                <span class="name">{{item.name}}</span>
                <span class="value">{{item.value}}</span>
                <span class="price">{{commonData.prefix}}{{item.price | filterMoney}}</span>
              </p>
            </div>
            <div class="subtotal">
              <span class="name">{{lang.shoppingCar_goodsTotalPrice}}：</span>
              <span v-loading="dataLoading">{{commonData.prefix }}{{((onePrice * 1).toFixed(2)) | filterMoney
                }}</span>
            </div>
          </div>

          <div class="f-box" v-if="isShowBtn">
            <!-- 合计 优惠码 购买按钮 -->
            <div class="order-right-footer">
              <div class="order-right-item" v-if="basicInfo.allow_qty">
                <div class="row">
                  <div class="label">{{lang.shoppingCar_goodsNums}}</div>
                  <div class="value del-add">
                    <span class="del" @click="delQty" :class="{disabled: basicInfo.allow_qty === 0 }">-</span>
                    <el-input-number class="num" :controls="false" v-model="orderData.qty" :min="1"
                      :disabled="basicInfo.allow_qty === 0">
                    </el-input-number>
                    <span class="add" @click="addQty" :class="{disabled: basicInfo.allow_qty === 0 }">+</span>
                  </div>
                </div>
              </div>
              <div class="footer-total">
                <div class="left">{{lang.shoppingCar_tip_text3}}</div>
                <div class="right" v-loading="dataLoading">
                  <span>{{commonData.prefix}} {{totalPrice | filterMoney}}</span>
                  <el-popover placement="top-start" width="200" trigger="hover" v-if="original_price !=totalPrice">
                    <div class="show-config-list">
                      <p v-if="clDiscount * 1 !== 0">{{lang.shoppingCar_tip_text2}}：{{commonData.prefix}} {{
                        clDiscount |
                        filterMoney }}</p>
                      <p v-if="isShowPromo && isUseDiscountCode">
                        {{lang.shoppingCar_tip_text4}}：{{commonData.prefix}} {{ code_discount | filterMoney }}
                      </p>
                      <p v-if="customfield.event_promotion">{{lang.goods_text4}}：{{commonData.prefix}} {{
                        eventData.discount | filterMoney }}
                      </p>
                    </div>
                    <i class="el-icon-warning-outline total-icon" slot="reference"></i>
                  </el-popover>
                  <p class="original-price" v-if="original_price !=totalPrice">{{commonData.prefix}}
                    {{original_price.toFixed(2) | filterMoney}}
                  </p>
                  <!-- 优惠码 -->
                  <div class="discount-box">
                    <discount-code v-if="isShowPromo && !customfield.promo_code " @get-discount="getDiscount(arguments)"
                      scene='new' :product_id='id' :qty="orderData.qty" :amount="onePrice"
                      :billing_cycle_time="orderData.duration">
                    </discount-code>
                    <div v-if="customfield.promo_code" class="discount-codeNumber">
                      {{ customfield.promo_code }}
                      <i class="el-icon-circle-close remove-discountCode" @click="removeDiscountCode()"></i>
                    </div>
                    <!-- 活动插件 -->
                    <event-code v-if="isShowFull" :product_id='id' :qty="orderData.qty" :amount="onePrice"
                      :billing_cycle_time="orderData.duration" @change="eventChange">
                    </event-code>
                  </div>
                </div>
              </div>

            </div>
            <!-- 需读 -->
            <!-- 购买按钮 -->
            <div class="f-btn ifram-hiden">
              <div class="buy-btn" @click="handlerCart" :loading="submitLoading">{{calcCartName}}</div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>

  <!-- 通用 -->
  <script src="/themes/cart/default/v10/resource/vue.js"></script>
  <script src="/themes/cart/default/v10/resource/element.js"></script>
  <script src="/themes/cart/default/v10/utils/axios.min.js"></script>
  <script src="/themes/cart/default/v10/utils/request.js"></script>
  <script src="/themes/cart/default/v10/utils/util.js"></script>
  <script src="/themes/cart/default/v10/components/customGoods/customGoods.js"></script>
  <!-- 独有 -->

  <script src="/themes/cart/default/v10/api/common_product.js"></script>
  <script src="/themes/cart/default/v10/js/common_product.js"></script>
</body>

</html>
