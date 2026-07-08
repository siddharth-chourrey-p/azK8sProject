# Azure Kubernetes Service (AKS) Terraform Infrastructure

This repository contains a robust, modular, and production-ready Terraform infrastructure definition for provisioning Azure Kubernetes Service (AKS) clusters across multiple environments (`dev` and `stage`).

## Architecture & Modules

The infrastructure is composed of decoupled, reusable Terraform modules designed for best practices in security, network isolation, identity management, and scalability:

* **[modules/resource_group](file:///Users/siddhu/Documents/Projects/azK8sProject/modules/resource_group)**: Manages the foundational Azure Resource Group with lifecycle protections.
* **[modules/network](file:///Users/siddhu/Documents/Projects/azK8sProject/modules/network)**: Provisions a Virtual Network (VNet) and a dedicated subnet for AKS nodes and pods.
* **[modules/log_analytics](file:///Users/siddhu/Documents/Projects/azK8sProject/modules/log_analytics)**: Establishes a Log Analytics workspace to support container insights, metrics, and logging.
* **[modules/identity](file:///Users/siddhu/Documents/Projects/azK8sProject/modules/identity)**: Configures User-Assigned Managed Identities and RBAC permissions for secure AKS cluster operation.
* **[modules/aks](file:///Users/siddhu/Documents/Projects/azK8sProject/modules/aks)**: Deploys the primary AKS control plane and system node pool with OIDC Issuer URL enabled for Workload Identity federation.
* **[modules/node_pool](file:///Users/siddhu/Documents/Projects/azK8sProject/modules/node_pool)**: Dynamically provisions secondary user node pools (e.g., app workloads, batch processing) with custom sizing, scaling, labels, and taints.

---

## Environments

The repository is structured into distinct environment directories to maintain complete isolation between deployments:

```
.
├── dev/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   └── terraform.tfvars
├── stage/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   └── terraform.tfvars
└── modules/
    ├── aks/
    ├── identity/
    ├── log_analytics/
    ├── network/
    ├── node_pool/
    └── resource_group/
```

### Dev Environment
Located in **[dev/](file:///Users/siddhu/Documents/Projects/azK8sProject/dev)**, pre-configured via [dev/terraform.tfvars](file:///Users/siddhu/Documents/Projects/azK8sProject/dev/terraform.tfvars) for development testing with `10.240.0.0/16` VNet addressing.

### Stage Environment
Located in **[stage/](file:///Users/siddhu/Documents/Projects/azK8sProject/stage)**, pre-configured via [stage/terraform.tfvars](file:///Users/siddhu/Documents/Projects/azK8sProject/stage/terraform.tfvars) for pre-production validation with `10.241.0.0/16` VNet addressing.

---

## Usage & Deployment Guide

### Prerequisites
- [Terraform](https://www.terraform.io/) (`>= 1.5.0`)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/) (`az login`)

### Deploying an Environment

To deploy or update an environment, navigate into the respective environment directory (`dev/` or `stage/`) and execute standard Terraform workflows:

```bash
# 1. Navigate to the desired environment
cd dev

# 2. Initialize Terraform (downloads provider plugins and initializes modules)
terraform init

# 3. Validate configuration syntax
terraform validate

# 4. Preview the infrastructure execution plan
terraform plan

# 5. Apply the configuration to provision Azure resources
terraform apply
```

---

## Automatic Kubeconfig Provisioning

Upon a successful `terraform apply`, the infrastructure configuration automatically writes the cluster's raw `kubeconfig` to `./.kube/config` (configurable via `kubeconfig_output_path`). 

You can instantly interact with your new cluster using `kubectl`:

```bash
export KUBECONFIG="./.kube/config"
kubectl get nodes
```
