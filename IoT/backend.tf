terraform {
  backend "azurerm" {
    resource_group_name   = "RG1"                     # Resource group name
    storage_account_name  = "datalakestorage012"      # Storage account name
    container_name        = "tfstate"                # Blob container name
    #//key                   = # # Name of the state file
  }
}