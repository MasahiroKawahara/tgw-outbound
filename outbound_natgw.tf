# resource "aws_nat_gateway" "outbound_a" {
#   allocation_id = aws_eip.outbound_a.id
#   subnet_id = aws_subnet.outbound_public_a.id
#   tags = {
#     Name = "${local.outbound.name}-natgw-a"
#   }
#   depends_on = [aws_internet_gateway.outbound]
# }
#  
# resource "aws_eip" "outbound_a" {
#   vpc = true
#   tags = {
#     Name = "${local.outbound.name}-eip-a"
#   }
# }
#  
# resource "aws_nat_gateway" "outbound_c" {
#   allocation_id = aws_eip.outbound_c.id
#   subnet_id = aws_subnet.outbound_public_c.id
#   tags = {
#     Name = "${local.outbound.name}-natgw-c"
#   }
#   depends_on = [aws_internet_gateway.outbound]
# }
#  
# resource "aws_eip" "outbound_c" {
#   vpc = true
#   tags = {
#     Name = "${local.outbound.name}-eip-c"
#   }
# }
