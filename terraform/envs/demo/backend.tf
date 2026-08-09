terraform {
  backend "azurerm" {
    # Fill from bootstrap/README.md after running bootstrap-state.sh.
    resource_group_name  = "TODO"
    storage_account_name = "TODO"
    container_name       = "tfstate"
    key                  = "demo.terraform.tfstate"

    # Shared key access is disabled on the storage account.
    use_azuread_auth = true
  }
}
