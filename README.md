# zjmf-Docker
 智简魔方财务系统，但是Docker，还是开心版
 
 源码来自<https://github.com/aazooo/zjmf>，本仓库只负责容器化
 
 附：摘录的安装指南
 
 > 3. 填写授权码的时候，随便填写一个的32位大写的MD5字符串，例如可以在[这里生成](https://md5jiami.bmcx.com/)。（之前安装过的可以跳过此步骤） 该官方安装包已经集成部分常用插件，无需再去商店购买。
 > 4. 安装完之后默认就是专业版，所有专业版的功能均可使用。
 > 5. 如果上传了第三方付费插件或模板，使用过程中提示插件未购买，需要在php配置文件（php.ini）加入idcsmart.app这个配置项，配置第三方插件标识，多个插件标识用英文逗号隔开，例如：
 >    ```
 >    idcsmart.app=AliPayDmf,Smsbao,Subemail
 >    ```
 >    重启php进程，在后台系统升级页面，已授权模块处，点击“拉取授权”。即可使用付费的第三方插件或模板。

提示：修改php配置文件时，直接在`/usr/local/etc/php/conf.d/`目录新建任意名称的`.ini`文件，并添加配置项即可

## 使用方法
### 0. 先安装`docker`和`docker-compose`
### 1. 修改`docker-compose.yml`文件
- 修改`db`的`environment`项中的环境变量（之后安装时请填写相同的）
- 修改`db`的`volumes`项`:`之前的目录，设定为数据库存储的目录，该目录必须存在于主机上
### 2. 启动与停止
输入以下命令在前台启动
```
docker-compose up --build
```
在后台启动
```
docker-compose up --build -d
```
停止
```
docker-compose down
```
之后启动可以省略`--build`
