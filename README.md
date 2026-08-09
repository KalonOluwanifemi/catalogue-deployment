# catalog-deployment

Azure Static Web App (Standard) serving an HTML catalog, restricted to
employees of a single Microsoft Entra ID tenant.

Target: `catalog.nmc2.info` (DNS deferred, see `docs/dns-handoff.md`)

## Layout

| Path | Purpose |
|---|---|
| `bootstrap/` | One-time CLI creation of the Terraform state backend. Not managed by Terraform. |
| `terraform/modules/static-web-app/` | Reusable SWA module. |
| `terraform/envs/demo/` | Demo environment root module. Build and test here first. |
| `terraform/envs/prod/` | Production root module. Intentionally empty for now. |
| `handoff/` | Files delivered to the repo owner. Never applied by Terraform. |
| `docs/` | Manual procedures: app registration, DNS, secret rotation, negative test. |

## Build order

1. `bootstrap/bootstrap-state.sh` - create the state backend, record the values.
2. `terraform/envs/demo` - apply a bare Standard SWA with no auth wired up.
   The only goal is to bring the generated `*.azurestaticapps.net` hostname
   into existence.
3. Portal app registration for demo, using that hostname as the redirect URI.
   Write `docs/app-registration.md` while doing it.
4. Wire `app_settings` (client ID + secret), apply, THEN deploy
   `staticwebapp.config.json`. Order matters: settings before config.
5. Negative test against the `azurestaticapps.net` hostname.
   This is the only step that proves the requirement.
6. `terraform/envs/prod` + DNS CNAME handoff.

## Decisions already made

- App registration is created in the **portal**, not Terraform. Redirect URIs
  are back-filled after the SWA exists.
- Terraform state is bootstrapped **outside** Terraform, then referenced.
- Client secret, not certificate. SWA's custom OIDC provider schema has no
  certificate credential option.
- Standard SKU is non-negotiable. The Free plan's preconfigured Entra provider
  accepts any Microsoft account, including personal ones from outside the
  tenant. See `docs/architecture.md`.

## Open items

- [ ] Does the tenant contain B2B guest accounts? Changes the portal steps.
- [ ] App Developer / App Administrator role confirmed.
- [ ] Contributor on target subscription + Standard SKU cost signoff.
- [ ] Non-tenant Microsoft account available for the negative test.
