<!-- markdownlint-disable-file -->
# Implementation Details: Multi-Sport SaaS Platform (Phases 0–3 + T&F Scaffold)

## Context Reference

Sources:
* .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md (primary architecture reference)
* .copilot-tracking/research/2026-06-23/swimomatic-modernization-research.md (stack decisions, entity inventory, endpoint mapping)
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md (admin authorization, heat grid, approval workflows)
* .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md (tenancy, Azure infra, Auth0)
* .copilot-tracking/research/subagents/2026-06-23/multisport-domain-extensibility-research.md (ISportModule, athlete identity, T&F)

---

## Phase A: Solution Structure + Azure Infrastructure

<!-- parallelizable: false -->

### Step A.1: Scaffold .NET 9 Solution with All Project References

Create the monorepo solution structure. The host API project is thin; domain logic lives in class libraries.

Solution file: `AthletePlatform.sln`

Project structure:
```
AthletePlatform/
  AthletePlatformAPI/           .NET 9 WebAPI host (thin — pipeline + DI wiring only)
  Platform.Core/                Shared interfaces, models, ISportModule (no DI, no infra)
  Platform.Infrastructure/      Dapper repos for platform entities (Athlete, League, Team, etc.)
  SwimDomain/                   Swim class library (SwimModule : ISportModule)
  SwimDomain.Tests/             xUnit tests for SwimDomain services + handlers
  TrackField.Domain/            T&F stub class library (TrackFieldModule : ISportModule)
  athlete-platform-spa/         Vite + React SPA (npm project, NOT a .csproj)
  infra/                        Bicep IaC files
  db/migrations/                DbUp SQL migration scripts (numbered V001__ prefix)
  .github/workflows/            GitHub Actions YAML
```

Create .sln and .csproj files:
* `AthletePlatformAPI` → project references: `Platform.Core`, `Platform.Infrastructure`, `SwimDomain`, `TrackField.Domain`
* `Platform.Infrastructure` → project reference: `Platform.Core`
* `SwimDomain` → project references: `Platform.Core`, `Platform.Infrastructure`
* `SwimDomain.Tests` → project references: `SwimDomain`; NuGet: xunit, Moq, FluentAssertions
* `TrackField.Domain` → project reference: `Platform.Core`

Files:
* AthletePlatform.sln — solution file
* AthletePlatformAPI/AthletePlatformAPI.csproj — target: `net9.0`
* Platform.Core/Platform.Core.csproj — target: `net9.0`; no external dependencies
* Platform.Infrastructure/Platform.Infrastructure.csproj — target: `net9.0`; NuGet: Dapper, Microsoft.Data.SqlClient
* SwimDomain/SwimDomain.csproj — target: `net9.0`; NuGet: Dapper, Microsoft.Data.SqlClient
* SwimDomain.Tests/SwimDomain.Tests.csproj — target: `net9.0`
* TrackField.Domain/TrackField.Domain.csproj — target: `net9.0`

Success criteria:
* `dotnet build AthletePlatform.sln` exits 0 with empty projects
* All project references resolve correctly

Dependencies:
* None (this is the first step)

---

### Step A.2: Provision Azure Resources with Bicep IaC

Create Bicep IaC for all production resources. Single environment (production only).

Files to create:
* infra/main.bicep — orchestrates all modules
* infra/modules/sql.bicep — Azure SQL Server + Database (S3 tier, ~$150/mo)
* infra/modules/app-service.bicep — App Service Plan (B2) + App Service
* infra/modules/static-web-apps.bicep — Azure Static Web Apps (free tier)
* infra/modules/key-vault.bicep — Azure Key Vault (for connection strings, Auth0 secrets)
* infra/modules/app-insights.bicep — Application Insights + Log Analytics Workspace

Key Bicep parameters:
* `appName` — base name for all resources (e.g., `athleteplatform`)
* `sqlAdminPassword` — passed via GitHub Actions secret; stored in Key Vault
* `auth0Domain`, `auth0Audience` — stored as Key Vault secrets; referenced in App Service config

App Service configuration:
* `ASPNETCORE_ENVIRONMENT` = `Production`
* Key Vault references for `ConnectionStrings__Default`, `Auth0__Domain`, `Auth0__Audience`
* Managed Identity enabled (used by App Insights and for Key Vault access)
* `WEBSITES_ENABLE_APP_SERVICE_STORAGE` = false

Azure SQL configuration:
* Firewall rule: allow Azure services (`startIpAddress: '0.0.0.0'`, `endIpAddress: '0.0.0.0'`)
* Contained database users for Managed Identity (handled in DbUp migration V003)

Static Web Apps configuration:
* `sku: 'Free'`
* `allowedOrigins` for API CORS includes SWA default domain + custom domain when added

Success criteria:
* `az bicep build --file infra/main.bicep` exits 0
* `az deployment group create` succeeds in Azure subscription

Context references:
* .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md — Azure infra section — budget $250–400/month breakdown

Dependencies:
* Azure subscription with Contributor access on target resource group

---

### Step A.3: Configure GitHub Actions CI/CD Pipeline (API + SPA)

Create two GitHub Actions workflows: one for the .NET API and one for the React SPA.

Files to create:
* .github/workflows/api-cd.yml — on push to `main`; build, test, deploy API to App Service
* .github/workflows/spa-cd.yml — on push to `main`; build SPA, deploy to Static Web Apps

API workflow steps:
```yaml
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-dotnet@v4
        with: { dotnet-version: '9.x' }
      - run: dotnet restore AthletePlatform.sln
      - run: dotnet build AthletePlatform.sln --no-restore -c Release
      - run: dotnet test AthletePlatform.sln --no-build -c Release
      - uses: azure/webapps-deploy@v3
        with:
          app-name: ${{ vars.AZURE_APP_SERVICE_NAME }}
          publish-profile: ${{ secrets.AZURE_APP_SERVICE_PUBLISH_PROFILE }}
          package: './publish'
```

SPA workflow steps:
```yaml
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20' }
      - run: npm ci
        working-directory: athlete-platform-spa
      - run: npm run build
        working-directory: athlete-platform-spa
        env:
          VITE_AUTH0_DOMAIN: ${{ secrets.VITE_AUTH0_DOMAIN }}
          VITE_AUTH0_CLIENT_ID: ${{ secrets.VITE_AUTH0_CLIENT_ID }}
          VITE_AUTH0_AUDIENCE: ${{ secrets.VITE_AUTH0_AUDIENCE }}
          VITE_API_BASE_URL: ${{ vars.VITE_API_BASE_URL }}
      - uses: Azure/static-web-apps-deploy@v1
        with:
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN }}
          action: 'upload'
          app_location: '/athlete-platform-spa'
          output_location: 'dist'
```

GitHub Secrets to configure:
* `AZURE_APP_SERVICE_PUBLISH_PROFILE` — from Azure Portal publish profile download
* `AZURE_STATIC_WEB_APPS_API_TOKEN` — from SWA resource in Azure Portal
* `VITE_AUTH0_DOMAIN` — Auth0 tenant domain
* `VITE_AUTH0_CLIENT_ID` — Auth0 SPA application client ID
* `VITE_AUTH0_AUDIENCE` — Auth0 API audience (`https://api.athleteplatform.com`)

GitHub Variables to configure:
* `AZURE_APP_SERVICE_NAME`
* `VITE_API_BASE_URL` — App Service URL

Success criteria:
* Push to `main` triggers both workflows
* API workflow passes all unit tests before deployment
* SPA deploys to Static Web Apps with correct Auth0 environment variables

Dependencies:
* Step A.2 complete (Azure resources must exist for deployment)

---

### Step A.4: Configure DbUp Migration Runner in API Host Project

DbUp runs during application startup via `IHostedService` or directly in `Program.cs` before the app starts serving requests.

Files to create/modify:
* AthletePlatformAPI/Infrastructure/Migrations/DatabaseMigrator.cs — DbUp wrapper
* AthletePlatformAPI/Program.cs — call migrator before `app.Run()`
* db/migrations/ — directory for all V001__*.sql migration scripts (empty at this step; scripts added per phase)

DbUp pattern:
```csharp
// AthletePlatformAPI/Infrastructure/Migrations/DatabaseMigrator.cs
public static class DatabaseMigrator
{
    public static void MigrateDatabase(string connectionString)
    {
        var upgrader = DeployChanges.To
            .SqlDatabase(connectionString)
            .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(),
                s => s.StartsWith("AthletePlatformAPI.db.migrations"))
            .WithTransaction()
            .LogToConsole()
            .Build();

        var result = upgrader.PerformUpgrade();
        if (!result.Successful)
            throw new Exception($"DbUp migration failed: {result.Error.Message}");
    }
}

// Program.cs (before app.Run())
DatabaseMigrator.MigrateDatabase(
    builder.Configuration.GetConnectionString("Default")!);
```

Migration file naming: `V001__description.sql`, `V002__description.sql` (must be embedded resources in `AthletePlatformAPI.csproj`).

Embed migrations in .csproj (path is relative to `AthletePlatformAPI.csproj`, which is one level below the `db/migrations/` folder at solution root):
```xml
<ItemGroup>
  <EmbeddedResource Include="..\db\migrations\**\*.sql" />
</ItemGroup>
```

Success criteria:
* Application startup runs DbUp and logs "No new scripts found" when already up to date
* Failed migration throws exception and prevents app startup

Dependencies:
* Step A.1 (project structure must exist)

---

## Phase B: SaaS Platform Foundation (.NET)

<!-- parallelizable: false -->

### Step B.1: Create Platform Database Schema Migrations

Create DbUp SQL migration scripts for all platform (`dbo.*`) tables and Azure SQL RLS policies.

