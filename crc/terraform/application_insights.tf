resource "azurerm_application_insights" "backend" {
  name                = "funccloudresumeauedev01"
  resource_group_name = azurerm_resource_group.crc.name
  location            = azurerm_resource_group.crc.location

  application_type    = "web"
  workspace_id        = "/subscriptions/4900ff14-dda8-44d2-8fe4-5d33bb90c7a9/resourceGroups/DefaultResourceGroup-EAU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-4900ff14-dda8-44d2-8fe4-5d33bb90c7a9-EAU"
  retention_in_days   = 90
  sampling_percentage = 0
}