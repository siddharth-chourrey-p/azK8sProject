variable "workspace_name" {
  type        = string
  description = "Name of the Log Analytics workspace."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group."
}

variable "location" {
  type        = string
  description = "Azure region for the Log Analytics workspace."
}

variable "sku" {
  type        = string
  description = "SKU of the Log Analytics workspace."
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  description = "Log retention in days."
  default     = 30
}
