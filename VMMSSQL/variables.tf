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

variable "sql_server_name" {
  type        = string
  description = "Name of the SQL Server"
  default     = "dev-az-cin-sqlserver"

}

variable "sql_db_name" {
  type        = string
  description = "Name of the SQL Database"
  default     = "dev-az-cin-sqldb"

}

variable "administrator_id" {
  type        = string
  description = "User ID for the SQL Server"
  default     = "sqladmin@01"

}

variable "administrator_password" {
  type        = string
  description = "Password for the SQL Server"
  default     = "passw0rd@SQL"

}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name for the virtual machine"
  default     = "dev-az-cin-vmvnn"

}

variable "subnet_name" {
  type        = string
  description = "Subnet name for the virtual network"
  default     = "dev-az-cin-vmsnn"

}

variable "network_interface_name" {
  type        = string
  description = "Network interface name for subnet"
  default     = "dev-az-cin-vmnic"

}

variable "virtual_machine_name" {
  type        = string
  description = "Virtual machine name"
  default     = "dev-az-cin-vm"

}