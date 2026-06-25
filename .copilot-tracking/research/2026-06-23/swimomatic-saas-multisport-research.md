<!-- markdownlint-disable-file -->
# Task Research: SaaS Multi-Sport Platform Architecture

The system being built is NOT a single-sport application. It is a **SaaS multi-sport athlete management platform** where:

- Swim meet management is the **first sport domain** (derived from the existing Swimomatic codebase)
- Track & Field, and other sports, will be added as **additional sport domains** over time
- The **athlete/user is the central entity** — one identity that can participate in any number of supported sports
- The system is delivered as a **Software as a Service** product — multiple leagues/organizations (tenants) use the same platform

This research document captures the architectural decisions needed to support these requirements, consistent with the stack decisions in `swimomatic-modernization-research.md` and `swimomatic-admin-features-research.md`.

## Task Implementation Requests

* Re-architect the platform as SaaS with multi-tenancy support
* Design the central athlete/user identity that spans sports
* Design the sport domain extension model (how to add Track & Field, etc.)
* Define tenant isolation strategy for data and configuration
* Define how the React SPA accommodates multiple sport modules
* Define how Auth0 supports multi-tenant SaaS
* Define Azure infrastructure for SaaS scale
* Ensure swim meet domain fits within the multi-sport model without rewrite

## Scope and Success Criteria

* Scope: SaaS tenancy model, athlete identity design, sport domain extension architecture, Auth0 multi-tenant, Azure SaaS infrastructure, API structure for multi-sport, React SPA module federation or route-based sport modules
* Assumptions:
  * Stack is fixed: .NET 9 WebAPI + Dapper + React + Auth0 + Azure SQL + Azure App Service
  * Swim meet domain is implemented first; architecture must not require a rewrite when Track & Field is added
  * Each sport adds its own service/repository libraries; the core platform provides shared identity, league/season, and team primitives
  * SaaS tenants are leagues or organizations (e.g., "Riverside Swim League" is one tenant)
  * Athletes can belong to teams in multiple leagues across multiple sports
* Success Criteria:
  * Tenant isolation strategy selected with rationale
  * Central athlete identity schema defined
  * Sport domain extension pattern selected (plugin / module / separate service)
  * Auth0 multi-tenant configuration approach defined
  * Azure SQL database-per-tenant vs shared-schema strategy decided
  * API versioning and sport-module routing strategy defined
  * React SPA structure for multi-sport navigation

## Outline

1. SaaS tenancy model (isolation strategy)
2. Central athlete/user identity
3. Sport domain extension architecture
4. Shared platform primitives (League, Season, Team, Location)
5. Auth0 multi-tenant SaaS configuration
6. Azure infrastructure for SaaS
7. API structure and sport module routing
8. React SPA multi-sport structure

## Potential Next Research

* SQL migration script: `Swimmer` → `Athlete` data migration without breaking existing stored procedures during transition
* Stored procedure naming conventions for `swim.*` procs that join to `dbo.Athlete` via Dapper
* `Tenant` sport configuration: how `enabledSports` is set per tenant (feature flag vs League config row)
* T&F scoring schemes: whether existing `ScoringScheme`/`SeasonScoringScheme` pattern covers T&F place-scored meets
* Multi-sport athlete results page: `useQueries` pattern for aggregating swim times + T&F marks in one React view
* DbUp/Flyway rolling schema migrations with live tenants on shared schema
* Auth0 Management API for programmatic Organization creation during tenant onboarding
* Azure SQL Query Store + Resource Governor for noisy-neighbor prevention at scale

## Research Executed

### Conceptual Analysis (initial)

* The existing Swimomatic domain has entities that are SPORT-SPECIFIC:
  - `SwimEvent`, `Stroke`, `HeatSheet`, `Heat`, `HeatSwimmer`, `Split` → swim-specific
  - `Pool`, `PoolConfig` → swim-specific venue configuration
  - `AgeClass`, `AgeClassRule` → actually sport-agnostic — both swim and T&F use age groups

* The existing Swimomatic domain has entities that are PLATFORM-GENERIC:
  - `League`, `Season`, `Team`, `TeamSeason` → generic organization hierarchy
  - `Location` → generic venue
  - `SystemUser`, `Profile` → generic user identity
  - `Region`, `UOM` → generic reference data
  - `UserLeague`, `UserTeam`, `UserSwimMeet` → generic membership/admin tables
  - `ScoringScheme`, `SeasonScoringScheme` → partially shared pattern

