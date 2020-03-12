#!/bin/sh
echo "Installing packages ..."
apt-get update &&\
apt-get install -y vim wget git build-essential openssh-server &&\
apt-get autoremove &&\
rm -rf /var/lib/apt/lists/*
echo "creating the GoPath ..."
mkdir -p /root/go/bin
echo "creating the ssh root folder ..."
mkdir -p /root/.ssh
echo "creating ssh root keys ..."
echo -e "\n\n\n" > ssh-keygen -t rsa 
