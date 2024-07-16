<?php
namespace certification\threehc;

class ThreehcPlugin extends \app\admin\lib\Plugin
{
    public $info = ["name" => "Threehc", "title" => "三要素--深圳华辰", "description" => "三要素--深圳华辰", "status" => 1, "author" => "顺戴网络", "version" => "1.0", "help_url" => "https://market.aliyun.com/products/57000002/cmapi025566.html"];
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
        if (file_exists(__DIR__ . "/config/config.php")) {
            $con = (require __DIR__ . "/config/config.php");
        } else {
            $con = [];
        }
        $config = $this->getConfig();
        $_config = array_merge($con, $config);
        $type = $_config["type"];
        if ($type == 2) {
            $param = ["name" => $certifi["name"], "bank" => $certifi["bank"]];
        } else {
            if ($type == 3) {
                $param = ["bank" => $certifi["bank"], "name" => $certifi["name"], "number" => $certifi["card"], "type" => 0];
            } else {
                $param = ["bank" => $certifi["bank"], "mobile" => $certifi["phone"], "name" => $certifi["name"], "number" => $certifi["card"], "type" => 0];
            }
        }
        $logic = new logic\Threehc();
        $query = $logic->createLinkstrings($param);
        $appcode = $_config["app_code"];
        $result = $logic->httpsPhoneThree($appcode, $query, $_config["threehc_url"], $type);
        $data = ["status" => 2, "auth_fail" => "", "certify_id" => $result["log_id"] ?: ""];
        if ($result["ret"] == 200) {
            if (isset($result["data"]["desc"]) && $result["data"]["desc"] == "一致") {
                $data["status"] = 1;
            } else {
                $data["auth_fail"] = $result["data"]["desc"] ?: "";
            }
        } else {
            $data["auth_fail"] = $result["msg"] ?: "实名认证接口配置错误,请联系管理员";
        }
        updatePersonalCertifiStatus($data);
        return "<h3 class=\"pt-2 font-weight-bold h2 py-4\"><img src=\"\" alt=\"\"> 正在认证,请稍等...</h3>";
    }
    public function company($certifi)
    {
        if (file_exists(__DIR__ . "/config/config.php")) {
            $con = (require __DIR__ . "/config/config.php");
        } else {
            $con = [];
        }
        $config = $this->getConfig();
        $_config = array_merge($con, $config);
        $type = $_config["type"];
        if ($type == 2) {
            $param = ["name" => $certifi["name"], "bank" => $certifi["bank"]];
        } else {
            if ($type == 3) {
                $param = ["bank" => $certifi["bank"], "name" => $certifi["name"], "number" => $certifi["card"], "type" => 0];
            } else {
                $param = ["bank" => $certifi["bank"], "mobile" => $certifi["phone"], "name" => $certifi["name"], "number" => $certifi["card"], "type" => 0];
            }
        }
        $logic = new logic\Threehc();
        $query = $logic->createLinkstrings($param);
        $appcode = $_config["app_code"];
        $result = $logic->httpsPhoneThree($appcode, $query, $_config["threehc_url"], $type);
        $data = ["status" => 2, "auth_fail" => "", "certify_id" => $result["log_id"] ?: ""];
        if ($result["ret"] == 200) {
            if (isset($result["data"]["desc"]) && $result["data"]["desc"] == "一致") {
                $data["status"] = 1;
            } else {
                $data["auth_fail"] = $result["data"]["desc"] ?: "";
            }
        } else {
            $data["auth_fail"] = $result["msg"] ?: "实名认证接口配置错误,请联系管理员";
        }
        updateCompanyCertifiStatus($data);
        return "<h3 class=\"pt-2 font-weight-bold h2 py-4\"><img src=\"\" alt=\"\"> 正在认证,请稍等...</h3>";
    }
    public function collectionInfo()
    {
        $config = $this->getConfig();
        $type = $config["type"];
        if ($type == 2) {
            $data = ["bank" => ["title" => "银行卡号", "type" => "text", "value" => "", "tip" => "请输入银行卡号", "required" => true]];
        } else {
            if ($type == 3) {
                $data = ["bank" => ["title" => "银行卡号", "type" => "text", "value" => "", "tip" => "请输入银行卡号", "required" => true]];
            } else {
                if ($type == 4) {
                    $data = ["bank" => ["title" => "银行卡号", "type" => "text", "value" => "", "tip" => "请输入银行卡号", "required" => true], "phone" => ["title" => "手机号", "type" => "text", "value" => "", "tip" => "请输入手机号", "required" => true]];
                } else {
                    $data = [];
                }
            }
        }
        return $data;
    }
    public function getStatus($certifi)
    {
        return true;
    }
}

?>