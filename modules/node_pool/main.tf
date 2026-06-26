resource "azurerm_kubernetes_cluster_node_pool" "pool" {
  name                  = var.pool_name
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = var.vm_size
  node_count            = var.node_count
  min_count             = var.min_count
  max_count             = var.max_count
  enable_auto_scaling   = var.enable_auto_scaling
  os_disk_size_gb       = var.os_disk_size_gb
  mode                  = var.mode
  node_labels           = var.node_labels
  node_taints           = var.node_taints
  vnet_subnet_id        = var.vnet_subnet_id

  # lifecycle: Ignore dynamic node count adjustments made by the auto-scaler
  lifecycle {
    ignore_changes = [
      node_count
    ]
  }
}
