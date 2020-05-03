variable "redundancy" {
  description = "Storage redundancy option (ZRS, GRS, LRS)"
}
variable "storage_tier" {
  description = "Storage tier (Standard, Premium)"
}
variable "location" {
  description = "Azure region location of the resource"
}
variable "resource_group_name" {
  description = "Resource group placement for this resource"
}
variable "storage_account_name" {
  description = "Name given to the storage"
}