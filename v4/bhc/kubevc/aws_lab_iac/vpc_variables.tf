variable "vpc_cidr" {
  type = string
  default = "192.168.0.0/16"
}
variable "public_subnet_cidrs" {
  description = "cidr should be match with public_subnet_number"
  type = list(string)
  # default = ["192.168.10.0/24", "192.168.20.0/24"]
  default = ["192.168.10.0/24"]
}