
# Deployment Config

resourcegroup_name = "RGeastus2"

location = "eastus2"

tags = {
  "Environment" = "terraform-Lab"
  "Owner"       = "Deepak Gupta"
}

DDoS_Plan_name = "DDoS_Plan_terraform01"

vnet_name = "VNeteastus2"

vnet_address_space = ["10.211.0.0/16"]

subnets = {
  Subnet_1 = {
    name             = "subnet_1"
    address_prefixes = ["10.211.1.0/24"]
  }
  Subnet_2 = {
    name             = "subnet_2"
    address_prefixes = ["10.211.2.0/24"]
  }
  bastion_subnet = {
    name             = "AzureBastionSubnet"
    address_prefixes = ["10.211.250.0/24"]
  }
}

bastionhost_name = "BastionHost"