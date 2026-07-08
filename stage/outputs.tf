output "resource_group_name" {
  description = "The name of the resource group containing the AKS cluster."
  value       = module.resource_group.name
}

output "kubernetes_cluster_name" {
  description = "The name of the provisioned AKS cluster."
  value       = module.aks.cluster_name
}

output "kubernetes_cluster_id" {
  description = "The ARM ID of the AKS cluster."
  value       = module.aks.cluster_id
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL for the AKS cluster, enabling seamless Workload Identity federation."
  value       = module.aks.oidc_issuer_url
}

output "host" {
  description = "The Kubernetes cluster server host FQDN / connection string."
  value       = module.aks.host
  sensitive   = true
}

output "kube_config" {
  description = "Raw Kubernetes config string to connect to the cluster. Exported for automated dev discovery."
  value       = module.aks.kube_config_raw
  sensitive   = true
}

output "kubeconfig_local_path" {
  description = "The local file path within the AntiGravity IDE workspace where the kubeconfig was automatically provisioned."
  value       = var.kubeconfig_output_path
}

output "node_pools" {
  description = "Map of created secondary node pools with their respective configuration details."
  value = {
    for k, v in module.secondary_node_pools : k => {
      id         = v.id
      name       = v.name
      vm_size    = v.vm_size
      node_count = v.node_count
    }
  }
}
