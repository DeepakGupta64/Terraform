# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "resource" {
  name     = var.resource_group_name
  location = var.location_name
  #tags = local.tags
}

# Create a storage account
resource "azurerm_storage_account" "stgacc" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.resource.name
  location                 = azurerm_resource_group.resource.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  #tags = local.tags
  }

# Create a azure data factory
resource "azurerm_data_factory" "adf" {
  name                = var.azure_data_factory_name
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  #tags = local.tags
}

# Create a azure Logic app consumption based
resource "azurerm_logic_app_workflow" "Logicapp01" {
  name                = var.Logicapp_name
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
}