# Trade-offs cheat sheet (.NET + Azure)

| Topic | Axes |
|-------|------|
| **Monolith vs services** | Velocity vs independent scale; .NET single deploy vs many APIs |
| **EF Core** | Productivity vs heavy queries—raw SQL for hot paths |
| **APIM** | Central policies vs duplicated middleware in each API |
| **Sync HTTP** | Simplicity vs timeouts—use queues for slow work |
| **Angular + API** | BFF layer vs SPA talking to many microservices |
