resource "azurerm_linux_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  https_only          = var.https_only
  tags                = var.tags

  site_config {
    always_on = true
    application_stack {
      docker_image_name = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.application_insights_connection_string
  }
}
