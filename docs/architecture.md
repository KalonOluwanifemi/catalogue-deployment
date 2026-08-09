# Architecture and auth flow

STUB - diagram and full write-up to be added.

## Flow

GitHub repo (merge to main) -> GitHub Actions
  -> deployment token -> Azure Static Web App (Standard)
  -> staticwebapp.config.json routes /* requiring `authenticated`
  -> app settings AZURE_CLIENT_ID / AZURE_CLIENT_SECRET
  -> Entra ID app registration, single-tenant issuer

## What the client secret actually does

SWA's built-in auth runs an OAuth 2.0 authorization code flow server-side.
The SWA platform acts as a confidential client against Entra ID.

1. User hits a protected route, redirected to `/.auth/login/aad`.
2. SWA redirects to the tenant authorize endpoint using `AZURE_CLIENT_ID`.
3. User authenticates, returns to `/.auth/login/aad/callback` with a code.
4. SWA redeems the code at the token endpoint and must authenticate itself as
   the app. **This is the only place `AZURE_CLIENT_SECRET` is used.**
5. SWA validates the ID token, creates a session, sets its own cookie.
   Everything afterwards is cookie-based.

Consequence: the secret is touched only at sign-in, never per-request. An
expired secret does not drop existing sessions, it breaks all **new**
sign-ins. It presents as a redirect loop or a callback error, and gets
reported as "the site is down" by users who were fine an hour earlier.

## Rejected alternatives

- App Service + Easy Auth: works, costs more, pays for compute to serve
  static files.
- Storage static website + Front Door: no built-in auth, needs Front Door
  Premium plus a custom auth layer.
- Private endpoint / IP allowlist: the requirement calls for internet
  availability. SWA Standard does support `allowedIpRanges` for
  defence in depth on top of SSO later.
