output "cluster_name" {
  description = "The name of the provisioned AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "cluster_id" {
  description = "The ARM ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL for the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}

output "host" {
  description = "The Kubernetes cluster server host FQDN / connection string."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive   = true
}

output "kube_config_raw" {
  description = "Raw Kubernetes config string to connect to the cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}
