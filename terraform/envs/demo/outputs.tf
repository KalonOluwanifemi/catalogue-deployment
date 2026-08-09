output "default_host_name" {
  description = "Copy into the app registration redirect URI."
  value       = module.static_web_app.default_host_name
}

output "login_callback_uri" {
  description = "The exact redirect URI to paste into the portal."
  value       = "https://${module.static_web_app.default_host_name}/.auth/login/aad/callback"
}

output "api_key" {
  description = "Deployment token. Read with: terraform output -raw api_key"
  value       = module.static_web_app.api_key
  sensitive   = true
}
