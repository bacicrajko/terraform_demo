resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind = "Linux"
  reserved = true

  sku {
    tier = var.plan_tier
    size = var.plan_size
  }
}