resource "azurerm_storage_account" "frontend" {
  name                     = "stcloudresumeauedev01"
  resource_group_name      = azurerm_resource_group.crc.name
  location                 = azurerm_resource_group.crc.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  custom_domain {
    name          = "www.janinocencio.xyz"
    use_subdomain = false
  }

  static_website {
    index_document = "index.html"
  }
}