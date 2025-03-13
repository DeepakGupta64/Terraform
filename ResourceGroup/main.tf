terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  name = "Terraform Lab"
  tags = {
            environment = "Lab-01"
            Owner = "Deepak"
  }
}
######################### Real code start from here #################

resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resource_group_name
  location = var.location_name
  tags = local.tags
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.resourcegroup.name
  location                 = azurerm_resource_group.resourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}


resource "azurerm_virtual_network" "TF-VNet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = var.location_name
  address_space       = ["20.0.0.0/16"]
}

    #     resource "random_string" "random" {
    #       length = 10
    #       special = false
    #       upper = false
    #     }
    #     
    #     module "rg-module" {
    #       source = ".\path1"
    #       
    #     }
    #
    #   name = "${var.resource_group_name.name}${var.random.result}"
    #
    #
