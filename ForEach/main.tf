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

resource "azurerm_resource_group" "rg_block5" {
  for_each = var.rgs
  name     = each.key
  location = each.value
}
