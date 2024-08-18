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

resource "azurerm_resource_group" "rg_block3" {
  name     = "rg_example3"
  location = "westus2"
}

resource "azurerm_storage_account" "storage_block2" {
  depends_on               = [azurerm_resource_group.rg_block3]
  name                     = "storageexampl2"
  resource_group_name      = azurerm_resource_group.rg_block3.name
  location                 = azurerm_resource_group.rg_block3.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container_block" {
  depends_on            = [azurerm_storage_account.storage_block2]
  name                  = "container1"
  storage_account_name  = azurerm_storage_account.storage_block2.name
  container_access_type = "private"
}
