variable "vpc" {}
variable "public_subnet_ids" {}
variable "cluster_prefix" {}
variable "master_node_number" {}
variable "amd64_worker_node_number" {}
variable "arm64_worker_node_number" {}
variable "amd64_instance_type" {}
variable "arm64_instance_type" {}
variable "ubuntu_ami" {}
variable "debian_amd64_ami" {}
variable "debian_arm64_ami" {}
variable "key_name" {}
variable "ec2_instance_profile" {}
# variable "monitoring-efs-id" {}