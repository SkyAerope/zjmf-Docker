
// 产品列表
function getMfList (params) {
  return Axios.get(`/product/common_cloud`, { params });
}
// 获取订购页面配置
function getOrderConfig (params) {
  return Axios.get(`/v10/host/product/${params.id}/mf_dcim/order_page`, { params });
}
// 获取操作系统列表
function getSystemList (params) {
  return Axios.get(`/v10/host/product/${params.id}/mf_dcim/image`);
}
// 获取商品配置所有周期价格
function getDuration (params) {
  return Axios.post(`/v10/host/product/${params.id}/mf_dcim/duration`, params);
}
// 修改配置计算价格
function calcPrice (params) {
  return Axios.post(`/product/${params.id}/config_option`, params)
}
// 结算商品
function settle (params) {
  return Axios.post(`/product/settle`, params)
}
// 使用优惠码
function usePromo (params) {
  return Axios.post(`/promo_code/apply`, params)
}


// 获取购物车
function getCart () {
  return Axios.get(`/cart`);
}
// 获取线路详情
function getLineDetail (params) {
  return Axios.get(`/product/${params.id}/v10/host/mf_dcim/line/${params.line_id}`);
}
// 获取ssh列表
function getSshList (params) {
  return Axios.get(`/ssh_key`, { params });
}
// 获取安全组
function getGroup (params) {
  return Axios.get(`/security_group`, { params });
}
// 获取VPC
function getVpc (params) {
  return Axios.get(`/mf_dcim/${params.id}/vpc_network`, { params });
}
// 用户等级折扣
function getLevelDiscount(params) {
  return Axios.get(`/client_level/product/${params.id}/amount`, { params });
}


// 登录
function loginFun (params) {
  return Axios.post(`/login/v10/auth`, params);
}
// 加入购物车
function addCart (params) {
  return Axios.post(`/cart/v10/add`, params);
}

// 获取编辑回填参数
function getBackParams (params) {
  return Axios.get(`/cart/v10/edit`, {params});
}
// 编辑购物车
function updateCart (params) {
  return Axios.post(`/cart/v10/edit`, params);
}

// 实时计算价格

function financeCalc (params) {
  return Axios.post(`/product/${params.id}/config_option`, params);
}
// 获取套餐详情
function getPackageDetail(params) {
  return Axios.get(`/v10/host/product/${params.id}/mf_dcim/package`, { params });
}


// 商品订单页自定义字段
function customFieldsProduct(id) {
  return Axios.get(`/v10/host/product/${id}/self_defined_field/order_page`);
}
