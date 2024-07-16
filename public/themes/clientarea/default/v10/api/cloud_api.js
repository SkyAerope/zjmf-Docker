// 产品接口
// 获取数据中心
function dataCenter(id) {
  return Axios.get(`/product/${id}/v10/host/mf_cloud/data_center`);
}
/* 产品列表 */
function cloudList(params) {
  return Axios.get(`/v10/host/${params.id}/mf_cloud/list`, { params });
}
// 产品详情
function hostDetail(params) {
  return Axios.get(`/v10/host/${params.id}`, { params });
}
// 实例详情
function cloudDetail(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}`, { params });
}
// cloud日志
function getLog(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/log`, { params });
}
// 快照列表
function snapshotList(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/snapshot`, { params });
}
// 创建快照
function createSnapshot(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/snapshot`, params);
}
// 快照还原
function restoreSnapshot(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/snapshot/restore`, params);
}

// 获取快照/备份数量升降级价格
function backupConfig(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/backup_config`, { params });
}

// 生成快照/备份数量升降级订单
function backupOrder(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/upgrade/order`, params);
}

// 删除快照
function delSnapshot(params) {
  return Axios.delete(
    `/v10/host/mf_cloud/${params.id}/snapshot/${params.snapshot_id}`,
    params
  );
}
// 备份列表
function backupList(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/backup`, { params });
}
// 创建备份
function createBackup(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/backup`, params);
}
// 备份还原
function restoreBackup(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/backup/restore`, params);
}
// 删除备份
function delBackup(params) {
  return Axios.delete(
    `/v10/host/mf_cloud/${params.id}/backup/${params.backup_id}`,
    params
  );
}

// 获取实例磁盘
function getDiskList(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/disk`, { params });
}
// 获取其它设置
function config(params) {
  return Axios.get(`/product/${params.product_id}/v10/host/mf_cloud/config`, { params });
}
// 获取购买磁盘价格
function diskPrice(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/disk/price`, params);
}

// 生成购买磁盘订单
function diskOrder(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/upgrade/order`, params);
}

// 获取扩容磁盘价格
function expanPrice(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/disk/resize`, params);
}
// 生成磁盘扩容订单
function diskExpanOrder(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/upgrade/order`, params);
}

// 修改产品备注
function editNotes(params) {
  return Axios.put(`/v10/host/${params.id}/notes`, params);
}
// 获取可用操作系统
function image(params) {
  return Axios.get(`v10/host/product/${params.id}/mf_cloud/image`, { params });
}
// 检查产品是否购买过镜像
function checkImage(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/image/check`, { params });
}
// 生成购买镜像订单
function imageOrder(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/upgrade/order`, params);
}
// 获取SSH秘钥列表
function sshKey(params) {
  return Axios.get(`/v10/host/${params.id}/ssh_key`, { params });
}
// 重装系统
function reinstall(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/reinstall`, params);
}
// 获取实例状态
function cloudStatus(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/status`, { params });
}
// 开机
function powerOn(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/on`, params);
}
// 关机
function powerOff(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/off`, params);
}
// 获取控制台地址
function vncUrl(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/vnc`, params);
}
// 救援模式
function rescue(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/rescue`, params);
}
// 退出救援模式
function exitRescue(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/rescue/exit`, params);
}
// 获取升降级订购页套餐
function upgradePackage(params) {
  return Axios.get(`/product/${params.product_id}/v10/host/mf_cloud/package`, {
    params,
  });
}
// 获取升降级套餐价格

function upgradePackagePrice(type, params) {
  if (type === 'custom') {
    return Axios.get(`/v10/host/mf_cloud/${params.id}/common_config`, { params });
  } else if (type === 'package') {
    return Axios.get(`/v10/host/mf_cloud/${params.id}/recommend_config/price`, { params });
  }
}
// 生成升降级套餐订单
function upgradeOrder(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/upgrade/order`, params);
}
// 获取是否救援系统
function remoteInfo(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/remote_info`, { params });
}
// 重启
function reboot(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/reboot`, params);
}
// 强制重启
function hardReboot(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/hard_reboot`, params);
}
// 强制关机
function hardOff(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/hard_off`, params);
}
// 重置密码
function resetPassword(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/reset_password`, params);
}

/* 续费相关 */
// 续费页面
function renewPage(params) {
  return Axios.get(`/v10/host/${params.id}/renew`, { params });
}
// 续费提交
function renew(params) {
  return Axios.post(`/host/renew`, params);
}

