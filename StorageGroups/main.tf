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


resource "azurerm_resource_group" "rg_block2" {
  name     = "reg_example2"
  location = "westus2"
}

resource "azurerm_storage_account" "storage_block1" {
  depends_on               = [azurerm_resource_group.rg_block2]
  name                     = "storeexample1"
  location                 = azurerm_resource_group.rg_block2.location //implicit Dependencies
  resource_group_name      = azurerm_resource_group.rg_block2.name     //implicit Dependencies
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
