# 酒店管理系统-服务端



后端重构中

登录账号：admin，密码123456

前台账号：dev，密码123456

因为服务端没有维护session会话，因此每次服务端重启后，会丢失session，前端需要重新登录让服务端记录session即可，可以自己用redis实现一下，原本的模板文件里已经配置了redis工具类

