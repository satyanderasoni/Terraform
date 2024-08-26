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

resource "azurerm_resource_group" "rg12_block" {
  name     = var.vm.resource_group_name
  location = var.vm.location
}

resource "azurerm_virtual_network" "vnet4_block" {
  depends_on          = [azurerm_resource_group.rg12_block]
  name                = var.vm.vnet_name
  resource_group_name = azurerm_resource_group.rg12_block.name
  location            = azurerm_resource_group.rg12_block.location
  address_space       = var.vm.address_space
  dns_servers         = var.vm.dns_servers
}

resource "azurerm_subnet" "subnet_block3" {
  depends_on           = [azurerm_virtual_network.vnet4_block]
  name                 = var.vm.subnet_name
  resource_group_name  = azurerm_resource_group.rg12_block.name
  virtual_network_name = azurerm_virtual_network.vnet4_block.name
  address_prefixes     = var.vm.address_prefixes
}

resource "azurerm_network_interface" "nic_block2" {
  depends_on          = [azurerm_subnet.subnet_block3]
  name                = var.vm.nic_name
  location            = azurerm_resource_group.rg12_block.location
  resource_group_name = azurerm_resource_group.rg12_block.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_block3.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "vm1_block" {
  depends_on            = [azurerm_network_interface.nic_block2]
  name                  = var.vm.vm_name
  location              = azurerm_resource_group.rg12_block.location
  resource_group_name   = azurerm_resource_group.rg12_block.name
  network_interface_ids = [azurerm_network_interface.nic_block2.id]
  vm_size               = "Standard_DS1_v2"
  storage_os_disk {
    name              = var.vm.storage_os_disk
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vm1"
    admin_username = "admin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
