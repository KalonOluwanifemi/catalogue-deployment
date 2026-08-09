# Custom domain, count-gated.
#
# STUB - deliberately inert until DNS is arranged.
#
# Enabled by setting var.custom_domain to a non-null value. Demo never sets
# it. Prod sets it once the CNAME exists and resolves.
#
# For a subdomain (catalog.nmc2.info) validation is "cname-delegation": the
# CNAME itself is the proof of ownership. There is no TXT token to generate.
# The TXT path applies to apex domains and to pre-validation only.
#
# The CNAME must exist and resolve BEFORE this resource will validate. Expect
# to need explicit ordering or a wait, same shape as other ARM eventual
# consistency problems.
