#!/bin/sh
cd ~
apt-get update
apt-get install -y vim wget curl git git-el git-extras git-lfs git-man git-doc openssh-server
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
mkdir -p /root/go/bin
mkdir -p /root/.ssh
