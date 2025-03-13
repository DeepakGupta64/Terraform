variable "location_name" {
  type        = string
  description = "The location for deployment"
  default     = "centralindia"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for deployment"
  default     = "dev-az-cin-rg"

}

variable "stg_acc_name" {
  type        = string
  description = "Storage account name"
  default     = "devazstgacc"

}

variable "iothub_name" {
  type        = string
  description = "Azure IoT Hub"
  default     = "dev-az-cin-ih"

}

variable "stream_analytics_name" {
  type        = string
  description = "Azure Stream Analytics"
  default     = "dev-az-cin-sa"

}

variable "stg_cont_name" {
  type        = string
  description = "Storage Container Name"
  default     = "devazstgcont"

}

variable "stg_cont_bronze" {
  type        = string
  description = "Storage Container Name - Bronze"
  default     = "bronze"

}

variable "stg_cont_silver" {
  type        = string
  description = "Storage Container Name - Silver"
  default     = "silver"

}

variable "stg_cont_gold" {
  type        = string
  description = "Storage Container Name - Gold"
  default     = "gold"

}

variable "file_system_name" {
  type        = string
  description = "File System Name"
  default     = "devazfilesys"

}


variable "synapse_wrksp_name" {
  type        = string
  description = "Synapse Workspace Name"
  default     = "dev-az-cin-syn"

}