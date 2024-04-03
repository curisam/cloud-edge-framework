#!/bin/bash

validate_ip_block() {
  local IP="$1"

  if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        IFS='.' read -r -a IP_BLOCKS <<< "$IP"
        for block in "${IP_BLOCKS[@]}"; do
            if [ "$block" -lt 0 ] || [ "$block" -gt 255 ]; then
                return 1
            fi
        done
    else
        return 1
    fi
    return 0
}

NGINX_VERSION="v1.8.1"
METALLB_VERSION="0.13.10"
LOADBALANCER_IP_POOL=""

files=($HOME/.kube/*)
echo "Please select number from the cluster name list"
cluster_indices=()
cluster_index=0

for i in "${!files[@]}"; do
  if [[ ! "${files[$i]}" == *"/cache" ]]; then
    echo "$cluster_index. $(basename ${files[$i]})"
    cluster_indices+=("$i")
    ((cluster_index++))
  fi
done

while true; do
  read -p "> " choice

  if [ "$choice" -ge 0 ] && [ "$choice" -lt ${#cluster_indices[@]} ]; then
    selected_file=${files[ ${cluster_indices[$choice]} ]}
    selected_cluster_name=$(basename $selected_file)
    echo -e "[Selected Cluster]: $selected_cluster_name"
    export KUBECONFIG=$HOME/.kube/"$selected_cluster_name"
    break
  else
    echo -e "[Wrong Input]: Please try again\n"
  fi
done

# add metallb helm repo
echo -e "\n[Adding] MetalLB helm repository"
helm repo add metallb https://metallb.github.io/metallb > /dev/null
helm repo update > /dev/null

echo -e "\n[Installing] MetalLB"
kubectl create namespace metallb-system > /dev/null
helm install metallb metallb/metallb --namespace metallb-system > /dev/null

echo -e "\n### Please set loadbalancer's IP pool.The IP pool must be in the same network. ###"
echo -e "Loadbalancer's IP(ex: 192.168.10.210-192.168.10.220)" 
while true; do
  read -p "> " LOADBALANCER_IP_POOL

  IFS='-' read -r START_IP END_IP <<< "$LOADBALANCER_IP_POOL"

  valid_start_ip=false
  valid_end_ip=false

  validate_ip_block "$START_IP" && valid_start_ip=true
  validate_ip_block "$END_IP" && valid_end_ip=true

  if $valid_start_ip && $valid_end_ip; then
      echo -e "($LOADBALANCER_IP_POOL is valid IP address range.)"
      break
  else
      echo "(Invalid IP address format. Please try again.)"
  fi
done

# init manifest.yaml
cat << EOF > /tmp/manifest.yaml
---
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
  - $LOADBALANCER_IP_POOL
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
    - default
---
EOF

sleep 10;

while true; do
        output=$(kubectl create -f /tmp/manifest.yaml --kubeconfig=$HOME/.kube/k3s 2>&1)
        echo "$output" | grep "created" > /dev/null
        if [[ $? -ne 0 ]]; then
                sleep 1
        else
                break
        fi
done

while true; do
    read -p "Enter the Public IP Address of the Ingress Controller within LB Address Pool : " INGRESS_IP

    if [ "$INGRESS_IP" = "" ]; then
        break
    elif [[ $INGRESS_IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        IFS='.' read -r -a IP_BLOCKs <<< "$INGRESS_IP"
        valid_ip=true
        for block in "${IP_BLOCKs[@]}"; do
            if [ "$block" -lt 0 ] || [ "$block" -gt 255 ]; then
                valid_ip=false
            fi
        done
        if $valid_ip; then
            echo "($INGRESS_IP is valid IP address.)"
        break
        else
            echo "(Invalid IP address format. Please try again.)"
        fi
    else
        echo "(Invalid IP address format. Please try again.)"
    fi
done

# init manifest.yaml
cat << EOF > /tmp/manifest.yaml
service:
  spec:
    loadBalancerIP: $INGRESS_IP
EOF

# add metallb helm repo
echo -e "\n[Adding] Nginx Ingress Controller helm repository"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx > /dev/null
helm repo update > /dev/null

echo -e "\n[Installing] Nginx Ingress Controller"
kubectl create namespace ingress-nginx > /dev/null
helm install ingress-nginx ingress-nginx/ingress-nginx -f /tmp/manifest.yaml --namespace ingress-nginx > /dev/null

echo -e "\n\n### Ingress and LoadBalancer were successfully deployed! ###\n"