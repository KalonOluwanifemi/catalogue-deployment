terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.81" # verify latest patch at pin time
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
