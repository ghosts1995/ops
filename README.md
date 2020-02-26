##### ops 仅限cenots7+

## 防火墙相关


### 选择安装

```text
wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/i.sh | bash
```

##### 设置iptables端口流量转发

````text
wget --no-check-certificate https://raw.githubusercontent.com/ghosts1995/ops/master/install/iptablesForward.sh && chmod +x iptablesForward.sh && ./iptablesForward.sh

````

## 工具安装

> 安装git2.21.1

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/igit.sh | bash && source /etc/bashrc && git --version

````

> 编译安装 php7.2.11

```text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/DevtoinInstallPhp.sh | bash && source /etc/bashrc

```


> 安装SS

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/ssInstall.sh | bash

````

> 安装swoole -v 1.10.5

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/installSwoole.sh | bash

````

> yum 安装nginx

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/inginx.sh | bash

````

> yum 安装php7.2 包含swoole

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/iphp7.2.sh | bash

````


> yum 安装php7.3 包含swoole

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/iphp7.3.sh | bash

````


> centos7.x 安装python3.7.5

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/ipy3-7-5.sh | bash && source /etc/profile

````

> golang install in version 1.13.8

````text
wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/igo.sh | bash && source /etc/profile && go env

````

### 建议安装screen,避免网络抖动

````text
yum -y install screen

> 创建一个screen
screen -S logInstall
> 恢复会话
screen -r logInstall
> 当前进行的会话
screen -ls

> mac & osx out 快捷健
control +a +d
```` 

### init
```text
yum -y install epel-release && yum -y update
yum -y install wget git jwhois bind-utils tmux screen mtr traceroute

```

