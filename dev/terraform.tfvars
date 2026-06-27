resource_group_name          = "dev-rg"
location                     = "eastus"
cluster_name                 = "dev-aks"
dns_prefix                   = "dev-dns"
vnet_name                    = "dev-vnet"
vnet_address_space           = ["10.240.0.0/16"]
aks_subnet_name              = "dev-subnet"
aks_subnet_address_prefixes  = ["10.240.0.0/20"]
log_analytics_workspace_name = "dev-law"
kubeconfig_output_path       = "./.kube/config"

default_tags = {
  Environment = "dev"
  ManagedBy   = "AntiGravity-IDE"
  Project     = "AzureK8s"
}
