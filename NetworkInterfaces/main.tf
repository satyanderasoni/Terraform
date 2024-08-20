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

resource "azurerm_virtual_network" "vnet_block3" {
  depends_on          = [azurerm_resource_group.rg_block8]
  name                = var.vnet.name
  resource_group_name = azurerm_resource_group.rg_block8.name
  location            = azurerm_resource_group.rg_block8.location
  address_space       = var.vnet.address_space
  dns_servers         = var.vnet.dns_servers
}

resource "azurerm_subnet" "subnet2" {
  depends_on           = [azurerm_virtual_network.vnet_block3]
  name                 = var.subnet.name
  resource_group_name  = azurerm_resource_group.rg_block8.name
  virtual_network_name = azurerm_virtual_network.vnet_block3.name
  address_prefixes     = var.subnet.address_prefixes
}

resource "azurerm_network_interface" "nic_block1" {
  depends_on          = [azurerm_subnet.subnet2]
  name                = var.nic.name
  location            = azurerm_resource_group.rg_block8.location
  resource_group_name = azurerm_resource_group.rg_block8.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
