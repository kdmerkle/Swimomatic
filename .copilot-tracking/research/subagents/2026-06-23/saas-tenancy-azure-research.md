# SaaS Tenancy & Azure Architecture Research

**Date:** 2026-06-23
**Context:** Sports management SaaS platform — .NET 9 WebAPI, Dapper + stored procedures, Azure SQL, Auth0, Vite + React SPA

---

## Topic 1: SaaS Multi-Tenancy Strategy for Azure SQL + Dapper

### The Three Approaches Compared

#### Approach A: Database-per-Tenant

Each tenant gets a dedicated Azure SQL database. The application selects the connection string based on the resolved tenant.

**Dapper integration:** The repository layer uses a tenant-aware connection factory that maps a `tenantKey` to a connection string stored in Azure Key Vault or App Configuration.

```csharp
// Connection factory resolves tenant-specific connection string
public interface IDbConnectionFactory
{
    IDbConnection Create(); // uses ITenantContext internally
}

public class TenantDbConnectionFactory : IDbConnectionFactory
{
    private readonly ITenantContext _tenantContext;
    private readonly IConfiguration _config;

    public TenantDbConnectionFactory(ITenantContext tenantContext, IConfiguration config)
    {
        _tenantContext = tenantContext;
        _config = config;
    }

    public IDbConnection Create()
    {
        // e.g., "ConnectionStrings:Tenants:riverside" per tenant
        var connStr = _config[$"ConnectionStrings:Tenants:{_tenantContext.TenantKey}"]
            ?? throw new InvalidOperationException($"No connection string for tenant '{_tenantContext.TenantKey}'");
        return new SqlConnection(connStr);
    }
}
```

No TenantId parameter needed in stored procedures because isolation is at the database level.

