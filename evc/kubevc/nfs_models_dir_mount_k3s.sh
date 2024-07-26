#!/bin/bash

nfs_client_inv_path="/tmp/nfs_client_inventory.txt"

read -p "Enter the Path of the SSH Key: " SSH_KEY_PATH

echo -e "[all:vars]" > "$nfs_client_inv_path"
echo -e "ansible_ssh_private_key_file=$SSH_KEY_PATH" >> "$nfs_client_inv_path"
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> "$nfs_client_inv_path"

echo -e "\n[nfs_client]" >> "$nfs_client_inv_path"

nfs_client_count=0

while true; do
    read -p "Enter the UserName of the NFS Client(you want to quit, enter 0): " nfs_client_username
    if [[ "$nfs_client_username" == "0" ]]; then
        break
    fi
    ((nfs_client_count++))
    read -p "Enter the Public IP of the NFS Client: " nfs_client_ip
    read -p "Enter the SSH Port of NFS Client: " nfs_client_ssh_port
    echo -e "nfs_client$nfs_client_count ansible_host=$nfs_client_ip ansible_ssh_port=$nfs_client_ssh_port ansible_user=$nfs_client_username" >> "$nfs_client_inv_path"
done

echo
read -p "Enter the Private IP of the NFS Server: " nfs_server_ip

echo -e "\n[nfs_client:vars]" >> "$nfs_client_inv_path"
echo -e "nfs_server_ip=$nfs_server_ip" >> "$nfs_client_inv_path"

ansible-playbook -i "$nfs_client_inv_path" ansible_assets/nfs_models_dir_mount.yml

echo -e "\n\n### the models directory was successfully mounted to the NFS Server! ###\n"

rm $nfs_client_inv_path