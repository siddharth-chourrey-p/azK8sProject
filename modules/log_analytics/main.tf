resource "azurerm_log_analytics_workspace" "law" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days

  # lifecycle: Ignore retention changes if modified outside Terraform by DevOps admins
  lifecycle {
    ignore_changes = [
      retention_in_days
    ]
  }
}
