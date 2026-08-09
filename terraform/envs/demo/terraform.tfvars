# Non-secret values only. This file IS committed.
#
# The Entra client secret is passed at apply time:
#   export TF_VAR_azure_client_secret='...'
#
# It still lands in state, which is unavoidable while Terraform manages
# app_settings, and is exactly why the state container is locked down.

# subscription_id     = "TODO"
# location            = "TODO"   # confirm SWA Standard is offered there
# resource_group_name = "rg-catalog-demo"
# swa_name            = "swa-catalog-demo"
subscription_id     = "TODO"
location            = "westeurope"   # verify SWA Standard availability
resource_group_name = "rg-catalog-demo"
swa_name            = "swa-catalog-demo"