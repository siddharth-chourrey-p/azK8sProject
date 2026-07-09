variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group. Can be injected via TF_VAR_resource_group_name in the AntiGravity IDE."
  default     = "stage-rg"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be deployed. Can be injected via TF_VAR_location."
  default     = "eastus"
}

variable "cluster_name" {
  type        = string
  description = "The name of the AKS cluster. Can be injected via TF_VAR_cluster_name."
  default     = "stage-aks"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix specified when creating the managed cluster. Can be injected via TF_VAR_dns_prefix."
  default     = "stage-dns"
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network for AKS. Can be injected via TF_VAR_vnet_name."
  default     = "stage-vnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the Virtual Network."
  default     = ["10.241.0.0/16"]
}

variable "aks_subnet_name" {
  type        = string
  description = "Name of the dedicated subnet for AKS nodes and pods."
  default     = "stage-subnet"
}

variable "aks_subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the dedicated AKS subnet."
  default     = ["10.241.0.0/20"]
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Name of the Log Analytics workspace for AKS container insights."
  default     = "stage-law"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to be applied to all resources. Useful for tracking AntiGravity IDE workspace deployments."
  default = {
    Environment = "stage"
    ManagedBy   = "Terraform"
    Project     = "AzureK8s"
  }
}

variable "default_node_pool" {
  type = object({
    name                = string
    vm_size             = string
    node_count          = number
    min_count           = optional(number, 1)
    max_count           = optional(number, 3)
    enable_auto_scaling = optional(bool, true)
    os_disk_size_gb     = optional(number, 30)
  })
  description = "Configuration for the default system node pool in AKS."
  default = {
    name                = "systempool"
    vm_size             = "Standard_D2s_v5"
    node_count          = 1
    min_count           = 1
    max_count           = 1
    enable_auto_scaling = true
    os_disk_size_gb     = 30
  }
}

variable "secondary_node_pools" {
  type = map(object({
    name                = string
    vm_size             = string
    node_count          = number
    min_count           = optional(number, 1)
    max_count           = optional(number, 1)
    enable_auto_scaling = optional(bool, true)
    os_disk_size_gb     = optional(number, 20)
    mode                = optional(string, "User")
    node_labels         = optional(map(string), {})
    node_taints         = optional(list(string), [])
  }))
  description = "Map of objects defining secondary node pools (e.g., app workloads, batch processing). Can be dynamically populated via TF_VAR_secondary_node_pools."
  default = {
    app = {
      name                = "apppool"
      vm_size             = "Standard_D4s_v5"
      node_count          = 1
      min_count           = 1
      max_count           = 1
      enable_auto_scaling = true
      mode                = "User"
      node_labels         = { workload = "application", environment = "stage" }
    },
    batch = {
      name                = "batchpool"
      vm_size             = "Standard_D4s_v5"
      node_count          = 1
      min_count           = 1
      max_count           = 1
      enable_auto_scaling = true
      mode                = "User"
      node_labels         = { workload = "batch", priority = "low" }
      node_taints         = ["workload=batch:NoSchedule"]
    }
  }
}


