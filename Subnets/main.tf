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

resource "azurerm_virtual_network" "vnet_block2" {
  depends_on          = [azurerm_resource_group.rg_block7]
  name                = var.vnet.name
  resource_group_name = azurerm_resource_group.rg_block7.name
  location            = azurerm_resource_group.rg_block7.location
  address_space       = var.vnet.address_space
  dns_servers         = var.vnet.dns_servers
}

resource "azurerm_subnet" "subnet_block" {
  depends_on           = [azurerm_virtual_network.vnet_block2]
  name                 = var.subnet.name
  resource_group_name  = azurerm_resource_group.rg_block7.name
  virtual_network_name = azurerm_virtual_network.vnet_block2.name
  address_prefixes     = var.subnet.address_prefixes
}
