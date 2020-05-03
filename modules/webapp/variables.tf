variable "location" {
  description = "Azure region location of the resource"
}
variable "resource_group_name" {
  description = "Resource group placing of the resource"
}
variable "plan_id" {
  description = "Id of the app service plan connected to this app"
}
variable "always_on" {
  description = "Is this application always running"
}
variable "storage_connection_string" {
  description = "Connection string for Azure Storage account"
}
variable "app_name" {
  description = "Name for the web apllication (affects DNS entry)"
}