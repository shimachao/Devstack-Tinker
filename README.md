# 在 Ubuntu 14.04 上通过 DevStack 安装 OpenStack 前的准备工作
此脚本的目的是在全新安装的 Ubuntu 14.04 系统上做一些准备工作，以便稍后通过 DevStack 以 All-in-One 的方式安装 OpenStack Kilo 版

由于通过 DevStack 安装 Kilo 版的 OpenStack 经常失败，一般需要多次安装，固有此脚本

# 该脚本干了什么
* 修改 Ubuntu 软件源为本校的镜像源
* 修改 Python 的 PIP 源为本校的镜像源
* 安装 Python-pip、Python3-pip、python-setuptools 和 python3-setuptools
* 安装一些必要的软件 git、vim 等
* 升级 pip
* 安装一些其他的 Python 包
* 从 GitHub 上 git clone devstack 仓库代码
* git clone elijah-openstack 仓库（cloudlet 扩展）
* 将 clone 到本地的 DevStack 代码切换到 stable/kilo 分支

# 文件列表
* init.sh--脚本
* pip.conf--本校 pip 源配置文件
* sources.list--本校的 Ubuntu 14.04 软件源
* local.conf--Devstack stable/kilo 分支 samples 目录下提供的配置文件模板
* local.conf01、local.conf02--本人两次安装过程中使用的配置文件。这两次虽然安装上了，但安装好了的 OpenStack 任有问题，所以只能作参考用