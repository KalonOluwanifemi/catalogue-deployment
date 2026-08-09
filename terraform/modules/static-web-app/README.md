# Module: static-web-app

Creates an Azure Static Web App on the Standard SKU, with optional custom
domain.

STUB. Usage example to be added once the module is written.

## Why Standard

The Free plan's preconfigured Entra ID provider accepts **any** Microsoft
account: a personal outlook.com address, or a work account from any other
tenant. All of them authenticate and land in the built-in `authenticated`
role. Restricting sign-in to one tenant requires a custom registration with a
tenant-specific `openIdIssuer`, and custom authentication is Standard-only.

A Free deployment passes a casual test while being open to the world. Do not
downgrade this SKU to save money.
