<?php

namespace gateways\epay_usdt;

use app\admin\lib\Plugin;
use gateways\epay_usdt\lib\EpayCore;
use think\Db;

class EpayUsdtPlugin extends Plugin
{

    public $info = array(
        'name'        => 'EpayUsdt',
        'title'       => 'USDT',
        'description' => '易支付-USDT',
        'status'      => 1,
        'author'      => '白猿科技',
        'version'     => '1.0',
        'module'        => 'gateways',
    );

    public $hasAdmin = 0;//插件是否有后台管理界面

    // 插件安装
    public function install()
    {
        return true;//安装成功返回true，失败false
    }

    // 插件卸载
    public function uninstall()
    {
        return true;//卸载成功返回true，失败false
    }

    public function EpayUsdtHandle($param)
    {
		$config = $this->config();
		$domain = configuration('domain');
		$parameter = array(
			"pid" => trim($config['pid']),
			"type" => $config['paytype'] ? $config['paytype'] : 'usdt',
			"notify_url"	=> $domain."/gateway/epay_usdt/index/notifyHandle",
			"return_url"	=> $domain."/gateway/epay_usdt/index/returnHandle",
			"out_trade_no"	=> $param['out_trade_no'],
			"name"	=> $param['product_name'],
			"money"	=> $param['total_fee']
		);
		$epaySubmit = new EpayCore($config);
        $url = $epaySubmit->getPayLink($parameter);

		$reData = array(
            'type' => 'jump',
            'data' => $url,
        );
		return $reData;
    }

	public function config()
    {
        $name = $this->info['name'];

        $config = db('plugin')->where('name', $name)->value('config');
        if (!empty($config) && $config != "null") {
            $config = json_decode($config, true);
        } else {
            return json(['msg'=>'请先将配置好商户信息','status'=>400]);
        }
		$config['sign_type'] = 'MD5';
		$config['input_charset'] = 'utf-8';
        return $config;
    }

}