# STUB - module outputs to be added.
#
# Expected:
#   default_host_name  - the generated *.azurestaticapps.net hostname.
#                        Needed for the app registration redirect URI.
#   api_key            - deployment token, sensitive. Goes to the repo owner
#                        as a GitHub secret. Regenerates if the SWA is ever
#                        destroyed and recreated, which silently breaks CI in
#                        a repo we do not control. See handoff/README-handoff.md
