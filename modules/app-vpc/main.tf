# vpc
resource aws_vpc main {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.sysname}-${var.env}-vpc"
  }
}

# private subnet a
resource aws_subnet private_a {
  vpc_id                   = aws_vpc.main.id
  cidr_block               = var.private_subnet_a_cidr
  availability_zone        = "ap-northeast-1a"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${var.sysname}-${var.env}-private-subnet-a"
  }
}

# private subnet c
resource aws_subnet private_c {
  vpc_id                   = aws_vpc.main.id
  cidr_block               = var.private_subnet_c_cidr
  availability_zone        = "ap-northeast-1c"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${var.sysname}-${var.env}-private-subnet-c"
  }
}

# private route table
resource aws_route_table private {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.sysname}-${var.env}-private-rtb"
  }
}

# private route table association a
resource aws_route_table_association private_a {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

# private route table association c
resource aws_route_table_association private_c {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private.id
}

# tgw subnets a
resource aws_subnet tgw_a {
  vpc_id                   = aws_vpc.main.id
  cidr_block               = var.tgw_subnet_a_cidr
  availability_zone        = "ap-northeast-1a"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${var.sysname}-${var.env}-tgw-subnet-a"
  }
}

# tgw subnets c
resource aws_subnet tgw_c {
  vpc_id                   = aws_vpc.main.id
  cidr_block               = var.tgw_subnet_c_cidr
  availability_zone        = "ap-northeast-1c"
  map_public_ip_on_launch  = false

  tags = {
    Name = "${var.sysname}-${var.env}-tgw-subnet-c"
  }
}

# tgw route table
resource aws_route_table tgw {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.sysname}-${var.env}-tgw-rtb"
  }
}

# tgw route table association a
resource aws_route_table_association tgw_a {
  subnet_id      = aws_subnet.tgw_a.id
  route_table_id = aws_route_table.tgw.id
}

# tgw route table association c
resource aws_route_table_association tgw_c {
  subnet_id      = aws_subnet.tgw_c.id
  route_table_id = aws_route_table.tgw.id
}

# security group for test instance
resource aws_security_group test {
  name   = "${var.sysname}-${var.env}-instance-sg"
  vpc_id = aws_vpc.main.id
 
  # ingress {}
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  tags = {
    Name = "${var.sysname}-${var.env}-instance-sg"
  }
}
