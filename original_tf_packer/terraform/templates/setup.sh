#!/bin/bash
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart sshd

# Add user chef-training
useradd chef-training
yum install expect -y
# Set password for user
SET_PASSWORD=$(expect -c "
set timeout 10
spawn passwd chef-training
expect \"New password:\"
send \"123Chef321\r\"
expect \"Retype new password:\"
send \"123Chef321\r\"
expect eof
")
echo "$SET_PASSWORD"
# # Give user sudo access
usermod -aG wheel,root chef-training

