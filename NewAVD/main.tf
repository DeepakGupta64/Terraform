terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.49.0"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource group name is output when execution plan is applied.
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.resource_group_location
  tags = var.tags
}

# Create AVD workspace
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = var.workspace
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  friendly_name       = "${var.prefix} Workspace"
  description         = "${var.prefix} Workspace"
  tags = var.tags
}

# Create AVD host pool
resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  name                     = var.hostpool
  friendly_name            = var.hostpool
  validate_environment     = true #[true false]
  start_vm_on_connect      = true
  custom_rdp_properties    = "targetisaadjoined:i:1;drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;redirectwebauthn:i:1;use multimon:i:1;enablerdsaadauth:i:1;"
  description              = "${var.prefix} HostPool"
  type                     = "Pooled" #[Pooled or Personal]
  maximum_sessions_allowed = 5
  load_balancer_type       = "DepthFirst" #[BreadthFirst DepthFirst]
  tags = var.tags
scheduled_agent_updates {
  enabled = true
  timezone = "AUS Eastern Standard Time"  # Update this value with your desired timezone
  schedule {
    day_of_week = "Saturday"
    hour_of_day = 1   #[1 here means 1:00 am]
  }
}
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool.id
  expiration_date = var.rfc3339
}

# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = azurerm_resource_group.rg.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  location            = azurerm_resource_group.rg.location
  type                = "Desktop"
  name                = var.app_group_name
  friendly_name       = "Desktop AppGroup"
  description         = "${var.prefix} AVD application group"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool, azurerm_virtual_desktop_workspace.workspace]
  tags = var.tags
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}
