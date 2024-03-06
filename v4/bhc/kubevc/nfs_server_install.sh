#!/bin/bash

nfs_server_inv_path="/tmp/nfs_server_install_inventory.txt"

read -p "Enter the Path of the SSH Key: " SSH_KEY_PATH

echo -e "[all:vars]" > "$nfs_server_inv_path"
echo -e "ansible_ssh_private_key_file=$SSH_KEY_PATH" >> "$nfs_server_inv_path"
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> "$nfs_server_inv_path"

read -p "Enter the UserName of the node to configure the nfs server.: " nfs_server_username
read -p "Enter the PublicIP of the node to configure the nfs server.: " nfs_server_ip
read -p "Enter the SSH Port of the node to configure the nfs server.: " nfs_server_ssh_port

read -p "Enter the CIDR block of the host that you want to allow to connect to NFS services. (ex: 192.168.10.0/24): " nfs_subnet

echo -e "\n[nfs_server]" >> "$nfs_server_inv_path"
echo -e "nfs_server ansible_host=$nfs_server_ip ansible_ssh_port=$nfs_server_ssh_port ansible_user=$nfs_server_username" >> "$nfs_server_inv_path"

echo -e "\n[nfs_server:vars]" >> "$nfs_server_inv_path"
echo -e "nfs_subnet=$nfs_subnet" >> "$nfs_server_inv_path"

ansible-playbook -i "$nfs_server_inv_path" ansible_assets/nfs_server_install.yml

echo -e "\n\n### the NFS Server was successfully installed! ###\n"

rm $nfs_server_inv_path