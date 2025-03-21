variable "resource_group_name" {
  type    = string
  default = "synapse-rg"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "storage_account_name" {
  type    = string
  default = "synapsestorage1234"
}

variable "synapse_workspace_name" {
  type    = string
  default = "synapse-workspace"
}

variable "sql_admin_login" {
  type    = string
  default = "adminuser"
}

variable "sql_admin_password" {
  type    = string
  default = "P@ssword1234"
  sensitive = true
}

variable "sql_pool_name" {
  type    = string
  default = "synapse-sqlpool"
}
