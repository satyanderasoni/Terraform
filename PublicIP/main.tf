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

resource "azurerm_resource_group" "rg_block8" {
  name     = var.rg.name
  location = var.rg.location
}

resource "azurerm_public_ip" "example" {
  name                    = var.pip.name
  location                = azurerm_resource_group.rg_block8.location
  resource_group_name     = azurerm_resource_group.rg_block8.name
  allocation_method       = var.pip.allocation_method
  idle_timeout_in_minutes = var.pip.idle_timeout_in_minutes
}
