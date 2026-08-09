resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "static_web_app" {
  source = "../../modules/static-web-app"

  name                = var.swa_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = var.tags

  # First apply: leave both variables empty and this map stays empty.
  # Second apply, after the portal app registration exists: set the two
  # TF_VARs and these populate.
  app_settings = var.azure_client_id == "" ? {} : {
    AZURE_CLIENT_ID     = var.azure_client_id
    AZURE_CLIENT_SECRET = var.azure_client_secret
  }

  # Demo has no custom domain. Left explicit rather than omitted so the
  # decision is visible.
  custom_domain = null
}
