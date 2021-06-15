resource "aws_vpc" "cspm_vpc" {
  cidr_block = "192.168.10.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
}

variable "aws_subnets" {
  default = ["192.168.10.0/26", "192.168.10.64/26", "192.168.10.128/26", "192.168.10.192/26"]
}

variable "aws_azs" {
  default = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]
}

resource "aws_subnet" "cspm_subnet" {
  count = length(var.aws_subnets)
  vpc_id = aws_vpc.cspm_vpc.id
  cidr_block = var.aws_subnets[count.index]
  availability_zone = var.aws_azs[count.index]

  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "cspm_igw" {
  vpc_id = aws_vpc.cspm_vpc.id
}

resource "aws_route_table" "cspm_route_table" {
  vpc_id = aws_vpc.cspm_vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.cspm_igw.id
  }
}

resource "aws_route_table_association" "cspm_routing" {
  count = length(var.aws_subnets)

  route_table_id = aws_route_table.cspm_route_table.id
  subnet_id = aws_subnet.cspm_subnet.*.id[count.index]
}