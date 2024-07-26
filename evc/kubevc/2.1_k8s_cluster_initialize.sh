#!/bin/bash

inventory_path="/tmp/inventory.txt"

read -p "Enter the Path of the SSH Key: " SSH_KEY_PATH
read -p "Enter the UserName of the Master node: " MASTER_USERNAME

while true; do
    read -p "Enter the Public IP Address of the Master node: " MASTER_PUBLIC_IP
    read -p "Enter the SSH Port of the Master node: " MASTER_SSH_PORT

    if [ "$MASTER_PUBLIC_IP" = "" ]; then
        break
    elif [[ $MASTER_PUBLIC_IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        IFS='.' read -r -a IP_BLOCKs <<< "$MASTER_PUBLIC_IP"
        valid_ip=true
        for block in "${IP_BLOCKs[@]}"; do
            if [ "$block" -lt 0 ] || [ "$block" -gt 255 ]; then
                valid_ip=false
            fi
        done
        if $valid_ip; then
            echo "($MASTER_PUBLIC_IP is valid IP address.)"
        break
        else
            echo "(Invalid IP address format. Please try again.)"
        fi
    else
        echo "(Invalid IP address format. Please try again.)"
    fi
done

echo -e "[all:vars]\n" > "$inventory_path"
echo -e "ansible_ssh_private_key_file=$SSH_KEY_PATH \n" >> "$inventory_path"
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no' \n" >> "$inventory_path"

echo -e "\n[master_node]" >> "$inventory_path"
echo -e "master ansible_host=$MASTER_PUBLIC_IP ansible_ssh_port=$MASTER_SSH_PORT ansible_user=$MASTER_USERNAME" >> "$inventory_path"
echo -e "\n[master_node:vars]" >> "$inventory_path"

echo -e "\n[local]" >> "$inventory_path"
echo -e "localhost ansible_host=127.0.0.1 ansible_user=localhost" >> "$inventory_path"
echo -e "\n[local:vars]" >> "$inventory_path"

echo -e "\n\n### Please enter the information of your cluster ###"

while true; do
    read -p "Enter the K8S cluster name: " CLUSTER_NAME

    if [ -z "$CLUSTER_NAME" ]; then
        CLUSTER_NAME="kubernetes"
    fi

    if [ -e "$HOME/.kube/$CLUSTER_NAME" ]; then
        echo "The cluster name($CLUSTER_NAME) already exists. Please choose a different name."
    else
        break
    fi
done

read -p "Cluster IP range as CIDR: " CLUSTER_CIDR
if [ "$CLUSTER_CIDR" = "" ]; then
    CLUSTER_CIDR="172.17.0.0/16"
fi

ansible-playbook -i "$inventory_path" ansible_assets/k8s_cluster_init.yaml -e "MASTER_PUBLIC_IP=$MASTER_PUBLIC_IP" -e "CLUSTER_NAME=$CLUSTER_NAME" -e "CLUSTER_CIDR=$CLUSTER_CIDR"
echo -e "\n\n### K8S Cluster was successfully initialized! ###"
rm "$inventory_path"

#Download .kube/config file from master node
mkdir -p ~/.kube
LOCAL_PATH="$HOME/.kube"
scp -P $MASTER_SSH_PORT -i "$SSH_KEY_PATH" "$MASTER_USERNAME"@"$MASTER_PUBLIC_IP":/tmp/config "$LOCAL_PATH"/"$CLUSTER_NAME"
chmod 600 $HOME/.kube/$CLUSTER_NAME

echo -e "\n\n### "Download of config file from the master node was complete!" ###\n"