* The athlete participation model in Swimomatic:
  - `Swimmer` → contains only: FirstName, LastName, BirthDate, IsMale — zero swim-specific attributes
  - `SwimmerTeamSeason` → links athlete to team-season
  - `UserSwimmer` → links platform user to swimmer profile

* Key implication: `Swimmer` is ALREADY a generic athlete entity — rename is nearly zero-risk

### Subagent Research

* `.copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md`
  * SaaS tenancy strategy, Auth0 multi-tenant, Azure infrastructure, tenant resolution middleware

* `.copilot-tracking/research/subagents/2026-06-23/multisport-domain-extensibility-research.md`
  * Central athlete identity, sport module architecture, shared primitives, React SPA structure, T&F domain validation

## Key Discoveries

### Tenancy Strategy
**Recommended: Shared schema + `TenantId` column + Azure SQL Row Level Security (RLS)**

- Schema-per-tenant is eliminated because stored procedures cannot be schema-parameterized without dynamic SQL — incompatible with the Dapper + stored procedures strategy
- Database-per-tenant scales poorly at early stage (each DB = ~$5/mo minimum; provisioning takes 30–90 sec)
- RLS enforced via `EXEC sp_set_session_context @key=N'TenantId', @value=@tenantId, @read_only=1` per connection — blocks data leakage even if application code has a bug
- Tenant onboarding = single INSERT row — milliseconds, no provisioning
- Elastic Pool makes sense at 10–15+ separate DBs; shared-schema on Azure SQL S3 ($150/mo) handles ~50 tenants
- **Escape hatch**: per-tenant connection string override in `IConnectionFactory` allows migrating a large tenant to a dedicated database without changing application code

### Auth0 Multi-Tenant Strategy
**Recommended: Custom `tenant_id` claim via Post-Login Action now; migrate to Auth0 Organizations at commercial launch**

- Auth0 Organizations requires the Professional tier ($240/month) — not appropriate for a pre-revenue startup
- Custom claim approach: Post-Login Action injects `https://athleteplatform.com/tenant_id` into the JWT access token from `user.app_metadata.tenantId`
- **Must namespace custom claims** — Auth0 rejects unnamespaced custom claims from Actions
- `.NET 9` reads claim via `User.FindFirstValue("https://athleteplatform.com/tenant_id")`
- Athletes in multiple sports/leagues within the same tenant: single JWT works fine — tenant is resolved once, sport is resolved from the URL route
- Athletes in leagues from DIFFERENT tenants (rarer case, e.g., cross-league championship): require re-login with different `organization`; the multi-tenant model assumes one tenant per athlete session

### Azure Infrastructure
**Recommended: Single App Service with modular sport libraries; Azure Static Web Apps for React SPA**

- Do NOT split by sport into separate App Services — modularize within a single App Service; split only when independent scaling is needed
- Skip Azure API Management and Application Gateway at launch — add when moving to production external traffic
- Azure Static Web Apps free tier handles all React Router sport routes from a single deployment (`staticwebapp.config.json` `navigationFallback`)
- Application Insights `ITelemetryInitializer` adds `TenantId` as a custom dimension to every telemetry item for per-tenant performance analysis
- **Early budget estimate: $250–400/month** (Azure SQL + App Service B2 + SWA + Auth0 Essential + Application Insights)
- Tenant onboarding automation: API endpoint (`POST /api/admin/tenants`) triggers DB row insert + Auth0 tenant setup via Management API — no separate pipeline needed at early stage

### Tenant Resolution in .NET 9
**Recommended: JWT claim → `ITenantContext` scoped service → RLS session context per connection**

```
Request Pipeline Order (CRITICAL):
UseRouting()
UseAuthentication()
UseAuthorization()
UseTenantResolution()   ← reads JWT claim, populates ITenantContext
UseCors()
MapControllers()
```

