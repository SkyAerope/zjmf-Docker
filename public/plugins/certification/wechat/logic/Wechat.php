<?php
namespace certification\wechat\logic;

class Wechat
{
    private $aop;
    public $_config;
    public function __construct()
    {
        $config = (new \certification\wechat\WechatPlugin())->getConfig();
        $this->_config = $config;
    }
    public function getDetectAuth($realname, $idcard)
    {
        $qcloud = new QcloudFaceid($this->_config["SecretId"], $this->_config["SecretKey"], $this->_config["RuleId"]);
        $result = $qcloud->GetRealNameAuthToken($realname, $idcard, "");
        if(!$result){
            return ["status" => 400, "msg" => "请求失败"];
        }elseif(isset($result['BizToken'])){
            return ["status" => 200, "data" => $result];
        }else{
            return ["status" => 400, "msg" => $result['Error']['Message']];
        }
    }
    public function getWechatAuthStatus($certify_id)
    {
        $qcloud = new QcloudFaceid($this->_config["SecretId"], $this->_config["SecretKey"], $this->_config["RuleId"]);
        $result = $qcloud->GetRealNameAuthResult($certify_id);
        if(!$result){
            $status = 2;
            $msg = "请求失败";
        }elseif(isset($result['Text'])){
            if(isset($result['Text']['ErrCode']) && $result['Text']['ErrCode'] == 0){
                $status = 1;
                $msg = "认证通过";
            }else{
                $status = 2;
                $msg = $result["Text"]["ErrMsg"] ?? "未认证";
            }
        }else{
            $msg = $result["Error"]["Message"];
            $status = 2;
        }
        return ["status" => $status, "msg" => $msg];
    }
}

?>