output "id" {
  description = "ID of the node pool."
  value       = azurerm_kubernetes_cluster_node_pool.pool.id
}

output "name" {
  description = "Name of the node pool."
  value       = azurerm_kubernetes_cluster_node_pool.pool.name
}

output "vm_size" {
  description = "VM size of the node pool."
  value       = azurerm_kubernetes_cluster_node_pool.pool.vm_size
}

output "node_count" {
  description = "Node count of the node pool."
  value       = azurerm_kubernetes_cluster_node_pool.pool.node_count
}
