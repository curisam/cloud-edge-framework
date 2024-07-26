#!/bin/bash

CALICO_VERSION="v3.26.1"

echo -e "### Initialize K8S Cluster ###"
echo -e "\n[Set K8S Cluster information]"
echo -n "K8s cluster name: "
read CLUSTER_NAME
if [ "$CLUSTER_NAME" = "" ]; then
    CLUSTER_NAME="kubernetes"
fi

#ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

while true; do
    echo -n "control plane IP address: "
    read MASTER_IP_ADDRESS

    if [ "$MASTER_IP_ADDRESS" = "" ]; then
        break
    elif [[ $MASTER_IP_ADDRESS =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        IFS='.' read -r -a IP_BLOCKs <<< "$MASTER_IP_ADDRESS"
        valid_ip=true
        for block in "${IP_BLOCKs[@]}"; do
            if [ "$block" -lt 0 ] || [ "$block" -gt 255 ]; then
                valid_ip=false
            fi
        done
        if $valid_ip; then
            echo "$MASTER_IP_ADDRESS is valid IP address."
        break
        else
            echo "Invalid IP address format. Please try again."
        fi
    else
        echo "Invalid IP address format. Please try again."
    fi
done

if [ "$MASTER_IP_ADDRESS" = "" ]; then
      LOCAL_IP_ADDRESS=`ip addr | grep global | head -n 1 | awk '{print $2}'`
      CLEANED_IP_ADDRESS=${LOCAL_IP_ADDRESS%%/*}
      MASTER_IP_ADDRESS=$CLEANED_IP_ADDRESS
fi

#ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
echo -n "cluster IP range as CIDR: "
read CLUSTER_CIDR
if [ "$CLUSTER_CIDR" = "" ]; then
    CLUSTER_CIDR="172.17.0.0/16"
fi

#ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

echo -n "token: "
read TOKEN
if [ "$TOKEN" = "" ]; then
    TOKEN=$(sudo kubeadm token generate)
fi

#ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

echo -n "Time-To-Live for token as seconds. 0 for no expiration. :"
read TOKEN_TTL
if [ "$TOKEN_TTL" = "" ]; then
    TOKEN_TTL="0"
fi


#ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
#ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

cat << EOF > /tmp/init.yaml
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: v1.27.3
clusterName: "$CLUSTER_NAME"
apiServer:
  certSANs:
    - "127.0.0.1"
controlPlaneEndpoint: "$MASTER_IP_ADDRESS:6443"
imageRepository: registry.k8s.io
networking:
  podSubnet: "$CLUSTER_CIDR"
---
apiVersion: kubeadm.k8s.io/v1beta3
kind: InitConfiguration
bootstrapTokens:
- groups:
  - system:bootstrappers:kubeadm:default-node-token
  token: "$TOKEN"
  ttl: "$TOKEN_TTL"
  usages:
  - signing
  - authentication

EOF

echo -e "\n[Reset] Kubernetes Cluster"
sudo kubeadm reset -f > /dev/null 2>&1
echo -e "\n[Initialize] Kubernetes control-plane "
sudo kubeadm init --config=/tmp/init.yaml > /dev/null 2>&1

echo -e "\n[Configuration] for using Kubernetes Cluster"
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo chmod 600 $HOME/.kube/$CLUSTER_NAME

echo -e "\n[Create] Calico CNI plugin"
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/$CALICO_VERSION/manifests/calico.yaml > /dev/null

echo -e "\n\n### K8S Cluster was successfully initialized! ###"