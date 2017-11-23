#!/bin/bash
#
# Install base packages
# 
# Author : Shailesh Sutar

sudo apt-add-repository ppa:ansible:ansible -y

sudo apt-get update
sudo apt-get upgrade

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ansible git

git clone https://github.com/shaileshsutar88/ansible.git -o /etc/ansible/ops