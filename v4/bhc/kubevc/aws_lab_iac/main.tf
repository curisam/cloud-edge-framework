provider "aws" {
  #Seoul region
  region  = var.region
  profile = var.awscli_profile
}

module "vpc" {
  source               = "./vpc"
  vpc_name             = "${var.main_suffix}-k8s-vpc"
  vpc_cidr             = var.vpc_cidr
  current_region       = data.aws_region.current_region.id
  region_azs           = data.aws_availability_zones.region_azs.names
  public_subnet_cidrs  = var.public_subnet_cidrs
  key_name             = var.key_name
  cluster_prefix       = "${var.main_suffix}-k8s"
}

module "k8s" {
  source                   = "./k8s"
  cluster_prefix           = "${var.main_suffix}-k8s"
  vpc                      = module.vpc.vpc
  public_subnet_ids        = module.vpc.public_subnet_ids
  master_node_number       = var.master_node_number
  amd64_worker_node_number = var.amd64_worker_node_number
  arm64_worker_node_number = var.arm64_worker_node_number
  amd64_instance_type      = var.amd64_instance_type
  arm64_instance_type      = var.arm64_instance_type
  ubuntu_ami               = data.aws_ami.ubuntu_ami
  debian_amd64_ami         = data.aws_ami.debian_amd64_ami
  debian_arm64_ami         = data.aws_ami.debian_arm64_ami
  key_name                 = var.key_name
  ec2_instance_profile     = aws_iam_instance_profile.k8s-cluster-ec2role-instance-profile.name
  depends_on = [
    module.vpc
  ]
}