Files to create:
* db/migrations/V001__platform_schemas.sql — create `swim` and `tf` schemas
* db/migrations/V002__platform_tables.sql — `dbo.Tenant`, `dbo.Sport`, `dbo.SystemUser`, `dbo.Athlete`, `dbo.UserAthlete`, `dbo.League`, `dbo.Season`, `dbo.Team`, `dbo.TeamSeason`, `dbo.AthleteTeamSeason`, `dbo.Location`, `dbo.Region`, `dbo.UOM`, `dbo.AgeClass`, `dbo.AgeClassRule`, `dbo.ScoringScheme`, `dbo.SeasonScoringScheme`, `dbo.Meet`
* db/migrations/V003__rls_policies.sql — RLS security policies on all `TenantId`-scoped tables
* db/migrations/V004__managed_identity_user.sql — Azure SQL contained user for Managed Identity

Key table DDL:
```sql
-- V001__platform_schemas.sql
CREATE SCHEMA swim;
CREATE SCHEMA tf;

-- V002__platform_tables.sql (excerpt — key new tables)
CREATE TABLE dbo.Tenant (
    TenantId    INT IDENTITY(1,1) PRIMARY KEY,
    TenantKey   NVARCHAR(50) NOT NULL UNIQUE,  -- e.g. 'riverside-swim'
    Name        NVARCHAR(200) NOT NULL,
    IsActive    BIT NOT NULL DEFAULT 1,
    CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

-- TenantSport join table: which sports are enabled for each tenant
CREATE TABLE dbo.TenantSport (
    TenantSportId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId      INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SportId       INT NOT NULL REFERENCES dbo.Sport(SportId),
    EnabledDate   DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_TenantSport UNIQUE (TenantId, SportId)
);

CREATE TABLE dbo.Sport (
    SportId     INT IDENTITY(1,1) PRIMARY KEY,
    SportCode   NVARCHAR(10) NOT NULL UNIQUE,  -- 'swim', 'tf'
    Name        NVARCHAR(100) NOT NULL,
    IsActive    BIT NOT NULL DEFAULT 1
);
INSERT INTO dbo.Sport (SportCode, Name) VALUES ('swim', 'Swimming'), ('tf', 'Track & Field');
-- Seed a default tenant (developer/test); production tenants are created via API
INSERT INTO dbo.Tenant (TenantKey, Name) VALUES ('dev-tenant', 'Development Tenant');
INSERT INTO dbo.TenantSport (TenantId, SportId)
    SELECT t.TenantId, s.SportId FROM dbo.Tenant t CROSS JOIN dbo.Sport s
    WHERE t.TenantKey = 'dev-tenant' AND s.SportCode = 'swim';

CREATE TABLE dbo.Athlete (
    AthleteId    INT IDENTITY(1,1) PRIMARY KEY,
    TenantId     INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    FirstName    NVARCHAR(100) NOT NULL,
    LastName     NVARCHAR(100) NOT NULL,
    BirthDate    DATE NOT NULL,
    Gender       NCHAR(1) NOT NULL CHECK (Gender IN ('M','F','X')),
    CreatedDate  DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    ModifiedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.UserAthlete (
    UserAthleteId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId      INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SystemUserId  INT NOT NULL REFERENCES dbo.SystemUser(SystemUserId),
    AthleteId     INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    IsPrimary     BIT NOT NULL DEFAULT 1
);

CREATE TABLE dbo.AthleteTeamSeason (
    AthleteTeamSeasonId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId            INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    AthleteId           INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    TeamSeasonId        INT NOT NULL REFERENCES dbo.TeamSeason(TeamSeasonId),
    StartDate           DATE NOT NULL,
    EndDate             DATE NOT NULL
);

-- dbo.League includes SportId so the /api/leagues endpoint can filter by sport without joins
CREATE TABLE dbo.League (
    LeagueId    INT IDENTITY(1,1) PRIMARY KEY,
    TenantId    INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SportId     INT NOT NULL REFERENCES dbo.Sport(SportId),  -- filter leagues by sport
    Name        NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500) NULL,
    RegionId    INT NULL REFERENCES dbo.Region(RegionId),
    CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.Meet (
    MeetId      INT IDENTITY(1,1) PRIMARY KEY,
    TenantId    INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SportId     INT NOT NULL REFERENCES dbo.Sport(SportId),
    SeasonId    INT NOT NULL REFERENCES dbo.Season(SeasonId),
    LocationId  INT NOT NULL REFERENCES dbo.Location(LocationId),
    Description NVARCHAR(200) NOT NULL,
    StartDate   DATE NOT NULL,
    EndDate     DATE NOT NULL
);

-- V003__rls_policies.sql (excerpt — repeat pattern for each tenant-scoped table)
CREATE FUNCTION dbo.fn_TenantFilter(@TenantId INT)
RETURNS TABLE
WITH SCHEMABINDING
AS RETURN SELECT 1 AS fn_result
WHERE CAST(SESSION_CONTEXT(N'TenantId') AS INT) = @TenantId;

CREATE SECURITY POLICY dbo.AthletePolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Athlete,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Athlete
    WITH (STATE = ON);
-- Repeat for: Tenant-scoped tables — Meet, League, Season, Team, TeamSeason, AthleteTeamSeason, UserAthlete
```

Success criteria:
* All migrations apply to a fresh Azure SQL database without error
* RLS blocks INSERT/SELECT to rows with a different TenantId than session context

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md (Lines 100–170) — Athlete schema + RLS pattern

Dependencies:
* Step A.4 (DbUp runner must be configured before migrations are authored)

---

### Step B.2: Implement `ITenantContext`, `TenantContext`, `TenantResolutionMiddleware`

Files to create:
* AthletePlatformAPI/Infrastructure/Tenancy/ITenantContext.cs
* AthletePlatformAPI/Infrastructure/Tenancy/TenantContext.cs
* AthletePlatformAPI/Infrastructure/Tenancy/TenantResolutionMiddleware.cs

```csharp
// ITenantContext.cs
public interface ITenantContext
{
    int TenantId { get; }
    string TenantKey { get; }
    bool IsResolved { get; }
}

// TenantContext.cs (registered as Scoped)
public sealed class TenantContext : ITenantContext
{
    public int TenantId { get; private set; }
    public string TenantKey { get; private set; } = string.Empty;
    public bool IsResolved { get; private set; }

    public async Task ResolveAsync(string tenantKey, IDbConnectionFactory connFactory)
    {
        using var conn = await connFactory.OpenAsync(bypassRls: true); // system query
        var tenant = await conn.QuerySingleOrDefaultAsync<(int Id, string Key)>(
            "SELECT TenantId, TenantKey FROM dbo.Tenant WHERE TenantKey = @key AND IsActive = 1",
            new { key = tenantKey });
        if (tenant == default)
            throw new TenantNotFoundException(tenantKey);
        TenantId = tenant.Id;
        TenantKey = tenant.Key;
        IsResolved = true;
    }
}

// TenantResolutionMiddleware.cs
public class TenantResolutionMiddleware(RequestDelegate next)
{
    private const string TenantClaimType = "https://athleteplatform.com/tenant_id";

    public async Task InvokeAsync(HttpContext ctx, ITenantContext tenantContext,
        IDbConnectionFactory connFactory)
    {
        // Only resolve for authenticated requests
        if (ctx.User.Identity?.IsAuthenticated == true)
        {
            var tenantKey = ctx.User.FindFirstValue(TenantClaimType);
            if (tenantKey is null)
            {
                ctx.Response.StatusCode = StatusCodes.Status401Unauthorized;
                return;
            }
            if (tenantContext is TenantContext tc)
                await tc.ResolveAsync(tenantKey, connFactory);
        }
        await next(ctx);
    }
}
```

DI registration (Program.cs):
```csharp
builder.Services.AddScoped<ITenantContext, TenantContext>();
builder.Services.AddScoped<TenantContext>(); // also register concrete for middleware
```

Success criteria:
* Middleware populates `ITenantContext.TenantId` from JWT claim on each request
* Missing tenant claim returns 401; unknown tenant key returns 404 via `TenantNotFoundException` handled by global exception middleware

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md (Lines 190–230) — full middleware code example

Dependencies:
* Step B.1 (`dbo.Tenant` table must exist for the DB lookup)

---

### Step B.3: Implement `TenantAwareConnectionFactory` with RLS Session Context

Files to create:
* AthletePlatformAPI/Infrastructure/Data/IDbConnectionFactory.cs
* AthletePlatformAPI/Infrastructure/Data/DbConnectionFactory.cs

```csharp
// IDbConnectionFactory.cs
public interface IDbConnectionFactory
{
    Task<SqlConnection> OpenAsync(bool bypassRls = false);
}

// DbConnectionFactory.cs
public sealed class DbConnectionFactory(
    string connectionString, ITenantContext tenantContext) : IDbConnectionFactory
{
    public async Task<SqlConnection> OpenAsync(bool bypassRls = false)
    {
        var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        if (!bypassRls && tenantContext.IsResolved)
        {
            await conn.ExecuteAsync(
                "EXEC sp_set_session_context @key=N'TenantId', @value=@id, @read_only=1",
                new { id = tenantContext.TenantId });
        }
        return conn;
    }
}
```

DI registration:
```csharp
builder.Services.AddScoped<IDbConnectionFactory>(sp =>
    new DbConnectionFactory(
        builder.Configuration.GetConnectionString("Default")!,
        sp.GetRequiredService<ITenantContext>()));
```

Repositories use `IDbConnectionFactory.OpenAsync()` and dispose the connection in a `using` block per operation. They never hold long-lived connections.

