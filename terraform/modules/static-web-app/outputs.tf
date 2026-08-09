output "id" {
  description = "Resource ID of the Static Web App."
  value       = azurerm_static_web_app.this.id
}

output "default_host_name" {
  description = <<-EOT
    Generated *.azurestaticapps.net hostname.

    This is the reason the first apply exists. Copy it into the Entra app
    registration redirect URI:
      https://<this>/.auth/login/aad/callback
  EOT
  value = azurerm_static_web_app.this.default_host_name
}

output "api_key" {
  description = <<-EOT
    Deployment token, delivered to the repo owner as a GitHub secret.

    Regenerates if this SWA is ever destroyed and recreated, which silently
    breaks CI in a repository we do not control. Warn the owner before any
    replace, and check this first if their pipeline starts failing on auth.
  EOT
  value     = azurerm_static_web_app.this.api_key
  sensitive = true
}