- `TenantResolutionMiddleware` reads the `tenant_id` claim (or `org_id` when Auth0 Organizations is adopted) and populates a scoped `ITenantContext`
- `TenantAwareConnectionFactory` opens a `SqlConnection`, then calls `sp_set_session_context` with `TenantId` before any query — enforces RLS at the engine level
- Defense-in-depth: JWT validation → claim extraction → RLS session context → repository guard → 404 (not 403) for cross-tenant ID guesses (do not expose whether another tenant's resource exists)

### Central Athlete Identity
**Recommended: Rename `Swimmer` → `Athlete` (platform-level); add `swim.SwimProfile` as sport-specific extension point**

The existing `Swimmer` entity contains ONLY: `FirstName`, `LastName`, `BirthDate`, `IsMale` — these are universal athlete attributes. There are no swim-specific columns. This makes the rename a nearly mechanical change with minimal migration risk.

```
dbo.Athlete (platform)
  AthleteId, FirstName, LastName, BirthDate, Gender, TenantId

swim.SwimProfile (sport-specific extension)
  SwimProfileId, AthleteId FK, USASwimmingId, ...

tf.TrackFieldProfile (future sport-specific extension)
  TrackFieldProfileId, AthleteId FK, USATFId, ...

dbo.UserAthlete (platform — replaces UserSwimmer)
  UserAthleteId, SystemUserId, AthleteId, IsPrimary, TenantId

dbo.AthleteTeamSeason (platform — replaces SwimmerTeamSeason)
  AthleteTeamSeasonId, AthleteId, TeamSeasonId, TenantId
```

- `UserAthlete.IsPrimary` supports parent/guardian managing a child athlete (common in youth sports)
- `AthleteTeamSeason` with the platform `TeamSeason` covers all sports — no `SportID` needed on this table because `TeamSeason` → `Season` → `League` → `Sport` can be resolved via join

### Sport Domain Module Architecture (.NET 9)
**Recommended: Monorepo with sport-specific class libraries + `ISportModule` extension contract**

Microservices are rejected for a 1–3 person team — operational overhead exceeds benefit at this stage.

```csharp
// Core platform defines the contract
public interface ISportModule
{
    string SportCode { get; }           // "swim", "tf"
    void RegisterServices(IServiceCollection services, IConfiguration config);
    void MapEndpoints(WebApplication app);
}

// Swim module implements it
// SwimDomain/SwimModule.cs
public class SwimModule : ISportModule
{
    public string SportCode => "swim";
    public void RegisterServices(IServiceCollection services, IConfiguration config)
    {
        services.AddScoped<ISwimMeetRepository, SwimMeetRepository>();
        services.AddScoped<IHeatSheetService, HeatSheetService>();
        // ... all swim-specific DI
    }
    public void MapEndpoints(WebApplication app)
    {
        // Controller discovery via AddApplicationPart
        // (Controllers are already mapped by the host's MapControllers call)
    }
}

// Host Program.cs
var modules = new List<ISportModule> { new SwimModule() };
// Adding Track & Field later = add new TrackFieldModule() to this list
foreach (var module in modules)
    module.RegisterServices(builder.Services, builder.Configuration);

// Register sport module controllers
foreach (var module in modules)
    builder.Services.AddControllers()
        .AddApplicationPart(module.GetType().Assembly);
```

- New sport = add one class library project + register in `Program.cs` list — no changes to platform code
- Explicit module list (not assembly scanning) until 5+ sports: less magic, easier to debug

### API Route Structure
**Recommended: Sport-prefixed routes — `/api/swim/...` and `/api/tf/...`**

- Sport is structural, not a query parameter — `/api/swim/meets` vs `/api/meets?sport=swim`
- The sport prefix makes it clear in logs, API documentation, and React code which domain is being accessed
- Platform routes (League, Team, Athlete, User) stay at `/api/leagues`, `/api/teams`, `/api/athletes`

```
/api/leagues/{id}                     ← platform (all sports)
/api/leagues/{id}/seasons             ← platform
/api/teams/{id}                       ← platform
/api/athletes/{id}                    ← platform (central identity)
/api/swim/meets                       ← swim domain
/api/swim/meets/{id}/heatsheets       ← swim domain
/api/tf/meets                         ← Track & Field domain (future)
/api/tf/meets/{id}/events             ← Track & Field domain (future)
```

### React SPA Multi-Sport Structure
**Recommended: Route-based lazy loading with sport code prefixed in TanStack Query keys**

Module Federation is overkill for a 1–3 person team. Route-based code splitting with `React.lazy()` is sufficient and built into Vite/React.

```tsx
// App.tsx — sport modules are lazy-loaded
const SwimModule = React.lazy(() => import('./features/swim/SwimRoutes'));
const TrackFieldModule = React.lazy(() => import('./features/tf/TFRoutes'));

// Enabled sports come from tenant context (API)
const { data: tenant } = useTenant();
<Routes>
  <Route path="/swim/*" element={
    tenant?.enabledSports.includes('swim')
      ? <Suspense fallback={<Spinner />}><SwimModule /></Suspense>
      : <Navigate to="/" />
  } />
  <Route path="/tf/*" element={
    tenant?.enabledSports.includes('tf')
      ? <Suspense fallback={<Spinner />}><TrackFieldModule /></Suspense>
      : <Navigate to="/" />
  } />
</Routes>
```

TanStack Query key convention — sport code always at index 0:
```tsx
['swim', 'meets', seasonId]       // swim domain
['swim', 'heatsheets', meetId]
['tf', 'meets', seasonId]         // future T&F domain
['platform', 'leagues']           // platform primitives
['platform', 'athletes', id]
```

### Result Generalization (CRITICAL prerequisite for T&F)

The existing `Result` entity has only `ElapsedTime` (a `double`). Track & Field requires distance and height measurements. **The `Result` table must be generalized before Track & Field development begins.**

```sql
-- Generalized platform Result
ALTER TABLE dbo.Result ADD MeasurementType NVARCHAR(20) NOT NULL DEFAULT 'Time';
-- Values: 'Time', 'Distance', 'Height', 'Points'
ALTER TABLE dbo.Result ADD MeasurementValue FLOAT NULL;  -- for distance/height
-- ElapsedTime remains for Time measurements (no data migration needed for swim)
```

### Track & Field Domain Validation

Research confirmed the swim platform architecture accommodates T&F:
- T&F uses `Heat` for track events and `Flight` for field events (`Flight` ≈ `Heat` structurally — a grouping of athletes)
- Field events require `FieldAttempt` (up to 6 attempts per athlete per event) — new entity in `tf.*`
- `LaneNumber` is nullable in T&F (null for distance events and all field events) — `swim.HeatSwimmer.LaneNumber` must be non-null; `tf.HeatAthlete.LaneNumber` nullable
- The generalized `AthleteTeamSeason` + `Meet` (with `SportID` FK) covers the participation model for both sports
- `AgeClass`/`AgeClassRule` are already sport-agnostic — no changes needed for T&F

## Technical Scenarios

### Scenario 1: SaaS Tenant Resolution Pipeline (.NET 9)

**Requirements:**
- Every API request must identify the tenant before any data access
- Tenant ID from JWT claim (custom or `org_id`)
- RLS session context set per connection before queries run
- 404 (not 403) for cross-tenant resource guesses

**Preferred Approach:**

```csharp
// Infrastructure/Tenancy/ITenantContext.cs
public interface ITenantContext
{
    int TenantId { get; }
    string TenantKey { get; }   // human-readable slug, e.g. "riverside-swim"
}

// Infrastructure/Tenancy/TenantResolutionMiddleware.cs
public class TenantResolutionMiddleware(RequestDelegate next)
{
    public async Task InvokeAsync(HttpContext ctx, ITenantContext tenantContext)
    {
        var tenantClaim = ctx.User.FindFirstValue("https://athleteplatform.com/tenant_id");
        if (tenantClaim is not null && tenantContext is TenantContext tc)
        {
            await tc.ResolveAsync(tenantClaim); // DB lookup: key → TenantId int
        }
        await next(ctx);
    }
}

// Infrastructure/Data/TenantAwareConnectionFactory.cs
public class TenantAwareConnectionFactory(string connString, ITenantContext tenant)
{
    public async Task<SqlConnection> OpenAsync()
    {
        var conn = new SqlConnection(connString);
        await conn.OpenAsync();
        // Set RLS session context — read_only = true prevents app code from overriding
        await conn.ExecuteAsync(
            "EXEC sp_set_session_context @key=N'TenantId', @value=@id, @read_only=1",
            new { id = tenant.TenantId });
        return conn;
    }
}

// Program.cs pipeline order
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.UseMiddleware<TenantResolutionMiddleware>(); // AFTER auth, reads validated JWT claims
app.UseCors("SpaOrigin");
app.MapControllers();
```

### Scenario 2: Central Athlete Entity Schema

**Platform tables (dbo schema):**

```sql
-- Platform-level athlete identity
CREATE TABLE dbo.Athlete (
    AthleteId       INT IDENTITY(1,1) PRIMARY KEY,
    TenantId        INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    FirstName       NVARCHAR(100) NOT NULL,
    LastName        NVARCHAR(100) NOT NULL,
    BirthDate       DATE NOT NULL,
    Gender          NCHAR(1) NOT NULL CHECK (Gender IN ('M','F','X')),
    CreatedDate     DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    ModifiedDate    DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

-- User → Athlete link (replaces UserSwimmer)
CREATE TABLE dbo.UserAthlete (
    UserAthleteId   INT IDENTITY(1,1) PRIMARY KEY,
    TenantId        INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SystemUserId    INT NOT NULL REFERENCES dbo.SystemUser(SystemUserId),
    AthleteId       INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    IsPrimary       BIT NOT NULL DEFAULT 1  -- parent/guardian support
);

-- Athlete on a team in a season (replaces SwimmerTeamSeason)
CREATE TABLE dbo.AthleteTeamSeason (
    AthleteTeamSeasonId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId            INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    AthleteId           INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    TeamSeasonId        INT NOT NULL REFERENCES dbo.TeamSeason(TeamSeasonId),
    StartDate           DATE NOT NULL,
    EndDate             DATE NOT NULL
);

-- Sport-specific swim extension
CREATE TABLE swim.SwimProfile (
    SwimProfileId   INT IDENTITY(1,1) PRIMARY KEY,
    AthleteId       INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    TenantId        INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    USASwimmingId   NVARCHAR(20) NULL
    -- future swim-specific fields go here
);
```

**Migration path from existing Swimomatic schema:**
1. Create `dbo.Athlete` table with same columns as `dbo.Swimmer` plus `TenantId`
2. Migrate data: `INSERT dbo.Athlete SELECT SwimmerID, FirstName, LastName, BirthDate, IsMale FROM dbo.Swimmer`
3. Create `swim.SwimProfile` with FK to `dbo.Athlete` (empty for now — no swim-specific columns yet)
4. Create `dbo.UserAthlete` from `dbo.UserSwimmer`
5. Create `dbo.AthleteTeamSeason` from `dbo.SwimmerTeamSeason`
6. Update stored procedures: replace `dbo.Swimmer` references with `dbo.Athlete`
7. Keep `dbo.Swimmer` as a VIEW aliasing `dbo.Athlete` during transition to avoid breaking any remaining references

### Scenario 3: ISportModule Extension Contract (.NET 9)

```csharp
// AthletePlatform.Core/ISportModule.cs (platform class library)
public interface ISportModule
{
    string SportCode { get; }
    void RegisterServices(IServiceCollection services, IConfiguration config);
    // MapEndpoints not needed — controllers discovered via AddApplicationPart
}

// SwimDomain/SwimModule.cs (swim class library)
public sealed class SwimModule : ISportModule
{
    public string SportCode => "swim";

    public void RegisterServices(IServiceCollection services, IConfiguration config)
    {
        // Swim-specific repositories
        services.AddScoped<ISwimMeetRepository, SwimMeetRepository>();
        services.AddScoped<IHeatSheetRepository, HeatSheetRepository>();
        services.AddScoped<IResultRepository, ResultRepository>();
        // Swim-specific services
        services.AddScoped<ISwimMeetService, SwimMeetService>();
        services.AddScoped<IHeatSheetService, HeatSheetService>();
        services.AddScoped<IResultService, ResultService>();
    }
}

// AthletePlatformAPI/Program.cs (host project — minimal changes per new sport)
var modules = new List<ISportModule>
{
    new SwimModule(),
    // new TrackFieldModule(), ← adding T&F = one line change
};

var mvcBuilder = builder.Services.AddControllers();
foreach (var module in modules)
{
    module.RegisterServices(builder.Services, builder.Configuration);
    mvcBuilder.AddApplicationPart(module.GetType().Assembly); // discovers sport controllers
}
```

### Scenario 4: React SPA Multi-Sport Navigation

```tsx
// features/platform/hooks/useTenant.ts
export function useTenant() {
  return useQuery({
    queryKey: ['platform', 'tenant'],
    queryFn: api.platform.getTenant
  });
}

// features/platform/components/NavBar.tsx
export function NavBar() {
  const { data: tenant } = useTenant();
  return (
    <nav>
      <NavLink to="/dashboard">Home</NavLink>
      {tenant?.enabledSports.includes('swim') && (
        <NavLink to="/swim">Swimming</NavLink>
      )}
      {tenant?.enabledSports.includes('tf') && (
        <NavLink to="/tf">Track & Field</NavLink>
      )}
      <NavLink to="/profile">My Profile</NavLink>
    </nav>
  );
}

// App.tsx — sport modules loaded only when accessed
const SwimRoutes = React.lazy(() => import('./features/swim/SwimRoutes'));
const TFRoutes = React.lazy(() => import('./features/tf/TFRoutes'));
```

### Scenario 5: Database Schema Organization

```
dbo.*           — Platform primitives (Tenant, SystemUser, Athlete, League, Season,
                  Team, TeamSeason, Location, Region, UOM, AgeClass,
                  ScoringScheme, UserAthlete, AthleteTeamSeason, etc.)

swim.*          — Swim-specific tables (SwimProfile, SwimMeet, SwimMeetConfig,
                  HeatSheet, Heat, HeatSheetEvent, HeatSwimmer, Stroke,
                  SwimEvent, PoolConfig, Split, SwimResult)

tf.*            — Track & Field tables (future: TFMeet, TFMeetConfig, TFEvent,
                  EventType, Heat/Flight, HeatAthlete, FieldAttempt, TFResult)
```

Stored procedure naming convention:
- Platform: `spAthleteGet`, `spLeagueSave`, `spTeamSeasonGetAll`
- Swim: `spSwimMeetGet`, `spHeatSheetSave`, `spHeatSwimmerGetAll`
- T&F: `spTFMeetGet`, `spFlightSave`, `spFieldAttemptGetAll`

### Scenario 6: Meet Generalization

The existing `SwimMeet` maps to a platform-level `Meet` concept:

```sql
-- Platform-level Meet
CREATE TABLE dbo.Meet (
    MeetId          INT IDENTITY(1,1) PRIMARY KEY,
    TenantId        INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SportId         INT NOT NULL REFERENCES dbo.Sport(SportId),
    SeasonId        INT NOT NULL REFERENCES dbo.Season(SeasonId),
    LocationId      INT NOT NULL REFERENCES dbo.Location(LocationId),
    Description     NVARCHAR(200) NOT NULL,
    StartDate       DATE NOT NULL,
    EndDate         DATE NOT NULL,
    MeetTypeId      INT NOT NULL  -- Dual/Triangle/Invitational — sport-specific lookup
);

-- Swim-specific meet configuration
CREATE TABLE swim.SwimMeetConfig (
    SwimMeetConfigId    INT IDENTITY(1,1) PRIMARY KEY,
    MeetId              INT NOT NULL REFERENCES dbo.Meet(MeetId),
    -- swim-specific fields: SwimMeetTypeID mapping, HeatSheet settings, etc.
);
```

## Implementation Roadmap Addendum (SaaS + Multi-Sport)

### Phase 0 — Platform Foundation (before Phase 1 of core features)
1. Define `Tenant`, `Sport`, `dbo.Athlete` tables (alongside existing Swimomatic schema during migration)
2. Implement `ITenantContext`, `TenantResolutionMiddleware`, `TenantAwareConnectionFactory`
3. Add `TenantId` column to all tenant-scoped tables
4. Implement Azure SQL RLS policies via `sp_set_session_context`
5. Set up Auth0 Post-Login Action to inject `https://athleteplatform.com/tenant_id` custom claim
6. Define `ISportModule` interface in platform core library
7. Scaffold `AthletePlatformAPI` host project + `SwimDomain` class library structure

### Phase 1 — Core Swim Features (revised)
* Unchanged from existing plan, but implemented within the SaaS + multi-sport scaffold
* All swim entities use `swim.*` schema prefix
* All platform entities (`dbo.Athlete`, `dbo.League`, etc.) used by swim domain via join

### Existing Phase 2–5 continue unchanged within the multi-sport scaffold
