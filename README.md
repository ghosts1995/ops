# ops 仅限cenots7+

## 设置iptables端口流量转发

````text
wget --no-check-certificate https://raw.githubusercontent.com/ghosts1995/ops/master/install/iptablesForward.sh && chmod +x iptablesForward.sh && ./iptablesForward.sh

````

## 安装git2.9.5

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/gitInstall.sh | bash && source /etc/bashrc && git --version

````

## 安装SS

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/ssInstall.sh | bash

````


##编译安装 php7.2.11

```text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/DevtoinInstallPhp.sh | bash && source /etc/bashrc

```

## 安装swoole -v 1.10.5

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/installSwoole.sh | bash

````
## yum 安装nginx

````text

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/yumInstallnginx.sh | bash

````


# 建议安装screen,避免网络抖动
yum -y install screen

## 创建一个screen

screen -S logInstall

## 恢复会话

screen -r logInstall

## 当前进行的会话

screen -ls

#### mac out 快捷健
control +a +d