// 网络
// 获取ip列表
function ipList(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/ip`, { params });
}

// 产品内页获取优惠码信息
function promoCode(params) {
  return Axios.get(`/promo_code/host/${params.id}/promo_code`, { params });
}

// 统计图表
// 获取图表数据
function chartList(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/chart`, { params });
}

// 获取网络流量
function getFlow(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/flow`, { params });
}

// 获取套餐所有周期价格

// 获取商品折扣金额
function clientLevelAmount(params) {
  return Axios.get(`/client_level/product/${params.id}/amount`, { params });
}

// 卸载磁盘
function unmount(params) {
  return Axios.post(
    `/v10/host/mf_cloud/${params.id}/disk/${params.disk_id}/unmount`,
    params
  );
}

// 挂载磁盘
function mount(params) {
  return Axios.post(
    `/v10/host/mf_cloud/${params.id}/disk/${params.disk_id}/mount`,
    params
  );
}

// 获取自动续费状态
function renewStatus(params) {
  return Axios.get(`/host/${params.id}/renew/auto`, { params });
}
// 自动续费开关
function rennewAuto(params) {
  return Axios.put(`/host/${params.id}/renew/auto`, params);
}

// 获取cpu/内存使用信息
function realData(id) {
  return Axios.get(`/v10/host/mf_cloud/${id}/real_data`);
}
// 获取订购页面配置
function getOrderConfig(params) {
  return Axios.get(`/v10/host/product/${params.id}/mf_cloud/order_page`, { params });
}
// 获取线路配置
function getLineConfig(params) {
  return Axios.get(`/product/${params.id}/v10/host/mf_cloud/line/${params.line_id}`, {
    params,
  });
}
// 获取附加IP价格
function ipPrice(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/ip_num`, { params });
}
// 生成附加IP订单
function ipOrder(params) {
  return Axios.post(`v10/host/mf_cloud/${params.id}/upgrade/order`, params);
}
// VPC网络列表
function vpcNetwork(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/vpc_network`, { params });
}
// 切换实例VPC网络
function changeVpc(params) {
  return Axios.put(`/v10/host/mf_cloud/${params.id}/vpc_network`, params, {
    timeout: 1000 * 60 * 10,
  });
}

// 删除VPC网络
function delVpc(params) {
  return Axios.delete(
    `/v10/host/mf_cloud/${params.id}/vpc_network/${params.vpc_network_id}`
  );
}
//创建VPC网络
function addVpcNet(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/vpc_network`, params);
}
// 安全组列表
function securityGroup(params) {
  return Axios.get(`/security_group`, { params });
}
//关联安全组
function addSafe(params) {
  return Axios.post(
    `/security_group/${params.id}/host/${params.host_id}`,
    params
  );
}

// 获取线路详情
function getLineDetail(params) {
  return Axios.get(`/product/${params.id}/v10/host/mf_cloud/line/${params.line_id}`);
}

// NAT转发
function getNatAcl(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/nat_acl`);
}
function addNatAcl(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/nat_acl`, params);
}
function delNatAcl(params) {
  return Axios.delete(`/v10/host/mf_cloud/${params.id}/nat_acl`, { params });
}
// NAT建站
function getNatWeb(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/nat_web`);
}
function addNatWeb(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/nat_web`, params);
}
function delNatWeb(params) {
  return Axios.delete(`/v10/host/mf_cloud/${params.id}/nat_web`, { params });
}

// 获取产品停用信息
function refundMsg(params) {
  return Axios.get(`/v10/host/refund/host/${params.id}/refund`, { params })
}

// 申请停用
function refund(params) {
  return Axios.post(`/host/cancel`, params)
}
// 取消停用
function cancelRefund(params) {
  return Axios.delete(`host/cancel`, {
    data: params
  })
}
function getFlowPacket(params) {
  return Axios.get(`/v10/host/${params.id}/flow_packet`)
}
function buyFlowPacket(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/upgrade/order`, params)
}
// 发送短信验证码
function phoneCode(params) {
  return Axios.post(`v10/host/${params.id}/phone/code`, params)
}

/* 套餐版升降级 */
function getPackageList(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/recommend_config`);
}



// 产品IP详情
function getHostIpDetails(id) {
  return Axios.get(`/v10/host/${id}/ip`);
}

// 模拟物理机运行
function changeSimulatePhysical(params) {
  return Axios.post(`/v10/host/mf_cloud/${params.id}/simulate_physical_machine`, params);
}

// IPv6
function ipv6List(params) {
  return Axios.get(`/v10/host/mf_cloud/${params.id}/ipv6`, { params });
}
