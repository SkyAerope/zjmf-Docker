<?php
namespace certification\wechat;

class WechatPlugin extends \app\admin\lib\Plugin
{
    public $info = ["name" => "Wechat", "title" => "微信实名认证", "description" => "微信实名认证", "status" => 1, "author" => "顺戴网络", "version" => "1.0", "help_url" => "https://cloud.tencent.com/product/faceid"];
    public function wechatidcsmartauthorize()
    {
    }
    public function install()
    {
        $sql = ["ALTER TABLE `shd_certifi_person` CHANGE `certify_id` `certify_id` varchar(64) NOT NULL DEFAULT '' COMMENT '认证证书'", "ALTER TABLE `shd_certifi_company` CHANGE `certify_id` `certify_id` varchar(64) NOT NULL DEFAULT '' COMMENT '认证证书'"];
        foreach ($sql as $v) {
            \think\Db::execute($v);
        }
        return true;
    }
    public function uninstall()
    {
        return true;
    }
    public function personal($certifi)
    {
        $logic = new logic\Wechat();
        $res = $logic->getDetectAuth($certifi["name"], $certifi["card"]);
        $data = ["status" => 4, "auth_fail" => "", "certify_id" => "", "notes" => ""];
        if ($res["status"] == 200) {
            $resp = $res["data"];
            $certify_id = $resp["BizToken"];
            $data["certify_id"] = $certify_id;
            $url = htmlspecialchars_decode($resp["Url"]);
            $time = date("Y-m-d H:i:s", time());
            $data["notes"] = "微信记录号:" . $certify_id . ";\r\n" . "实名认证方式:" . $this->info["title"] . ";\r\n" . "实名认证接口提交时间:" . $time . "\r\n";
            $uid = request()->uid;
            $filename = md5($uid . "_zjmf_" . time()) . ".png";
            $file = WEB_ROOT . "upload/" . $filename;
            \cmf\phpqrcode\QRcode::png($url, $file);
            $base64 = base64EncodeImage($file);
            unlink($file);
            updatePersonalCertifiStatus($data);
            return "<h5 class=\"pt-2 font-weight-bold h5 py-4\">请使用微信扫描二维码</h5><img height='200' width='200' src=\"" . $base64 . "\" alt=\"\">";
        }
        $data["auth_fail"] = $res["msg"] ?: "实名认证接口配置错误,请联系管理员";
        return "<h3 class=\"pt-2 font-weight-bold h2 py-4\"><img src=\"\" alt=\"\">" . $data["auth_fail"] . "</h3>";
    }
    public function company($certifi)
    {
        $logic = new logic\Wechat();
        $res = $logic->getDetectAuth($certifi["name"], $certifi["card"]);
        $data = ["status" => 4, "auth_fail" => "", "certify_id" => "", "notes" => ""];
        if ($res["status"] == 200) {
            $resp = $res["data"];
            $certify_id = $resp["BizToken"];
            $data["certify_id"] = $certify_id;
            $url = htmlspecialchars_decode($resp["Url"]);
            $time = date("Y-m-d H:i:s", time());
            $data["notes"] = "微信记录号:" . $certify_id . ";\r\n" . "实名认证方式:" . $this->info["title"] . ";\r\n" . "实名认证接口提交时间:" . $time . "\r\n";
            $uid = request()->uid;
            $filename = md5($uid . "_zjmf_" . time()) . ".png";
            $file = WEB_ROOT . "upload/" . $filename;
            \cmf\phpqrcode\QRcode::png($url, $file);
            $base64 = base64EncodeImage($file);
            unlink($file);
            updateCompanyCertifiStatus($data);
            return "<h5 class=\"pt-2 font-weight-bold h5 py-4\">请使用微信扫描二维码</h5><img height='200' width='200' src=\"" . $base64 . "\" alt=\"\">";
        }
        $data["auth_fail"] = $res["msg"] ?: "实名认证接口配置错误,请联系管理员";
        return "<h3 class=\"pt-2 font-weight-bold h2 py-4\"><img src=\"\" alt=\"\">" . $data["auth_fail"] . "</h3>";
    }
    public function collectionInfo()
    {
        return [];
    }
    public function getStatus($certifi)
    {
        $logic = new logic\Wechat();
        $certify_id = $certifi["certify_id"];
        $res = $logic->getWechatAuthStatus($certify_id);
        return $res;
    }
}

?>