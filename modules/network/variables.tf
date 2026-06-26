variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group."
}

variable "location" {
  type        = string
  description = "Azure region for the Virtual Network."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the Virtual Network."
}

variable "aks_subnet_name" {
  type        = string
  description = "Name of the dedicated AKS subnet."
}

variable "aks_subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the dedicated AKS subnet."
}
