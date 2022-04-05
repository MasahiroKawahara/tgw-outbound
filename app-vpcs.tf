# PrefixList
resource aws_ec2_managed_prefix_list app {
  name           = "app-vpcs"
  address_family = "IPv4"
  max_entries    = 5
}

# APP VPCs
module app1_vpc {
  source = "./modules/app-vpc"

  sysname = local.app1.sysname
  env     = local.app1.env

  vpc_cidr              = local.app1.vpc_cidr
  private_subnet_a_cidr = local.app1.private_subnet_a_cidr
  private_subnet_c_cidr = local.app1.private_subnet_c_cidr
  tgw_subnet_a_cidr     = local.app1.tgw_subnet_a_cidr
  tgw_subnet_c_cidr     = local.app1.tgw_subnet_c_cidr
}
resource aws_ec2_managed_prefix_list_entry app1 {
  prefix_list_id = aws_ec2_managed_prefix_list.app.id
  cidr           = module.app1_vpc.vpc_cidr
  description    = "app1"
}

module app2_vpc {
  source = "./modules/app-vpc"

  sysname = local.app2.sysname
  env     = local.app2.env

  vpc_cidr              = local.app2.vpc_cidr
  private_subnet_a_cidr = local.app2.private_subnet_a_cidr
  private_subnet_c_cidr = local.app2.private_subnet_c_cidr
  tgw_subnet_a_cidr     = local.app2.tgw_subnet_a_cidr
  tgw_subnet_c_cidr     = local.app2.tgw_subnet_c_cidr
}
resource aws_ec2_managed_prefix_list_entry app2 {
  prefix_list_id = aws_ec2_managed_prefix_list.app.id
  cidr           = module.app2_vpc.vpc_cidr
  description    = "app2"
}