Success criteria:
* Every call to `OpenAsync()` on an authenticated request sets the RLS session context
* Cross-tenant queries are blocked by RLS FILTER predicate and return empty sets (not errors)

Discrepancy references:
* Addresses DR-01 (RLS as defense-in-depth; application-layer tenant guard is secondary)

Context references:
* .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md — `TenantAwareRepository` pattern

Dependencies:
* Step B.2 (TenantContext must be registered before DbConnectionFactory can reference it)

---

### Step B.4: Configure Auth0 Tenant + Post-Login Action (Custom `tenant_id` Claim)

This step requires manual configuration in the Auth0 dashboard. Document the steps precisely so they are reproducible.

Auth0 configuration actions:
1. Create Auth0 tenant at `manage.auth0.com`
2. Create API resource: Identifier = `https://api.athleteplatform.com`; Signing = RS256
3. Create SPA Application: Type = Single Page Application; Allowed Callback URLs = SWA URL + `http://localhost:5173`; Allowed Logout URLs = same; Allowed Web Origins = same
4. Create Post-Login Action with this code:
```javascript
// Auth0 Post-Login Action: Inject tenant_id into access token
exports.onExecutePostLogin = async (event, api) => {
  const tenantId = event.user.app_metadata?.tenantId;
  if (tenantId) {
    api.accessToken.setCustomClaim(
      'https://athleteplatform.com/tenant_id', tenantId);
  }
};
```
5. Deploy the Action and attach it to the Login flow
6. For each tenant being created: set `app_metadata.tenantId = 'riverside-swim'` via Auth0 Management API or dashboard

.NET 9 Auth0 JWT Bearer configuration (appsettings.json + Program.cs):
```json
{
  "Auth0": {
    "Domain": "your-tenant.auth0.com",
    "Audience": "https://api.athleteplatform.com"
  }
}
```
```csharp
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
```

Files to create/modify:
* AthletePlatformAPI/appsettings.json — Auth0 section (values from Key Vault in prod)
* AthletePlatformAPI/Program.cs — AddAuthentication/AddJwtBearer

Success criteria:
* JWT from Auth0 passes validation in .NET 9 (`[Authorize]` returns 200, not 401)
* `User.FindFirstValue("https://athleteplatform.com/tenant_id")` returns the correct tenant key

Context references:
* .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md — Auth0 Post-Login Action section

Dependencies:
* Auth0 free tier account
* Step A.2 (App Service URL needed for Allowed Callback URLs)

---

### Step B.5: Configure Application Insights SDK + `TenantIdTelemetryInitializer`

Files to create/modify:
* AthletePlatformAPI/Infrastructure/Telemetry/TenantIdTelemetryInitializer.cs
* AthletePlatformAPI/appsettings.json — `ApplicationInsights.ConnectionString`

```csharp
// TenantIdTelemetryInitializer.cs
public class TenantIdTelemetryInitializer(IHttpContextAccessor httpContextAccessor) : ITelemetryInitializer
{
    public void Initialize(ITelemetry telemetry)
    {
        if (telemetry is not ISupportProperties props) return;
        var ctx = httpContextAccessor.HttpContext;
        if (ctx is null) return;
        var tenantContext = ctx.RequestServices.GetService<ITenantContext>();
        if (tenantContext?.IsResolved == true)
        {
            props.Properties["TenantKey"] = tenantContext.TenantKey;
            props.Properties["TenantId"] = tenantContext.TenantId.ToString(); // integer for KQL queries
        }
    }
}
```

Program.cs additions:
```csharp
builder.Services.AddApplicationInsightsTelemetry();
builder.Services.AddHttpContextAccessor();
builder.Services.AddSingleton<ITelemetryInitializer, TenantIdTelemetryInitializer>();
```

Serilog structured logging → Application Insights:
```csharp
builder.Host.UseSerilog((ctx, cfg) =>
    cfg.ReadFrom.Configuration(ctx.Configuration)
       .WriteTo.ApplicationInsights(
           TelemetryConfiguration.Active, TelemetryConverter.Traces));
```

Success criteria:
* Application Insights logs contain `TenantKey` custom dimension on all requests from authenticated tenants
* Serilog writes structured log entries to Application Insights

Dependencies:
* Step A.2 (Application Insights resource must be provisioned)
* Step B.2 (ITenantContext must be registered)

---

### Step B.6: Connect Grafana Cloud Free Tier to Application Insights

Grafana Cloud free tier (grafana.com) provides 10k metrics, 50GB logs, unlimited dashboards — sufficient for early-stage monitoring.

Configuration steps:
1. Sign up at grafana.com (free tier, no credit card)
2. Create an Azure Service Principal with **Reader** + **Monitoring Reader** roles on the resource group
3. In Grafana Cloud, add an **Azure Monitor** data source:
   * Directory (tenant) ID: Azure AD tenant ID
   * Application (client) ID: Service Principal app ID
   * Client Secret: Service Principal secret
   * Default Subscription: your Azure subscription ID
4. Create dashboards for:
   * Requests per second by TenantKey (custom dimension filter)
   * API response time p50/p95/p99 by controller action
   * Failed requests (4xx/5xx) by endpoint
   * Dependency duration (Azure SQL query times)

Security: Store Service Principal secret in GitHub Secrets; create a separate read-only principal that cannot modify Azure resources.

Files to create:
* .copilot-tracking/research/grafana-setup-notes.md — document the exact steps and Service Principal role assignments (for team reference)

Success criteria:
* Grafana dashboard shows live request data from Application Insights
* TenantKey filter works in Grafana query builder

Context references:
* .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md — Application Insights monitoring section

Dependencies:
* Step B.5 (Application Insights must be emitting data before dashboards are useful)
* Step A.2 (Application Insights resource provisioned)

---

### Step B.7: Implement `ISportModule` Interface + `SwimModule` + `TrackFieldModule` Stub

Files to create:
* Platform.Core/ISportModule.cs
* SwimDomain/SwimModule.cs
* TrackField.Domain/TrackFieldModule.cs

```csharp
// Platform.Core/ISportModule.cs
public interface ISportModule
{
    string SportCode { get; }
    void RegisterServices(IServiceCollection services, IConfiguration config);
    // Default no-op: controller-based sports use AddApplicationPart; override for Minimal API route groups
    void MapEndpoints(WebApplication app) { }
}

// SwimDomain/SwimModule.cs
public sealed class SwimModule : ISportModule
{
    public string SportCode => "swim";
    public void RegisterServices(IServiceCollection services, IConfiguration config)
    {
        // Repositories
        services.AddScoped<ISwimMeetRepository, SwimMeetRepository>();
        services.AddScoped<IHeatSheetRepository, HeatSheetRepository>();
        services.AddScoped<IResultRepository, ResultRepository>();
        // Services
        services.AddScoped<ISwimMeetService, SwimMeetService>();
        services.AddScoped<IHeatSheetService, HeatSheetService>();
        services.AddScoped<IResultService, ResultService>();
    }
}

// TrackField.Domain/TrackFieldModule.cs (stub)
public sealed class TrackFieldModule : ISportModule
{
    public string SportCode => "tf";
    public void RegisterServices(IServiceCollection services, IConfiguration config)
    {
        // TODO: Register T&F services when implemented
    }
}
```

Success criteria:
* Both `SwimModule` and `TrackFieldModule` implement `ISportModule`
* Empty `RegisterServices` does not throw

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md (Lines 155–195) — ISportModule code example

Dependencies:
* Step A.1 (all project files must exist)

---

### Step B.8: Configure Request Pipeline in Program.cs

The middleware order is critical for correct tenant resolution. Incorrect ordering causes 401/403 errors.

```csharp
// AthletePlatformAPI/Program.cs — complete pipeline (abbreviated)
var modules = new List<ISportModule> { new SwimModule(), new TrackFieldModule() };
var mvcBuilder = builder.Services.AddControllers();
foreach (var module in modules)
{
    module.RegisterServices(builder.Services, builder.Configuration);
    mvcBuilder.AddApplicationPart(module.GetType().Assembly);
}
// ... register platform services, auth, CORS, tenant context, DbConnectionFactory ...

var app = builder.Build();

// CRITICAL PIPELINE ORDER (CORS must precede UseAuthentication for SPA preflight OPTIONS requests):
app.UseRouting();
app.UseCors("SpaOrigin");      // 1. Respond to preflight OPTIONS before auth middleware
app.UseAuthentication();       // 2. Validate JWT, populate ClaimsPrincipal
app.UseAuthorization();        // 3. Check [Authorize] attributes
app.UseMiddleware<TenantResolutionMiddleware>(); // 4. Read tenant_id claim → ITenantContext
app.MapControllers();

DatabaseMigrator.MigrateDatabase(connectionString);
app.Run();
```

CORS policy (registered in services):
```csharp
builder.Services.AddCors(options =>
    options.AddPolicy("SpaOrigin", policy =>
        policy.WithOrigins(builder.Configuration["AllowedOrigins"]!.Split(','))
              .AllowAnyMethod()
              .AllowAnyHeader()
              .AllowCredentials()));
```

Files to create/modify:
* AthletePlatformAPI/Program.cs — complete wiring

Success criteria:
* Application starts without exception
* `GET /api/swim/meets` with valid JWT returns 200; without JWT returns 401

Discrepancy references:
* DD-01 — CORS positioned BEFORE UseAuthentication; this is the correct order per Microsoft docs (UseCors must follow UseRouting and precede UseAuthentication for OPTIONS preflight to work). Issue resolved.

Dependencies:
* Steps B.2–B.7 (all services and middleware must be registered)

---

### Step B.9: Implement `GET /api/tenant` Endpoint + `TenantController`

