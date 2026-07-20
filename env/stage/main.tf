# ============================================================================
# 1. RESOURCE GROUP MODULE
# ============================================================================
module "resource_group" {
  source = "../../modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

# ============================================================================
# 2. VIRTUAL NETWORK & SUBNET MODULE
# ============================================================================
module "network" {
  source = "../../modules/network"

  vnet_name                   = var.vnet_name
  resource_group_name         = module.resource_group.name
  location                    = module.resource_group.location
  vnet_address_space          = var.vnet_address_space
  aks_subnet_name             = var.aks_subnet_name
  aks_subnet_address_prefixes = var.aks_subnet_address_prefixes

  # depends_on: Enforce that the Resource Group is fully ready before deploying network infrastructure
  depends_on = [
    module.resource_group
  ]
}

# ============================================================================
# 3. LOGGING & MONITORING MODULE
# ============================================================================
# module "log_analytics" {
#   source = "../../modules/log_analytics"

#   workspace_name      = var.log_analytics_workspace_name
#   resource_group_name = module.resource_group.name
#   location            = module.resource_group.location

# depends_on: Enforce that the Resource Group is fully ready before deploying logging
#   depends_on = [
#     module.resource_group
#   ]
# }

# ============================================================================
# 4. MANAGED IDENTITY & RBAC MODULE
# ============================================================================
# module "identity" {
#   source = "../../modules/identity"

#   identity_name       = "mi-${var.cluster_name}"
#   resource_group_name = module.resource_group.name
#   location            = module.resource_group.location
#   subnet_id           = module.network.aks_subnet_id

#   # depends_on: Enforce that network infrastructure is fully ready before assigning RBAC permissions
#   depends_on = [
#     module.resource_group,
#     module.network
#   ]
# }

# ============================================================================
# 5. AZURE KUBERNETES SERVICE (AKS) MODULE
# ============================================================================
module "aks" {
  source = "../../modules/aks"

  cluster_name               = var.cluster_name
  resource_group_name        = module.resource_group.name
  location                   = module.resource_group.location
  dns_prefix                 = var.dns_prefix
  user_assigned_identity_id  = module.identity.identity_id
  aks_subnet_id              = module.network.aks_subnet_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
  default_node_pool          = var.default_node_pool

  # depends_on: Explicitly enforce the dependency chain, ensuring network infrastructure,
  # identity permissions (Managed Identities/RBAC), and logging are fully ready before the AKS cluster instantiates.
  depends_on = [
    module.network,
    module.log_analytics,
    module.identity
  ]
}

# ============================================================================
# 6. DYNAMIC SECONDARY NODE POOLS MODULE (FOR_EACH)
# ============================================================================
module "secondary_node_pools" {
  source = "../../modules/node_pool"

  for_each = var.secondary_node_pools

  pool_name             = each.value.name
  kubernetes_cluster_id = module.aks.cluster_id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  enable_auto_scaling   = each.value.enable_auto_scaling
  os_disk_size_gb       = each.value.os_disk_size_gb
  mode                  = each.value.mode
  node_labels           = each.value.node_labels
  node_taints           = each.value.node_taints
  vnet_subnet_id        = module.network.aks_subnet_id

  # depends_on: Ensure the primary AKS cluster is fully operational before attaching secondary node pools
  depends_on = [
    module.aks
  ]
}

