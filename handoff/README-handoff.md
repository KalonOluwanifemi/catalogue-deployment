# Handoff to the repo owner

Two files go into your repository. Neither is managed by our Terraform.

| File | Destination in your repo |
|---|---|
| `staticwebapp.config.json` | repository root (or the app source root) |
| `deploy.yml` | `.github/workflows/deploy.yml` |

## What we need from you

- The build output structure, so `app_location`, `api_location` and
  `output_location` can be set correctly rather than guessed.
- A secure channel to receive the deployment token.

## Moving from demo to the real repo

Three things change:

1. **Deployment token.** The demo token does not work against the production
   SWA. A new one will be issued.
2. **Build paths.** Confirmed against your actual repo layout.
3. **Redirect URI.** The production SWA has a different hostname, which must
   be added to the production Entra app registration before sign-in works.

## Warning: token regeneration

If the Static Web App is ever destroyed and recreated, the deployment token
changes and your pipeline breaks with an authorization failure. Tell us before
assuming the workflow is at fault.
