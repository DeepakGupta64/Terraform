terraform {
  backend "azurerm" {
    resource_group_name   = "RG1"                     # Resource group name
    storage_account_name  = "datalakestorage012"      # Storage account name
    container_name        = "tfstate"                # Blob container name
    #//key                   = # 
  }
}

#backend.tf is not used. Backed details has been added in YML Pipeline (Terraform-CMDs-All-in-One-Pipeline.yml)
