terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.115.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_block6" {
  name     = var.rgs.name
  location = var.rgs.location
}

resource "azurerm_storage_account" "storg_block3" {
  depends_on               = [azurerm_resource_group.rg_block6]
  name                     = var.strgs.name
  resource_group_name      = azurerm_resource_group.rg_block6.name
  location                 = azurerm_resource_group.rg_block6.location
  account_tier             = var.strgs.account_tier
  account_replication_type = var.strgs.account_replication_type
}
