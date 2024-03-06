#Create Virtual Private Cloud
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
}

#Create Public Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.public_subnet_cidrs)
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.region_azs[count.index]
  enable_resource_name_dns_a_record_on_launch = true
  map_public_ip_on_launch = true

  # tags = {
    # "Name" : "${var.vpc_name}-public-subnet-${substr(var.region_azs[count.index], -1, 1)}"
    # "kubernetes.io/cluster/${var.cluster_prefix}" : "shared"
    # "kubernetes.io/role/elb" : 1
  # }
}

#Create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  # tags = {
    # "Name" : "${var.vpc_name}-public-route-table"
    # "kubernetes.io/cluster/${var.cluster_prefix}" : "shared"
  # }
}

#Route table associations
resource "aws_route_table_association" "public_subnet_route_association" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}