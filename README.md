# zjmf-Docker
 智简魔方财务系统，但是Docker，还是开心版

## 使用方法
1. 修改`docker-compose.yml`文件
	- 修改`db`的`environment`项中的环境变量（之后安装时请填写相同的）
	- 修改`db`的`volumes`项`:`之前的目录，设定为数据库存储的目录，该目录必须存在于主机上
2. 启动与停止
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
