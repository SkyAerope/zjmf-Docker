(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["applicationDetail~f71cff67"],{1885:function(t,e,a){},"19fc":function(t,e,a){t.exports=a.p+"img/yasuobao.aa3a9aaf.svg"},"8bd6":function(t,e,a){"use strict";a.d(e,"m",(function(){return n})),a.d(e,"e",(function(){return o})),a.d(e,"i",(function(){return s})),a.d(e,"s",(function(){return p})),a.d(e,"k",(function(){return c})),a.d(e,"d",(function(){return i})),a.d(e,"b",(function(){return l})),a.d(e,"j",(function(){return u})),a.d(e,"h",(function(){return d})),a.d(e,"l",(function(){return f})),a.d(e,"u",(function(){return m})),a.d(e,"t",(function(){return g})),a.d(e,"c",(function(){return h})),a.d(e,"f",(function(){return _})),a.d(e,"n",(function(){return b})),a.d(e,"p",(function(){return v})),a.d(e,"q",(function(){return I})),a.d(e,"r",(function(){return y})),a.d(e,"a",(function(){return w})),a.d(e,"o",(function(){return x})),a.d(e,"g",(function(){return C}));var r=a("a27e");function n(t){return Object(r["a"])({url:"developer/developerlist",params:t})}function o(t){return Object(r["a"])({url:"developer/checkdeveloper",method:"post",data:t})}function s(t){return Object(r["a"])({url:"developer/developerapplist",params:t})}function p(t){return Object(r["a"])({url:"developer/toggleretired",method:"post",data:t})}function c(t){return Object(r["a"])({url:"developer/developerapp",params:t})}function i(t){return Object(r["a"])({url:"developer/checkdeveloperapp",method:"post",data:t})}function l(t){return Object(r["a"])({url:"developer/appaccounts",params:t})}function u(t){return Object(r["a"])({url:"developer/developerapplogs",params:t})}function d(t){return Object(r["a"])({url:"developer/developerapp",method:"delete",params:t})}function f(t){return Object(r["a"])({url:"developer/developerdetail",params:t})}function m(t){return Object(r["a"])({url:"withdraw/withdraw",params:t})}function g(t){return Object(r["a"])({url:"withdraw/withdraw",method:"post",data:t})}function h(t){return Object(r["a"])({url:"developer/app_evaluations",params:t})}function _(t){return Object(r["a"])({url:"developer/check_app_evaluations",method:"post",data:t})}function b(t){return Object(r["a"])({url:"developer/edit_app_evaluation",method:"put",data:t})}function v(t){return Object(r["a"])({url:"developer/hotapplist",params:t})}function I(t){return Object(r["a"])({url:"developer/hot_app",method:"put",data:t})}function y(t){return Object(r["a"])({url:"developer/recommendapplist",params:t})}function w(t){return Object(r["a"])({url:"developer/recommend_app",method:"post",data:t})}function x(t){return Object(r["a"])({url:"developer/recommend_app",method:"put",data:t})}function C(t){return Object(r["a"])({url:"developer/recommend_app",method:"delete",params:t})}},"9b2f":function(t,e,a){"use strict";a.r(e);var r=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{staticClass:"box"},[r("el-tabs",{on:{"tab-click":t.tabChange},model:{value:t.activeName,callback:function(e){t.activeName=e},expression:"activeName"}},[r("el-tab-pane",{attrs:{label:t.$lang.应用,name:"app"}},[r("el-row",{staticClass:"app-box"},[r("el-col",{attrs:{span:24}},[r("el-row",{staticClass:"app-box-row1"},[r("el-col",{staticClass:"app-box-unretired",attrs:{xs:24,lg:8}},[r("div",{staticClass:"box-unretired-top"},[r("div",[0===t.appInfo.product.retired&&1===t.appInfo.product.app_status?r("span",{staticClass:"mr-10",staticStyle:{color:"#333","font-size":"16px"}},[t._v(t._s(t.$lang.launch_info))]):t._e(),1===t.appInfo.product.retired&&1===t.appInfo.product.app_status?r("span",{staticClass:"mr-10",staticStyle:{color:"#333","font-size":"16px"}},[t._v(t._s(t.$lang.offline_info))]):t._e(),2===t.appInfo.product.app_status||0===t.appInfo.product.app_status?r("span",{staticClass:"mr-10",staticStyle:{color:"#333","font-size":"16px"}},[t._v(t._s(t.$lang.audit_info))]):t._e(),0===t.appInfo.product.retired&&1===t.appInfo.product.app_status?r("span",{staticClass:"retired-type0"},[t._v(t._s(t.$lang.the_shelves))]):1===t.appInfo.product.retired&&1===t.appInfo.product.app_status?r("span",{staticClass:"retired-type1"},[t._v(t._s(t.$lang.off_the_shelf))]):2===t.appInfo.product.app_status?r("span",{staticClass:"app_status-type2"},[t._v(t._s(t.$lang.rejected))]):0===t.appInfo.product.app_status?r("span",{staticClass:"app_status-type0"},[t._v(t._s(t.$lang.auditing))]):t._e()]),1===t.appInfo.product.app_status?r("div",{staticClass:"mt-10"},[t._v(t._s(t.appInfo.product.unretired_time?t.$moment(1e3*t.appInfo.product.unretired_time).format("YYYY-MM-DD HH:mm"):"-"))]):t._e(),2===t.appInfo.product.app_status||0===t.appInfo.product.app_status?r("div",{staticClass:"mt-10"},[t._v(t._s(t.appInfo.product.update_time?t.$moment(1e3*t.appInfo.product.update_time).format("YYYY-MM-DD HH:mm"):t.appInfo.product.create_time?t.$moment(1e3*t.appInfo.product.create_time).format("YYYY-MM-DD HH:mm"):"-"))]):t._e()]),r("div",{staticClass:"box-unretired-sellinfo"},[r("div",{staticClass:"tac"},[r("p",{staticStyle:{color:"#316eea","font-weight":"600","font-size":"18px",margin:"13px 0 20px"}},[t._v(t._s(t.appInfo.product.currency.prefix)+t._s(t.appInfo.product.sell_info.total))]),r("p",[t._v(t._s(t.$lang.shouru_yuan))])]),r("div",{staticClass:"unretired-sellinfo-divider"}),r("div",{staticClass:"tac"},[r("p",{staticStyle:{color:"#316eea","font-weight":"600","font-size":"18px",margin:"13px 0 20px"}},[t._v(t._s(t.appInfo.product.sell_info.count))]),r("p",[t._v(t._s(t.$lang.xiaoshou_bi))])])]),t.screenWidth>768?r("div",{staticClass:"box-unretired-divider"}):t._e()]),r("el-col",{staticClass:"app-box-author",attrs:{xs:24,lg:16}},[r("div",{staticClass:"box-author-title"},[r("label",[t._v("应用作者")]),r("span",[t._v(t._s(t.appInfo.developer.certifi_status))])]),r("el-form",{attrs:{"label-width":"70px"}},[r("el-form-item",{attrs:{label:"昵称"}},[r("span",[t._v(t._s(t.appInfo.developer.name))])]),r("el-form-item",{attrs:{label:"手机"}},[r("span",[t._v(t._s(t.appInfo.developer.phonenumber))])]),r("el-form-item",{attrs:{label:"简介"}},[r("span",{staticStyle:{display:"inline-block","max-height":"80px","overflow-y":"auto"}},[t._v(t._s(t.appInfo.developer.desc))])])],1)],1)],1),r("el-row",{staticClass:"app-box-row2"},[r("el-col",{attrs:{xs:24,lg:8}},[r("div",{staticClass:"box-row2-img"},[r("img",{staticClass:"h-100 w-100",attrs:{src:"/upload/common/application/"+t.appInfo.product.icon[0],alt:""}})]),r("div",{staticClass:"box-row2-appname"},[r("span",{staticClass:"fl mt-20 mb-10"},[t._v(t._s(t.appInfo.product.name))]),r("span",{staticClass:"fr mt-20 mb-10"},[r("i",{staticClass:"el-icon-delete cursor-pointer",staticStyle:{color:"#316eea","font-size":"16px"},on:{click:t.deleteHandleClick}})])]),r("div",{staticClass:"box-row2-desc"},[t._v(t._s(t.appInfo.product.info))])]),r("el-col",{staticClass:"box-row2-middle",attrs:{xs:24,lg:8}},[r("el-form",{attrs:{"label-width":"70px"}},[r("el-form-item",{attrs:{label:"应用名称"}},[r("span",[t._v(t._s(t.appInfo.product.name))])]),r("el-form-item",{attrs:{label:"应用类型"}},[r("span",[t._v(t._s(t.appInfo.product.type))])]),r("el-form-item",{attrs:{label:"出售方式"}},[r("span",{staticStyle:{color:"#2f54ea"}},[t._v(t._s(t.appInfo.product.pay_type_zh))])]),r("el-form-item",{attrs:{label:"出售价格"}},["recurring"===t.appInfo.product.pay_type?r("div",[t.appInfo.product.pricing.monthly?r("span",[r("span",{staticStyle:{color:"#316eea"}},[t._v(t._s(t.appInfo.product.currency.prefix)+t._s(t.appInfo.product.pricing.monthly))]),t._v(" "+t._s(t.appInfo.product.currency.suffix)+"/月 ")]):t._e(),t.appInfo.product.pricing.annually?r("span",[r("span",{staticStyle:{color:"#316eea"}},[t._v(t._s(t.appInfo.product.currency.prefix)+t._s(t.appInfo.product.pricing.annually))]),t._v(" "+t._s(t.appInfo.product.currency.suffix)+"/年 ")]):t._e()]):t._e(),"onetime"===t.appInfo.product.pay_type?r("div",[r("span",[r("span",{staticStyle:{color:"#316eea"}},[t._v(t._s(t.appInfo.product.currency.prefix)+t._s(t.appInfo.product.pricing.onetime))]),t._v(" "+t._s(t.appInfo.product.currency.suffix)+" ")])]):t._e()]),r("el-form-item",{attrs:{label:"使用说明"}},[r("span",{staticClass:"row2-middle-htmlstr",domProps:{innerHTML:t._s(t.appInfo.product.instruction)}})]),r("el-form-item",{attrs:{label:"版本说明"}},[r("span",{staticClass:"row2-middle-htmlstr",domProps:{innerHTML:t._s(t.appInfo.product.version_description)}})]),r("el-form-item",{attrs:{label:"应用描述"}},[r("span",{staticClass:"row2-middle-htmlstr",domProps:{innerHTML:t._s(t.appInfo.product.description)}})])],1)],1),r("el-col",{staticClass:"box-row2-right",attrs:{xs:24,lg:8}},[r("div",[r("span",{staticStyle:{color:"#999999"}},[t._v("应用图标")]),r("i",{staticClass:"el-icon-download cursor-pointer ml-10",staticStyle:{color:"#2f54ea"},on:{click:t.downloadImg}})]),r("div",{staticClass:"app-icon"},t._l(t.appInfo.product.icon,(function(t,e){return r("a",{key:e,attrs:{href:"/upload/common/application/"+t,target:"_blank"}},[r("img",{staticClass:"h-100 mr-10 cursor-pointer",staticStyle:{width:"60px"},attrs:{src:"/upload/common/application/"+t,alt:""}})])})),0),r("div",{staticClass:"mt-40 mb-20"},[r("span",{staticStyle:{color:"#999999"}},[t._v("应用文件")]),r("i",{staticClass:"el-icon-download cursor-pointer ml-10",staticStyle:{color:"#2f54ea"},on:{click:t.downloadFile}})]),t._l(t.appInfo.product.app_file,(function(e,n){return r("div",{key:n,staticClass:"app-file"},[r("img",{attrs:{src:a("19fc"),alt:"",width:"50",height:"50"}}),r("div",{staticClass:"appfile-name text-ofe mt-10"},[t._v(t._s(e.split("/")[e.split("/").length-1].split("^")[1]))])])}))],2)],1),r("el-row",{staticClass:"app-box-row3"},[r("el-col",{attrs:{span:24}},[0===t.appInfo.product.retired&&1===t.appInfo.product.app_status?r("el-button",{staticClass:"opt-btn-danger",attrs:{size:"small",type:"danger",plain:""},on:{click:t.toggleRetired}},[t._v("下架")]):t._e(),1===t.appInfo.product.retired&&1===t.appInfo.product.app_status?r("el-button",{staticClass:"opt-btn-primary",attrs:{size:"small",type:"primary"},on:{click:t.toggleRetired}},[t._v("上架")]):t._e(),t.appInfo.product.app_status&&1!==t.appInfo.product.app_status&&2!==t.appInfo.product.app_status||0===t.appInfo.product.app_status?r("el-button",{staticClass:"opt-btn-primary",attrs:{size:"small",type:"primary"},on:{click:function(e){return t.checkDeveloperApp(1)}}},[t._v("通过")]):t._e(),0===t.appInfo.product.app_status?r("el-button",{staticClass:"opt-btn-primary",attrs:{size:"small",type:"primary"},on:{click:function(e){return t.checkDeveloperApp(2)}}},[t._v("驳回")]):t._e(),t.appInfo.product.app_status||0===t.appInfo.product.app_status?r("el-button",{attrs:{size:"small"},on:{click:t.goBack}},[t._v("返回")]):t._e()],1)],1)],1)],1)],1),r("el-tab-pane",{attrs:{label:"交易",name:"transaction"}},[r("el-table",{staticClass:"mt-10",attrs:{data:t.transactionTableData,border:""},on:{"sort-change":t.transactionSortChange}},[r("el-table-column",{attrs:{prop:"trans_id",label:"交易流水号",sortable:""}}),r("el-table-column",{attrs:{prop:"username",label:"购买人",sortable:""}}),r("el-table-column",{attrs:{prop:"pay_time",label:"支付时间",sortable:""},scopedSlots:t._u([{key:"default",fn:function(e){var a=e.row;return[r("span",[t._v(t._s(a.pay_time?t.$moment(1e3*a.pay_time).format("YYYY-MM-DD HH:mm"):"-"))])]}}])}),r("el-table-column",{attrs:{prop:"gateway",label:"支付方式",sortable:""}}),r("el-table-column",{attrs:{prop:"amount_in",label:"支付金额",sortable:""}})],1),r("el-pagination",{staticClass:"mt-10",attrs:{"current-page":t.transactionSearch.page,"page-sizes":[10,15,20,25,50,100],"page-size":t.transactionSearch.limit,layout:"total, sizes, prev, pager, next, jumper",total:t.transactionTotal},on:{"size-change":t.transactionSizeChange,"current-change":t.getTransactionData,"update:currentPage":function(e){return t.$set(t.transactionSearch,"page",e)},"update:current-page":function(e){return t.$set(t.transactionSearch,"page",e)},"update:pageSize":function(e){return t.$set(t.transactionSearch,"limit",e)},"update:page-size":function(e){return t.$set(t.transactionSearch,"limit",e)}}})],1),r("el-tab-pane",{attrs:{label:"日志",name:"log"}},[r("el-table",{staticClass:"mt-10",attrs:{data:t.logTableData,border:""},on:{"sort-change":t.logSortChange}},[r("el-table-column",{attrs:{prop:"id",label:"ID",sortable:""}}),r("el-table-column",{attrs:{prop:"hostname",label:"时间",sortable:""},scopedSlots:t._u([{key:"default",fn:function(e){var a=e.row;return[r("span",[t._v(t._s(a.create_time?t.$moment(1e3*a.create_time).format("YYYY-MM-DD HH:mm"):"-"))])]}}])}),r("el-table-column",{attrs:{prop:"desc",label:"描述",sortable:""}}),r("el-table-column",{attrs:{prop:"reason",label:"原因",sortable:""}})],1),r("el-pagination",{staticClass:"mt-10",attrs:{"current-page":t.logSearch.page,"page-sizes":[10,15,20,25,50,100],"page-size":t.logSearch.limit,layout:"total, sizes, prev, pager, next, jumper",total:t.logTotal},on:{"size-change":t.logSizeChange,"current-change":t.getLogData,"update:currentPage":function(e){return t.$set(t.logSearch,"page",e)},"update:current-page":function(e){return t.$set(t.logSearch,"page",e)},"update:pageSize":function(e){return t.$set(t.logSearch,"limit",e)},"update:page-size":function(e){return t.$set(t.logSearch,"limit",e)}}})],1)],1)],1)},n=[],o=(a("4160"),a("b0c0"),a("a9e3"),a("ac1f"),a("1276"),a("159b"),a("96cf"),a("1da1")),s=a("8bd6"),p={metaInfo:{title:window.zjmf_cw_lang.app_details},data:function(){return{screenWidth:document.body.clientWidth,id:this.$route.query.id,appstatus:this.$route.query.appstatus,activeName:"app",appInfo:{developer:{},product:{currency:{code:"CNY",default:1,format:"3",id:1,prefix:"¥",rate:"1.00000",suffix:"元"},pricing:{onetime:"0.00",annually:"0.00",monthly:"0.00"},sell_info:{count:0,total:0},icon:[],app_file:[]}},transactionSearch:{id:this.$route.query.id,page:1,limit:Number(localStorage.getItem("limit"))||50,order:"id",sort:"desc"},transactionTableData:[],transactionTotal:0,logSearch:{id:this.$route.query.id,page:1,limit:Number(localStorage.getItem("limit"))||50,order:"id",sort:"desc"},logTableData:[],logTotal:0}},methods:{resize:function(){this.screenWidth=document.body.clientWidth},tabChange:function(t){"application"===t.name?this.getAppInfoById():"transaction"===t.name?this.getTransactionData():"log"===t.name&&this.getLogData()},getAppInfoById:function(){var t=this;return Object(o["a"])(regeneratorRuntime.mark((function e(){var a,r;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return e.next=2,Object(s["k"])({id:t.id});case 2:a=e.sent,r=a.data,200!==r.status?t.$message.error(r.msg):t.appInfo=r.data;case 5:case"end":return e.stop()}}),e)})))()},downloadImg:function(){(this.appInfo.product.icon||[]).forEach((function(t){var e="/upload/common/application/"+t,a=document.createElement("a"),r=new MouseEvent("click");a.download=t.split("^")[1],a.href=e,a.target="_blank",a.dispatchEvent(r)}))},downloadFile:function(){(this.appInfo.product.app_file||[]).forEach((function(t){var e="/upload/common/application/"+t,a=document.createElement("a"),r=new MouseEvent("click");a.download=t.split("^")[1],a.href=e,a.dispatchEvent(r)}))},deleteHandleClick:function(){var t=this;this.$confirm("确定删除吗？","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(Object(o["a"])(regeneratorRuntime.mark((function e(){var a,r;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return e.next=2,Object(s["h"])({id:t.id});case 2:a=e.sent,r=a.data,200!==r.status?t.$message.error(r.msg):(t.$message.success(r.msg),"1"===t.appstatus?t.$router.push("/application-list?appstatus=1"):t.$router.push("/appcheck-list?appstatus=2"));case 5:case"end":return e.stop()}}),e)})))).catch((function(){}))},toggleRetired:function(){var t=this,e=0,a="";0===this.appInfo.product.retired?(e=1,a="确定下架？"):1===this.appInfo.product.retired&&(e=0,a="确定上架？"),this.$confirm(a,"提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(Object(o["a"])(regeneratorRuntime.mark((function a(){var r,n;return regeneratorRuntime.wrap((function(a){while(1)switch(a.prev=a.next){case 0:return a.next=2,Object(s["s"])({id:t.id,retired:e});case 2:r=a.sent,n=r.data,200!==n.status?t.$message.error(n.msg):(t.$message.success(n.msg),t.getAppInfoById());case 5:case"end":return a.stop()}}),a)})))).catch((function(){}))},checkDeveloperApp:function(t){var e=this;1===t?this.$confirm("确定是否审核通过？","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then((function(){e.checkApp(t)})).catch((function(){})):2===t&&this.$prompt("请输入驳回原因","提示",{confirmButtonText:"确定",cancelButtonText:"取消",inputPattern:/^[\s\S]*.*[^\s][\s\S]*$/,inputErrorMessage:"请输入原因"}).then((function(a){e.checkApp(t,a.value)})).catch((function(){e.$message.info("取消输入")}))},checkApp:function(t,e){var a=this;return Object(o["a"])(regeneratorRuntime.mark((function r(){var n,o;return regeneratorRuntime.wrap((function(r){while(1)switch(r.prev=r.next){case 0:return r.next=2,Object(s["d"])({id:a.id,app_status:t,reason:e});case 2:n=r.sent,o=n.data,200!==o.status?a.$message.error(o.msg):(a.$message.success(o.msg),a.getAppInfoById());case 5:case"end":return r.stop()}}),r)})))()},goBack:function(){this.$router.go(-1)},getTransactionData:function(){var t=this;return Object(o["a"])(regeneratorRuntime.mark((function e(){var a,r;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return e.next=2,Object(s["b"])(t.transactionSearch);case 2:a=e.sent,r=a.data,200!==r.status?t.$message.error(r.msg):(t.transactionTableData=r.data.accounts,t.transactionTotal=r.data.count);case 5:case"end":return e.stop()}}),e)})))()},transactionSizeChange:function(t){this.transactionSearch.page=1,this.getTransactionData()},transactionSortChange:function(t,e,a){this.transactionSearch.order=t.prop,"ascending"===t.order?this.transactionSearch.sort="asc":this.transactionSearch.sort="desc",this.getTransactionData()},getLogData:function(){var t=this;return Object(o["a"])(regeneratorRuntime.mark((function e(){var a,r;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return e.next=2,Object(s["j"])(t.logSearch);case 2:a=e.sent,r=a.data,200!==r.status?t.$message.error(r.msg):(t.logTableData=r.data.logs,t.logTotal=r.data.count);case 5:case"end":return e.stop()}}),e)})))()},logSizeChange:function(t){this.transactionSearch.page=1,this.getLogData()},logSortChange:function(t,e,a){this.transactionSearch.order=t.prop,"ascending"===t.order?this.transactionSearch.sort="asc":this.transactionSearch.sort="desc",this.getLogData()}},created:function(){this.getAppInfoById()},mounted:function(){window.addEventListener("resize",this.resize)}},c=p,i=(a("c0c3"),a("2877")),l=Object(i["a"])(c,r,n,!1,null,"f7f0bbea",null);e["default"]=l.exports},c0c3:function(t,e,a){"use strict";var r=a("1885"),n=a.n(r);n.a}}]);