terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerem"
      version = "3.115.0"
    }
  }
}
provider "azurerm" {
  features {}
}


