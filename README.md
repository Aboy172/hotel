# 酒店管理系统 



如果hotel-admin和hotel-front文件夹是空的，执行git submodule update --init --recursive命令就可以下载子模块代码了。



## 介绍

使用kalvin-admin模板进行的二次开发的酒店管理系统，数据可视化懒得弄了（有能力的小伙伴可以自己弄一下，很简单）拿去直接当毕设应该没有问题（优秀毕设除外）

## 功能

- 用户

  - [x] 登录退出
  - [x] 订单
  - [x] 客房预定
  - [x] 投诉
  - [x] 评价
  - [x] 搜索客房

  管理员

  - [ ] 数据可视化
  - [x] 用户管理
  - [x] 角色管理
  - [x] 菜单管理
  - [x] 操作日志
  - [x] 酒店管理
  - [x] 房间管理
  - [x] 投诉管理
  - [x] 预定管理

  

## 后台启动教程

1. 导入sql文件下的sql文件夹(自行创建hotels数据库，sql文件不包含创建数据库语句)

2. 配置文件 里填写好数据库账号和密码

3. 启动

 后台访问地址: http://localhost:80

## 前台启动教程

- node版本 16.20.0 可以使用nvm切换到指定版本

进入到portal文件夹下

下载依赖

````bash
npm install
````

启动

````
npm run serve
````

前台地址：http://localhost:8087
