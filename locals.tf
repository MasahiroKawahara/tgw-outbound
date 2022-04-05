locals {
  project = "nwinfra"
  env     = "dev"
}

locals {
  app1 = {
    sysname               = "app1"
    env                   = "dev"
    vpc_cidr              = "10.0.0.0/22"
    private_subnet_a_cidr = "10.0.0.0/25"
    private_subnet_c_cidr = "10.0.0.128/25"
    tgw_subnet_a_cidr     = "10.0.3.224/28"
    tgw_subnet_c_cidr     = "10.0.3.240/28"
  }
}

locals {
  app2 = {
    sysname               = "app2"
    env                   = "dev"
    vpc_cidr              = "10.0.4.0/22"
    private_subnet_a_cidr = "10.0.4.0/25"
    private_subnet_c_cidr = "10.0.4.128/25"
    tgw_subnet_a_cidr     = "10.0.7.224/28"
    tgw_subnet_c_cidr     = "10.0.7.240/28"
  }
}

locals {
  center = {
    vpc_cidr             = "10.254.0.0/24"
    public_subnet_a_cidr = "10.254.0.0/27"
    public_subnet_c_cidr = "10.254.0.32/27"
    tgw_subnet_a_cidr    = "10.254.0.224/28"
    tgw_subnet_c_cidr    = "10.254.0.240/28"
  }
}
