locals {
  location = "australiasoutheast"
  subscription_id = "40371827-837f-4329-a4c1-1000a8a29725"
  tenant_id       = "74f9ac2f-c1d2-412f-8435-6e60efdad5e1"
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "leriksen-experiment"

    workspaces {
      name = "ac_auto_acc"
    }
  }
}

provider "azurerm" {
  version                    = "~> 2.0"
  subscription_id            = local.subscription_id
  tenant_id                  = local.tenant_id
  skip_provider_registration = true
  feature {}
}

resource "azurerm_resource_group" "auto_rg" {
  location = local.location
  name = "auto_rg"
}

resource "azurerm_automation_account" "default" {
  location = local.location
  name = "default"
  resource_group_name = azurerm_resource_group.auto_rg.name
  sku_name = "Basic"
}