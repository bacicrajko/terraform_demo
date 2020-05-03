output "plan" {
  description="service plan reference used in other modules"
  value= azurerm_app_service_plan.example.id
}