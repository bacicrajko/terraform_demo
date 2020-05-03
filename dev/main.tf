#initializing remote state in azure blob storage container
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state"
    storage_account_name = "terraformstaterb"
    container_name       = "tfstate"
    key                  = "demo.terraform.tfstate"
    access_key           = "Glk6aFicny/RPgLm1EQzRdeMrA/YZQ791t7yGjL/mU6UF1Nm+TGb3YhBBMfftdqrJsiC6wtDaDg46KacJ4Yd0Q=="
  }
}
#load up the provisioner
provider "azurerm" {
  version = "=2.6.0"
  features {
  }
}

locals {
  resource_group = {
    location = "West Europe"
    name = "terraform-demo-development"
  }
  service_plan = {
    plan_size = "B1"
    plan_tier = "Basic"
  }

  web_app = {
    always_on = false
    app_name = "development-tfdemo-rb"
  }

  storage = {
    storage_tier = "Standard"
    redundancy = "LRS"
    account_name = "devstorageaccounttdrb"
  }
}

resource "azurerm_resource_group" "rg" {
  location = local.resource_group.location
  name = local.resource_group.name
}

module "app_plan" {
  source = "../modules/serviceplan"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  plan_size = local.service_plan.plan_size
  plan_tier = local.service_plan.plan_tier
}

module "web_app" {
  source = "../modules/webapp"
  always_on = local.web_app.always_on
  location = azurerm_resource_group.rg.location
  plan_id = module.app_plan.plan
  resource_group_name = azurerm_resource_group.rg.name
  storage_connection_string = module.storage_account.access_key
  app_name = local.web_app.app_name
}

module "storage_account" {
  source = "../modules/storage"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  redundancy = local.storage.redundancy
  storage_account_name = local.storage.account_name
  storage_tier = local.storage.storage_tier
}