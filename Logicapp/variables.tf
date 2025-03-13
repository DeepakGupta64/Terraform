variable "location_name" {
  type        = string
  description = "The location for deployment"
  default     = "west us"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for deployment"
  default     = "default-rg-wus-001"

}

variable "storage_account_name" {
  type        = string
  description = "Storage account name"
  default     = "default-stgacc-001"

}

variable "azure_data_factory_name" {
  type        = string
  description = "Azure Data Factory"
  default     = "default-adf-001"

}

variable "Logicapp_name" {
  type        = string
  description = "Azure Logic App"
  default     = "default-TFLogicapp-001"

}