variable "subscription_id" {
  description = "Target subscription."
  type        = string
}

variable "location" {
  description = "Azure region. Confirm SWA Standard is offered there."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the demo SWA."
  type        = string
}

variable "swa_name" {
  description = "Name of the demo Static Web App."
  type        = string
}

variable "azure_client_id" {
  description = <<-EOT
    Entra app registration client ID. Leave empty on the first apply, the
    registration does not exist yet.
  EOT
  type    = string
  default = ""
}

variable "azure_client_secret" {
  description = <<-EOT
    Entra client secret. Never put this in terraform.tfvars.
    Pass at apply time: export TF_VAR_azure_client_secret='...'
  EOT
  type      = string
  default   = ""
  sensitive = true
}

variable "tags" {
  type = map(string)
  default = {
    environment = "demo"
    project     = "catalog"
    managed_by  = "terraform"
  }
}
