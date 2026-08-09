#!/usr/bin/env bash
#
# bootstrap-state.sh - create the Terraform remote state backend.
#
# Run ONCE, before any terraform init. Not managed by Terraform, by design:
# Terraform cannot create the backend it is configured to use.
#
# Requires: az cli, logged in, Contributor + User Access Administrator (or
# Owner) on the target subscription.
#
set -euo pipefail

# --- Edit these -------------------------------------------------------------
SUBSCRIPTION_ID=""                       # required
LOCATION="westeurope"
RG_NAME="rg-tfstate-catalog"
# Storage account names: globally unique, lowercase alphanumeric, 3-24 chars.
# Add a random suffix, the plain name is almost certainly taken.
STORAGE_ACCOUNT="sttfstatecatalog$RANDOM"
CONTAINER_NAME="tfstate"
# ---------------------------------------------------------------------------

if [[ -z "${SUBSCRIPTION_ID}" ]]; then
  echo "ERROR: set SUBSCRIPTION_ID at the top of this script." >&2
  exit 1
fi

az account set --subscription "${SUBSCRIPTION_ID}"

echo "==> Resource group: ${RG_NAME}"
az group create \
  --name "${RG_NAME}" \
  --location "${LOCATION}" \
  --output none

echo "==> Storage account: ${STORAGE_ACCOUNT}"
az storage account create \
  --name "${STORAGE_ACCOUNT}" \
  --resource-group "${RG_NAME}" \
  --location "${LOCATION}" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --allow-shared-key-access false \
  --https-only true \
  --output none

# Versioning + soft delete. The state file will contain the Entra client secret
# and the SWA deployment token, so recoverability and tight access both matter.
echo "==> Enabling blob versioning and soft delete"
az storage account blob-service-properties update \
  --account-name "${STORAGE_ACCOUNT}" \
  --resource-group "${RG_NAME}" \
  --enable-versioning true \
  --enable-delete-retention true \
  --delete-retention-days 30 \
  --enable-container-delete-retention true \
  --container-delete-retention-days 30 \
  --output none

# Shared key access is disabled above, so the identity running Terraform needs
# a data-plane RBAC role. Assign it to yourself now.
CURRENT_USER_OID="$(az ad signed-in-user show --query id -o tsv)"
SCOPE="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RG_NAME}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT}"

echo "==> Granting Storage Blob Data Contributor to current user"
az role assignment create \
  --assignee-object-id "${CURRENT_USER_OID}" \
  --assignee-principal-type User \
  --role "Storage Blob Data Contributor" \
  --scope "${SCOPE}" \
  --output none

echo "==> Waiting 30s for RBAC propagation before creating the container"
sleep 30

echo "==> Container: ${CONTAINER_NAME}"
az storage container create \
  --name "${CONTAINER_NAME}" \
  --account-name "${STORAGE_ACCOUNT}" \
  --auth-mode login \
  --output none

cat <<SUMMARY

===========================================================================
Backend created. Record these in bootstrap/README.md and use them in
terraform/envs/<env>/backend.tf:

  resource_group_name  = "${RG_NAME}"
  storage_account_name = "${STORAGE_ACCOUNT}"
  container_name       = "${CONTAINER_NAME}"
  key                  = "demo.terraform.tfstate"   # per environment

  use_azuread_auth     = true    # shared key access is disabled

Note: RBAC assignments can take a few minutes to propagate. If the first
terraform init fails on authorization, wait and retry before debugging.
===========================================================================

SUMMARY
