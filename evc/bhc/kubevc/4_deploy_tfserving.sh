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

echo -e "[Deleting] existing tfserving deployments"

ports=$(kubectl get svc -n ingress-nginx ingress-nginx-controller -o=jsonpath='{.spec.ports}' | jq "map(select(.port == 80 or .port == 443 ))") > /dev/null 2>&1
kubectl patch svc -n ingress-nginx ingress-nginx-controller --type='json' -p "[{\"op\": \"replace\", \"path\": \"/spec/ports\", \"value\": $ports}]" > /dev/null 2>&1

model_names=( "mobilenet_v1" "inception_v3" "yolo_v5" "bert_imdb" )
for model_name in "${model_names[@]}"
do
  kubectl delete namespace ${model_name/_/-} > /dev/null 2>&1
  kubectl delete pv ${model_name/_/-}-pv > /dev/null 2>&1
  kubectl delete configmap -n ingress-nginx${model_name/_/-}-grpc > /dev/null 2>&1
  var="--tcp-services-configmap=ingress-nginx/${model_name/_/-}-grpc"
  index=`kubectl get deployment -n ingress-nginx ingress-nginx-controller -o json | jq --arg var "$var" '.spec.template.spec.containers[0].args | index($var)'`
  if [ -n $index ]; then
    kubectl patch deployment -n ingress-nginx ingress-nginx-controller --type='json' -p="[{'op': 'remove', 'path': '/spec/template/spec/containers/0/args/$index'}]" > /dev/null 2>&1
  fi
  index=`kubectl get svc -n ingress-nginx ingress-nginx-controller -o json | jq --arg model_name "${model_name/_/-}" '.spec.ports | map(.name == $model_name) | index(true)'`
  if [ -n $index ]; then
    kubectl patch svc -n ingress-nginx ingress-nginx-controller --type='json' -p="[{'op': 'remove', 'path': '/spec/ports/$index'}]" > /dev/null 2>&1
  fi
done

echo -e "\n### Please configure the TensorFlow Serving Container. ###"

read -p "Enter the Private IP Address of the NFS Server: " NFS_SERVER_PRIVATE_IP

# read -p "Select the model name : " ingress_routing_path
echo "Select the model name : "
echo "1. mobilenet_v1"
echo "2. inception_v3"
echo "3. yolo_v5"
echo "4. bert_imdb"

while true; do
  read -p "> " choice
  if [ "$choice" == "1" ]; then
    model_name="mobilenet_v1"
    grpc_port=9000
    break
  elif [ "$choice" == "2" ]; then
    model_name="inception_v3"
    grpc_port=9001
    break
  elif [ "$choice" == "3" ]; then
    model_name="yolo_v5"
    grpc_port=9002
    break
  elif [ "$choice" == "4" ]; then
    model_name="bert_imdb"
    grpc_port=9003
    break
  else
    echo -e "[Wrong Input]: Please try again\n"
  fi
done

# init manifest.yaml
cat << EOF > /tmp/manifest.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: ${model_name/_/-}-pv
spec:
  capacity: #용량
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  nfs:
    server: $NFS_SERVER_PRIVATE_IP
    path: /models/$model_name
EOF

kubectl apply -f /tmp/manifest.yaml > /dev/null

Namespace_name="${model_name/_/-}"
echo "Namespace Name : $model_name"
ingress_routing_path="/$model_name"
echo "REST Ingress Routing Path : $ingress_routing_path"
echo "GRPC Port : $grpc_port"

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

echo -e "\n[Creating] Namespace, Deployment, Service, Ingress in manifest.yaml"
cat << EOF > /tmp/manifest.yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: $Namespace_name
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  namespace: $Namespace_name
  name: ${model_name/_/-}-pvc
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
  volumeName: ${model_name/_/-}-pv
---
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: $Namespace_name
  name: tensorflow-serving-deployment
spec:
  replicas: $count_replicas
  selector:
    matchLabels:
      app: tensorflow-serving
  template:
    metadata:
      labels:
        app: tensorflow-serving
    spec:
      containers:
        - name: tensorflow-serving
          image: kmubigdata/tfserving-armv8:latest
          ports:
            - containerPort: 8501
          volumeMounts:
            - name: model-volume
              mountPath: /models
          command: ["tensorflow_model_server"]
          args:
            - "--port=$grpc_port"
            - "--rest_api_port=8501"
            - "--model_config_file=/models/models.config"
            - "--model_config_file_poll_wait_seconds=60"
            - "--grpc_channel_arguments=grpc.max_send_message_length=50*1024*1024"
            - "--grpc_channel_arguments=grpc.max_receive_length=50*1024*1024"
            - "--grpc_max_threads=1000"
      volumes:
        - name: model-volume
          persistentVolumeClaim:
            claimName: ${model_name/_/-}-pvc
---
apiVersion: v1
kind: Service
metadata:
  namespace: $Namespace_name
  name: tensorflow-serving-service
spec:
  type: ClusterIP
  selector:
    app: tensorflow-serving
  ports:
    - name: http
      protocol: TCP
      port: 8501
      targetPort: 8501
    - name: grpc
      protocol: TCP
      port: $grpc_port
      targetPort: $grpc_port
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: ${model_name/_/-}-grpc
  namespace: ingress-nginx
data:
  $grpc_port: "${model_name/_/-}/tensorflow-serving-service:$grpc_port"
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: $Namespace_name
  name: tensorflow-serving-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /\$2
    nginx.ingress.kubernetes.io/proxy-body-size: 50m
spec:
  ingressClassName: nginx
  rules:
    - http:
        paths:
          - path: $ingress_routing_path(/|$)(.*)
            pathType: ImplementationSpecific
            backend:
              service:
                name: tensorflow-serving-service
                port:
                  number: 8501
EOF

echo -e "\n[Deploying] recources to the cluster"
kubectl apply -f /tmp/manifest.yaml > /dev/null
kubectl patch deployment -n ingress-nginx ingress-nginx-controller --type='json' -p="[{\"op\": \"add\", \"path\": \"/spec/template/spec/containers/0/args/-\", \"value\": \"--tcp-services-configmap=ingress-nginx/${model_name/_/-}-grpc\"}]" > /dev/null
ports=$(kubectl get svc -n ingress-nginx ingress-nginx-controller -o=jsonpath='{.spec.ports}' | jq "map(select(.port == 80 or .port == 443 ))")
modified_ports=$(echo $ports | jq ". + [{\"name\": \"${model_name/_/-}\", \"port\": $grpc_port, \"targetPort\": $grpc_port}]")
kubectl patch svc -n ingress-nginx ingress-nginx-controller --type='json' -p "[{\"op\": \"replace\", \"path\": \"/spec/ports\", \"value\": $modified_ports}]" > /dev/null

echo -e "\n\n### "The resources for tfserving were successfully deployed!" ###\n"