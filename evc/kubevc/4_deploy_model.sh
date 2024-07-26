#!/bin/bash

inventory_path="/tmp/inventory.txt"

read -p "Enter the Path of the SSH Key: " key_path
read -p "Enter the model directory Path( ex: ./models): " model_directory

read -p "Enter the UserName of the NFS Server: " NFS_SERVER_USERNAME
read -p "Enter the Public IP Address of the NFS Server: " NFS_SERVER_PUBLIC_IP
read -p "Enter the SSH Port of the NFS Server: " NFS_SERVER_SSH_PORT

echo -e "\n[Deploying] the model directory to NFS Server"

echo -e "[all:vars]\n" > "$inventory_path"
echo -e "ansible_ssh_private_key_file=$key_path \n" >> "$inventory_path"
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no' \n" >> "$inventory_path"

echo -e "\n[nfs_node]" >> "$inventory_path"
echo -e "nfs ansible_host=$NFS_SERVER_PUBLIC_IP ansible_ssh_port=$NFS_SERVER_SSH_PORT ansible_user=$NFS_SERVER_USERNAME" >> "$inventory_path"
echo -e "\n[nfs_node:vars]" >> "$inventory_path"

ansible-playbook -i "$inventory_path" ansible_assets/model_deploy.yaml -e "model_directory=$(pwd)/$model_directory"

# scp -P $NFS_SERVER_SSH_PORT -i $key_path -r $model_directory/* $NFS_SERVER_USERNAME@$NFS_SERVER_PUBLIC_IP:/models

echo -e "\n\n### "The model directory were successfully deployed!" ###\n"