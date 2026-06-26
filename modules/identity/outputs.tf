output "principal_id" {
  description = "The Principal ID of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "identity_id" {
  description = "The Resource ID of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.identity.id
}

output "client_id" {
  description = "The Client ID of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.identity.client_id
}
