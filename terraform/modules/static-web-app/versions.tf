terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # Verify the latest patch at pin time. The project doc cited 4.81.0,
      # confirm against the registry rather than trusting that number.
      version = "~> 4.81"
    }
  }
}
