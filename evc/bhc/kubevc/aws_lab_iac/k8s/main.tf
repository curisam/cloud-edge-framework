resource "aws_security_group" "cluster_sg" {
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
    },
    {
    cidr_blocks      = [var.vpc.cidr_block]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
    }
  ]
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  vpc_id = var.vpc.id

  tags = {
    "Name" = "${var.cluster_prefix}-cluster-sg"
  }
}

module "master_node" {
  source               = "./master_node"
  cluster_prefix       = var.cluster_prefix
  master_node_number   = var.master_node_number
  cluster_sg_id        = aws_security_group.cluster_sg.id
  vpc                  = var.vpc
  public_subnet_ids    = var.public_subnet_ids
  instance_type        = var.amd64_instance_type
  ubuntu_ami           = var.ubuntu_ami
  ec2_instance_profile = var.ec2_instance_profile
  key_name             = var.key_name
  public_subnet        = data.aws_subnet.public_subnet
}

module "amd64_worker_node" {
  source               = "./worker_node"
  architecture         = "amd64"
  cluster_prefix       = var.cluster_prefix
  worker_node_number   = var.amd64_worker_node_number
  cluster_sg_id        = aws_security_group.cluster_sg.id
  vpc                  = var.vpc
  public_subnet_ids    = var.public_subnet_ids
  instance_type        = var.amd64_instance_type
  debian_ami           = var.debian_amd64_ami
  ec2_instance_profile = var.ec2_instance_profile
  key_name             = var.key_name
  public_subnet        = data.aws_subnet.public_subnet
}

module "arm64_worker_node" {
  source               = "./worker_node"
  architecture         = "arm64"
  cluster_prefix       = var.cluster_prefix
  worker_node_number   = var.arm64_worker_node_number
  cluster_sg_id        = aws_security_group.cluster_sg.id
  vpc                  = var.vpc
  public_subnet_ids    = var.public_subnet_ids
  instance_type        = var.arm64_instance_type
  debian_ami           = var.debian_arm64_ami
  ec2_instance_profile = var.ec2_instance_profile
  key_name             = var.key_name
  public_subnet        = data.aws_subnet.public_subnet
}