The React SPA calls `GET /api/tenant` on startup to determine the current tenant's configuration — specifically `enabledSports` which gates sport module routes and NavBar links. This endpoint is required for Steps C.3 and C.4.

Files to create:
* AthletePlatformAPI/Controllers/TenantController.cs
* Platform.Infrastructure/Repositories/TenantRepository.cs
* Platform.Core/Models/TenantConfig.cs
* db/migrations/V005__tenant_sprocs.sql — `spTenantGetConfig`

```csharp
// TenantConfig.cs
public record TenantConfig(
    string TenantKey,
    string Name,
    IReadOnlyList<string> EnabledSports  // e.g. ["swim"] or ["swim", "tf"]
);

// TenantController.cs
[ApiController]
[Route("api/tenant")]
[Authorize]
public class TenantController(ITenantContext tenantContext, ITenantRepository tenantRepo) : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<TenantConfig>> GetTenantConfig()
    {
        var config = await tenantRepo.GetConfigAsync(tenantContext.TenantId);
        return Ok(config);
    }
}
```

Stored procedure `spTenantGetConfig` joins `dbo.Tenant` + `dbo.TenantSport` + `dbo.Sport` to return the tenant name and a comma-delimited sport code list, which the repository maps to `IReadOnlyList<string>`.

Success criteria:
* `GET /api/tenant` returns `{ tenantKey: 'riverside-swim', name: 'Riverside Swim League', enabledSports: ['swim'] }` for an authenticated user
* Returns 401 for unauthenticated requests
* `enabledSports` reflects the `dbo.TenantSport` rows for the current tenant

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md — React SPA Multi-Sport section

Dependencies:
* Step B.1 (`dbo.TenantSport` table must exist)
* Step B.2 (`ITenantContext.TenantId` must be populated)

---

### Step B.10: Write Unit Tests for `TenantResolutionMiddleware` and `TenantContext`

Files to create:
* SwimDomain.Tests/Infrastructure/TenantResolutionMiddlewareTests.cs
* SwimDomain.Tests/Infrastructure/TenantContextTests.cs

Test cases:
* Authenticated request with valid tenant claim → `ITenantContext.IsResolved = true`, `TenantId` populated
* Authenticated request with missing tenant claim → 401 returned, next middleware NOT called
* Authenticated request with unknown tenant key → `TenantNotFoundException` thrown
* Unauthenticated request → middleware skips resolution, next middleware called

Mock pattern (Moq):
```csharp
var mockConnFactory = new Mock<IDbConnectionFactory>();
mockConnFactory.Setup(f => f.OpenAsync(true))
    .ReturnsAsync(/* mock SqlConnection or interface */);
```

Success criteria:
* All test cases pass
* No actual database connections required in tests (mock factory)

Dependencies:
* Step B.2 (TenantResolutionMiddleware must exist)
* Step B.3 (IDbConnectionFactory must exist)

---

## Phase C: React SPA Foundation

<!-- parallelizable: true -->
<!-- Can start in parallel with Phase B after Step A.1 creates the directory structure -->

### Step C.1: Scaffold Vite + React + TypeScript SPA with Dependencies

Run from workspace root:
```bash
npm create vite@latest athlete-platform-spa -- --template react-ts
cd athlete-platform-spa
npm install @auth0/auth0-react @tanstack/react-query @tanstack/react-query-devtools
npm install react-router-dom
npm install zod
npm install -D tailwindcss @tailwindcss/vite
npm install @radix-ui/react-dialog @radix-ui/react-alert-dialog @radix-ui/react-dropdown-menu
npm install @dnd-kit/core @dnd-kit/sortable @dnd-kit/modifiers
```

Directory structure to create inside `athlete-platform-spa/src/`:
```
features/
  platform/
    hooks/
      useTenant.ts
      useCurrentUser.ts
    components/
      NavBar.tsx
      ProtectedRoute.tsx
    types.ts            ← Athlete, Meet, League, Team types
  swim/
    SwimRoutes.tsx
    api/
      swimApi.ts        ← API fetch functions for swim domain
    hooks/
      useSwimMeets.ts
    components/
      meets/
      heatsheets/
      results/
    types.ts            ← SwimMeet, HeatSheet, etc. (extends platform types)
  tf/
    TFRoutes.tsx        ← placeholder only
    types.ts            ← stub
lib/
  queryClient.ts        ← TanStack Query client configuration
  apiClient.ts          ← base fetch with auth header injection
App.tsx
main.tsx
```

Files to create:
* athlete-platform-spa/vite.config.ts — with `@tailwindcss/vite` plugin
* athlete-platform-spa/src/lib/queryClient.ts — `QueryClient` with `staleTime: 5 * 60 * 1000`
* athlete-platform-spa/src/lib/apiClient.ts — base fetch wrapper that injects Authorization Bearer token

Success criteria:
* `npm run dev` starts dev server at `http://localhost:5173`
* `npm run build` produces a `dist/` directory
* `npm run type-check` exits 0

Dependencies:
* Node.js 20 LTS

---

### Step C.2: Implement Auth0 PKCE Provider + `useCurrentUser` Hook

Files to create/modify:
* athlete-platform-spa/src/main.tsx — wrap `<App>` with `<Auth0Provider>`
* athlete-platform-spa/src/features/platform/hooks/useCurrentUser.ts

```tsx
// main.tsx
<Auth0Provider
  domain={import.meta.env.VITE_AUTH0_DOMAIN}
  clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
  authorizationParams={{
    redirect_uri: window.location.origin,
    audience: import.meta.env.VITE_AUTH0_AUDIENCE,
    scope: 'openid profile email'
  }}
>
  <QueryClientProvider client={queryClient}>
    <App />
  </QueryClientProvider>
</Auth0Provider>

// useCurrentUser.ts
export function useCurrentUser() {
  const { user, isLoading, isAuthenticated, loginWithRedirect, logout } = useAuth0();
  return { user, isLoading, isAuthenticated, loginWithRedirect, logout };
}
```

Files to create:
* athlete-platform-spa/.env.example — VITE_AUTH0_DOMAIN, VITE_AUTH0_CLIENT_ID, VITE_AUTH0_AUDIENCE, VITE_API_BASE_URL

Success criteria:
* Login redirects to Auth0 Universal Login
* After login, `useCurrentUser().isAuthenticated` is `true`
* JWT access token is retrievable via `useAuth0().getAccessTokenSilently()`

Dependencies:
* Step C.1 (project scaffold)
* Step B.4 (Auth0 tenant configured)

---

### Step C.3: Implement `useTenant` Hook + Sport-Aware `NavBar`

Files to create:
* athlete-platform-spa/src/features/platform/hooks/useTenant.ts
* athlete-platform-spa/src/features/platform/components/NavBar.tsx

```tsx
// useTenant.ts
export function useTenant() {
  return useQuery({
    queryKey: ['platform', 'tenant'],
    queryFn: () => apiClient.get<TenantConfig>('/api/tenant'),
    staleTime: Infinity  // tenant config is stable
  });
}

// NavBar.tsx
export function NavBar() {
  const { data: tenant } = useTenant();
  const { isAuthenticated, loginWithRedirect, logout } = useCurrentUser();
  return (
    <nav>
      <NavLink to="/dashboard">Home</NavLink>
      {tenant?.enabledSports.includes('swim') && <NavLink to="/swim">Swimming</NavLink>}
      {tenant?.enabledSports.includes('tf') && <NavLink to="/tf">Track & Field</NavLink>}
      {isAuthenticated
        ? <button onClick={() => logout()}>Sign Out</button>
        : <button onClick={() => loginWithRedirect()}>Sign In</button>}
    </nav>
  );
}
```

Add `GET /api/tenant` endpoint to `AthletePlatformAPI` returning `{ tenantKey, name, enabledSports: ['swim'] }`.

Success criteria:
* NavBar shows "Swimming" link when tenant has `swim` in `enabledSports`
* NavBar does NOT show "Track & Field" link until T&F is enabled for the tenant

Dependencies:
* Step C.2 (Auth0 + apiClient)
* Step B.2 (tenant resolution in API)

---

### Step C.4: Route-Based Lazy Loading in `App.tsx`

Files to create/modify:
* athlete-platform-spa/src/App.tsx

```tsx
const SwimRoutes = React.lazy(() => import('./features/swim/SwimRoutes'));
const TFRoutes = React.lazy(() => import('./features/tf/TFRoutes'));

export function App() {
  const { data: tenant } = useTenant();
  return (
    <BrowserRouter>
      <NavBar />
      <Suspense fallback={<div>Loading…</div>}>
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/swim/*" element={
            tenant?.enabledSports.includes('swim')
              ? <SwimRoutes /> : <Navigate to="/" />
          } />
          <Route path="/tf/*" element={
            tenant?.enabledSports.includes('tf')
              ? <TFRoutes /> : <Navigate to="/" />
          } />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}
```

Files to create:
* athlete-platform-spa/src/features/swim/SwimRoutes.tsx — stub with placeholder text
* athlete-platform-spa/src/features/tf/TFRoutes.tsx — stub with placeholder text

Success criteria:
* `/swim/*` routes load `SwimRoutes` chunk on demand (verify in browser Network tab)
* `/tf/*` routes redirect to `/` when T&F is not in `enabledSports`

Dependencies:
* Step C.3 (useTenant must exist)

---

### Step C.5: Create `staticwebapp.config.json`

Files to create:
* athlete-platform-spa/public/staticwebapp.config.json

```json
{
  "navigationFallback": {
    "rewrite": "/index.html",
    "exclude": ["/api/*", "*.{css,js,png,svg,ico,json}"]
  },
  "globalHeaders": {
    "X-Content-Type-Options": "nosniff",
    "X-Frame-Options": "DENY",
    "Content-Security-Policy": "default-src 'self'; connect-src 'self' https://*.auth0.com https://api.athleteplatform.com; script-src 'self' 'unsafe-inline'"
  }
}
```

