(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["addSupplier~f71cff67"],{e52a:function(a,t,e){"use strict";e.d(t,"a",(function(){return s})),e.d(t,"f",(function(){return n})),e.d(t,"c",(function(){return l})),e.d(t,"b",(function(){return o})),e.d(t,"d",(function(){return i})),e.d(t,"e",(function(){return m})),e.d(t,"g",(function(){return c}));var r=e("a27e");function s(a){return Object(r["a"])({url:"zjmf_finance_api",method:"post",data:a})}function n(a){return Object(r["a"])({url:"zjmf_finance_api",method:"put",data:a})}function l(a){return Object(r["a"])({url:"zjmf_finance_api/".concat(a)})}function o(a){return Object(r["a"])({url:"zjmf_finance_api/".concat(a),method:"delete"})}function i(a){return Object(r["a"])({url:"zjmf_finance_api",params:a})}function m(a){return Object(r["a"])({url:"zjmf_finance_api/".concat(a,"/status")})}function c(a){return Object(r["a"])({url:"zjmf_finance_api/upstreamcredit",params:a})}},ef86:function(a,t,e){"use strict";e.r(t);var r=function(){var a=this,t=a.$createElement,e=a._self._c||t;return e("div",[e("h2",[a._v(a._s(a.$route.query.data?a.$lang.edit_supplier:a.$lang.add_supplier))]),e("div",[e("el-form",{ref:"elForm",attrs:{model:a.formData,rules:a.rules,"label-width":"168px"}},[e("div",{staticClass:"mb-20 mt-20"},[a._v(a._s(a.$lang.basic_information))]),e("el-form-item",{attrs:{label:a.$lang.supplier_name,prop:"name"}},[e("span",{attrs:{slot:"label"},slot:"label"},[a._v(" "+a._s(a.$lang.name_designation)+" "),e("el-popover",{attrs:{placement:"top-start",title:"",width:"200",trigger:"hover"}},[e("el-row",[e("el-col",{attrs:{span:24}},[a._v(a._s(a.$lang.name_hint))])],1),e("i",{staticClass:"el-icon-question blue_qus",attrs:{slot:"reference"},slot:"reference"})],1)],1),e("el-input",{staticStyle:{width:"220px"},attrs:{size:"small"},model:{value:a.formData.name,callback:function(t){a.$set(a.formData,"name",t)},expression:"formData.name"}})],1),e("el-form-item",{attrs:{label:a.$lang.contact_information,prop:"contact_way"}},[e("el-input",{staticStyle:{width:"220px"},attrs:{size:"small"},model:{value:a.formData.contact_way,callback:function(t){a.$set(a.formData,"contact_way",t)},expression:"formData.contact_way"}})],1),e("el-form-item",{attrs:{label:a.$lang.remark,prop:"des"}},[e("el-input",{staticStyle:{width:"220px"},attrs:{size:"small",type:"textarea"},model:{value:a.formData.des,callback:function(t){a.$set(a.formData,"des",t)},expression:"formData.des"}})],1),e("div",{staticClass:"mb-20 mt-20"},[a._v(a._s(a.$lang.automatic_setup))]),e("el-form-item",{attrs:{label:a.$lang.interface_type}},[e("el-select",{staticStyle:{width:"220px"},attrs:{placeholder:a.$lang.select_sort,size:"small"},on:{change:a.changeType},model:{value:a.formData.type,callback:function(t){a.$set(a.formData,"type",t)},expression:"formData.type"}},[e("el-option",{attrs:{value:"manual",label:a.$lang.manual}}),e("el-option",{attrs:{value:"zjmf_api",label:a.$lang.zjmf}}),e("el-option",{attrs:{value:"v10",label:"v10"}})],1)],1),"zjmf_api"==a.formData.type||"whmcs"==a.formData.type||"v10"==a.formData.type?e("el-form-item",{attrs:{label:a.$lang.address_of_the_interface,prop:"hostname"}},[e("span",{attrs:{slot:"label"},slot:"label"},[a._v(" "+a._s(a.$lang.address_of_the_interface)+" "),e("el-popover",{attrs:{placement:"top-start",title:"",width:"230",trigger:"hover"}},[e("el-row",[e("el-col",{attrs:{span:24}},[a._v(a._s(a.$lang.interface_address_prompt))])],1),e("i",{staticClass:"el-icon-question blue_qus",attrs:{slot:"reference"},slot:"reference"})],1)],1),e("el-input",{staticStyle:{width:"220px"},attrs:{size:"small"},model:{value:a.formData.hostname,callback:function(t){a.$set(a.formData,"hostname",t)},expression:"formData.hostname"}})],1):a._e(),"zjmf_api"==a.formData.type||"whmcs"==a.formData.type||"v10"==a.formData.type?e("el-form-item",{attrs:{label:a.$lang.user_name,prop:"username"}},[e("span",{attrs:{slot:"label"},slot:"label"},[a._v(" "+a._s(a.$lang.user_name)+" "),e("el-popover",{attrs:{placement:"top-start",title:"",width:"200",trigger:"hover"}},[e("el-row",[e("el-col",{attrs:{span:24}},[a._v(a._s(a.$lang.the_upstream_registered))])],1),e("i",{staticClass:"el-icon-question blue_qus",attrs:{slot:"reference"},slot:"reference"})],1)],1),e("el-input",{staticStyle:{width:"220px"},attrs:{size:"small"},model:{value:a.formData.username,callback:function(t){a.$set(a.formData,"username",t)},expression:"formData.username"}})],1):a._e(),"zjmf_api"==a.formData.type||"whmcs"==a.formData.type||"v10"==a.formData.type?e("el-form-item",{attrs:{label:a.$lang.api_secret_key,prop:"password"}},[e("span",{attrs:{slot:"label"},slot:"label"},[a._v(" "+a._s(a.$lang.api_secret_key)+" "),e("el-popover",{attrs:{placement:"top-start",title:"",width:"200",trigger:"hover"}},[e("el-row",[e("el-col",{attrs:{span:24}},[a._v(a._s(a.$lang.api_secret_key_hint))])],1),e("i",{staticClass:"el-icon-question blue_qus",attrs:{slot:"reference"},slot:"reference"})],1)],1),e("el-input",{staticStyle:{width:"220px"},attrs:{size:"small","show-password":""},model:{value:a.formData.password,callback:function(t){a.$set(a.formData,"password",t)},expression:"formData.password"}})],1):a._e()],1),e("div",{staticClass:"mt-20 ml-20"},[e("el-button",{attrs:{size:"small"},on:{click:function(t){return a.$router.push({path:"zjmf-api"})}}},[a._v(a._s(a.$lang.cancel))]),e("el-button",{attrs:{size:"small",type:"primary",loading:a.btnLoading},on:{click:a.submit}},[a._v(a._s(a.$lang.confirm))])],1)],1)])},s=[],n=(e("b0c0"),e("a9e3"),e("96cf"),e("1da1")),l=e("e52a"),o={data:function(){return{formData:{id:0,name:"",hostname:"",username:"",password:"",des:"",type:"manual",contact_way:""},rules:{name:[{required:!0,message:this.$lang.please_enter_name,trigger:"blur"}],hostname:[{required:!0,message:this.$lang.plaese_enter_api_addr,trigger:"blur"}],username:[{required:!0,message:this.$lang.please_enter_user_name,trigger:"blur"}],password:[{required:!0,message:this.$lang.please_enter_password,trigger:"blur"}]},btnLoading:!1}},mounted:function(){this.$route.query.id&&this.getData()},methods:{getData:function(){var a=this;Object(l["c"])(this.$route.query.id).then((function(t){200===t.data.status&&(a.formData.id=t.data.data.id,a.formData.name=t.data.data.name,a.formData.hostname=t.data.data.hostname,a.formData.username=t.data.data.username,a.formData.password=t.data.data.password,a.formData.des=t.data.data.des,a.formData.type=t.data.data.type,a.formData.contact_way=t.data.data.contact_way)}))},changeType:function(){this.formData.hostname="",this.formData.username="",this.formData.password="",this.$refs.elForm.clearValidate()},submit:function(){var a=this;this.$refs.elForm.validate(function(){var t=Object(n["a"])(regeneratorRuntime.mark((function t(e){var r,s,n,o;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(e){t.next=2;break}return t.abrupt("return",!1);case 2:if(a.formData.id){t.next=12;break}return a.btnLoading=!0,t.next=6,Object(l["a"])(a.formData);case 6:r=t.sent,s=r.data,200!==s.status?a.$message.error(s.msg):(a.$message.success(s.msg),s.data.id?a.$router.push({name:"ZjmfApi",params:{refreshId:Number(s.data.id)}}):a.$router.push({name:"ZjmfApi"})),a.btnLoading=!1,t.next=19;break;case 12:return a.btnLoading=!0,t.next=15,Object(l["f"])(a.formData);case 15:n=t.sent,o=n.data,200!==o.status?a.$message.error(o.msg):(a.$message.success(o.msg),"zjmf_api"==a.formData.type?a.$router.push({name:"ZjmfApi",params:{refreshId:a.formData.id}}):a.$router.push({name:"ZjmfApi"})),a.btnLoading=!1;case 19:case"end":return t.stop()}}),t)})));return function(a){return t.apply(this,arguments)}}())}}},i=o,m=e("2877"),c=Object(m["a"])(i,r,s,!1,null,null,null);t["default"]=c.exports}}]);