data "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_ids)
  id = var.public_subnet_ids[count.index]
}