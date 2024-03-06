#!/bin/bash

inventory_path="/tmp/inventory.txt"

read -p "Enter the Path of the SSH Key: " SSH_KEY_PATH
read -p "Enter the UserName of the Master node: " MASTER_USERNAME


while true; do
    read -p "Enter the IP Address of the Master node: " MASTER_IP
    read -p "Enter the SSH Port of the Master node: " MASTER_SSH_PORT

    if [ "$MASTER_IP" = "" ]; then
        break
    elif [[ $MASTER_IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        IFS='.' read -r -a IP_BLOCKs <<< "$MASTER_IP"
        valid_ip=true
        for block in "${IP_BLOCKs[@]}"; do
            if [ "$block" -lt 0 ] || [ "$block" -gt 255 ]; then
                valid_ip=false
            fi
        done
        if $valid_ip; then
            echo -e "($MASTER_IP is valid IP address.)\n"
        break
        else
            echo "(Invalid IP address format. Please try again.)"
        fi
    else
        echo "(Invalid IP address format. Please try again.)"
    fi
done

echo -e "[all:vars]" > "$inventory_path"
echo -e "ansible_ssh_private_key_file=$SSH_KEY_PATH" >> "$inventory_path"
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> "$inventory_path"

echo -e "\n[master_node]" >> "$inventory_path"
echo -e "master ansible_host=$MASTER_IP ansible_ssh_port=$MASTER_SSH_PORT ansible_user=$MASTER_USERNAME" >> "$inventory_path"
echo -e "\n[master_node:vars]" >> "$inventory_path"

echo -e "\n[worker_node]" >> "$inventory_path"
WORKER_COUNT=0

while true; do
    read -p "Enter the UserName of the Worker node(If you want to quit, enter 0): " WORKER_USERNAME
    if [[ "$WORKER_USERNAME" == "0" ]]; then
        break
    fi
    ((WORKER_COUNT++))
    read -p "Enter the Public IP Address of the Worker node: " WORKER_PUBLIC_IP
    read -p "Enter the SSH Port of the Worker node: " WORKER_SSH_PORT
    echo -e "worker$WORKER_COUNT ansible_host=$WORKER_PUBLIC_IP ansible_ssh_port=$WORKER_SSH_PORT ansible_user=$WORKER_USERNAME \n" >> "$inventory_path"
done

echo -e "\n[worker_node:vars]" >> "$inventory_path"

ansible-playbook -i "$inventory_path" ansible_assets/k8s_worker_node_join.yaml 
echo -e "\n\n### K8S worker node was successfully joined to the cluster! ###\n"
rm "$inventory_path"