output "master_node_ids" {
  value = module.master_node.master_node_ids
}

output "master_node_names" {
  value = module.master_node.master_node_names
}

output "amd64_worker_node_ids" {
  value = module.amd64_worker_node.worker_node_ids
}

output "amd64_worker_node_names" {
  value = module.amd64_worker_node.worker_node_names
}

output "arm64_worker_node_ids" {
  value = module.arm64_worker_node.worker_node_ids
}

output "arm64_worker_node_names" {
  value = module.arm64_worker_node.worker_node_names
}