Success criteria:
* Direct navigation to `/swim/meets` (deep link) returns the SPA `index.html` and React Router handles the route
* Security headers present in all SWA responses

Dependencies:
* Step C.1 (SPA project must exist)

---

## Phase D: Core Swim API + Unit Tests

<!-- parallelizable: false -->

### Step D.1: Create Swim Database Schema Migrations

Files to create:
* db/migrations/V010__swim_tables.sql — `swim.SwimMeet`, `swim.SwimMeetConfig`, `swim.HeatSheet`, `swim.HeatSheetEvent`, `swim.HeatSheetTeam`, `swim.Heat`, `swim.HeatSwimmer`, `swim.Stroke`, `swim.SwimEvent`, `swim.PoolConfig`, `swim.Split`, `swim.SwimProfile`
* db/migrations/V011__swim_rls_policies.sql — RLS filter + block predicates on `swim.*` tables (TenantId column)
* db/migrations/V012__swim_reference_data.sql — seed Stroke reference data

Key table DDL:
```sql
CREATE TABLE swim.SwimMeet (
    SwimMeetId   INT IDENTITY(1,1) PRIMARY KEY,
    MeetId       INT NOT NULL REFERENCES dbo.Meet(MeetId),  -- FK to platform Meet
    TenantId     INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SwimMeetTypeId INT NOT NULL,  -- 1=Dual/Triangle, 3=Invitational/Championship
    PoolConfigId INT NULL REFERENCES swim.PoolConfig(PoolConfigId)
);

CREATE TABLE swim.HeatSheet (
    HeatSheetId  INT IDENTITY(1,1) PRIMARY KEY,
    TenantId     INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SwimMeetId   INT NOT NULL REFERENCES swim.SwimMeet(SwimMeetId)
);

CREATE TABLE swim.HeatSheetEvent (
    HeatSheetEventId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId         INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    HeatSheetId      INT NOT NULL REFERENCES swim.HeatSheet(HeatSheetId),
    SwimEventId      INT NOT NULL REFERENCES swim.SwimEvent(SwimEventId),
    AgeClassId       INT NOT NULL REFERENCES dbo.AgeClass(AgeClassId),
    Gender           NCHAR(1) NOT NULL CHECK (Gender IN ('M','F','X')),
    Sequence         INT NOT NULL,
    IsScratch        BIT NOT NULL DEFAULT 0
);
```

Success criteria:
* All V010–V012 migrations apply without FK violation errors
* `swim.*` tables visible in Azure SQL

Dependencies:
* Step B.1 (platform tables `dbo.Meet`, `dbo.Tenant`, etc. must exist before swim FK references)

---

### Step D.2: Implement Platform-Level Repositories

Files to create:
* Platform.Infrastructure/Repositories/AthleteRepository.cs
* Platform.Infrastructure/Repositories/LeagueRepository.cs
* Platform.Infrastructure/Repositories/TeamRepository.cs
* Platform.Core/Repositories/IAthleteRepository.cs (interface)
* Platform.Core/Repositories/ILeagueRepository.cs (interface)
* Platform.Core/Repositories/ITeamRepository.cs (interface)

Repository pattern (Dapper):
```csharp
public class AthleteRepository(IDbConnectionFactory connFactory) : IAthleteRepository
{
    public async Task<IEnumerable<Athlete>> GetByTenantAsync()
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<Athlete>(
            "spAthleteGetAll", commandType: CommandType.StoredProcedure);
    }

    public async Task<Athlete?> GetByIdAsync(int id)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QuerySingleOrDefaultAsync<Athlete>(
            "spAthleteGetById",
            new { AthleteId = id },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(Athlete athlete)
    {
        var p = new DynamicParameters(athlete);
        p.Add("@AthleteId", athlete.AthleteId, direction: ParameterDirection.InputOutput);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("spAthleteSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@AthleteId");
    }
}
```

Create corresponding stored procedures in:
* db/migrations/V013__platform_sprocs.sql — `spAthleteGetAll`, `spAthleteGetById`, `spAthleteSave`, `spLeagueGetAll`, `spLeagueGetById`, `spLeagueSave`, `spTeamGetAll`, `spTeamGetById`, `spTeamSave`

Success criteria:
* Repositories inject `IDbConnectionFactory` and dispose connections per operation
* RLS is enforced through the connection factory (no explicit TenantId filter in SELECT statements)

Dependencies:
* Step B.3 (IDbConnectionFactory must exist)
* Step B.1 (dbo.Athlete must exist)

---

### Step D.3: Implement `SwimMeetRepository` + `SwimMeetService` + Controller

Files to create:
* SwimDomain/Repositories/SwimMeetRepository.cs
* SwimDomain/Services/SwimMeetService.cs
* SwimDomain/Controllers/SwimMeetsController.cs
* Platform.Core/Repositories/ISwimMeetRepository.cs
* Platform.Core/Services/ISwimMeetService.cs
* db/migrations/V020__swim_meet_sprocs.sql

API endpoints implemented in this step:
```
GET  /api/swim/meets                    ← list meets for authenticated tenant
GET  /api/swim/meets/{id}               ← single meet detail
POST /api/swim/meets                    ← create meet (any auth'd user)
PUT  /api/swim/meets/{id}               ← update meet (admin only — Phase F)
DELETE /api/swim/meets/{id}             ← delete meet (admin only — Phase F)
```

`SwimMeetsController` route prefix: `[Route("api/swim/meets")]`

Create/Update pattern (output param):
```csharp
public async Task<int> SaveSwimMeetAsync(SwimMeet meet)
{
    var p = new DynamicParameters(meet);
    p.Add("@SwimMeetId", meet.SwimMeetId, direction: ParameterDirection.InputOutput);
    using var conn = await connFactory.OpenAsync();
    await conn.ExecuteAsync("spSwimMeetSave", p, commandType: CommandType.StoredProcedure);
    return p.Get<int>("@SwimMeetId");
}
```

Success criteria:
* `GET /api/swim/meets` returns 200 with JSON array for valid JWT + tenant
* `POST /api/swim/meets` returns 201 with new `SwimMeetId`
* Invalid or missing JWT returns 401

Dependencies:
* Step D.1 (`swim.SwimMeet` table must exist)
* Step B.7 (SwimModule registers this repository and service)
* Step B.8 (AddApplicationPart discovers SwimMeetsController)

---

### Step D.4: Implement `HeatSheetRepository` + `HeatSheetService` + Controller

The heat sheet generation algorithm (from `SwimomaticBusinessManager`) is the most complex swim operation. It assigns swimmers to heats and lanes based on seed times.

Files to create:
* SwimDomain/Repositories/HeatSheetRepository.cs
* SwimDomain/Services/HeatSheetService.cs — contains `GenerateHeatsAsync()` algorithm
* SwimDomain/Controllers/HeatSheetsController.cs
* db/migrations/V021__heat_sheet_sprocs.sql

API endpoints:
```
GET  /api/swim/meets/{id}/heatsheets           ← heat sheet for a meet
POST /api/swim/meets/{id}/heatsheets           ← create heat sheet
POST /api/swim/meets/{id}/heatsheets/{hsId}/generate  ← trigger heat generation
GET  /api/swim/meets/{id}/heatsheets/{hsId}/events    ← heat sheet events
```

Heat generation algorithm — from `SwimomaticBusinessManager`:
* Sorts swimmers by seed time (MostRecent, SeasonBest, or PersonalBest based on seed type)
* Assigns to heats from last heat (fastest) to first (slowest)
* Respects lane count from `PoolConfig`

Success criteria:
* `POST /api/swim/meets/{id}/heatsheets/{hsId}/generate` creates `swim.Heat` + `swim.HeatSwimmer` rows
* Heat count is `CEILING(swimmerCount / laneCount)`

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-modernization-research.md — SwimomaticBusinessManager section — seed time types
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md — heat generation section

Dependencies:
* Step D.1 (`swim.Heat`, `swim.HeatSwimmer` tables must exist)
* Step D.3 (SwimMeetRepository pattern to follow)

---

### Step D.5: Implement `ResultRepository` + `ResultService` + Controller

Files to create:
* SwimDomain/Repositories/ResultRepository.cs
* SwimDomain/Services/ResultService.cs — contains scoring algorithm
* SwimDomain/Controllers/ResultsController.cs
* db/migrations/V022__result_sprocs.sql

API endpoints:
```
GET  /api/swim/meets/{id}/heatsheets/{hsId}/events/{eventId}/results  ← results for event
POST /api/swim/meets/{id}/heatsheets/{hsId}/events/{eventId}/results  ← save results (batch)
GET  /api/swim/meets/{id}/results  ← meet-level results summary
```

Note: `dbo.Result` uses `MeasurementType = 'Time'` for swim; the column is added in Phase H. For Phase D, the swim result stored procedure always sets `MeasurementType = 'Time'` implicitly.

Success criteria:
* POST batch result saves ElapsedTime and calculates Score via stored procedure
* GET meet results returns ordered by Score descending

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-modernization-research.md — ResultController section

Dependencies:
* Step D.4 (HeatSheet entities must exist for FK relationships)

---

### Step D.6: Implement `AthleteRepository` + `AthleteService` + Controller

Files to create:
* AthletePlatformAPI/Controllers/AthletesController.cs — platform-level controller; athletes are shared across all sports (DD-04 decision)
* Platform.Infrastructure/Services/AthleteService.cs
* db/migrations/V014__athlete_sprocs.sql — stored procedures already noted in Step D.2

