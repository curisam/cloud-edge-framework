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
METALLB_VERSION="v0.13.10"
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

# ingress controler
echo -e "\n[Deploying] Ingress Nginx Controller"
kubectl create -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-$NGINX_VERSION/deploy/static/provider/baremetal/deploy.yaml > /dev/null 2>&1

# enable strictARP and install MetalLB
echo -e "\n[Setting] Enable strictARP"
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system > /dev/null 2>&1
echo -e "\n[Deploying] MetalLB"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$METALLB_VERSION/config/manifests/metallb-native.yaml > /dev/null 2>&1

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
  autoAssign: true
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

kubectl delete validatingwebhookconfigurations metallb-webhook-configuration > /dev/null
kubectl create -f /tmp/manifest.yaml > /dev/null

# set ingress-controller type as LoadBalancer
kubectl -n ingress-nginx patch service ingress-nginx-controller -p '{"spec":{"type":"LoadBalancer"}}' > /dev/null

echo -e "\n\n### Ingress and LoadBalancer were successfully deployed! ###\n"