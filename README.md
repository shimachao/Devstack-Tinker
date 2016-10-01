# 安装
安装 Cloudlet 需要先部署好 OpenStack，并在部署好的 OpenStack 上安装一个扩展。而部署 OpenStack 是一个复杂得过程，对电脑主机性能和网络环境都有一定的要求。

## 准备好硬件环境
搭建好 Cloudlet 测试环境，你需要准备一下环境
- 一个 U 盘或移动硬盘，供备份源码或配置文件用。
- 一台性能较好的电脑主机。
- 一个局域网环境，且局域网能连通外网。
- 将电脑主机连接到局域网中，并为其分配固定的 IP 地址。
- 在局域网内预留一段 IP 地址给供后面测试用。

电脑主机最好 4G 以上内存、多核 CPU、固态硬盘、两块网卡。本人在一台 4G 内存的 ThinkPad E40 笔记本上安装好 OpenStack 后，刚运行起来就卡死了。所以内存必须得 4G 以上。固态硬盘是为了加快安装系统和软件的速度。至于双网卡是为了后面网络设置方便。只有一张网卡也行。

## 准备好操作系统
在电脑主机上安装好 Ubuntu 14.04 LTS x64，可以是桌面版，也可以是服务器版，本人安装的是桌面版。Cloudlet 依赖于 Ubuntu 提供的一些软件包，所以必须在 Ubuntu 上安装。而且原作者只在 Ubuntu 14.04 x64 上做了测试。

## 准备好软件环境
1. 替换 Ubuntu 软件源

由于安装过程中需要到 Ubuntu 软件仓库下载大量的软件包，Ubuntu 系统默认的软件源在国外，往往会因为网速问题而导致失败。所以我们可以将 Ubuntu 的软件源替换为国内源。如果你所在的局域网环境搭建好了自己的 Ubuntu 源就更好了。我所在的环境离西电开源社区的软件源更近，所以下面以西电开源社区的源为例来说明。
编辑 /etc/apt/sources.list
```shell
~$ sudo gedit /etc/apt/sources.list
```
将 /etc/apt/sources.list 中的内容替换为下面的西电开源社区的源地址：
```
deb http://ftp.xdlinux.info/ubuntu/ trusty main restricted universe multiverse
deb http://ftp.xdlinux.info/ubuntu/ trusty-security main restricted universe multiverse
deb http://ftp.xdlinux.info/ubuntu/ trusty-updates main restricted universe multiverse
deb http://ftp.xdlinux.info/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://ftp.xdlinux.info/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://ftp.xdlinux.info/ubuntu/ trusty main restricted universe multiverse
deb-src http://ftp.xdlinux.info/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://ftp.xdlinux.info/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://ftp.xdlinux.info/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://ftp.xdlinux.info/ubuntu/ trusty-backports main restricted universe multiverse
```
你也可以选择清华大学的软件源、163源、阿里源等国内源。

2. 同步软件源并更新系统

```
~$ sudo apt-get update
~$ sudo apt-get -y upgrade
```

3. 修改 pip 源

OpenStack 安装过程中同样会下载大量 Python 包，同样由于网络问题，我们需要将 Python 的 pip 源替换为国内源。如果你所在的网络环境有自己的 pip 源就更好了。如果你在清华就使用清华的 pip 源，如果你在中科大就使用中科大的 pip 源。没有就建议使用豆瓣的 pip 源。我所在的环境没有好的 pip 源，所以就选择了豆瓣的 pip 源。下面是豆瓣的 pip 源为例说。
```shell
~$ cd ~
~$ mkdir .pip
~$ gedit .pip/pip.conf
```
在 .pip/pip.conf 中填入下面的豆瓣源地址：
```
[global]
timeout = 60
index-url = http://pypi.douban.com/simple
[install]
trusted-host = pypi.douban.com
```

4. 安装或升级必要的软件包

```
~$ sudo apt-get -y install python-pip python3-pip python-setuptools python3-setuptools git vim openssh-server fabric dos2unix
```
升级 pip
```shell
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
sudo pip install --upgrade os-testr
```
```shell
~$ sudo pip install pyopenssl ndg-httpsclient pyasn1
```
以上这些软件包大多是 Cloudlet 文档要求的，还有一些是本人多次安装过程中遇到错误总结出来的。

## 下载 Cloudlet 和 OpenStack 软件源码并备份
### 下载
```shell
~$ cd ~
~$ git clone https://github.com/cmusatyalab/elijah-provisioning
~$ git clone https://github.com/openstack-dev/devstack
~$ git clone https://github.com/cmusatyalab/elijah-openstack
```
本人将上面上个源码仓库备份到国内网站上。如果以上下载地址失效或网速有问题，你也可以到本人下面的备份地址下载：
```shell
~$ cd ~
~$ git clone https://git.oschina.net/shimachao/elijah-provisioning.git
~$ git clone https://git.oschina.net/shimachao/devstack.git
~$ git clone https://git.oschina.net/shimachao/elijah-openstack.git
```
第一个 elijah-provisioning 源码仓库包含和 BaseVM 相关的一些工具和 Cloudlet 用到的库。

第二个 devstack 源码仓库是用于部署 OpenStack 环境的工具。

第三个 elijah-openstack 源码仓库是针对 OpenStack 的 Cloudlet 扩展。

### 备份

由于 OpenStack 可能会安装失败，你可能会多次重装，所以建议你将上面下载的源码仓库备份起来，方便后面重装时使用。假设你的外接存储介质（U 盘或移动硬盘）在系统上的挂载路径为 /path/to/you/u，在存储介质上创建一个目录 cloudlet_backup。开始备份。
```shell
~$ cd /path/to/you/u/cloudlet_backup/
~$ git clone ~/elijah-provisioning
~$ git clone ~/devstack
~$ git clone ~/elijah-openstack
```
以后重装时就不需要从网上下载源码包了，直接从外接存储介质中备份目录 git clone 就行。
