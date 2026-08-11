resource "azurerm_cosmosdb_account" "database" {
  name                = "acdbtablecloudresumeauedev01"
  resource_group_name = azurerm_resource_group.crc.name
  location            = azurerm_resource_group.crc.location

  offer_type = "Standard"
  kind       = "GlobalDocumentDB"

  automatic_failover_enabled = true

  capabilities {
    name = "EnableTable"
  }

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level = "BoundedStaleness"

    max_interval_in_seconds = 86400
    max_staleness_prefix    = 1000000
  }

  geo_location {
    location          = azurerm_resource_group.crc.location
    failover_priority = 0
  }

  # Ignoring all tags in the meantime

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_cosmosdb_table" "visitor_counter" {
  name                = "visitorCounter"
  resource_group_name = azurerm_resource_group.crc.name
  account_name        = azurerm_cosmosdb_account.database.name
}