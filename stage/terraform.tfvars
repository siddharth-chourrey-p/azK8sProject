resource_group_name          = "stage-rg"
location                     = "southeastasia"
cluster_name                 = "stage-aks"
dns_prefix                   = "stage-dns"
vnet_name                    = "stage-vnet"
vnet_address_space           = ["10.241.0.0/16"]
aks_subnet_name              = "stage-subnet"
aks_subnet_address_prefixes  = ["10.241.0.0/20"]
log_analytics_workspace_name = "stage-law"
kubeconfig_output_path       = "./.kube/config"

default_tags = {
  Environment = "stage"
  ManagedBy   = "AntiGravity-IDE"
  Project     = "AzureK8s"
}
