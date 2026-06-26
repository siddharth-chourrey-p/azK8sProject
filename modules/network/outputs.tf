output "vnet_name" {
  description = "The name of the Virtual Network."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  description = "The ID of the dedicated AKS subnet."
  value       = azurerm_subnet.aks_subnet.id
}

output "aks_subnet_name" {
  description = "The name of the dedicated AKS subnet."
  value       = azurerm_subnet.aks_subnet.name
}
