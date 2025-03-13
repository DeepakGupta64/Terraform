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
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location_name
}

# Create a storage account
resource "azurerm_storage_account" "stg_acc" {
  name                     = var.stg_acc_name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

#Create a container inside storage account
resource "azurerm_storage_container" "stg_cont" {
  name                  = var.stg_cont_name
  storage_account_name  = azurerm_storage_account.stg_acc.name
  container_access_type = "private"
}

#Create a container inside storage account
resource "azurerm_storage_container" "stg_cont_bronze" {
  name                  = var.stg_cont_bronze
  storage_account_name  = azurerm_storage_account.stg_acc.name
  container_access_type = "private"
}

#Create a container inside storage account
resource "azurerm_storage_container" "stg_cont_silver" {
  name                  = var.stg_cont_silver
  storage_account_name  = azurerm_storage_account.stg_acc.name
  container_access_type = "private"
}

#Create a container inside storage account
resource "azurerm_storage_container" "stg_cont_gold" {
  name                  = var.stg_cont_gold
  storage_account_name  = azurerm_storage_account.stg_acc.name
  container_access_type = "private"
}


# Create an azure iothhub
resource "azurerm_iothub" "iothhub" {
  name                         = var.iothub_name
  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = azurerm_resource_group.resource_group.location

  sku {
    name     = "F1"  # Free Tier
    capacity = 1     # Free tier supports only one unit
  }
}

# Create an Azure Stream Analytics Job
resource "azurerm_stream_analytics_job" "stream_analytics_job" {
  name                                     = var.stream_analytics_name
  resource_group_name                      = azurerm_resource_group.resource_group.name
  location                                 = azurerm_resource_group.resource_group.location
  compatibility_level                      = "1.2"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 1  # Free tier supports up to 5 units

  transformation_query = <<QUERY
    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
QUERY
}


#Configure Input for Stream Analytics Job
data "azurerm_stream_analytics_job" "stream_analytics_job_i" {
  name                = azurerm_stream_analytics_job.stream_analytics_job.name
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_stream_analytics_stream_input_iothub" "stream_analytics_job_i" {
  name                         = "iothub-input"
  stream_analytics_job_name    = data.azurerm_stream_analytics_job.stream_analytics_job_i.name
  resource_group_name          = data.azurerm_stream_analytics_job.stream_analytics_job_i.resource_group_name
  endpoint                     = "messages/events"
  eventhub_consumer_group_name = "$Default"
  iothub_namespace             = azurerm_iothub.iothhub.name
  shared_access_policy_key     = azurerm_iothub.iothhub.shared_access_policy[0].primary_key
  shared_access_policy_name    = "iothubowner"

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}

#Configure Output for Stream Analytics Job
data "azurerm_stream_analytics_job" "stream_analytics_job_o" {
  name                = azurerm_stream_analytics_job.stream_analytics_job.name
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_stream_analytics_output_blob" "stream_analytics_job_o" {
  name                      = "blobstorage-output"
  stream_analytics_job_name = data.azurerm_stream_analytics_job.stream_analytics_job_o.name
  resource_group_name       = data.azurerm_stream_analytics_job.stream_analytics_job_o.resource_group_name
  storage_account_name      = azurerm_storage_account.stg_acc.name
  storage_account_key       = azurerm_storage_account.stg_acc.primary_access_key
  storage_container_name    = azurerm_storage_container.stg_cont.name
  path_pattern              = "iot-data/{date}/{time}"
  date_format               = "yyyy-MM-dd"
  time_format               = "HH"

  serialization {
    type     = "Json"
    format = "LineSeparated"
    encoding = "UTF8"
  }
}

#Create a Synapse workspace
resource "azurerm_storage_data_lake_gen2_filesystem" "file_system" {
  name               = var.file_system_name
  storage_account_id = azurerm_storage_account.stg_acc.id
}

resource "azurerm_synapse_workspace" "synapse_worskpace" {
  name                                 = var.synapse_wrksp_name
  resource_group_name                  = azurerm_resource_group.resource_group.name
  location                             = azurerm_resource_group.resource_group.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.file_system.id
  sql_administrator_login              = "sqladmin"
  sql_administrator_login_password     = "Passw0rd@SYN"

  identity {
    type = "SystemAssigned"
  }
}