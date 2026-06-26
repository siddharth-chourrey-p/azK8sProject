variable "identity_name" {
  type        = string
  description = "Name of the User Assigned Managed Identity."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group."
}

variable "location" {
  type        = string
  description = "Azure region for the Managed Identity."
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the identity needs Network Contributor role assignment."
}
