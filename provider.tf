terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = var.sid
  tenant_id       = var.tid
  client_id       = var.cid
  client_secret   = var.secret
  
}