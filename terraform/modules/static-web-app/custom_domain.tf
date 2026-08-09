# Inert until var.custom_domain is set. Demo leaves it null.
resource "azurerm_static_web_app_custom_domain" "this" {
  count = var.custom_domain == null ? 0 : 1

  static_web_app_id = azurerm_static_web_app.this.id
  domain_name       = var.custom_domain

  # Subdomain: the CNAME is itself the ownership proof, no TXT token.
  # dns-txt-token would only apply to an apex domain or pre-validation.
  validation_type = "cname-delegation"

  # The CNAME must already exist and resolve, or this hangs and then fails.
  # If it turns out to be flaky, a time_sleep between the CNAME and this
  # resource is the usual fix.
}
