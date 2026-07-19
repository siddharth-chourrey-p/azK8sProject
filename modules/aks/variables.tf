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


variable "aks_subnet_id" {
  type        = string
  description = "Subnet ID for the AKS cluster nodes."
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
