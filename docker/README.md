Docker环境安装方法
===
网上有很多安装Docker的方法，在这里主要介绍一下在不翻墙的基础上如何快速的安装使用。
目前不翻墙下载Docker和镜像是非常慢的。DockerHub已经在中国有一些镜像服务。如

[https://www.docker-cn.com/registry-mirror](https://www.docker-cn.com/registry-mirror)

[daocloud](https://get.daocloud.io/)

Docker下载目前可以通过`Daocloud`来进行。下面将分别从Windows和Centos7这两个操作系统来分步骤说明docker的安装

# Windows
在Windows安装Docker主要的目的是为了进行开发。官方有两个解决方案，一个是Docker的Windows版，主要通过HyperV来启动虚拟机。这个版本我不建议安装，主要是用VirtualBox习惯了，如果启用HyperV，VBox就不能用了。有些开发用的虚拟机环境就使不了了。另外一个就是使用`Docker Toolbox`。结合VBox来使用Docker。具体的操作步骤如下：

1. 从官网下载安装VirtualBox

2. 去DaoCloud下载Toolbox[https://get.daocloud.io/toolbox/](https://get.daocloud.io/toolbox/)并安装。
Docker Toolbox使用的是`boot2docker`的虚拟机来做为Docker的Host。安装完后会把Docker的执行文件和启动脚本放在安装目录(默认在`c:\Program Files\Docker Toolbox`)。

3. 下载最新的[boot2docker](https://github.com/boot2docker/boot2docker/releases/download/v18.05.0-ce/boot2docker.iso)发在"%USERPROFILE%\.docker\machine\cache\"目录下。

4. 启动安装好后的快捷方式运行初始化。

5. 启动Docker后，这个步骤就比较关键了。要个Boot2Docker加上registry mirror地址。以提高镜像下载速度。
```bash
docker-machine ssh "echo $'EXTRA_ARGS=\"--registry-mirror https://registry.docker-cn.com\"' | sudo tee -a /var/lib/boot2docker/profile && sudo /etc/init.d/docker restart"
```

#参考
[国内 docker 仓库镜像对比](https://ieevee.com/tech/2016/09/28/docker-mirror.html)
