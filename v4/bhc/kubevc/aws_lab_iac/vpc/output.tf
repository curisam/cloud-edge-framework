output "vpc" {
  value = aws_vpc.vpc
}

output "public_subnet_ids" {
  value = tolist(aws_subnet.public_subnets[*].id)
}
