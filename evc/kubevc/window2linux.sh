sed -i 's/\r$//' \
1_environment_setup_localhost.sh \
2.1_k3s_cluster_initialize.sh \
2.1_k8s_cluster_initialize.sh \
2.2_k3s_worker_node_join.sh \
2.2_k8s_worker_node_join.sh \
3_deploy_ingress_and_loadbalancer.sh \
3_deploy_ingress_and_loadbalancer_k3s.sh \
4_deploy_model.sh \
4_deploy_tfserving.sh \
4_deploy_tfserving_k3s.sh \
5_deploy_monitoring.sh \
nfs_models_dir_mount_k3s.sh \
nfs_server_install.sh \
models/model_download.sh

## for macOS edit first line to
# sed -i "" 's/\r$//'
