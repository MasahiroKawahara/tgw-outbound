output vpc_id {
  value = aws_vpc.main.id
}
output vpc_cidr {
  value = aws_vpc.main.cidr_block
}
output private_subnet_a_id {
  value = aws_subnet.private_a.id
}
output private_subnet_c_id {
  value = aws_subnet.private_c.id
}
output private_route_table_id {
  value = aws_route_table.private.id
}
output tgw_subnet_a_id {
  value = aws_subnet.tgw_a.id
}
output tgw_subnet_c_id {
  value = aws_subnet.tgw_c.id
}
output tgw_route_table_id {
  value = aws_route_table.tgw.id
}
