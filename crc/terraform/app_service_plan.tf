resource "azurerm_service_plan" "functions" {
  name                = "AustraliaEastLinuxDynamicPlan"
  resource_group_name = azurerm_resource_group.crc.name
  location            = azurerm_resource_group.crc.location

  os_type  = "Linux"
  sku_name = "Y1"
}