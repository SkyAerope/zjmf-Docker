<?php
namespace addons\export_excel;

use app\admin\lib\Plugin;
use think\Db;

class ExportExcelPlugin extends Plugin
{
    public $info = [
        'name' => 'ExportExcel',
        'title' => '数据导出至Excel插件',
        'description' => '选择列表,字段,可导出至Excel',
        'status' => 1,
        'author' => '顺戴网络',
        'version' => '1.0',
        'module' => 'addons'
    ];

    public function install()
    {
        $sql = [
            "DROP TABLE IF EXISTS `shd_export_plugin`",
            "CREATE TABLE `shd_export_plugin` (  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,  `custom_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '自定义名称',  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '导出列表名称',  `ep_param` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '要导出的参数',  `create_time` int(11) NOT NULL DEFAULT '0',  `update_time` int(11) NOT NULL DEFAULT '0',  PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;"
        ];
        foreach ($sql as $v) {
            Db::execute($v);
        }
        return true;
    }
    public function uninstall()
    {
        $sql = ["DROP TABLE IF EXISTS `shd_export_plugin`"];
        foreach ($sql as $v) {
            Db::execute($v);
        }
        return true;
    }
}

?>