API endpoints:
```
GET  /api/athletes              ← tenant's athletes
GET  /api/athletes/{id}         ← single athlete
POST /api/athletes              ← create athlete (links to current user via UserAthlete)
PUT  /api/athletes/{id}         ← update athlete
GET  /api/athletes/{id}/sports  ← sports this athlete participates in (AthleteTeamSeason join)
```

Note: `AthletesController` belongs in `AthletePlatformAPI/Controllers/` (platform-level), not `SwimDomain`.

Success criteria:
* `POST /api/athletes` creates `dbo.Athlete` + `dbo.UserAthlete` (IsPrimary = true) in a transaction
* `GET /api/athletes` returns only athletes in the authenticated tenant (RLS enforced)

Dependencies:
* Step B.3 (IDbConnectionFactory)
* Step D.2 (AthleteRepository)

---

### Step D.7: Write Unit Tests for Swim Domain Services

Files to create:
* SwimDomain.Tests/Services/SwimMeetServiceTests.cs
* SwimDomain.Tests/Services/HeatSheetServiceTests.cs
* SwimDomain.Tests/Services/ResultServiceTests.cs

Test cases for `HeatSheetService.GenerateHeatsAsync()`:
* Given 12 swimmers and 6 lanes → expect 2 heats
* Given 7 swimmers and 6 lanes → expect 2 heats (7 → heat 1 with 1 swimmer, heat 2 with 6 swimmers)
* Given 0 swimmers → expect 0 heats
* Swimmers sorted by seed time descending (fastest in last heat)

Test cases for `ResultService.CalculateScoreAsync()`:
* Place 1 with individual points "6,4,3,2" → score 6
* Place 3 with relay → score from relay points string
* DQ result → score 0

Mock pattern:
```csharp
var mockRepo = new Mock<IHeatSheetRepository>();
mockRepo.Setup(r => r.GetHeatSheetEventsAsync(It.IsAny<int>()))
    .ReturnsAsync(testEvents);
var service = new HeatSheetService(mockRepo.Object, mockMeetRepo.Object);
```

Success criteria:
* All service unit tests pass without database connection
* Heat generation algorithm test cases cover edge cases (0, 1, N swimmers)

Dependencies:
* Steps D.3–D.6 (services must exist)

---

### Step D.8: Validate Phase D

Run:
```
dotnet build AthletePlatform.sln
dotnet test SwimDomain.Tests/SwimDomain.Tests.csproj --verbosity normal
```

Fix all build errors and test failures before proceeding to Phase E.

---

## Phase E: Core Swim React Pages

<!-- parallelizable: true -->

### Step E.1: Swim Meet List + Detail Pages

Files to create:
* athlete-platform-spa/src/features/swim/components/meets/MeetList.tsx
* athlete-platform-spa/src/features/swim/components/meets/MeetDetail.tsx
* athlete-platform-spa/src/features/swim/hooks/useSwimMeets.ts
* athlete-platform-spa/src/features/swim/api/swimApi.ts

TanStack Query pattern:
```tsx
// useSwimMeets.ts
export function useSwimMeets(seasonId: number) {
  return useQuery({
    queryKey: ['swim', 'meets', seasonId],
    queryFn: () => swimApi.getMeets(seasonId)
  });
}
```

`MeetList.tsx` renders a shadcn/ui `Table` or `Card` grid. Clicking a row navigates to `/swim/meets/{id}`.

Success criteria:
* Meet list renders with loading/error/empty states
* TanStack Query refetches on window focus by default (acceptable for this use case)

Dependencies:
* Step D.3 (`GET /api/swim/meets` endpoint must exist)
* Step C.2 (apiClient must inject auth header)

---

### Step E.2: Heat Sheet Grid View

Files to create:
* athlete-platform-spa/src/features/swim/components/heatsheets/HeatSheetGrid.tsx
* athlete-platform-spa/src/features/swim/components/heatsheets/HeatSheetEventRow.tsx
* athlete-platform-spa/src/features/swim/hooks/useHeatSheet.ts

Layout: `<table>` (NOT CSS Grid — required for accessible row/column semantics).
Each row = one `HeatSheetEvent`. Columns = lanes (1–N based on PoolConfig).

Success criteria:
* Grid renders heat sheet events with swimmer names in lane columns
* Responsive: horizontally scrollable on mobile

Dependencies:
* Step D.4 (`GET /api/swim/meets/{id}/heatsheets` endpoint)

---

### Step E.3: Result Entry Form

Files to create:
* athlete-platform-spa/src/features/swim/components/results/ResultEntryForm.tsx
* athlete-platform-spa/src/features/swim/hooks/useResultEntry.ts

Result entry: input per swimmer per heat event. On submit, POST batch to `/api/swim/.../results`.

TanStack Query mutation:
```tsx
const mutation = useMutation({
  mutationFn: (results: ResultBatch) => swimApi.saveResults(eventId, results),
  onSuccess: () => queryClient.invalidateQueries({ queryKey: ['swim', 'meets', meetId] })
});
```

Success criteria:
* Successful save shows toast notification (shadcn/ui `Toast`)
* Invalid time format shows Zod validation error inline

Dependencies:
* Step D.5 (Results API endpoint)

---

### Step E.4: Athlete Management Pages

Files to create:
* athlete-platform-spa/src/features/platform/components/athletes/AthleteList.tsx
* athlete-platform-spa/src/features/platform/components/athletes/AthleteForm.tsx
* athlete-platform-spa/src/features/platform/hooks/useAthletes.ts

Success criteria:
* Athlete list renders all athletes for the tenant
* Add/edit form validates with Zod (FirstName, LastName required; BirthDate valid date; Gender M/F/X)

Dependencies:
* Step D.6 (Athletes API endpoint)

---

## Phase F: Admin Authorization + Admin Features API

<!-- parallelizable: false -->

### Step F.1: Implement Admin Authorization Handlers

Per-entity admin checks cannot use JWT roles alone — admin is stored in `UserTeam.IsAdmin`, `UserLeague.IsAdmin`, `UserSwimMeet.IsAdmin`. Custom `IAuthorizationHandler` implementations check the DB.

Key pattern: `context.Resource as HttpContext` (NOT `IHttpContextAccessor` injection — handlers may be scoped but the resource is already available).

Files to create:
* AthletePlatformAPI/Infrastructure/Auth/SwimMeetAdminHandler.cs
* AthletePlatformAPI/Infrastructure/Auth/TeamAdminHandler.cs
* AthletePlatformAPI/Infrastructure/Auth/LeagueAdminHandler.cs
* AthletePlatformAPI/Infrastructure/Auth/AdminRequirement.cs

```csharp
// AdminRequirement.cs
public record AdminRequirement(string ResourceType) : IAuthorizationRequirement;

// SwimMeetAdminHandler.cs
public class SwimMeetAdminHandler(IDbConnectionFactory connFactory)
    : AuthorizationHandler<AdminRequirement>
{
    protected override async Task HandleRequirementAsync(
        AuthorizationHandlerContext ctx, AdminRequirement requirement)
    {
        if (requirement.ResourceType != "SwimMeet") return;
        var httpCtx = ctx.Resource as HttpContext;
        if (httpCtx is null) { ctx.Fail(); return; }

        // Cache per-request in HttpContext.Items to avoid redundant DB calls
        const string cacheKey = "SwimMeetAdmin";
        if (httpCtx.Items.TryGetValue(cacheKey, out var cached))
        {
            if (cached is true) ctx.Succeed(requirement);
            return;
        }

        var swimMeetId = int.Parse(httpCtx.GetRouteValue("id")?.ToString() ?? "0");
        var userId = ctx.User.FindFirstValue(ClaimTypes.NameIdentifier);
        using var conn = await connFactory.OpenAsync();
        var isAdmin = await conn.QuerySingleOrDefaultAsync<bool>(
            "spUserSwimMeetIsAdmin",
            new { SystemUserId = userId, SwimMeetId = swimMeetId },
            commandType: CommandType.StoredProcedure);
        httpCtx.Items[cacheKey] = isAdmin;
        if (isAdmin) ctx.Succeed(requirement);
    }
}
```

Registration (Program.cs):
```csharp
builder.Services.AddScoped<IAuthorizationHandler, SwimMeetAdminHandler>();
builder.Services.AddScoped<IAuthorizationHandler, TeamAdminHandler>();
builder.Services.AddScoped<IAuthorizationHandler, LeagueAdminHandler>();
builder.Services.AddAuthorization(options => {
    options.AddPolicy("SwimMeetAdmin", p => p.AddRequirements(new AdminRequirement("SwimMeet")));
    options.AddPolicy("TeamAdmin", p => p.AddRequirements(new AdminRequirement("Team")));
    options.AddPolicy("LeagueAdmin", p => p.AddRequirements(new AdminRequirement("League")));
});
```

Success criteria:
* `[Authorize(Policy = "SwimMeetAdmin")]` on PUT/DELETE returns 403 for non-admins
* DB is queried at most once per request for admin check (HttpContext.Items cache)

Discrepancy references:
* DD-02 — Admin handlers registered as Scoped (not Singleton), because they make DB calls

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md — Scenario 1 — authorization handler pattern

Dependencies:
* Step D.3 (swim meet repository must exist for admin check stored proc)
* Step B.8 (program.cs pipeline must include UseAuthorization)

---

### Step F.2: Admin Swim Meet Endpoints (PUT/DELETE with Admin Gate)

Files to modify:
* SwimDomain/Controllers/SwimMeetsController.cs — add PUT and DELETE actions

```csharp
[HttpPut("{id}")]
[Authorize(Policy = "SwimMeetAdmin")]
public async Task<IActionResult> UpdateSwimMeet(int id, UpdateSwimMeetRequest req) { ... }

[HttpDelete("{id}")]
[Authorize(Policy = "SwimMeetAdmin")]
public async Task<IActionResult> DeleteSwimMeet(int id) { ... }
```

