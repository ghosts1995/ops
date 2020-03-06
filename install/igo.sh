#!/bin/bash

wget https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz

tar zxvf go1.13.8.linux-amd64.tar.gz -C /usr/local

mkdir -p /usr/local/gopro
mkdir -p /usr/local/gopro/src
mkdir -p /usr/local/gopro/bin
mkdir -p /usr/local/gopro/pkg

export GOPATH=/root/gopro
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
