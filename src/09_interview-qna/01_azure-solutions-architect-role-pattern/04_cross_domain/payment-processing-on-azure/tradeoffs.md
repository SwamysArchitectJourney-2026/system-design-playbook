# Trade-offs: payments on Azure

- **Sync authorize** (clear UX, slower) vs **async** processing (faster ack, harder state UX)—often hybrid.
- **SQL** strong transactions vs **Cosmos** global distribution—money paths need explicit consistency story.
- **Third-party processor** lock-in vs building direct acquirer integrations.
