# Azure Static Web App, Standard SKU.
#
# STUB - resource definition to be added.
#
# Notes for whoever writes this:
#   - sku_tier / sku_size must both be "Standard". Custom authentication is
#     not available on Free, and that is the entire security premise.
#   - Standard SKU is not offered in every region. Confirm the target region
#     is on the current supported list before the first apply.
#   - app_settings carries AZURE_CLIENT_ID and AZURE_CLIENT_SECRET. Both are
#     empty on the first apply, by design: the app registration does not
#     exist yet because it needs this resource's hostname first.
