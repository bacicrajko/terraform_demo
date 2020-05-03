resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_tier
  account_replication_type = var.redundancy
}

output "access_key" {
  value = azurerm_storage_account.example.primary_access_key
}