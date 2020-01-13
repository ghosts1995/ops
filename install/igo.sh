#!/bin/bash

wget https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz

tar zxvf go1.13.6.linux-amd64.tar.gz -C /usr/local

mkdir -p /root/.go

#input evn info
echo "export GOROOT=/usr/local/go" >> /etc/bashrc
echo "export GOPATH=/root/.go"  >> /etc/bashrc
echo "export GOBIN=$GOPATH/bin" >> /etc/bashrc
echo "export PATH=$PATH:$GOROOT/bin" >> /etc/bashrc
echo "export PATH=$PATH:$GOPATH/bin" >> /etc/bashrc

#cat go env 

go env