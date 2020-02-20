#!/bin/bash

wget https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz

tar zxvf go1.13.8.linux-amd64.tar.gz -C /usr/local

mkdir -p /root/go
mkdir -p /root/go/src
mkdir -p /root/go/bin
mkdir -p /root/go/pkg


#input evn info
echo "export GO111MODULE=auto" >> /etc/bashrc
echo "export GOROOT=/usr/local/go" >> /etc/bashrc
echo "export GOPATH=/root/go"  >> /etc/bashrc
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> /etc/bashrc

#cat go env 
