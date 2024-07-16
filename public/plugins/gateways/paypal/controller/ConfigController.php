<?php
namespace gateways\paypal\controller;
use think\Controller;
use gateways\paypal\PaypalPlugin;

class ConfigController extends Controller
{
    public static function getConfig()
    {
        static $_config = [];
        $get_name = new PaypalPlugin();
        $name = $get_name->info['name'];
        if (isset($_config[$name])) {
            return $_config[$name];
        }
        $config = db('plugin')->where('name', $name)->value('config');
        if (!empty($config) && $config != "null") {
            $config = json_decode($config, true);
        } else {
            return json(['msg'=>'请先将支付宝相关信息配置收入','status'=>400]);
        }
        $_config[$name] = $config;
        $con = require dirname(__DIR__).'/config/config.php';
        $config = array_merge($con,$config);
        return $config;
    }

}