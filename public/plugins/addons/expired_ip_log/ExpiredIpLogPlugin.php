<?php
namespace addons\expired_ip_log;

use app\admin\lib\Plugin;
use think\Db;

class ExpiredIpLogPlugin extends Plugin
{
    public $info = [
        'name' => 'ExpiredIpLog',
        'title' => '到期产品删除IP记录',
        'description' => '产品到期删除的时候记录IP',
        'status' => 1,
        'author' => '顺戴网络',
        'version' => '1.0',
        'module' => 'addons',
        'lang' => ['chinese' => '到期产品删除IP记录', 'chinese_tw' => '到期産品删除IP記録', 'english' => 'Delete IP records for expired products']
    ];

    public function install()
    {
        $sql = [
            "DROP TABLE IF EXISTS `shd_expired_ip_log`",
            "CREATE TABLE `shd_expired_ip_log` (  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,  `dedicatedip` text NOT NULL DEFAULT '' COMMENT '独立ip地址',  `assignedips` text NOT NULL DEFAULT '' COMMENT '分配的ip地址',  `host_create_time` int(11) NOT NULL DEFAULT '0' COMMENT '主机创建时间',  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '结束时间',  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8"
        ];
        foreach ($sql as $v) {
            Db::execute($v);
        }
        return true;
    }
    public function uninstall()
    {
        $sql = ["DROP TABLE IF EXISTS `shd_expired_ip_log`"];
        foreach ($sql as $v) {
            Db::execute($v);
        }
        return true;
    }
    public function afterModuleTerminate($param)
    {
        $params = $param["params"];
        Db::name("expired_ip_log")->insertGetId(["dedicatedip" => $params["dedicatedip"] ?: "", "assignedips" => $params["assignedips"] ?: "", "host_create_time" => $params["regdate"] ?: "0", "uid" => $params["uid"] ?: "0", "create_time" => time()]);
    }
}

?>