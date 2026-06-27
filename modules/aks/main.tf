resource "azurerm_kubernetes_cluster" "aks" {
  name                      = var.cluster_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.dns_prefix
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name            = var.default_node_pool.name
    vm_size         = var.default_node_pool.vm_size
    node_count      = var.default_node_pool.node_count
    min_count       = var.default_node_pool.min_count
    max_count       = var.default_node_pool.max_count
    os_disk_size_gb = var.default_node_pool.os_disk_size_gb
    vnet_subnet_id  = var.aks_subnet_id
    type            = "VirtualMachineScaleSets"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  # lifecycle: Ignore node_count changes caused by cluster auto-scaler during live operations
  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}
