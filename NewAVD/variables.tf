variable "resource_group_location" {
  default     = "australiaeast"
  description = "Location of the resource group - Australia East"
}

variable "rg_name" {
  type        = string
  default     = "AE-DEV-AVD-01-RG"
  description = "Name of the Resource group in which to deploy service objects"
}

variable "workspace" {
  type        = string
  description = "Name of the Azure Virtual Desktop workspace"
  default     = "AE-DEV-AVD-01-WS"
}

variable "hostpool" {
  type        = string
  description = "Name of the Azure Virtual Desktop host pool"
  default     = "AE-DEV-AVD-01-PE-D-HP"
}

variable "app_group_name" {
  description = "Name of the Azure Virtual Desktop application group"
  type        = string
  default     = "AE-DEV-AVD-01-DAG"
}

variable "rfc3339" {
  type        = string
  default     = "2025-03-20T12:43:13Z" #Update this value with a future date
  description = "Registration token expiration"
}

variable "prefix" {
  type        = string
  default     = "AE-DEV-AVD-01-HP-"
  description = "Prefix of the name of the AVD machine(s)"
}

variable "tags" {
  type    = map(string)
  default = {
    Environment = "Dev"
    Department  = "IT"
    Location = "AustraliaEast"
    ServiceClass = "DEV"
    Workload = "Host Pool 01"
  }
}

data "azuread_client_config" "AzureAD" {}

data "azuread_group" "AVDGroup" {
  display_name     = "Win365-Users"  
}