# Entra ID app registration (manual, portal)

STUB - fill this in WHILE performing the demo registration, not afterwards.
This procedure is run twice, once per environment, and is the only manual
step in an otherwise codified deployment.

## Prerequisite

The SWA must already exist. Its `*.azurestaticapps.net` hostname is needed for
the redirect URI, so the registration cannot be done first.

## Record per environment

| Field | demo | prod |
|---|---|---|
| Application (client) ID | TODO | TODO |
| Object ID | TODO | TODO |
| Directory (tenant) ID | TODO | TODO |
| Redirect URIs | TODO | TODO |
| Secret created on | TODO | TODO |
| Secret expires on | TODO | TODO |

## Redirect URIs

Every hostname that must serve a sign-in needs its own redirect URI:

    https://<generated>.azurestaticapps.net/.auth/login/aad/callback
    https://catalog.nmc2.info/.auth/login/aad/callback     (prod, once DNS lands)

The Definition of Done requires the `azurestaticapps.net` hostname to redirect
to sign-in as well, so its URI is not optional.

## Open question, resolve before doing this

Does the tenant contain B2B guest accounts? A tenant-scoped issuer admits
guests. If guests exist, "employees only" is not satisfied by the issuer
alone, and you additionally need:

- Assignment required = Yes on the enterprise application
- An employees-only group granted access

That changes these steps, so get the answer first.
