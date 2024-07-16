<?php
require "ProxmoxApiException.pve";
require "ProxmoxMethodsTrait.pve";
require "ProxmoxClient.pve";
require "ProxmoxNode.pve";
require "ProxmoxVM.pve";
function proxmoxve_idcsmartauthorizes()
{
}
function proxmoxve_MetaData()
{
    return ["DisplayName" => "ProxmoxVE LXC", "APIVersion" => "1.1", "HelpDoc" => "https://docs.oi8.cc/proxmoxve/index.htm"];
}
function proxmoxve_ConfigOptions()
{
    return [["type" => "text", "name" => "ProxmoxVE面板地址(面向用户)", "placeholder" => "https://pve.example.com:8006/", "description" => "ProxmoxVE面板地址，面向用户，必须以https://开头，结尾必须以/结尾", "key" => "panel"], ["type" => "text", "name" => "开通节点名称", "placeholder" => "pve", "description" => "PVE面板内显示的节点名称", "key" => "node"], ["type" => "text", "name" => "CPU数量", "placeholder" => "请输入CPU数量", "description" => "CPU数量，单位为[个]，必须为整数", "key" => "cores"], ["type" => "text", "name" => "内存大小", "placeholder" => "请输入内存大小", "description" => "内存大小，单位为[MiB]，必须为整数", "key" => "memory"], ["type" => "text", "name" => "交换分区大小", "placeholder" => "请输入交换分区大小", "description" => "交换分区大小，单位为[MiB]，必须为整数", "key" => "swap"], ["type" => "text", "name" => "无特权的容器", "description" => "是否有特权，填写【是】为有权限，【否】为无权限", "placeholder" => "是", "key" => "privileged"], ["type" => "text", "name" => "系统镜像", "placeholder" => "请输入系统镜像", "description" => "系统镜像,例如：local:vztmpl/debian-10-standard_10.7-1_amd64.tar.gz,获取方法见文档", "key" => "ostemplate"], ["type" => "text", "name" => "磁盘大小", "placeholder" => "请输入磁盘大小", "description" => "磁盘大小，单位为[GiB]，必须为整数", "key" => "disksize"], ["type" => "text", "name" => "磁盘存储位置", "placeholder" => "请输出保存的磁盘名称", "description" => "宿主机上的磁盘名称，保存虚拟硬盘，如local-lvm", "key" => "storage"], ["type" => "text", "name" => "桥接的网卡", "placeholder" => "请输入桥接的网卡", "description" => "桥接的网卡，例如：vmbr0", "key" => "bridge"], ["type" => "text", "name" => "速率限制", "placeholder" => "10", "description" => "速率限制，单位为[Mbps]，必须为整数", "key" => "speed"], ["type" => "text", "name" => "IP地址范围", "placeholder" => "请输入IP地址范围", "description" => "IP地址范围，最后一位不写，如：[172.16.1.]", "key" => "ip"]];
}
function proxmoxve_TestLink($params)
{
    $client = new ProxmoxApi\ProxmoxClient($params["server_ip"] . ":" . $params["port"], $params["server_username"], $params["server_password"], "pam");
    $return = $client->request("GET", "/version", []);
    $return = json_decode($return, true);
    if (6 < $return["data"]["version"]) {
        return "ok";
    }
    return "bad";
}
function proxmoxve_CreateAccount($params)
{
    $vmid = (string) rand(50000, 100000);
    $vmname = "PVELXC" . $vmid;
    $pass = randStr(8);
    $params["password"] = $pass;
    $hostusername = $vmname;
    $params["username"] = $hostusername;
    $client = new ProxmoxApi\ProxmoxClient($params["server_ip"] . ":" . $params["port"], $params["server_username"], $params["server_password"], "pam");
    $userPostdata = ["userid" => $hostusername . "@pve", "password" => $pass, "expire" => 0, "enable" => 1];
    $adduser = $client->request("POST", "/access/users", $userPostdata);
    if ($params["configoptions"]["privileged"] == "是") {
        $privileged = 1;
    } else {
        $privileged = 0;
    }
    $vmPostdata = ["vmid" => $vmid, "hostname" => $vmname, "password" => $pass, "ostemplate" => $params["configoptions"]["ostemplate"], "cores" => (int) $params["configoptions"]["cores"], "memory" => (int) $params["configoptions"]["memory"], "swap" => (int) $params["configoptions"]["swap"], "storage" => $params["configoptions"]["storage"], "rootfs" => $params["configoptions"]["storage"] . ":" . $params["configoptions"]["disksize"], "net0" => "name=eth0,bridge=" . $params["configoptions"]["bridge"] . ",ip=" . $params["configoptions"]["ip"] . rand(10, 234) . "/24,gw=" . $params["configoptions"]["ip"] . "1,ip6=auto,firewall=1,type=veth,rate=" . $params["configoptions"]["speed"], "onboot" => 0, "unprivileged" => $privileged, "arch" => "amd64"];
    $addvm = $client->request("POST", "/nodes/" . $params["configoptions"]["node"] . "/lxc", $vmPostdata);
    $aclPostdata = ["path" => "/vms/" . $vmid, "users" => $hostusername . "@pve", "roles" => "PVEVMUser", "propagate" => 1];
    $acl = $client->request("PUT", "/access/acl", $aclPostdata);
    $update["domainstatus"] = "Active";
    $update["username"] = $hostusername;
    $update["password"] = cmf_encrypt($pass);
    $update["os"] = "Linux";
    think\Db::name("host")->where("id", $params["hostid"])->update($update);
    return "ok";
}
function proxmoxve_Status($params)
{
    $vmid = substr($params["username"], 6);
    $result["status"] = "success";
    $result["data"]["status"] = "unknown";
    $result["data"]["des"] = "获取服务器运行状态失败";
    $client = new ProxmoxApi\ProxmoxClient($params["server_ip"] . ":" . $params["port"], $params["server_username"], $params["server_password"], "pam");
    $return = $client->request("GET", "/nodes/" . $params["configoptions"]["node"] . "/lxc/" . $vmid . "/status/current", []);
    $status = $return->status;
    if ($status == "running") {
        $result["status"] = "success";
        $result["data"]["status"] = "on";
        $result["data"]["des"] = "开机";
    }
    if ($status == "stopped") {
        $result["status"] = "success";
        $result["data"]["status"] = "off";
        $result["data"]["des"] = "关机";
    }
    return $result;
}
function proxmoxve_ClientArea($params)
{
    return ["goPanel" => ["name" => "控制面板信息"]];
}
function proxmoxve_ClientAreaOutput($params, $key)
{
    if ($key == "goPanel") {
        $url = $params["configoptions"]["panel"];
        return ["template" => "templates/gopanel.htm", "vars" => ["url" => $url, "username" => $params["username"], "password" => $params["password"]]];
    }
}
function proxmoxve_TerminateAccount($params)
{
    $vmid = substr($params["username"], 6);
    $client = new ProxmoxApi\ProxmoxClient($params["server_ip"] . ":" . $params["port"], $params["server_username"], $params["server_password"], "pam");
    $return = $client->request("GET", "/nodes/" . $params["configoptions"]["node"] . "/lxc/" . $vmid . "/status/current", []);
    $status = $return->status;
    if ($status == "running") {
        $client = new ProxmoxApi\ProxmoxClient($params["server_ip"] . ":" . $params["port"], $params["server_username"], $params["server_password"], "pam");
        $return = $client->request("POST", "/nodes/" . $params["configoptions"]["node"] . "/lxc/" . $vmid . "/status/stop", []);
        sleep(1);
    }
    $client = new ProxmoxApi\ProxmoxClient($params["server_ip"] . ":" . $params["port"], $params["server_username"], $params["server_password"], "pam");
    $return = $client->request("DELETE", "/nodes/" . $params["configoptions"]["node"] . "/lxc/" . $vmid, []);
    $return = $client->request("DELETE", "/access/users/" . $params["username"] . "@pve", []);
    $update["domainstatus"] = "Terminated";
    think\Db::name("host")->where("id", $params["hostid"])->update($update);
    return "ok";
}

?>