DELETE guard — if results exist, return `409 Conflict`:
```csharp
if (await swimMeetService.HasResultsAsync(id))
    return Conflict(new ProblemDetails {
        Title = "Cannot delete swim meet with results",
        Detail = "Remove all results before deleting this meet.",
        Status = 409
    });
```

Success criteria:
* PUT returns 200 for swim meet admin, 403 for non-admin
* DELETE returns 409 when results exist; 204 when no results

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md — Swim Meet Admin section

Dependencies:
* Step F.1 (authorization handlers must be registered)
* Step D.3 (SwimMeetsController must exist to add to)

---

### Step F.3: Heat Sheet Event CRUD + Resequencing + Seeding + Lane Management

Files to create/modify:
* SwimDomain/Controllers/HeatSheetsController.cs — add admin endpoints
* SwimDomain/Services/HeatSheetService.cs — add `SeedEventAsync()`, `ResequenceEventsAsync()`, `SwapLanesAsync()`

Admin endpoints to add:
```
POST   /api/swim/meets/{id}/heatsheets/{hsId}/events              ← add event
DELETE /api/swim/meets/{id}/heatsheets/{hsId}/events/{eventId}    ← delete event (409 if results)
PUT    /api/swim/meets/{id}/heatsheets/{hsId}/events/resequence   ← reorder (body: ordered ID list)
POST   /api/swim/meets/{id}/heatsheets/{hsId}/events/{eventId}/seed  ← seed swimmers
POST   /api/swim/meets/{id}/heatsheets/{hsId}/events/{eventId}/heats/{heatId}/lanes  ← swap lanes
```

Seeding transaction (Dapper explicit transaction):
```csharp
public async Task SeedEventAsync(int heatSheetEventId, SeedType seedType)
{
    using var conn = await connFactory.OpenAsync();
    using var tx = await conn.BeginTransactionAsync();
    try
    {
        await conn.ExecuteAsync("spHeatSheetEventClearSwimmers",
            new { HeatSheetEventId = heatSheetEventId }, transaction: tx,
            commandType: CommandType.StoredProcedure);
        await conn.ExecuteAsync("spHeatSheetEventSeed",
            new { HeatSheetEventId = heatSheetEventId, SeedTypeId = (int)seedType },
            transaction: tx, commandType: CommandType.StoredProcedure);
        await tx.CommitAsync();
    }
    catch { await tx.RollbackAsync(); throw; }
}
```

Success criteria:
* DELETE event with existing results returns 409
* Resequence updates `Sequence` column for all events in the heat sheet
* Seeding clears then re-populates `swim.HeatSwimmer` atomically

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md — Heat Sheet Admin section

Dependencies:
* Step F.1 (admin policy must be registered)
* Step D.4 (heat sheet repository must exist)

---

### Step F.4: Scoring Scheme Admin Endpoints

Files to create:
* SwimDomain/Controllers/ScoringController.cs (or add to LeaguesController in Phase G)
* SwimDomain/Services/ScoringService.cs

Season scoring = two ScoringScheme records (Dual and Invitational) + two SeasonScoringScheme records. All four saves must be atomic.

```
POST /api/leagues/{id}/seasons/{seasonId}/scoring  ← save both schemes atomically
GET  /api/leagues/{id}/seasons/{seasonId}/scoring  ← get both schemes
```

Dapper transaction saves all four records:
```csharp
using var conn = await connFactory.OpenAsync();
using var tx = await conn.BeginTransactionAsync();
// Save ScoringScheme dual, ScoringScheme invitational,
// SeasonScoringScheme dual, SeasonScoringScheme invitational
// All in one transaction
await tx.CommitAsync();
```

Success criteria:
* Partial save (one scheme saved, other fails) rolls back completely
* IndividualPoints and RelayPoints stored as comma-delimited strings (per existing Swimomatic format)

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md — Season Scoring Scheme section

Dependencies:
* Step B.1 (`dbo.ScoringScheme`, `dbo.SeasonScoringScheme` tables must exist)
* Step F.1 (admin authorization)

---

### Step F.5: Approval Workflow Admin Endpoints

Files to create:
* AthletePlatformAPI/Controllers/LeagueRequestsController.cs
* AthletePlatformAPI/Controllers/TeamRequestsController.cs
* Platform.Infrastructure/Services/ApprovalService.cs

Endpoints:
```
GET  /api/leagues/{id}/join-requests              ← league admin: view team requests
POST /api/leagues/{id}/join-requests/{rid}/approve ← league admin: approve → creates TeamSeason
GET  /api/teams/{id}/join-requests                ← team admin: view athlete requests
POST /api/teams/{id}/join-requests/{rid}/approve  ← team admin: approve → creates AthleteTeamSeason
```

Approval creates the dependent entity in a transaction:
```csharp
using var tx = await conn.BeginTransactionAsync();
await conn.ExecuteAsync("spTeamLeagueRequestApprove", new { RequestId = rid }, tx, commandType: ...);
await conn.ExecuteAsync("spTeamSeasonCreate", new { ... }, tx, commandType: ...);
await tx.CommitAsync();
```

Success criteria:
* Approving a team league request creates a `dbo.TeamSeason` row
* Approving an athlete team request creates a `dbo.AthleteTeamSeason` row
* Both atomic — no partial creates

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md — Approval Workflows section

Dependencies:
* Step D.2 (team and athlete repositories)
* Step F.1 (admin authorization)

---

### Step F.6: React Admin Pages (Heat Grid with @dnd-kit, Seeding Dialog, Scoring Form)

Files to create:
* athlete-platform-spa/src/features/swim/components/admin/HeatSheetAdminGrid.tsx — drag-to-reorder events
* athlete-platform-spa/src/features/swim/components/admin/SeedConfirmDialog.tsx — AlertDialog confirmation
* athlete-platform-spa/src/features/swim/components/admin/ScoringSchemeForm.tsx — Zod-validated form
* athlete-platform-spa/src/features/platform/components/admin/JoinRequestList.tsx

@dnd-kit pattern for event reordering:
```tsx
// Only call API in onDragEnd, NOT during drag (no debounce needed)
function onDragEnd(event: DragEndEvent) {
  const { active, over } = event;
  if (!over || active.id === over.id) return;
  const newOrder = arrayMove(events, oldIndex, newIndex);
  setEvents(newOrder); // optimistic update
  resequenceMutation.mutate(newOrder.map(e => e.id)); // API call
}
```

Seeding uses `AlertDialog` (not `Dialog`):
```tsx
<AlertDialog>
  <AlertDialogTrigger>Seed Event</AlertDialogTrigger>
  <AlertDialogContent>
    <AlertDialogTitle>Seed {eventName}?</AlertDialogTitle>
    <AlertDialogDescription>This will replace current lane assignments.</AlertDialogDescription>
    <AlertDialogCancel>Cancel</AlertDialogCancel>
    <AlertDialogAction onClick={handleSeed}>Confirm Seed</AlertDialogAction>
  </AlertDialogContent>
</AlertDialog>
```

Success criteria:
* Drag-to-reorder updates event sequence in API on drop
* Seed confirmation requires explicit user confirmation before API call
* Scoring form validates IndividualPoints as comma-separated integers with Zod

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md — React admin pages, @dnd-kit pattern

Dependencies:
* Step E.2 (base heat sheet grid must exist)
* Step F.3 (admin API endpoints for heat grid)

---

### Step F.7: Unit Tests for Admin Authorization Handlers

Files to create:
* SwimDomain.Tests/Auth/SwimMeetAdminHandlerTests.cs
* SwimDomain.Tests/Auth/TeamAdminHandlerTests.cs

Test cases:
* User who is admin → `HandleRequirementAsync` calls `ctx.Succeed(requirement)`
* User who is NOT admin → requirement not succeeded
* HttpContext.Items cache hit → DB not queried a second time on same request
* Route value `id` missing → handler fails gracefully

Success criteria:
* DB mock called exactly once per request (cache tested by calling handler twice)

Dependencies:
* Step F.1 (handlers must exist)

---

## Phase G: Organization Features

<!-- parallelizable: false -->

### Step G.1: League/Season API + Unit Tests

Files to create:
* AthletePlatformAPI/Controllers/LeaguesController.cs
* Platform.Infrastructure/Services/LeagueService.cs
* db/migrations/V030__league_sprocs.sql — `spLeagueGetAll`, `spLeagueSave`, `spSeasonGetAll`, `spSeasonSave`

Endpoints:
```
GET  /api/leagues
GET  /api/leagues/{id}
POST /api/leagues                ← creates league + UserLeague(IsAdmin=true) for current user
PUT  /api/leagues/{id}           ← league admin only
GET  /api/leagues/{id}/seasons
GET  /api/seasons/{id}
POST /api/leagues/{id}/seasons   ← league admin only
PUT  /api/seasons/{id}           ← league admin only
```

Unit tests: `LeagueServiceTests.cs` — mock repository, test that CreateLeague also creates UserLeague.

Success criteria:
* `POST /api/leagues` creates league AND UserLeague with IsAdmin=true atomically

Dependencies:
* Step D.2 (platform repository pattern to follow)

---

### Step G.2: Team API + Unit Tests

Files to create:
* AthletePlatformAPI/Controllers/TeamsController.cs
* Platform.Infrastructure/Services/TeamService.cs
* db/migrations/V031__team_sprocs.sql

Endpoints:
```
GET  /api/teams/search?regionId={id}&city={city}
GET  /api/teams/{id}
POST /api/teams                   ← creates team + UserTeam(IsAdmin=true) for current user
PUT  /api/teams/{id}              ← team admin only
GET  /api/teams/{id}/seasons      ← team seasons
```

