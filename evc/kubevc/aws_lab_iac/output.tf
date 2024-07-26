output "master_node_ids" {
  value = module.k8s.master_node_ids
}

output "amd64_worker_node_ids" {
  value = module.k8s.amd64_worker_node_ids
}

output "arm64_worker_node_ids" {
  value = module.k8s.arm64_worker_node_ids
}