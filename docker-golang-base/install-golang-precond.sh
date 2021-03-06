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
ssh-keyscan github.com >> githubKey
ssh-keygen -lf githubKey
cat githubKey > ~/.ssh/known_hosts
chmod 600 /root/.ssh/*

