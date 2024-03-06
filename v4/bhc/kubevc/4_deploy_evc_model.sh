#!/bin/bash

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
    echo -e "[Selected Cluster]: $selected_cluster_name\n"
    export KUBECONFIG=$HOME/.kube/"$selected_cluster_name"
    break
  else
    echo -e "[Wrong Input]: Please try again\n"
  fi
done

read -p "base image path (dockerhub) : " BASE_IMAGE_PATH
read -p "target cpu arch (lower case) : " CPU_ARCH

while true; do
  read -p "Number of replicas: " count_replicas
  if [ -z "$count_replicas" ]; then
    count_replicas=1
    break
  elif [[ "$count_replicas" =~ ^[0-9]+$ ]] && ! [[ "$count_replicas" -le 0 ]]; then
    break
  else
    echo "(Wrong Input. Please try again.)"
  fi
done

cat << EOF > /tmp/manifest.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: evc-deployment-$CPU_ARCH
  labels:
    app: evc-pod-$CPU_ARCH
spec:
  replicas: $count_replicas
  selector:
    matchLabels:
      app: evc-pod-$CPU_ARCH
  template:
    metadata:
      labels:
        app: evc-pod-$CPU_ARCH
    spec:
      containers:
      - name: evc-test
        image: $BASE_IMAGE_PATH
        imagePullPolicy: IfNotPresent
        command: ["python", "app.py"]
        ports:
        - containerPort: 7860
      nodeSelector:
        key: $CPU_ARCH
---
apiVersion: v1
kind: Service
metadata:
  name: evc-app-$CPU_ARCH
  labels:
    app: evc-pod-$CPU_ARCH
spec:
  type: LoadBalancer
  ports:
  - port: 7860
  selector:
    app: evc-pod-$CPU_ARCH

EOF