<?php
namespace certification\alitwo;

class AlitwoPlugin extends \app\admin\lib\Plugin
{
    public $info = ["name" => "Alitwo", "title" => "阿里云身份证二要素", "description" => "阿里云身份证二要素", "status" => 1, "author" => "顺戴网络", "version" => "1.0", "help_url" => "https://market.aliyun.com/products/57000002/cmapi022049.html"];
    public function install()
    {
        return true;
    }
    public function uninstall()
    {
        return true;
    }
    public function personal($certifi)
    {
        $custom1 = $certifi["test_field"];
        $logic = new logic\Alitwo();
        $result = $logic->alitwoHttp($certifi["card"], $certifi["name"]);
        $data = ["status" => 2, "auth_fail" => "", "certify_id" => $result["body"]["traceId"] ?: ""];
        if ($result["status"] == 200) {
            if ($result["body"]["status"] == "01") {
                $data["status"] = 1;
            }
            $data["auth_fail"] = $result["body"]["msg"] ?: "";
        } else {
            $data["auth_fail"] = $result["msg"] ?: "实名认证接口配置错误,请联系管理员";
        }
        updatePersonalCertifiStatus($data);
        return "<h3 class=\"pt-2 font-weight-bold h2 py-4\"><img src=\"\" alt=\"\"> 正在认证,请稍等...</h3>";
    }
    public function company($certifi)
    {
        $custom1 = $certifi["test_field"];
        $logic = new logic\Alitwo();
        $result = $logic->alitwoHttp($certifi["card"], $certifi["name"]);
        $data = ["status" => 2, "auth_fail" => "", "certify_id" => $result["body"]["traceId"] ?: ""];
        if ($result["status"] == 200) {
            if ($result["body"]["status"] == "01") {
                $data["status"] = 1;
            }
            $data["auth_fail"] = $result["body"]["msg"] ?: "";
        } else {
            $data["auth_fail"] = $result["msg"] ?: "实名认证接口配置错误,请联系管理员";
        }
        updateCompanyCertifiStatus($data);
        return "<h3 class=\"pt-2 font-weight-bold h2 py-4\"><img src=\"\" alt=\"\"> 正在认证,请稍等...</h3>";
    }
    public function collectionInfo()
    {
        return [];
    }
    public function getStatus($certifi)
    {
        return true;
    }
}

?>