Success criteria:
* Team search endpoint supports filtering by region and city (optional params)
* POST creates team AND UserTeam atomically

Dependencies:
* Step G.1 (league must exist before team seasons reference it)

---

### Step G.3: Athlete Join Request Workflow + Unit Tests

Files to create:
* db/migrations/V032__join_request_sprocs.sql — `spSwimmerTeamRequestSave`, `spSwimmerTeamRequestApprove`

Endpoints:
```
POST /api/athletes/{id}/join-requests   ← athlete requests to join a team season
GET  /api/teams/{id}/join-requests      ← team admin: view pending requests
POST /api/teams/{id}/join-requests/{rid}/approve  ← team admin: approve
POST /api/teams/{id}/join-requests/{rid}/reject   ← team admin: reject
```

Unit tests: `ApprovalServiceTests.cs` — mock repo, verify approval creates AthleteTeamSeason.

Dependencies:
* Step G.2 (team must exist)
* Step F.5 (ApprovalService already has TeamLeagueRequest — extend for athlete requests)

---

### Step G.4: Location/Pool/PoolConfig API + Unit Tests

Files to create:
* AthletePlatformAPI/Controllers/LocationsController.cs
* db/migrations/V033__location_sprocs.sql

Endpoints:
```
GET  /api/locations
GET  /api/locations/{id}
POST /api/locations              ← any auth'd user (creator-owned)
PUT  /api/locations/{id}         ← creator or admin only
GET  /api/locations/{id}/pools
POST /api/locations/{id}/pools
POST /api/pools/{id}/configs
```

Creator ownership check: `CreatedBySystemUserId = currentUserId` (no policy handler needed — simpler check in service).

Success criteria:
* POST location records `CreatedBySystemUserId` from JWT sub claim

Dependencies:
* Step D.2 (base repository pattern)

---

### Step G.5: React Organization Pages

Files to create:
* athlete-platform-spa/src/features/platform/components/leagues/LeagueList.tsx
* athlete-platform-spa/src/features/platform/components/leagues/SeasonDetail.tsx
* athlete-platform-spa/src/features/platform/components/teams/TeamDetail.tsx
* athlete-platform-spa/src/features/platform/components/teams/JoinRequestList.tsx
* athlete-platform-spa/src/features/platform/components/locations/LocationList.tsx

Success criteria:
* League list loads with TanStack Query key `['platform', 'leagues']`
* Join request approval mutates and invalidates `['platform', 'team', id, 'join-requests']`

Dependencies:
* Steps G.1–G.4 (all API endpoints must exist)

---

## Phase H: Track & Field Scaffolding

<!-- parallelizable: true -->
<!-- Can run in parallel with Phase G; touches different files -->

### Step H.1: Create `TrackField.Domain` Class Library + `TrackFieldModule` Stub

Files to create/modify:
* TrackField.Domain/TrackFieldModule.cs — already stubbed in Phase B.7; ensure `RegisterServices` is a no-op
* TrackField.Domain/Controllers/ — empty directory; placeholder `TFMeetsController.cs` with stub GET action returning `NotImplemented()`

```csharp
// TFMeetsController.cs
[ApiController]
[Route("api/tf/meets")]
public class TFMeetsController : ControllerBase
{
    [HttpGet]
    public IActionResult GetMeets() => StatusCode(501, "Track & Field coming soon");
}
```

Success criteria:
* `GET /api/tf/meets` returns 501 (Not Implemented), proving the controller is discoverable
* Solution builds without error with TrackField.Domain included

Dependencies:
* Step A.1 (TrackField.Domain project must exist)
* Step B.7 (ISportModule must exist for TrackFieldModule to implement)

---

### Step H.2: Create `tf.*` Schema Stub Migrations

Files to create:
* db/migrations/V040__tf_schema_stubs.sql

```sql
CREATE TABLE tf.TFMeet (
    TFMeetId   INT IDENTITY(1,1) PRIMARY KEY,
    MeetId     INT NOT NULL REFERENCES dbo.Meet(MeetId),
    TenantId   INT NOT NULL REFERENCES dbo.Tenant(TenantId)
    -- T&F-specific columns TBD when T&F is implemented
);

CREATE TABLE tf.TFEvent (
    TFEventId   INT IDENTITY(1,1) PRIMARY KEY,
    TenantId    INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    Name        NVARCHAR(100) NOT NULL,
    EventType   NVARCHAR(20) NOT NULL CHECK (EventType IN ('Track','Field','Road','Combined'))
    -- Seed table with common T&F events
);

CREATE TABLE tf.TFResult (
    TFResultId      INT IDENTITY(1,1) PRIMARY KEY,
    TenantId        INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    AthleteId       INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    TFMeetId        INT NOT NULL REFERENCES tf.TFMeet(TFMeetId),
    TFEventId       INT NOT NULL REFERENCES tf.TFEvent(TFEventId),
    MeasurementType NVARCHAR(20) NOT NULL CHECK (MeasurementType IN ('Time','Distance','Height','Points')),
    ElapsedTime     FLOAT NULL,      -- for Track events
    MeasurementValue FLOAT NULL,     -- for Field events (meters)
    LaneNumber      INT NULL,        -- NULL for distance/field events
    IsDisqualified  BIT NOT NULL DEFAULT 0
);
```

Success criteria:
* V040 migration applies without error
* `tf.TFResult` has `MeasurementType` discriminator from the start

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md — T&F Domain section

Dependencies:
* Step B.1 (`dbo.Meet`, `dbo.Athlete` tables must exist for FKs)

---

### Step H.3: Generalize `dbo.Result` — Add `MeasurementType` + `MeasurementValue`

This is the critical prerequisite for T&F. The migration adds columns with defaults so existing swim data is unaffected.

Files to create:
* db/migrations/V041__result_generalization.sql

```sql
-- V041__result_generalization.sql
-- Add MeasurementType with default 'Time' — all existing rows become 'Time' automatically
ALTER TABLE dbo.Result ADD MeasurementType NVARCHAR(20) NOT NULL
    CONSTRAINT DF_Result_MeasurementType DEFAULT 'Time';

ALTER TABLE dbo.Result ADD MeasurementValue FLOAT NULL;

ALTER TABLE dbo.Result ADD CONSTRAINT CK_Result_MeasurementType
    CHECK (MeasurementType IN ('Time','Distance','Height','Points'));

-- Update swim result stored procedures to explicitly pass MeasurementType = 'Time'
-- (handled in spSwimResultSave — no data migration needed)
```

Success criteria:
* Migration applies to production database with 0 rows updated (additive only)
* Swim result stored procedures still work after the migration
* `MeasurementType` column present and constrained to valid values

Discrepancy references:
* DR-01 — research noted this is a critical prerequisite; implemented here in H.3 rather than deferred

Context references:
* .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md — Result Generalization section

Dependencies:
* Step D.5 (swim result table and stored procedures must exist before this migration alters the table)

---

### Step H.4: React TF Route Placeholder + Update App.tsx

Files to modify:
* athlete-platform-spa/src/features/tf/TFRoutes.tsx — add placeholder with "Coming Soon" message
* athlete-platform-spa/src/App.tsx — already references TFRoutes from Step C.4

```tsx
// TFRoutes.tsx
export default function TFRoutes() {
  return (
    <div>
      <h1>Track &amp; Field</h1>
      <p>Track &amp; Field features are coming soon.</p>
    </div>
  );
}
```

Success criteria:
* Navigating to `/tf` shows the placeholder page
* NavBar "Track & Field" link only appears when tenant has `tf` in `enabledSports`

Dependencies:
* Step C.4 (App.tsx lazy loading must exist)

---

### Step H.5: Register `TrackFieldModule` in `Program.cs`

Files to modify:
* AthletePlatformAPI/Program.cs — uncomment/add `new TrackFieldModule()` to modules list

```csharp
var modules = new List<ISportModule>
{
    new SwimModule(),
    new TrackFieldModule()  // stub — 501 responses until T&F is implemented
};
```

Success criteria:
* `GET /api/tf/meets` returns 501 (not 404)
* `GET /api/swim/meets` still returns correct data (no regression)

Dependencies:
* Step H.1 (TFMeetsController stub must exist)
* Step B.8 (Program.cs structure)

---

## Phase I: Final Validation

<!-- parallelizable: false -->

### Step I.1–I.5: Run Full Project Validation

```powershell
# .NET
dotnet build AthletePlatform.sln -c Release
dotnet test AthletePlatform.sln -c Release --verbosity normal

# React
cd athlete-platform-spa
npm ci
npm run type-check
npm run lint
npm run build

# Bicep
az bicep build --file infra/main.bicep
```

### Step I.6: Fix Minor Issues

Apply straightforward fixes for lint errors, build warnings, and type errors. Apply `// eslint-disable` only with explanation comment when a false positive is confirmed.

### Step I.7: Report Blocking Issues

Document any issues requiring additional research. Do not attempt large-scale refactoring in this phase. Provide next steps with recommended planning approach.

---

## Dependencies

* .NET 9 SDK
* Node.js 20 LTS
* Azure CLI + Bicep extension
* Auth0 free tier account
* Azure subscription (Contributor on resource group)
* xUnit 2.x, Moq 4.x, FluentAssertions

## Success Criteria

* `dotnet build AthletePlatform.sln` exits 0
* All unit tests pass (`dotnet test`)
* React TypeScript type-check exits 0
* Bicep compiles without error
* Deployed API responds to `GET /api/swim/meets` with tenant-scoped data
* Grafana Cloud shows TenantKey custom dimension on Application Insights data
