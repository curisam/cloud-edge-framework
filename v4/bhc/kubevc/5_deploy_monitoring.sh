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

echo -e "\n### Please enter the value for installing Grafana and Prometheus. ###"
read -p "Grafana admin password(ex. admin): " PASSWORD
if [ "$PASSWORD" = "" ]; then
    PASSWORD="admin"
    echo "(Password: $PASSWORD)"
fi

read -p "Ingress path(ex. /monitor): " INGRESS_PATH
if [ -z "$INGRESS_PATH" ]; then
  INGRESS_PATH="/monitor"
  echo "(Ingress path: $INGRESS_PATH)"
elif ! [[ "$INGRESS_PATH" == "/"* ]]; then
  INGRESS_PATH="/$INGRESS_PATH"
fi

read -p "Ingress Virtualhost. It could be domain or wildcard(* or blank): " INGRESS_HOST

# add kube-prometheus helm repo
echo -e "\n[Adding] kube-prometheus helm repository"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts > /dev/null
helm repo update > /dev/null

echo -e "\n[Installing] kube-prometheus-stack"
helm inspect values prometheus-community/kube-prometheus-stack > /tmp/kube-prometheus-stack.values
if [[ "$INGRESS_HOST" = "" || "$INGRESS_HOST" = "*" ]]; then
    helm install prometheus-community/kube-prometheus-stack \
        --create-namespace --namespace monitoring \
        --generate-name --values /tmp/kube-prometheus-stack.values \
        --set grafana.adminPassword=$PASSWORD\
        --set grafana.ingress.enabled=true \
        --set grafana.ingress.ingressClassName=nginx \
        --set grafana.ingress.paths={$INGRESS_PATH} \
        --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
        --set prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues=false \
        > /dev/null
else
    helm install prometheus-community/kube-prometheus-stack \
        --create-namespace --namespace monitoring \
        --generate-name --values /tmp/kube-prometheus-stack.values \
        --set grafana.adminPassword=$PASSWORD\
        --set grafana.ingress.enabled=true \
        --set grafana.ingress.ingressClassName=nginx \
        --set grafana.ingress.paths={$INGRESS_PATH} \
        --set grafana.ingress.hosts={$INGRESS_HOST} \
        --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
        --set prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues=false \
        > /dev/null
fi

echo -e "\n\n### "Grafana and Prometheus for monitoring were successfully deployed!" ###\n"