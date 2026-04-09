# Follow-ups: AI engineer feature design

## Scalability attacks

- **10× traffic** tomorrow—what do you scale first: API replicas, retrieval, or model quota?
- **Thundering herd** on cold cache after deploy?

## Failure attacks

- Model returns **200** with **nonsense**—how does the user experience not break trust?
- **Partial JSON** from model—retry policy?

## Data and privacy attacks

- User pastes **PII**—what leaves your service toward the model provider?
- **Cross-tenant** leak via retrieval—how do you **prove** isolation in review?

## Cost attacks

- **Power users** burn budget—per-user caps vs global throttle?

## Testing attacks

- How do you **prevent** prompt regressions on **every** PR?

## Career ladder attacks

- When would you **escalate** to a platform team vs build in-feature?
