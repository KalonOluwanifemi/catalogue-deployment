# Negative test (WI 6)

STUB - method and evidence to be filled in.

**This is the only check that proves the requirement.** Signing in
successfully with a work account demonstrates nothing about exclusion. This
story must not be closed on the happy path alone.

## Prerequisite

A Microsoft account that is NOT in the tenant and is NOT already a guest in
it. A guest account gives a false pass.

## Tests

| # | Test | Expected | Evidence | Result |
|---|---|---|---|---|
| 1 | Unauthenticated request to `*.azurestaticapps.net` | Redirect to sign-in, never 200 | TODO | TODO |
| 2 | Unauthenticated request to `catalog.nmc2.info` | Redirect to sign-in, never 200 | TODO | blocked on DNS |
| 3 | Sign-in with a tenant work account | Site loads | TODO | TODO |
| 4 | Sign-in with a personal / non-tenant Microsoft account | **Rejected at the Entra sign-in page** | TODO | TODO |
| 5 | If guests exist: sign-in with a guest account | Rejected | TODO | TODO |

Test 4 is the requirement. Test 5 applies only if the tenant hosts B2B guests
and Assignment required has been configured.

Run all of these against the DEMO environment first. Finding a design fault
here is cheap. Finding it in prod is not.
