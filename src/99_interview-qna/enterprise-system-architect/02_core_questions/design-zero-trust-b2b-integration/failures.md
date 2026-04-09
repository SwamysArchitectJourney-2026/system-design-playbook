# Failure scenarios: zero-trust B2B integration

- **Token broker** outage — partners cannot authenticate; **cached** revocation lists vs **stale** deny risk.
- **Mis-scoped OAuth / mTLS** — partner accesses **wrong** tenant data; **audience** and **resource** binding bugs.
- **Network policy too loose** — lateral movement after one compromise; **micro-segment** APIs and data.
- **Certificate rotation** failure — **midnight** outage; **dual** cert windows and **automation** tests.
- **IdP federation** break — **SAML/OIDC** clock skew, metadata expiry; **monitor** federation health.
- **Audit pipeline** loss — compliance **gap**; **durable** logging with **tamper-evident** retention.
