# Client secret lifecycle

STUB.

## Certificates are not an option here

SWA's custom OIDC provider config exposes only `clientIdSettingName` and
`clientSecretSettingName`. There is no certificate credential in that schema.
Certificate-based client authentication is an App Service / Easy Auth
capability, not an SWA one. Do not spend time trying.

## Expiry

Portal caps custom expiry at 24 months. Shorter is better hygiene, but each
rotation carries a small outage risk window. 12 to 18 months with a calendar
alert at minus 30 days is a reasonable middle.

Record the expiry date, app registration object ID, and this procedure
somewhere outside this repository.

## Rotation, order matters

1. **Add** the new secret in the portal.
2. **Update** the `AZURE_CLIENT_SECRET` app setting on the SWA.
3. **Delete** the old secret.

Deleting first is an immediate outage for all new sign-ins.

## Key Vault reference (optional, unverified)

SWA Standard supports Key Vault references for app settings, but it requires
a system-assigned managed identity on the SWA with `get` on secrets. Verify
against current documentation before committing, it changes the Terraform.

Note this does not remove the expiry problem. It only centralises where the
value lives. If Terraform writes the secret into the vault, the secret is
still in state and nothing has been gained but a moving part.
