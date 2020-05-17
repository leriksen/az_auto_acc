locals {
  location = "australiasoutheast"
}

terraform {
  backend "remote" {
    hostname     = "terraform.automation.agl.com.au"
    organization = "AGL"

    workspaces {
      prefix = "workspace-ml-at-scale-"
    }
  }
}
resource "azurerm_resource_group" "auto_rg  " {
  location = local.location
  name = "auto_rg"
}

resource "azurerm_automation_account" "default" {
  location = local.location
  name = "default"
  resource_group_name = azurerm_resource_group.auto_rg.name
  sku_name = "Basic"
}