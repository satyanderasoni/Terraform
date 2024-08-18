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

resource "azurerm_resource_group" "rg_block7" {
  name     = var.rg.name
  location = var.rg.location
}

resource "azurerm_virtual_network" "vnet_block1" {
  name                = var.vnet.name
  location            = azurerm_resource_group.rg_block7.location
  resource_group_name = azurerm_resource_group.rg_block7.name
  address_space       = var.vnet.address_space
  dns_servers         = var.vnet.dns_servers
}
