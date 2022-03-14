# -----
# VPC
# -----
resource "aws_vpc" "workload1" {
  cidr_block = local.workload1.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${local.workload1.name}-vpc"
  }
}

# -----
# Subnets
# -----
resource "aws_subnet" "workload1_private_a" {
  vpc_id                   = aws_vpc.workload1.id
  cidr_block               = local.workload1.private_subnet_a_cidr
  availability_zone        = "ap-northeast-1a"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.workload1.name}-private-subnet-a"
  }
}

resource "aws_subnet" "workload1_private_c" {
  vpc_id                   = aws_vpc.workload1.id
  cidr_block               = local.workload1.private_subnet_c_cidr
  availability_zone        = "ap-northeast-1c"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.workload1.name}-private-subnet-c"
  }
}

resource "aws_subnet" "workload1_tgw_a" {
  vpc_id                   = aws_vpc.workload1.id
  cidr_block               = local.workload1.tgw_subnet_a_cidr
  availability_zone        = "ap-northeast-1a"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.workload1.name}-tgw-subnet-a"
  }
}

resource "aws_subnet" "workload1_tgw_c" {
  vpc_id                   = aws_vpc.workload1.id
  cidr_block               = local.workload1.tgw_subnet_c_cidr
  availability_zone        = "ap-northeast-1c"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.workload1.name}-tgw-subnet-c"
  }
}
