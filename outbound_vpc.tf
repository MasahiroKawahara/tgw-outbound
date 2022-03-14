# -----
# VPC
# -----
resource "aws_vpc" "outbound" {
  cidr_block = local.outbound.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${local.outbound.name}-vpc"
  }
}

# -----
# Internet Gateway
# -----
resource "aws_internet_gateway" "outbound" {
  vpc_id = aws_vpc.outbound.id

  tags = {
    Name = "${local.outbound.name}-igw"
  }
}

# -----
# Subnets
# -----
resource "aws_subnet" "outbound_public_a" {
  vpc_id                   = aws_vpc.outbound.id
  cidr_block               = local.outbound.public_subnet_a_cidr
  availability_zone        = "ap-northeast-1a"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.outbound.name}-public-subnet-a"
  }
}

resource "aws_subnet" "outbound_public_c" {
  vpc_id                   = aws_vpc.outbound.id
  cidr_block               = local.outbound.public_subnet_c_cidr
  availability_zone        = "ap-northeast-1c"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.outbound.name}-public-subnet-c"
  }
}

resource "aws_subnet" "outbound_tgw_a" {
  vpc_id                   = aws_vpc.outbound.id
  cidr_block               = local.outbound.tgw_subnet_a_cidr
  availability_zone        = "ap-northeast-1a"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.outbound.name}-tgw-subnet-a"
  }
}

resource "aws_subnet" "outbound_tgw_c" {
  vpc_id                   = aws_vpc.outbound.id
  cidr_block               = local.outbound.tgw_subnet_c_cidr
  availability_zone        = "ap-northeast-1c"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.outbound.name}-tgw-subnet-c"
  }
}
