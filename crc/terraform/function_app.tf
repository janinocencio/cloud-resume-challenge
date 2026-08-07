resource "azurerm_linux_function_app" "backend" {
  name                = "funccloudresumeauedev01"
  resource_group_name = azurerm_resource_group.crc.name
  location            = azurerm_resource_group.crc.location
  
  service_plan_id = azurerm_service_plan.functions.id

  storage_account_name       = azurerm_storage_account.frontend.name
  storage_account_access_key = azurerm_storage_account.frontend.primary_access_key

  app_settings = {
  COSMOS_TABLE_CONNECTION = var.cosmos_table_connection
  }
  
  builtin_logging_enabled = false
  client_certificate_mode = "Optional"
  ftp_publish_basic_authentication_enabled = false
  webdeploy_publish_basic_authentication_enabled = false

  site_config {

    ftps_state = "FtpsOnly"
    application_insights_connection_string = azurerm_application_insights.backend.connection_string
    ip_restriction_default_action = "Allow"
    scm_ip_restriction_default_action = "Allow" 

    application_stack {
        python_version = "3.11"
    }
    
    cors {
    allowed_origins = [
      "http://127.0.0.1:5500",
      "https://janinocencio.xyz",
      "https://stcloudresumeauedev01.z8.web.core.windows.net",
      "https://www.janinocencio.xyz",
      ]
    support_credentials = false
    }  
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }  
}