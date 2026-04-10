# Scale from Zero to Million Users - Context Diagram

## System Context

This diagram shows the system and its relationships with users and external systems.

```mermaid
C4Context
    title System Context - Scale from Zero to Million Users

    Person(user, "User", "End user of the application")
    System(app, "Application System", "Core application handling user requests")
    System_Ext(auth, "Auth Provider", "External authentication service (optional)")
    System_Ext(cdn, "CDN", "Content delivery network for static assets")
    System_Ext(analytics, "Analytics Service", "Third-party analytics (optional)")

    Rel(user, app, "Uses", "HTTPS")
    Rel(app, auth, "Authenticates via", "OAuth/OIDC")
    Rel(app, cdn, "Serves static content via")
    Rel(app, analytics, "Sends events to")
```

## ASCII Fallback

```text
┌─────────┐
│  User   │
└────┬────┘
     │ Uses (HTTPS)
     │
┌────▼────────────────────────────┐
│   Application System            │
│   (Core application)            │
└────┬────────────────────────────┘
     │
     ├──► Auth Provider (OAuth/OIDC)
     ├──► CDN (Static content)
     └──► Analytics Service (Events)
```

## Key Relationships

- **Users** interact with the Application System via HTTPS
- **Application System** may integrate with external Auth Provider for authentication
- **CDN** serves static assets to reduce load on application servers
- **Analytics Service** receives events for monitoring and analysis
