variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group."
}

variable "location" {
  type        = string
  description = "Azure region for the AKS cluster."
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster."
}

variable "user_assigned_identity_id" {
  type        = string
  description = "Resource ID of the User Assigned Managed Identity."
}

variable "aks_subnet_id" {
  type        = string
  description = "Subnet ID for the AKS cluster nodes."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics workspace ID for OMS agent monitoring."
}

variable "default_node_pool" {
  type = object({
    name                = string
    vm_size             = string
    node_count          = number
    min_count           = number
    max_count           = number
    enable_auto_scaling = bool
    os_disk_size_gb     = number
  })
  description = "Configuration for the default system node pool."
}
