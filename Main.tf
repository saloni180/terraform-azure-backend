terraform {
  //terraform version and provider details
  required_version = ">=1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.43.0"
    }
  }
  /*//terraform cloud configuration
  cloud {
    organization = "sal180"
    workspaces {
      name = "Remote"
    }
  }*/
    //remote state configuration
    backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }


}
//sal
provider "azurerm" {
  features {}
  //test
}

  resource "azurerm_resource_group" "rg" {
    name     = "rg-terraform"
    location = var.location
  }

  resource "azurerm_storage_account" "sa" {
    name                     = "sa-terraform"
    location                 = var.location
    resource_group_name      = azurerm_resource_group.rg.name
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

resource azurerm_storage_container "container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource azurerm_storage_blob "blob" {
  name                   = "terraform.tfstate"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
}

