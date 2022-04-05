# tgw attachment
resource aws_ec2_transit_gateway_vpc_attachment app {
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = var.vpc_id
  subnet_ids         = [ var.private_subnet_a_id, var.private_subnet_c_id ]

  transit_gateway_default_route_table_propagation = true
  transit_gateway_default_route_table_association = false

  tags = {
    Name = "${var.sysname}-${var.env}-tgw-attachment"
  }
}

# tgw route table association
resource aws_ec2_transit_gateway_route_table_association app {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app.id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}

# vpc route
resource aws_route app_to_tgw {
  route_table_id            = var.private_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  transit_gateway_id        = var.transit_gateway_id
}