**Azure SQL Elastic Pool:** At fewer than 10 tenants, individual Basic/Standard databases ($5–15/month each) are often cheaper than a pool. A Standard Elastic Pool starts at ~$150/month shared; it becomes economical when 10–15+ databases share common peak times (i.e., peaks don't overlap).

**Pros:**
- Maximum data isolation — a misconfigured query cannot leak cross-tenant data
- Each tenant database can be independently backed up, restored, or geo-replicated
- Meets strict compliance requirements (SOC 2, HIPAA) with minimal additional controls
- Schema migrations can be rolled out tenant by tenant (blue/green per tenant)

**Cons:**
- Operational overhead: connection string management, schema migrations across N databases
- Azure SQL limits: 4000 databases per logical server (not a near-term concern)
- Most expensive at scale unless Elastic Pool is used aggressively
- New tenant onboarding requires provisioning a new database (30–60 seconds on Azure)

---

#### Approach B: Schema-per-Tenant

One database, separate SQL schemas per tenant (e.g., `riverside.SwimMeet`, `metro.SwimMeet`). Azure SQL supports schemas natively.

**Dapper integration:** Every query must be schema-qualified. This is impractical with stored procedures because the schema cannot be passed as a parameter — SQL requires literal schema names in procedure names and table references. You would need dynamic SQL or one copy of every stored procedure per tenant, both of which are maintenance nightmares.

```sql
-- NOT possible with Dapper + stored procedures cleanly:
EXEC @schema + '.usp_GetSwimMeets' -- this is invalid T-SQL syntax
-- Dynamic SQL workaround is fragile and bypasses SQL plan caching
```

**Pros:**
- Single database, simpler backup/restore at database level
- Schema-level security grants provide isolation

**Cons:**
- Stored procedures cannot be schema-parameterized without dynamic SQL
- Each new tenant requires creating a full schema with all objects (dozens of tables, procedures)
- Azure SQL does not support row-level cross-schema joins easily
- Schema proliferation makes query plan management complex
- Not recommended when the data layer is stored-procedure-based

**Verdict: Eliminated for this stack.** Schema-per-tenant is architecturally incompatible with a stored-procedure-centric Dapper data layer.

---

#### Approach C: Shared Schema with TenantId + Row Level Security

All tenants share all tables. Every tenant-scoped table has a `TenantId` column. Azure SQL Row Level Security (RLS) enforces that queries only return rows matching the session's active tenant.

**Azure SQL RLS with session context:**

```sql
-- Step 1: Create the security predicate function
CREATE FUNCTION dbo.fn_TenantAccessPredicate(@TenantId INT)
RETURNS TABLE WITH SCHEMABINDING
AS
RETURN
    SELECT 1 AS fn_accessResult
    WHERE TRY_CAST(SESSION_CONTEXT(N'TenantId') AS INT) = @TenantId;
GO

-- Step 2: Apply to every tenant-scoped table
CREATE SECURITY POLICY dbo.SwimMeetTenantPolicy
    ADD FILTER PREDICATE dbo.fn_TenantAccessPredicate(TenantId) ON dbo.SwimMeet,
    ADD BLOCK PREDICATE  dbo.fn_TenantAccessPredicate(TenantId) ON dbo.SwimMeet AFTER INSERT,
    ADD BLOCK PREDICATE  dbo.fn_TenantAccessPredicate(TenantId) ON dbo.SwimMeet BEFORE UPDATE
WITH (STATE = ON);
GO
```

**Setting session context before Dapper calls:**

```csharp
// Extension method used by every repository base class
public static async Task SetTenantContextAsync(this IDbConnection connection, int tenantId)
{
    await connection.ExecuteAsync(
        "EXEC sp_set_session_context @key = N'TenantId', @value = @tenantId, @read_only = 1",
        new { tenantId });
}
```

The `@read_only = 1` flag prevents the application code from overwriting the session context after it is set — a defense-in-depth measure.

**Inside stored procedures:** stored procedures do not need to be modified to accept TenantId once RLS is active. The RLS predicate filters automatically. However, for clarity and auditability, passing TenantId explicitly as a stored procedure parameter is also valid and recommended for stored procedures that INSERT (to populate the column):

```sql
CREATE PROCEDURE dbo.usp_CreateSwimMeet
    @TenantId   INT,
    @MeetName   NVARCHAR(200),
    @MeetDate   DATE
AS
BEGIN
    INSERT INTO dbo.SwimMeet (TenantId, MeetName, MeetDate)
    VALUES (@TenantId, @MeetName, @MeetDate);
END
```

**Pros:**
- Single database to manage — dramatically lower operational overhead
- No connection string switching; one connection string for all tenants
- Cost-effective at all scales (one Standard S2–S4 database handles 50 small-to-medium tenants)
- New tenant onboarding is a single INSERT into a `Tenants` table (milliseconds)
- RLS enforcement happens in the SQL engine, not application code

**Cons:**
- Noisy-neighbor risk: one tenant's heavy queries affect others (mitigated by Query Store + workload groups on Business Critical tier, or by moving to Elastic Pool per-tenant at scale)
- A misconfigured RLS policy is a harder-to-detect bug than a wrong connection string
- Backup/restore affects all tenants simultaneously
- If a tenant requires data residency in a different region, this model breaks

**RLS Verification — critical test:**

```sql
-- Test that RLS works as expected
EXEC sp_set_session_context @key = N'TenantId', @value = 1;
SELECT COUNT(*) FROM dbo.SwimMeet; -- should return only tenant 1 rows

EXEC sp_set_session_context @key = N'TenantId', @value = 2;
SELECT COUNT(*) FROM dbo.SwimMeet; -- should return only tenant 2 rows
```

---

### Recommendation: Shared Schema with TenantId + RLS

**Rationale:** For an early-stage SaaS with fewer than 50 tenants, shared schema is the right starting point. The stored-procedure architecture is fully compatible — RLS filters at the engine level without stored procedure changes, and explicit TenantId parameters in INSERT procedures are clean and auditable. The zero-latency tenant onboarding (just insert a row) is a meaningful competitive advantage during early growth. When a specific tenant grows large enough to justify isolation (e.g., a major league with 10,000 athletes), migrate that single tenant to a dedicated database — the application's connection factory can support per-tenant connection string overrides at that point without changing the data model.

**Elastic Pool decision point:** Add an Elastic Pool when tenant count exceeds ~15 and you are running database-per-tenant for any of them. For shared-schema, a single Azure SQL Standard S3 ($150/month) supports the first 50 tenants comfortably; scale up to Business Critical or Hyperscale when 99th-percentile latency becomes a concern.

---

## Topic 2: Auth0 Multi-Tenant SaaS Configuration

### Auth0 Organizations

An Auth0 Organization maps 1:1 to a SaaS tenant. An organization named `org_riverside` represents "Riverside Swim League." Users (athletes, admins) are invited to one or more organizations. When a user logs in through an organization, the resulting JWT contains an `org_id` claim identifying which organization context they are operating in.

**Key behaviors:**
- A user can be a member of multiple organizations (e.g., an athlete who swims for a league and also competes in a track club)
- Each organization login produces a JWT scoped to that organization — the `org_id` claim indicates the current tenant context
- Organizations support their own branding, connections (enterprise SSO), and member metadata

### React SPA — Passing the Organization Parameter

Using `@auth0/auth0-react`, the SPA must know which organization the user is logging into. Two patterns:

**Pattern A — Organization selection before login (recommended for multi-sport):**

```tsx
import { useAuth0 } from '@auth0/auth0-react';

function LoginButton({ organizationId }: { organizationId: string }) {
    const { loginWithRedirect } = useAuth0();

    return (
        <button
            onClick={() =>
                loginWithRedirect({
                    authorizationParams: {
                        organization: organizationId, // e.g., 'org_KyAFxxxxxxxx'
                    },
                })
            }
        >
            Log in to {organizationName}
        </button>
    );
}
```

**Pattern B — Subdomain-inferred organization (cleaner UX):**

```tsx
// In Auth0Provider setup, derive organization from subdomain
const organizationId = resolveOrgFromSubdomain(window.location.hostname);
// e.g., riverside.athleteplatform.com → lookup 'riverside' → 'org_KyAFxxxxxxxx'

<Auth0Provider
    domain={import.meta.env.VITE_AUTH0_DOMAIN}
    clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
    authorizationParams={{
        redirect_uri: window.location.origin,
        organization: organizationId,
        audience: import.meta.env.VITE_AUTH0_AUDIENCE,
    }}
>
```

Pattern B pairs well with subdomain-based tenant resolution (see Topic 4).

### .NET 9 WebAPI — Extracting `org_id` from JWT

Auth0 JWTs include `org_id` as a standard claim when the user authenticated through an organization. In a .NET 9 WebAPI using `Microsoft.AspNetCore.Authentication.JwtBearer`:

```csharp
// Program.cs
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = $"https://{builder.Configuration["Auth0:Domain"]}/";
        options.Audience = builder.Configuration["Auth0:Audience"];
        options.TokenValidationParameters = new TokenValidationParameters
        {
            NameClaimType = ClaimTypes.NameIdentifier
        };
    });

// In middleware or controller:
var orgId = httpContext.User.FindFirst("org_id")?.Value;
// e.g., "org_KyAFxxxxxxxx"
```

The `org_id` is then used to resolve the internal `TenantId` (integer) from the Tenants table via a cached lookup.

### Athletes in Multiple Organizations

Yes — this is a first-class Auth0 Organizations scenario. An athlete is invited to `org_riverside` (swim league) and also to `org_metro_track` (track club). Each login session produces a token scoped to one organization. The athlete switches context by logging out and logging in under a different organization, or (with a custom UI) by selecting their active context.

**Recommended model for multi-sport:**
- One Auth0 organization per league/team (not per sport)
- An athlete who competes in swim AND track AND field belongs to multiple organizations
- The platform's internal `Athlete` record has a `UserId` (Auth0 `sub` claim) and a many-to-many join to `Tenants`
- The active organization in the current session determines which tenant's data is visible

### Auth0 Tiers and Organizations Feature

| Tier | Price (2025) | Organizations | MAU Limit |
|------|-------------|---------------|-----------|
| Free | $0 | **Not included** | 7,500 |
| Essential | ~$35/month | **Not included** | 10,000 |
| Professional | ~$240/month | **Included** | 50,000 |
| Enterprise | Custom | **Included** | Unlimited |

**Organizations requires Professional tier or above.** The free and Essential tiers do not include Organizations.

### Alternative: Custom `tenant_id` Claim via Post-Login Action

If Professional tier cost is a concern early on, inject a custom claim using an Auth0 Post-Login Action:

```javascript
// Auth0 Post-Login Action (runs server-side at login time)
exports.onExecutePostLogin = async (event, api) => {
    const tenantId = event.user.app_metadata?.tenant_id;
    if (tenantId) {
        api.idToken.setCustomClaim('https://athleteplatform.com/tenant_id', tenantId);
        api.accessToken.setCustomClaim('https://athleteplatform.com/tenant_id', tenantId);
    }
};
```

**Tradeoffs vs Organizations:**

| Concern | Auth0 Organizations | Custom Claim |
|---------|---------------------|--------------|
| Tier required | Professional ($240/mo) | Free/Essential |
| Multi-tenant support | Native | Manual management |
| Athlete in multiple tenants | Native org membership | Requires array of tenant IDs in app_metadata |
| Per-org branding/SSO | Built-in | Manual |
| Auth0 dashboard visibility | Organizations UI | app_metadata JSON |
| Future-proofing | High | Moderate |

**Recommendation:** Start with the custom claim approach on Free/Essential tier during development and beta. Migrate to Organizations when launching commercially. Auth0 supports coexistence — the `org_id` claim simply doesn't appear when using custom claims, so the migration requires only updating the claim extraction in middleware.

---

## Topic 3: Azure Infrastructure for SaaS Scale

### Single vs. Multiple App Services for Sport Domains

**Do not split by sport into separate App Services at the start.** The correct boundary is the deployment unit, not the domain concept. Sport domains (swim, track) should be modules or feature folders within a single .NET 9 WebAPI. A single App Service with two slots (production + staging) provides zero-downtime deploys.

When to split:
- When a single sport has a team large enough to require independent scaling (e.g., the swim module handles 10× the traffic of the track module)
- When a sport module needs different runtime dependencies or deployment cadence
- When organization boundaries require separate compliance/audit scopes

**Azure API Management vs Application Gateway:**

| Concern | Azure API Management | Application Gateway |
|---------|---------------------|---------------------|
| Primary purpose | API gateway (versioning, throttling, developer portal) | Layer-7 load balancer + WAF |
| Sport routing | Policy-based routing to sport-specific backends | Path-based routing rules |
| Cost | Developer tier: ~$50/month; Standard v2: ~$800/month | WAF v2: ~$250/month |
| Needed at launch? | No | No (App Service handles it) |
| When to add | When exposing a public API to third parties, or when needing per-tenant rate limiting | When adding WAF protection in front of multiple backends |

**Recommendation:** Skip both at launch. Add Azure Application Gateway with WAF when moving to production with external traffic. Add APIM when building a partner API ecosystem.

### Azure SQL Elastic Pool Decision Points

For **database-per-tenant** approach:

| Tenant Count | Recommendation | Estimated Monthly Cost |
|-------------|----------------|----------------------|
| 1–10 | Individual Basic/S0 databases | $5–15/tenant |
| 10–30 | Standard Elastic Pool (100 eDTUs) | ~$150 pool + marginal per-DB |
| 30–100 | Standard Elastic Pool (200–400 eDTUs) | $300–600 |
| 100+ | General Purpose Elastic Pool (vCore-based) | ~$500+ |

For **shared-schema** approach: a single Standard S2 ($150/month) handles ~50 tenants. Scale up to S4 ($300/month) or Business Critical when P99 query latency exceeds SLA at peak concurrent meets.

### Tenant Onboarding Automation

For shared-schema (recommended approach), onboarding is: INSERT tenant row + create Auth0 Organization. This can be an API endpoint on the admin backend:

```csharp
[HttpPost("/api/admin/tenants")]
[Authorize(Roles = "PlatformAdmin")]
public async Task<IActionResult> CreateTenant([FromBody] CreateTenantRequest request)
{
    var tenant = await _tenantService.ProvisionAsync(request);
    // 1. INSERT into dbo.Tenants
    // 2. Call Auth0 Management API to create Organization
    // 3. Send welcome email
    return CreatedAtAction(nameof(GetTenant), new { id = tenant.TenantId }, tenant);
}
```

For database-per-tenant, use an Azure Function triggered by a Service Bus message. The function creates the database from a template (BACPAC or ARM template), runs migrations via DbUp/Flyway, and returns the connection string to Key Vault. Estimated provisioning time: 30–90 seconds.

### Azure Static Web Apps for the React SPA

Azure Static Web Apps (SWA) is well-suited for the Vite + React SPA. A **single SWA deployment** handles all sport modules because routing is handled entirely by React Router — the SWA serves the same `index.html` for all routes and the SPA decides what to render.

```json
// staticwebapp.config.json — fallback routing for SPA
{
    "navigationFallback": {
        "rewrite": "/index.html",
        "exclude": ["/api/*", "/assets/*"]
    },
    "routes": [
        {
            "route": "/swim/*",
            "rewrite": "/index.html"
        },
        {
            "route": "/track/*",
            "rewrite": "/index.html"
        }
    ]
}
```

**SWA tiers:**

| Tier | Price | Custom Domains | Bandwidth | Staging Environments |
|------|-------|---------------|-----------|---------------------|
| Free | $0 | 2 | 100 GB/month | 3 |
| Standard | $9/month | Unlimited | 100 GB/month (then $0.20/GB) | 10 |

The free tier is sufficient for development and early production. Upgrade to Standard when you need more than 2 custom domains or more than 3 preview environments.

### Application Insights with Per-Tenant Custom Dimensions

```csharp
// ITelemetryInitializer adds TenantId to every telemetry item
public class TenantTelemetryInitializer : ITelemetryInitializer
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public TenantTelemetryInitializer(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public void Initialize(ITelemetry telemetry)
    {
        if (telemetry is not ISupportProperties item) return;

        var context = _httpContextAccessor.HttpContext;
        if (context is null) return;

        // ITenantContext is scoped; resolve from DI via IServiceProvider if needed
        var tenantContext = context.RequestServices.GetService<ITenantContext>();
        if (tenantContext?.TenantKey is not null)
        {
            item.Properties["TenantId"] = tenantContext.TenantId.ToString();
            item.Properties["TenantKey"] = tenantContext.TenantKey;
        }
    }
}

// Registration in Program.cs
builder.Services.AddSingleton<ITelemetryInitializer, TenantTelemetryInitializer>();
```

In Application Insights, you can then filter and split by `customDimensions.TenantKey` to see per-tenant error rates, latency, and usage.

---

## Topic 4: .NET 9 WebAPI Tenant Resolution Middleware

### Strategy Comparison

| Strategy | How it works | Pros | Cons |
|----------|-------------|------|------|
| Subdomain (`riverside.athleteplatform.com`) | Middleware reads `Host` header, splits on first dot | Clean UX, invisible to the user | Requires wildcard SSL cert, wildcard DNS, complex on Azure Static Web Apps |
| Custom header (`X-Tenant-ID`) | Middleware reads `Request.Headers["X-Tenant-ID"]` | Simple to implement | Easy to forge; not enforceable without Auth0 validation; bad for browsers |
| JWT claim (`org_id` or custom) | Middleware reads claim after authentication | Cryptographically tied to Auth0 identity; tamper-proof | Requires authentication on every route; unauthenticated routes need a fallback |
| URL path prefix (`/api/tenants/{tenantId}/...`) | Route parameter | REST-standard, explicit | Verbose URLs; `{tenantId}` in path must be validated against JWT claim |

### Recommended Strategy: JWT Claim (`org_id`)

The cleanest and most secure approach for an Auth0 Organizations architecture. The tenant identity is cryptographically bound to the user's authenticated session — it cannot be guessed or forged by a client. There is no additional DNS or certificate infrastructure required.

If subdomain-based routing is also desired for UX (e.g., `riverside.athleteplatform.com`), use it as a UX affordance that pre-selects the organization at login time (see Topic 2, Pattern B), but still validate the resolved tenant against the JWT `org_id` claim in the API.

### Full ITenantContext Implementation

```csharp
// Abstractions
public interface ITenantContext
{
    int TenantId { get; }
    string TenantKey { get; }
    bool IsResolved { get; }
}

// Mutable internal implementation (scoped per-request)
public sealed class TenantContext : ITenantContext
{
    public int TenantId { get; private set; }
    public string TenantKey { get; private set; } = string.Empty;
    public bool IsResolved { get; private set; }

    internal void Resolve(int tenantId, string tenantKey)
    {
        TenantId = tenantId;
        TenantKey = tenantKey;
        IsResolved = true;
    }
}

// Tenant lookup service (cached)
public interface ITenantResolver
{
    Task<TenantRecord?> ResolveByOrgIdAsync(string auth0OrgId);
}

public sealed class CachedTenantResolver : ITenantResolver
{
    private readonly IMemoryCache _cache;
    private readonly IDbConnectionFactory _dbFactory;

    public CachedTenantResolver(IMemoryCache cache, IDbConnectionFactory dbFactory)
    {
        _cache = cache;
        _dbFactory = dbFactory;
    }

    public async Task<TenantRecord?> ResolveByOrgIdAsync(string auth0OrgId)
    {
        return await _cache.GetOrCreateAsync($"tenant:orgid:{auth0OrgId}", async entry =>
        {
            entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(10);
            using var conn = _dbFactory.CreateSystem(); // system connection, not tenant-scoped
            return await conn.QuerySingleOrDefaultAsync<TenantRecord>(
                "SELECT TenantId, TenantKey, IsActive FROM dbo.Tenants WHERE Auth0OrgId = @auth0OrgId",
                new { auth0OrgId });
        });
    }
}
```

### Middleware Registration and Pipeline Order

```csharp
// TenantResolutionMiddleware.cs
public sealed class TenantResolutionMiddleware
{
    private readonly RequestDelegate _next;

    public TenantResolutionMiddleware(RequestDelegate next) => _next = next;

    public async Task InvokeAsync(
        HttpContext context,
        ITenantResolver resolver,
        TenantContext tenantContext) // concrete type to call internal Resolve()
    {
        // Only resolve if the request is authenticated
        if (context.User.Identity?.IsAuthenticated == true)
        {
            var orgId = context.User.FindFirstValue("org_id");
            if (orgId is not null)
            {
                var record = await resolver.ResolveByOrgIdAsync(orgId);
                if (record is { IsActive: true })
                {
                    tenantContext.Resolve(record.TenantId, record.TenantKey);
                }
                else
                {
                    // Authenticated but org is unknown or inactive
                    context.Response.StatusCode = StatusCodes.Status403Forbidden;
                    await context.Response.WriteAsJsonAsync(new { error = "Tenant not found or inactive." });
                    return;
                }
            }
        }

        await _next(context);
    }
}

// Program.cs — pipeline order matters
app.UseAuthentication();   // 1. Validates JWT, populates context.User
app.UseAuthorization();    // 2. Evaluates [Authorize] attributes
app.UseMiddleware<TenantResolutionMiddleware>(); // 3. Resolves tenant from claims
app.MapControllers();
```

### DI Registration

```csharp
// Program.cs
builder.Services.AddScoped<TenantContext>(); // concrete for internal mutation
builder.Services.AddScoped<ITenantContext>(sp => sp.GetRequiredService<TenantContext>());
builder.Services.AddSingleton<ITenantResolver, CachedTenantResolver>();
builder.Services.AddMemoryCache();
```

### Dapper Repository Pattern with TenantContext

```csharp
public abstract class TenantAwareRepository
{
    protected readonly IDbConnectionFactory _connectionFactory;
    protected readonly ITenantContext _tenantContext;

    protected TenantAwareRepository(IDbConnectionFactory connectionFactory, ITenantContext tenantContext)
    {
        _connectionFactory = connectionFactory;
        _tenantContext = tenantContext;
    }

    /// <summary>
    /// Opens a connection and sets the RLS session context for the current tenant.
    /// All subsequent queries on this connection are automatically filtered by RLS.
    /// </summary>
    protected async Task<IDbConnection> OpenTenantConnectionAsync()
    {
        if (!_tenantContext.IsResolved)
            throw new InvalidOperationException("Tenant context has not been resolved. Ensure TenantResolutionMiddleware runs before repository calls.");

        var conn = _connectionFactory.Create();
        conn.Open();

        // Set RLS session context — read_only = 1 prevents downstream code from overwriting it
        await conn.ExecuteAsync(
            "EXEC sp_set_session_context @key = N'TenantId', @value = @tenantId, @read_only = 1",
            new { tenantId = _tenantContext.TenantId });

        return conn;
    }
}

// Concrete repository
public sealed class SwimMeetRepository : TenantAwareRepository, ISwimMeetRepository
{
    public SwimMeetRepository(IDbConnectionFactory connectionFactory, ITenantContext tenantContext)
        : base(connectionFactory, tenantContext) { }

    public async Task<IEnumerable<SwimMeetDto>> GetUpcomingMeetsAsync()
    {
        using var conn = await OpenTenantConnectionAsync();
        // RLS is active — no TenantId parameter needed in the SELECT stored procedure
        return await conn.QueryAsync<SwimMeetDto>("EXEC dbo.usp_GetUpcomingSwimMeets");
    }

    public async Task<int> CreateMeetAsync(CreateSwimMeetCommand command)
    {
        using var conn = await OpenTenantConnectionAsync();
        // INSERT procedures should still receive TenantId explicitly to populate the column
        return await conn.ExecuteScalarAsync<int>(
            "EXEC dbo.usp_CreateSwimMeet @TenantId, @MeetName, @MeetDate, @LocationId",
            new
            {
                TenantId = _tenantContext.TenantId,
                command.MeetName,
                command.MeetDate,
                command.LocationId,
            });
    }
}
```

### Preventing Tenant Data Leakage

Defense-in-depth layers:

1. **JWT validation** — Auth0 signs the JWT; the API validates the signature and expiry. A forged token is rejected at authentication.
2. **`org_id` → tenant lookup** — The `org_id` is a random Auth0-assigned string, not guessable. Resolving it to an internal `TenantId` happens only after signature validation.
3. **RLS session context** — Even if application code has a bug and omits the TenantId filter, RLS at the database engine level enforces it. A compromised stored procedure still cannot leak cross-tenant rows.
4. **Authorization assertion in repositories** — The `OpenTenantConnectionAsync()` guard throws if the tenant context is unresolved, preventing any database access from unauthenticated requests.
5. **Integration tests** — Write a test that authenticates as Tenant A, then attempts to fetch a known resource that belongs to Tenant B. The response must be 404 (not 403, to avoid information disclosure).

```csharp
// Example: additional guard in controller if route includes a resource ID
[HttpGet("meets/{meetId}")]
public async Task<IActionResult> GetMeet(int meetId)
{
    var meet = await _repository.GetByIdAsync(meetId);
    if (meet is null) return NotFound(); // RLS already filtered it out if it belongs to another tenant
    return Ok(meet);
}
// No explicit TenantId check needed in the controller because RLS ensures
// GetByIdAsync returns null for cross-tenant IDs. The controller returns 404,
// which leaks no information about the existence of the resource in another tenant.
```

---

## Summary: Recommended Decisions

| Decision | Recommendation | Rationale |
|----------|---------------|-----------|
| Tenancy model | Shared schema + TenantId + RLS | Lowest cost, lowest ops overhead, compatible with stored procedures, fast onboarding |
| Auth0 | Custom claim via Post-Login Action initially; migrate to Organizations for commercial launch | Avoids $240/month Professional tier during development |
| App Service architecture | Single App Service with sport modules as feature folders | Over-engineering sport-specific App Services is premature |
| API Gateway | None at launch; add Application Gateway + WAF at production | Cost-justified only when external traffic and WAF are needed |
| Azure Static Web Apps | Single deployment, React Router handles sport routes | Vite SPA with React Router requires no SWA-level sport routing |
| Tenant resolution | JWT `org_id` claim (or custom `tenant_id` claim if not using Organizations) | Cryptographically bound, tamper-proof, no extra infrastructure |
| TenantId in Dapper | `OpenTenantConnectionAsync()` base method sets RLS session context; INSERT procedures receive TenantId explicitly | Defense-in-depth without duplicating TenantId in every SELECT call |

---

## Pricing Reference (2025 approximate, East US)

| Resource | SKU | Monthly Cost |
|----------|-----|-------------|
| Azure SQL Database | Standard S2 (50 DTUs) | ~$75 |
| Azure SQL Database | Standard S3 (100 DTUs) | ~$150 |
| Azure App Service | P1v3 (2 vCores, 8 GB) | ~$140 |
| Azure Static Web Apps | Standard | $9 |
| Application Insights | Pay-per-use, 5 GB/month free | ~$0–20 |
| Auth0 | Essential (~10k MAU) | ~$35 |
| Auth0 | Professional (~50k MAU, Organizations) | ~$240 |

Early-stage monthly infrastructure budget estimate: **$250–400/month** (SQL + App Service + SWA + Auth0 Essential + App Insights).

---

## Recommended Next Research Items

1. **DbUp or Flyway for schema migrations** — with shared-schema tenancy, all schema changes must be backward-compatible rolling deployments; research the migration strategy for `ALTER TABLE` when live tenants are active.
2. **Auth0 Post-Login Action for array-of-tenants custom claim** — if an athlete belongs to multiple leagues before Organizations is adopted, how to encode and decode a `tenant_ids` array claim in .NET 9.
3. **Azure SQL Query Store and Resource Governor** — for shared-schema tenancy at scale, research per-tenant query classification and resource limits to prevent noisy-neighbor issues.
4. **Multi-sport data model design** — research how `Athlete`, `Event`, `Result`, and `Season` entities generalize across swim meets (heats, lanes, splits) and track meets (heats, lanes, field events). The tenancy layer is resolved; the domain model needs a sport-agnostic abstraction.
5. **Auth0 Management API for tenant provisioning** — research the Management API endpoint for creating Organizations programmatically, setting branding, and inviting users, for the tenant onboarding automation service.
6. **Azure Static Web Apps + Auth0 PKCE flow** — verify the exact configuration for Auth0 PKCE (no client secret) with the `@auth0/auth0-react` SDK and `VITE_AUTH0_*` environment variables in a SWA deployment.
