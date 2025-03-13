variable "location_name" {
  type        = string
  description = "The location for deployment"
  default     = "west us"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for deployment"
  default     = "NewRG-099"

}

variable "storage_account_name" {
  type        = string
  description = "Storage account name"
  default     = "stg0986568"

}


variable "vnet_name" {
  type        = string
  description = "The location for deployment"
}
