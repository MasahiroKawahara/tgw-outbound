# vpc 
resource aws_vpc center {
  cidr_block           = local.center.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.project}-${local.env}-center-vpc"
  }
}

# igw
resource aws_internet_gateway center {
  vpc_id = aws_vpc.center.id

  tags = {
    Name = "${local.project}-${local.env}-center-igw"
  }
}

# public subnet a, c
resource aws_subnet center_public_a {
  vpc_id                   = aws_vpc.center.id
  cidr_block               = local.center.public_subnet_a_cidr
  availability_zone        = "ap-northeast-1a"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.project}-${local.env}-center-public-subnet-a"
  }
}
resource aws_subnet center_public_c {
  vpc_id                   = aws_vpc.center.id
  cidr_block               = local.center.public_subnet_c_cidr
  availability_zone        = "ap-northeast-1c"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.project}-${local.env}-center-public-subnet-c"
  }
}

# public route table, route, route table association
resource aws_route_table center_public {
  vpc_id = aws_vpc.center.id

  tags = {
    Name = "${local.project}-${local.env}-center-public-rtb"
  }
}

resource aws_route center_public_to_igw {
  route_table_id            = aws_route_table.center_public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.center.id
}

resource aws_route_table_association center_public_a {
  subnet_id      = aws_subnet.center_public_a.id
  route_table_id = aws_route_table.center_public.id
}
resource aws_route_table_association center_public_c {
  subnet_id      = aws_subnet.center_public_c.id
  route_table_id = aws_route_table.center_public.id
}

# tgw subnet a, c
resource aws_subnet center_tgw_a {
  vpc_id                   = aws_vpc.center.id
  cidr_block               = local.center.tgw_subnet_a_cidr
  availability_zone        = "ap-northeast-1a"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.project}-${local.env}-center-tgw-subnet-a"
  }
}
resource aws_subnet center_tgw_c {
  vpc_id                   = aws_vpc.center.id
  cidr_block               = local.center.tgw_subnet_c_cidr
  availability_zone        = "ap-northeast-1c"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${local.project}-${local.env}-center-tgw-subnet-c"
  }
}

# EIP and NATGW a,c
resource aws_eip center_a {
  vpc        = true
  depends_on = [aws_internet_gateway.center]

  tags = {
    Name = "${local.project}-${local.env}-center-eip-a"
  }
}
resource aws_nat_gateway center_a {
  allocation_id = aws_eip.center_a.id
  subnet_id     = aws_subnet.center_public_a.id
  depends_on    = [aws_internet_gateway.center]

  tags = {
    Name = "${local.project}-${local.env}-center-natgw-a"
  }
}

resource aws_eip center_c {
  vpc        = true
  depends_on = [aws_internet_gateway.center]

  tags = {
    Name = "${local.project}-${local.env}-center-eip-c"
  }
}
resource aws_nat_gateway center_c {
  allocation_id = aws_eip.center_c.id
  subnet_id     = aws_subnet.center_public_c.id
 depends_on    = [aws_internet_gateway.center]

  tags = {
    Name = "${local.project}-${local.env}-center-natgw-c"
  }
}

# tgw route table, route, route table association a/c
resource aws_route_table center_tgw_a {
  vpc_id = aws_vpc.center.id

  tags = {
    Name = "${local.project}-${local.env}-center-tgw-rtb-a"
  }
}
resource aws_route_table_association center_tgw_a {
  subnet_id      = aws_subnet.center_tgw_a.id
  route_table_id = aws_route_table.center_tgw_a.id
}
resource aws_route center_tgw_to_natgw_a {
  route_table_id            = aws_route_table.center_tgw_a.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.center_a.id
}


resource aws_route_table center_tgw_c {
  vpc_id = aws_vpc.center.id

  tags = {
    Name = "${local.project}-${local.env}-center-tgw-rtb-c"
  }
}
resource aws_route_table_association center_tgw_c {
  subnet_id      = aws_subnet.center_tgw_c.id
  route_table_id = aws_route_table.center_tgw_c.id
}
resource aws_route center_tgw_to_natgw_c {
  route_table_id            = aws_route_table.center_tgw_c.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.center_c.id
}
