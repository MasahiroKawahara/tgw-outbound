# tgw
resource aws_ec2_transit_gateway main {
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "${local.project}-${local.env}-tgw"
  }
}

# tgw attachment (center)
resource aws_ec2_transit_gateway_vpc_attachment center {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.center.id
  subnet_ids         = [ aws_subnet.center_tgw_a.id, aws_subnet.center_tgw_c.id ]

  transit_gateway_default_route_table_propagation = true
  transit_gateway_default_route_table_association = false

  tags = {
    Name = "${local.project}-${local.env}-center-tgw-attachment"
  }
}

# tgw route table association(center)
resource aws_ec2_transit_gateway_route_table_association center {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.center.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.main.propagation_default_route_table_id
}

# vpc route (center)
resource aws_route center_tgw {
  route_table_id             = aws_route_table.center_public.id
  destination_prefix_list_id = aws_ec2_managed_prefix_list.app.id
  transit_gateway_id         = aws_ec2_transit_gateway.main.id
}

# tgw route table and route (app)
resource aws_ec2_transit_gateway_route_table app {
  transit_gateway_id = aws_ec2_transit_gateway.main.id

  tags = {
    Name = "${local.project}-${local.env}-app-tgwrtb"
  }
}
resource aws_ec2_transit_gateway_route app_default {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.center.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app.id
}
resource aws_ec2_transit_gateway_prefix_list_reference app_blackhole {
  blackhole                      = true
  prefix_list_id                 = aws_ec2_managed_prefix_list.app.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app.id
}

# tgw attachment app1 (includes tgwrtb association and vpc routing)
module app1_tgwatt {
  source = "./modules/app-tgw-attachment"

  sysname = local.app1.sysname
  env     = local.app1.env

  vpc_id                         = module.app1_vpc.vpc_id
  private_subnet_a_id            = module.app1_vpc.private_subnet_a_id
  private_subnet_c_id            = module.app1_vpc.private_subnet_c_id
  private_route_table_id         = module.app1_vpc.private_route_table_id
  transit_gateway_id             = aws_ec2_transit_gateway.main.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app.id
}

# tgw attachment app2 (includes rtb association and vpc routing)
module app2_tgwatt {
  source = "./modules/app-tgw-attachment"

  sysname = local.app2.sysname
  env     = local.app2.env

  vpc_id                         = module.app2_vpc.vpc_id
  private_subnet_a_id            = module.app2_vpc.private_subnet_a_id
  private_subnet_c_id            = module.app2_vpc.private_subnet_c_id
  private_route_table_id         = module.app2_vpc.private_route_table_id
  transit_gateway_id             = aws_ec2_transit_gateway.main.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app.id
}
