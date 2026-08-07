output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.crc.name
}

output "storage_static_website_url" {
  description = "Azure Storage static website endpoint"
  value       = azurerm_storage_account.frontend.primary_web_endpoint
}

output "function_app_url" {
  description = "Azure Function App hostname"
  value       = azurerm_linux_function_app.backend.default_hostname
}

output "cosmos_db_endpoint" {
  description = "Cosmos DB account endpoint"
  value       = azurerm_cosmosdb_account.database.endpoint
}