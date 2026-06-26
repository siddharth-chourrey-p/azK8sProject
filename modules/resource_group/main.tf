resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  # lifecycle: Protect the foundational resource group from accidental deletion
  # in a collaborative IDE environment.
  lifecycle {
    prevent_destroy = false # Set to false for dev/testing cleanup, toggle to true for prod
    ignore_changes = [
      tags["CreationDate"]
    ]
  }
}
