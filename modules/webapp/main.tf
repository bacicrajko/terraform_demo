
resource "azurerm_app_service" "example" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.plan_id

  site_config {
    linux_fx_version = "DOTNETCORE|3.1"
  }

  connection_string {
    name  = "StorageStr"
    type  = "Custom"
    value = var.storage_connection_string
  }
}
