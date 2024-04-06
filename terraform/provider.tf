provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "rajtfstate"
    container_name       = "rajfolder"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
}