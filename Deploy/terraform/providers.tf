terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG1"
    storage_account_name = "datalakestorage012"
    container_name       = "tfstate"
    key                  = "tfdemo.env01.tfstate"
    #//access_key           = 
  }
}

provider "azurerm" {
  features {}
}