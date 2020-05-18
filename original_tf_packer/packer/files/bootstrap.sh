#!/bin/bash

sudo yum install wget -y
sudo yum install tree -y
sudo wget https://packages.chef.io/files/stable/chef-workstation/0.17.5/el/7/chef-workstation-0.17.5-1.el7.x86_64.rpm
sudo rpm -ivh chef-workstation-0.17.5-1.el7.x86_64.rpm
sudo yum check-update
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
