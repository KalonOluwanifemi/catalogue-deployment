variable "name" {
  description = "Name of the Static Web App."
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group to create the SWA in."
  type        = string
}

variable "location" {
  description = <<-EOT
    Azure region. Static Web Apps is only offered in a limited set of regions,
    and the list is shorter than for most services. Confirm the target region
    against current docs before the first apply, a bad value fails here for
    reasons unrelated to the design.
  EOT
  type        = string
}

variable "app_settings" {
  description = <<-EOT
    Application settings. Carries AZURE_CLIENT_ID and AZURE_CLIENT_SECRET,
    referenced by name from staticwebapp.config.json.

    Empty on the first apply, by design: the app registration cannot exist
    yet because it needs this resource's hostname for its redirect URI.
  EOT
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "custom_domain" {
  description = <<-EOT
    FQDN to attach, e.g. catalog.nmc2.info. Leave null to skip entirely.
    Demo never sets this. Prod sets it only once the CNAME resolves.
  EOT
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the SWA."
  type        = map(string)
  default     = {}
}
