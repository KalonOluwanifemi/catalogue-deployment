resource "azurerm_static_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Both must be Standard. Custom authentication is not available on Free,
  # and custom authentication is the entire security premise of this project.
  # See modules/static-web-app/README.md before changing either line.
  sku_tier = "Standard"
  sku_size = "Standard"

  app_settings = var.app_settings

  tags = var.tags
}
