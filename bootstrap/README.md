# State backend

Created once via `bootstrap-state.sh`, outside Terraform. Terraform cannot
create the backend it is configured to use.

## Recorded values

Fill these in after running the script, they are needed by every `backend.tf`.

| Field | Value |
|---|---|
| Subscription ID | `TODO` |
| Resource group | `TODO` |
| Storage account | `TODO` |
| Container | `tfstate` |
| Location | `TODO` |
| Created on | `TODO` |
| Created by | `TODO` |

## State keys

| Environment | Key |
|---|---|
| demo | `demo.terraform.tfstate` |
| prod | `prod.terraform.tfstate` |

## Why this is locked down

Terraform state for this project contains the Entra ID client secret (passed
into SWA `app_settings`) and the SWA deployment token. Treat the container as
a secret store: shared key access disabled, RBAC only, versioning and soft
delete on, access granted to the smallest possible set of principals.

Do not relax `allow_shared_key_access` to make a tool work. Fix the tool.
