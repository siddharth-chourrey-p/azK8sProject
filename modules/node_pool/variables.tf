variable "pool_name" {
  type        = string
  description = "Name of the node pool."
}

variable "kubernetes_cluster_id" {
  type        = string
  description = "ID of the AKS cluster."
}

variable "vm_size" {
  type        = string
  description = "VM size for the node pool."
}

variable "node_count" {
  type        = number
  description = "Initial node count."
}

variable "min_count" {
  type        = number
  description = "Minimum node count for auto-scaling."
}

variable "max_count" {
  type        = number
  description = "Maximum node count for auto-scaling."
}

variable "enable_auto_scaling" {
  type        = bool
  description = "Enable auto-scaling for the node pool."
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB."
}

variable "mode" {
  type        = string
  description = "Mode of the node pool (System or User)."
}

variable "node_labels" {
  type        = map(string)
  description = "Kubernetes labels applied to the nodes."
}

variable "node_taints" {
  type        = list(string)
  description = "Kubernetes taints applied to the nodes."
}

variable "vnet_subnet_id" {
  type        = string
  description = "Subnet ID for the node pool."
}
