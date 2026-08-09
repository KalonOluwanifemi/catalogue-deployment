# DNS handoff

STUB.

nmc2.info is registered but not hosted in Azure DNS, and the current plan is
to add the record wherever the domain's DNS is managed today rather than
delegating the zone.

## What the DNS owner needs

One CNAME:

    catalog.nmc2.info.  CNAME  <generated>.azurestaticapps.net.

For a subdomain, the CNAME is itself the ownership proof. There is no TXT
token to generate. The TXT method applies to apex domains and pre-validation.

## If full zone delegation is ever revisited

Delegating the whole nmc2.info zone moves ALL DNS for the domain to Azure.
Every existing record (MX, SPF, DKIM, DMARC, other subdomains) must be
inventoried and recreated in the Azure zone **before** the nameserver change
at the registrar, or those services break. Delegating only the `catalog`
subdomain via an NS record avoids this entirely.

## Blocked until this is done

- `catalog.nmc2.info` serving over a valid certificate
- The `catalog.nmc2.info` half of the unauthenticated-redirect check

The negative test is NOT blocked, it runs against the azurestaticapps.net
hostname.
