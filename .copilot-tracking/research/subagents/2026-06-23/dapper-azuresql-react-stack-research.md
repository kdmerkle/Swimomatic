# Research: Dapper + Azure SQL + React Stack

**Date:** 2026-06-23  
**Status:** Complete  
**Topics:** Dapper .NET 9, Vite/React/TypeScript, Azure Static Web Apps + App Service, Azure SQL Migration

---

## Research Questions

1. Dapper best practices in .NET 9 ASP.NET Core WebAPI
2. Vite + React + TypeScript project structure for data-heavy apps
3. Azure Static Web Apps + Azure App Service deployment pattern
4. Azure SQL migration from SQL Server

---

## Topic 1: Dapper Best Practices in .NET 9 ASP.NET Core WebAPI

### Sources
- https://github.com/DapperLib/Dapper (README, live 2025)
- https://www.learndapper.com/
- Current Dapper version: 2.1.79 (May 2025)

### Data Access Layer Structure

**Recommended: IDbConnectionFactory + Repository Pattern**

Rather than injecting `SqlConnection` directly or creating a custom `DapperContext` class, the 2025 best practice is an `IDbConnectionFactory` interface injected into repositories.

```csharp
// Interface
public interface IDbConnectionFactory
{
    IDbConnection CreateConnection();
}

// Implementation
public class SqlConnectionFactory : IDbConnectionFactory
{
    private readonly string _connectionString;

    public SqlConnectionFactory(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
    }

    public IDbConnection CreateConnection() => new SqlConnection(_connectionString);
}

// Registration in Program.cs
builder.Services.AddSingleton<IDbConnectionFactory, SqlConnectionFactory>();
```

**Repository pattern example:**

```csharp
public interface ISwimmerRepository
{
    Task<IEnumerable<Swimmer>> GetByTeamAsync(int teamId);
    Task<Swimmer?> GetByIdAsync(int swimmerId);
    Task<int> CreateAsync(Swimmer swimmer);
}

public class SwimmerRepository : ISwimmerRepository
{
    private readonly IDbConnectionFactory _connectionFactory;

    public SwimmerRepository(IDbConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<IEnumerable<Swimmer>> GetByTeamAsync(int teamId)
    {
        using var conn = _connectionFactory.CreateConnection();
        return await conn.QueryAsync<Swimmer>(
            "spGetSwimmersByTeam",
            new { TeamId = teamId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Swimmer?> GetByIdAsync(int swimmerId)
    {
        using var conn = _connectionFactory.CreateConnection();
        return await conn.QuerySingleOrDefaultAsync<Swimmer>(
            "spGetSwimmerById",
            new { SwimmerId = swimmerId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<int> CreateAsync(Swimmer swimmer)
    {
        using var conn = _connectionFactory.CreateConnection();
        return await conn.ExecuteScalarAsync<int>(
            "spCreateSwimmer",
            new { swimmer.FirstName, swimmer.LastName, swimmer.TeamId },
            commandType: CommandType.StoredProcedure);
    }
}
```

### IDbConnection: Scoped vs Transient vs Singleton

**Best practice (2025):** Register `IDbConnectionFactory` as **Singleton** (it's just a factory). Open connections **per-operation** inside `using` blocks. Do NOT register `SqlConnection` or `IDbConnection` as Scoped/Transient — this leads to connection lifetime confusion with connection pooling.

```csharp
// DO THIS (open per operation):
public async Task<IEnumerable<T>> QueryAsync<T>()
{
    using var conn = _connectionFactory.CreateConnection(); // opens fresh conn
    return await conn.QueryAsync<T>(...);
}

// AVOID (injecting IDbConnection):
// builder.Services.AddScoped<IDbConnection, SqlConnection>(); // problematic
```

ADO.NET connection pooling handles the actual pool — opening/closing `SqlConnection` is cheap.

### Stored Procedure Calls

**Basic query returning a list:**

```csharp
var swimmers = await conn.QueryAsync<Swimmer>(
    "spGetSwimmersByTeam",
    new { TeamId = 5 },
    commandType: CommandType.StoredProcedure);
```

**Single row (nullable return):**

```csharp
var swimmer = await conn.QuerySingleOrDefaultAsync<Swimmer>(
    "spGetSwimmerById",
    new { SwimmerId = swimmerId },
    commandType: CommandType.StoredProcedure);
```

**Execute (insert/update/delete):**

```csharp
int rowsAffected = await conn.ExecuteAsync(
    "spUpdateSwimmer",
    new { swimmer.SwimmerId, swimmer.FirstName, swimmer.LastName },
    commandType: CommandType.StoredProcedure);
```

### Output Parameters from Stored Procedures

Use `DynamicParameters` with `ParameterDirection.Output`:

```csharp
var p = new DynamicParameters();
p.Add("@FirstName", swimmer.FirstName);
p.Add("@LastName", swimmer.LastName);
p.Add("@NewSwimmerId", dbType: DbType.Int32, direction: ParameterDirection.Output);
p.Add("@ErrorMessage", dbType: DbType.String, size: 255, direction: ParameterDirection.Output);

await conn.ExecuteAsync("spCreateSwimmer", p, commandType: CommandType.StoredProcedure);

int newId = p.Get<int>("@NewSwimmerId");
string? errorMsg = p.Get<string?>("@ErrorMessage");
```

For stored procedure `RETURN` values:

```csharp
p.Add("@ReturnValue", dbType: DbType.Int32, direction: ParameterDirection.ReturnValue);
await conn.ExecuteAsync("spMyProc", p, commandType: CommandType.StoredProcedure);
int returnCode = p.Get<int>("@ReturnValue");
```

### Transaction Management

Transactions are handled at the `IDbConnection` level. Open connection, begin transaction, pass transaction to Dapper calls:

```csharp
public async Task<bool> SaveHeatSheetAsync(HeatSheet heatSheet, IEnumerable<HeatSwimmer> swimmers)
{
    using var conn = _connectionFactory.CreateConnection();
    conn.Open();
    using var transaction = conn.BeginTransaction();
    try
    {
        var heatSheetId = await conn.ExecuteScalarAsync<int>(
            "spCreateHeatSheet",
            new { heatSheet.SwimMeetId, heatSheet.Name },
            transaction: transaction,
            commandType: CommandType.StoredProcedure);

        foreach (var swimmer in swimmers)
        {
            await conn.ExecuteAsync(
                "spAddHeatSwimmer",
                new { HeatSheetId = heatSheetId, swimmer.SwimmerId, swimmer.LaneNumber },
                transaction: transaction,
                commandType: CommandType.StoredProcedure);
        }

        transaction.Commit();
        return true;
    }
    catch
    {
        transaction.Rollback();
        throw;
    }
}
```

### Async Patterns

All Dapper methods have async variants. **Always use async in ASP.NET Core:**

| Sync | Async |
|------|-------|
| `Query<T>()` | `QueryAsync<T>()` |
| `QuerySingle<T>()` | `QuerySingleAsync<T>()` |
| `QuerySingleOrDefault<T>()` | `QuerySingleOrDefaultAsync<T>()` |
| `QueryFirst<T>()` | `QueryFirstAsync<T>()` |
| `QueryFirstOrDefault<T>()` | `QueryFirstOrDefaultAsync<T>()` |
| `Execute()` | `ExecuteAsync()` |
| `ExecuteScalar<T>()` | `ExecuteScalarAsync<T>()` |

### Multi-Mapping (Joined Results)

Dapper can map a single SQL row to multiple objects. Use for JOIN queries:

```csharp
var sql = @"
    SELECT s.SwimmerId, s.FirstName, s.LastName,
           t.TeamId, t.TeamName, t.ShortName
    FROM Swimmer s
    INNER JOIN Team t ON s.TeamId = t.TeamId
    WHERE s.SwimmerId = @SwimmerId";

var swimmer = (await conn.QueryAsync<Swimmer, Team, Swimmer>(
    sql,
    (swimmer, team) =>
    {
        swimmer.Team = team;
        return swimmer;
    },
    new { SwimmerId = id },
    splitOn: "TeamId"))  // column name where second object begins
    .FirstOrDefault();
```

**Multiple result sets (QueryMultiple):**

```csharp
var sql = @"
    SELECT * FROM SwimMeet WHERE SwimMeetId = @id;
    SELECT * FROM SwimMeetEvent WHERE SwimMeetId = @id;
    SELECT * FROM SwimMeetTeam WHERE SwimMeetId = @id;";

using var multi = await conn.QueryMultipleAsync(sql, new { id = meetId });
var meet = await multi.ReadFirstOrDefaultAsync<SwimMeet>();
var events = (await multi.ReadAsync<SwimMeetEvent>()).ToList();
var teams = (await multi.ReadAsync<SwimMeetTeam>()).ToList();
```

### Connection String Management with Azure SQL

**appsettings.json (development only — never commit secrets):**

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=your-server.database.windows.net;Database=YourDb;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }
}
```

**For local dev with Managed Identity (passwordless, recommended):**

```csharp
// In SqlConnectionFactory, use Azure.Identity for Managed Identity
using Azure.Identity;
using Microsoft.Data.SqlClient;

public IDbConnection CreateConnection()
{
    var conn = new SqlConnection(_connectionString);
    // For Managed Identity auth (no password in connection string):
    conn.AccessToken = new DefaultAzureCredential()
        .GetToken(new TokenRequestContext(
            new[] { "https://database.windows.net/.default" }))
        .Token;
    return conn;
}
```

Connection string for Managed Identity (no password):

```
Server=your-server.database.windows.net;Database=YourDb;Encrypt=True;Authentication=Active Directory Default;
```

**Production: Use Key Vault or App Service Connection Strings** (see Topic 3).

### DI Registration Summary (Program.cs)

```csharp
builder.Services.AddSingleton<IDbConnectionFactory, SqlConnectionFactory>();
builder.Services.AddScoped<ISwimmerRepository, SwimmerRepository>();
builder.Services.AddScoped<ITeamRepository, TeamRepository>();
builder.Services.AddScoped<ISwimMeetRepository, SwimMeetRepository>();
```

---

## Topic 2: Vite + React + TypeScript Project Structure

### Sources
- https://ui.shadcn.com/docs/installation/vite
- https://tanstack.com/query/latest/docs/framework/react/overview
- https://vite.dev/guide/

### Project Scaffolding (2025)

```bash
# Create Vite + React + TypeScript project
pnpm create vite@latest my-swim-app -- --template react-ts
cd my-swim-app

# Install core dependencies
pnpm add @tanstack/react-query @tanstack/react-query-devtools
pnpm add react-router-dom
pnpm add react-hook-form @hookform/resolvers zod
pnpm add tailwindcss @tailwindcss/vite
pnpm add -D @types/node

# Install shadcn/ui
pnpm dlx shadcn@latest init -t vite
```

### Recommended Folder Structure (Medium-Large Admin SPA)

```
src/
├── api/                    # API client layer
│   ├── client.ts           # Base fetch wrapper with error handling
│   ├── swimmers.ts         # Swimmer-domain API functions
│   ├── teams.ts            # Team-domain API functions
│   ├── meets.ts            # Swim meet API functions
│   └── types.ts            # Shared API response/request types
├── components/
│   ├── ui/                 # shadcn/ui generated components (DO NOT EDIT)
│   ├── layout/             # App shell: Sidebar, Navbar, PageWrapper
│   └── shared/             # Reusable app components: DataTable, LoadingSpinner
├── features/               # Feature-sliced: each major area in one folder
│   ├── swimmers/
│   │   ├── components/     # SwimmerTable, SwimmerForm, SwimmerCard
│   │   ├── hooks/          # useSwimmers, useSwimmer, useCreateSwimmer
│   │   ├── pages/          # SwimmersPage, SwimmerDetailPage
│   │   └── types.ts
│   ├── teams/
│   ├── meets/
│   ├── heatsheets/
│   └── results/
├── hooks/                  # Global hooks: useAuth, useToast
├── lib/
│   ├── query-client.ts     # TanStack Query client configuration
│   ├── utils.ts            # cn() and other utilities
│   └── env.ts              # Environment variable validation
├── pages/                  # Top-level route pages (thin wrappers)
│   ├── DashboardPage.tsx
│   └── NotFoundPage.tsx
├── router/
│   └── index.tsx           # React Router route definitions
├── types/                  # Global TS types
│   └── index.ts
├── App.tsx
└── main.tsx
```

### TanStack Query v5 (React Query)

**QueryClient configuration (`src/lib/query-client.ts`):**

```typescript
import { QueryClient } from '@tanstack/react-query';

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 1000 * 60 * 5,        // 5 min: data stays fresh
      gcTime: 1000 * 60 * 10,          // 10 min: keep in cache after unmount
      retry: 2,
      refetchOnWindowFocus: false,      // disable for admin apps
    },
  },
});
```

**App.tsx setup:**

```tsx
import { QueryClientProvider } from '@tanstack/react-query';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { queryClient } from '@/lib/query-client';
import { RouterProvider } from 'react-router-dom';
import { router } from '@/router';

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <RouterProvider router={router} />
      <ReactQueryDevtools initialIsOpen={false} />
    </QueryClientProvider>
  );
}
```

**useQuery pattern (read):**

```typescript
// src/features/swimmers/hooks/useSwimmers.ts
import { useQuery } from '@tanstack/react-query';
import { getSwimmersByTeam } from '@/api/swimmers';

export function useSwimmersByTeam(teamId: number) {
  return useQuery({
    queryKey: ['swimmers', 'byTeam', teamId],
    queryFn: () => getSwimmersByTeam(teamId),
    enabled: teamId > 0,     // only run if teamId is valid
  });
}
```

**useMutation pattern (write) with invalidation:**

```typescript
// src/features/swimmers/hooks/useCreateSwimmer.ts
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { createSwimmer } from '@/api/swimmers';
import type { CreateSwimmerRequest } from '@/api/types';

export function useCreateSwimmer(teamId: number) {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (data: CreateSwimmerRequest) => createSwimmer(data),
    onSuccess: () => {
      // Invalidate all swimmer queries for this team
      queryClient.invalidateQueries({ queryKey: ['swimmers', 'byTeam', teamId] });
      // Also invalidate broader swimmer list if it exists
      queryClient.invalidateQueries({ queryKey: ['swimmers'] });
    },
  });
}
```

**Usage in component:**

```tsx
function SwimmerForm({ teamId }: { teamId: number }) {
  const createSwimmer = useCreateSwimmer(teamId);

  const onSubmit = async (data: CreateSwimmerRequest) => {
    try {
      await createSwimmer.mutateAsync(data);
      toast.success('Swimmer created');
    } catch {
      toast.error('Failed to create swimmer');
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      {/* ... */}
      <Button disabled={createSwimmer.isPending}>
        {createSwimmer.isPending ? 'Saving...' : 'Save'}
      </Button>
    </form>
  );
}
```

### React Router v7

```typescript
// src/router/index.tsx
import { createBrowserRouter } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';

export const router = createBrowserRouter([
  {
    path: '/',
    element: <AppLayout />,
    children: [
      { index: true, element: <DashboardPage /> },
      { path: 'swimmers', element: <SwimmersPage /> },
      { path: 'swimmers/:id', element: <SwimmerDetailPage /> },
      { path: 'teams', element: <TeamsPage /> },
      { path: 'meets', element: <SwimMeetsPage /> },
      { path: 'meets/:id/heatsheet', element: <HeatSheetPage /> },
    ],
  },
  { path: '*', element: <NotFoundPage /> },
]);
```

### React Hook Form + Zod

```typescript
// src/features/swimmers/components/SwimmerForm.tsx
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const swimmerSchema = z.object({
  firstName: z.string().min(1, 'First name is required').max(50),
  lastName: z.string().min(1, 'Last name is required').max(50),
  dateOfBirth: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Invalid date format'),
  teamId: z.number().int().positive('Team is required'),
});

type SwimmerFormValues = z.infer<typeof swimmerSchema>;

export function SwimmerForm({ onSubmit }: { onSubmit: (data: SwimmerFormValues) => void }) {
  const form = useForm<SwimmerFormValues>({
    resolver: zodResolver(swimmerSchema),
    defaultValues: { firstName: '', lastName: '', dateOfBirth: '', teamId: 0 },
  });

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        <FormField
          control={form.control}
          name="firstName"
          render={({ field }) => (
            <FormItem>
              <FormLabel>First Name</FormLabel>
              <FormControl>
                <Input {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        {/* more fields... */}
        <Button type="submit">Save Swimmer</Button>
      </form>
    </Form>
  );
}
```

### shadcn/ui Setup in Vite

**Step 1: tsconfig.json path aliases (required):**

```json
// tsconfig.json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": { "@/*": ["./src/*"] }
  }
}
```

```json
// tsconfig.app.json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": { "@/*": ["./src/*"] }
  }
}
```

**Step 2: vite.config.ts:**

```typescript
import path from 'path';
import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import { defineConfig } from 'vite';

export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: { '@': path.resolve(__dirname, './src') },
  },
});
```

**Step 3: Initialize shadcn/ui:**

```bash
pnpm dlx shadcn@latest init
```

**Step 4: Add key components for admin apps:**

```bash
pnpm dlx shadcn@latest add table dialog form select button input badge card
pnpm dlx shadcn@latest add dropdown-menu sheet toast
```

**Key components for data-heavy admin apps:**

| Component | Use case |
|-----------|----------|
| `DataTable` | Paginated, sortable swimmer/results tables |
| `Dialog` | Confirm delete, quick-edit modals |
| `Form` (+ RHF) | Create/edit forms with validation |
| `Select` | Age class, team, stroke selectors |
| `DatePicker` | Meet date, DOB fields |
| `Badge` | Status indicators, role labels |
| `Sheet` | Side panels for detail views |

### API Client Layer

```typescript
// src/api/client.ts
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

class ApiError extends Error {
  constructor(public status: number, message: string) {
    super(message);
  }
}

async function request<T>(path: string, options?: RequestInit): Promise<T> {
  const response = await fetch(`${API_BASE_URL}${path}`, {
    headers: {
      'Content-Type': 'application/json',
      // Authorization header injected here for auth token
    },
    ...options,
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new ApiError(response.status, errorText || `HTTP ${response.status}`);
  }

  return response.json() as Promise<T>;
}

export const apiClient = {
  get: <T>(path: string) => request<T>(path),
  post: <T>(path: string, body: unknown) =>
    request<T>(path, { method: 'POST', body: JSON.stringify(body) }),
  put: <T>(path: string, body: unknown) =>
    request<T>(path, { method: 'PUT', body: JSON.stringify(body) }),
  delete: <T>(path: string) => request<T>(path, { method: 'DELETE' }),
};
```

```typescript
// src/api/swimmers.ts
import { apiClient } from './client';
import type { Swimmer, CreateSwimmerRequest } from './types';

export const getSwimmersByTeam = (teamId: number) =>
  apiClient.get<Swimmer[]>(`/api/swimmers?teamId=${teamId}`);

export const getSwimmerById = (id: number) =>
  apiClient.get<Swimmer>(`/api/swimmers/${id}`);

export const createSwimmer = (data: CreateSwimmerRequest) =>
  apiClient.post<Swimmer>('/api/swimmers', data);

export const updateSwimmer = (id: number, data: Partial<CreateSwimmerRequest>) =>
  apiClient.put<Swimmer>(`/api/swimmers/${id}`, data);

export const deleteSwimmer = (id: number) =>
  apiClient.delete<void>(`/api/swimmers/${id}`);
```

### Environment Variables in Vite

Vite only exposes variables prefixed with `VITE_` to the client bundle:

```
# .env.development
VITE_API_BASE_URL=http://localhost:7071

# .env.production
VITE_API_BASE_URL=https://your-api.azurewebsites.net
```

```typescript
// src/lib/env.ts — validate at startup
const env = {
  API_BASE_URL: import.meta.env.VITE_API_BASE_URL as string,
};

if (!env.API_BASE_URL) {
  throw new Error('VITE_API_BASE_URL is not set');
}

export default env;
```

---

## Topic 3: Azure Static Web Apps + Azure App Service Deployment Pattern

### Sources
- https://learn.microsoft.com/en-us/azure/static-web-apps/overview
- https://learn.microsoft.com/en-us/azure/static-web-apps/configuration
- https://learn.microsoft.com/en-us/azure/static-web-apps/apis-overview
- https://learn.microsoft.com/en-us/azure/app-service/overview-managed-identity
- https://learn.microsoft.com/en-us/azure/key-vault/general/tutorial-net-create-vault-azure-web-app
- https://learn.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core

### Recommended Architecture

```
┌──────────────────────────────────┐
│   Azure Static Web Apps          │
│   (React SPA - Free/Standard)    │
│   *.azurestaticapps.net          │
└──────────────┬───────────────────┘
               │ HTTPS (CORS or proxy)
               ▼
┌──────────────────────────────────┐
│   Azure App Service              │
│   (.NET 9 WebAPI - B1)           │
│   *.azurewebsites.net            │
└──────────────┬───────────────────┘
               │ Managed Identity (no password)
               ▼
┌──────────────────────────────────┐
│   Azure SQL Database             │
│   (Standard S0 or Basic)         │
└──────────────────────────────────┘
               ▲
               │ Key Vault References
┌──────────────────────────────────┐
│   Azure Key Vault                │
│   (secrets for connection str)   │
└──────────────────────────────────┘
```

### CORS Configuration Between Static Web Apps and App Service

Since React SPA and .NET API are on **different origins**, CORS must be configured on the API.

**In .NET 9 Program.cs:**

```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("SwaPolicy", policy =>
    {
        policy.WithOrigins(
                "https://your-app.azurestaticapps.net",
                "http://localhost:5173")   // local Vite dev
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials();         // if using cookies/auth
    });
});

// ...
app.UseCors("SwaPolicy");
```

**Important:** Static Web Apps has a "seamless routing" feature when using **managed Azure Functions** as the API (routes under `/api/` are proxied without CORS). However, if using **App Service as backend** (Bring Your Own API), you must configure CORS explicitly as shown above.

### Azure Static Web Apps API Proxy Option

When using Azure Static Web Apps Standard plan with a "Bring Your Own" App Service backend, you can link the backend to eliminate CORS:

```json
// staticwebapp.config.json
{
  "navigationFallback": {
    "rewrite": "/index.html",
    "exclude": ["/api/*", "/images/*.{png,jpg,gif}", "/css/*"]
  },
  "globalHeaders": {
    "X-Content-Type-Options": "nosniff",
    "X-Frame-Options": "SAMEORIGIN",
    "Content-Security-Policy": "default-src https: 'unsafe-eval' 'unsafe-inline'; object-src 'none'"
  }
}
```

When the SWA Standard plan proxies `/api/*` to App Service, **no CORS config is needed** on the API because requests appear same-origin.

### Authentication: Auth0 vs Static Web Apps Built-in Auth

**Azure Static Web Apps built-in auth** supports:
- Microsoft Entra ID
- GitHub
- Twitter/X

**Auth0 is NOT natively supported** by Static Web Apps built-in auth. Use one of these approaches:

**Option A: Auth0 JavaScript SDK directly (recommended for Auth0)**

```typescript
// src/main.tsx
import { Auth0Provider } from '@auth0/auth0-react';

<Auth0Provider
  domain={import.meta.env.VITE_AUTH0_DOMAIN}
  clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
  authorizationParams={{
    redirect_uri: window.location.origin,
    audience: import.meta.env.VITE_AUTH0_AUDIENCE,
  }}
>
  <App />
</Auth0Provider>
```

In the API client, inject the Auth0 token:

```typescript
import { useAuth0 } from '@auth0/auth0-react';

// In your API client or hook:
const { getAccessTokenSilently } = useAuth0();
const token = await getAccessTokenSilently();

// Use token in fetch calls
headers: { Authorization: `Bearer ${token}` }
```

**On the .NET API side:** Validate the Auth0 JWT:

```csharp
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = $"https://{builder.Configuration["Auth0:Domain"]}/";
        options.Audience = builder.Configuration["Auth0:Audience"];
    });
```

### Azure SQL Connection from App Service (Managed Identity)

**Preferred:** System-assigned Managed Identity — no secrets needed.

**Step 1: Enable system-assigned identity on App Service:**

```bash
az webapp identity assign --name MyApi --resource-group MyRg
```

**Step 2: Create contained database user in Azure SQL:**

```sql
-- Run in Azure SQL Database
CREATE USER [MyApi] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [MyApi];
ALTER ROLE db_datawriter ADD MEMBER [MyApi];
ALTER ROLE db_ddladmin ADD MEMBER [MyApi];  -- if needed for schema changes
```

**Step 3: Connection string (no password):**

```
Server=your-server.database.windows.net;Database=YourDb;Authentication=Active Directory Default;Encrypt=True;
```

**Step 4: In SqlConnectionFactory:**

```csharp
// Microsoft.Data.SqlClient handles token acquisition automatically
// when Authentication=Active Directory Default is in the connection string
public IDbConnection CreateConnection() 
    => new SqlConnection(_connectionString);
```

`Microsoft.Data.SqlClient` natively supports `Authentication=Active Directory Default` which uses `DefaultAzureCredential` under the hood — works with managed identity in Azure and dev tools locally.

### App Service Plan Tier Recommendations (Low-Traffic App)

| Tier | vCPU | RAM | Cost/mo | Recommendation |
|------|------|-----|---------|----------------|
| F1 Free | Shared | 1 GB | $0 | Dev/testing only; 60 min/day CPU cap |
| B1 Basic | 1 | 1.75 GB | ~$13 | **Low-traffic production** minimum |
| B2 Basic | 2 | 3.5 GB | ~$26 | Better for 10–50 concurrent users |
| S1 Standard | 1 | 1.75 GB | ~$70 | Custom domains, SSL, auto-scale slots |

**Recommendation:** Start with **B1** for initial deployment. Upgrade to S1 if you need staging slots or auto-scale.

### Azure Key Vault Integration with App Service

**Step 1: Assign Key Vault Secrets User role to App Service identity:**

```bash
az role assignment create \
  --role "Key Vault Secrets User" \
  --assignee <principalId-from-identity-assign> \
  --scope "/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.KeyVault/vaults/<vaultName>"
```

**Step 2: Access secrets via Key Vault References in App Service configuration (no code changes):**

In App Service Configuration > Application Settings, use Key Vault reference syntax:

```
ConnectionStrings:DefaultConnection = @Microsoft.KeyVault(VaultName=myvault;SecretName=SqlConnectionString)
```

OR in code using `DefaultAzureCredential`:

```csharp
// In Program.cs, add Key Vault to IConfiguration
builder.Configuration.AddAzureKeyVault(
    new Uri($"https://{vaultName}.vault.azure.net/"),
    new DefaultAzureCredential());

// Then access normally:
var connectionString = builder.Configuration["SqlConnectionString"];
```

### Application Insights for .NET 9

**Important note from official docs (2025):** The classic Application Insights SDK (`Microsoft.ApplicationInsights.AspNetCore`) is **deprecated** (retires 2027). The **recommended approach** for new .NET 9 apps is the **Azure Monitor OpenTelemetry Distro**.

**New (recommended) - OpenTelemetry Distro:**

```bash
dotnet add package Azure.Monitor.OpenTelemetry.AspNetCore
```

```csharp
// Program.cs
builder.Services.AddOpenTelemetry().UseAzureMonitor(options =>
{
    options.ConnectionString = builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"];
});
```

**Legacy (still works until 2027):**

```csharp
builder.Services.AddApplicationInsightsTelemetry();
// Connection string from appsettings.json:
// "ApplicationInsights": { "ConnectionString": "..." }
```

---

## Topic 4: Azure SQL Migration from SQL Server

### Sources
- https://learn.microsoft.com/en-us/azure/azure-sql/database/transact-sql-tsql-differences-sql-server
- https://learn.microsoft.com/en-us/azure/azure-sql/database/migrate-to-database-from-sql-server
- https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-dotnet-core

### Migration Tools

| Tool | Best For |
|------|----------|
| **Azure Database Migration Service (DMS)** | Online/offline migration with minimal downtime |
| **SSMS Migrate (Data Migration Assistant - DMA)** | Assessment + migration for smaller databases |
| **sqlpackage (BACPAC)** | Export/import schema+data as a BACPAC file |
| **Transactional Replication** | Near-zero downtime migration for active databases |

**Recommended for Swimomatic scenario (existing SQL Server 2008 database):**

1. Run **Data Migration Assistant (DMA)** to assess compatibility
2. Fix any incompatibilities identified
3. Use **Azure Database Migration Service** for the actual migration

### Compatibility Level Differences

The original Swimomatic database appears to be SQL Server 2008 (compatibility level 100). Azure SQL Database runs on the latest SQL Server engine but defaults to a specific compatibility level. Key considerations:

- Azure SQL default compatibility: 150 (SQL Server 2019) or 160 for new databases
- Most SQL Server 2008 T-SQL syntax is compatible
- Stored procedures that use deprecated features need review

### T-SQL Features NOT Supported in Azure SQL

These are blocked or not available in Azure SQL that may appear in older SQL Server 2008 stored procedures:

**Completely unsupported:**
- `EXECUTE AS LOGIN` → use `EXECUTE AS USER` instead
- `.NET CLR integration` (CLR stored procedures/functions)
- SQL Server Agent jobs (`sp_add_job`, `msdb` tables)
- Cross-database queries with 3/4-part names (e.g., `OtherDB.dbo.TableName`)
- `FILESTREAM`, `FILETABLE`
- Server-level triggers (logon triggers)
- Linked servers (`OPENQUERY`, `OPENDATASOURCE`)
- `OPENROWSET` with bulk insert from file system
- `USE <DatabaseName>` (cannot switch databases in a connection)
- `sp_configure` and `RECONFIGURE`
- `SHUTDOWN`
- `sp_addmessage`
- Windows authentication (use Entra ID / SQL auth instead)
- `CREATE DATABASE` / `ALTER DATABASE` with file placement options
- Backup/Restore T-SQL statements

**Partially supported:**
- `CREATE LOGIN` / `ALTER LOGIN` — limited options; prefer contained database users
- `CREATE TABLE` — no `FILETABLE` or `FILESTREAM`

**Key finding for Swimomatic:** If stored procedures use `msdb` for email (`sp_send_dbmail`), SQL Server Agent jobs, or cross-database references, these will need reworking.

### Connection String for Azure SQL from .NET 9

**Microsoft.Data.SqlClient (recommended over System.Data.SqlClient):**

```bash
dotnet add package Microsoft.Data.SqlClient
```

**With SQL authentication:**

```
Server=your-server.database.windows.net;Database=YourDb;User Id=youruser;Password=yourpassword;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

**With Managed Identity (recommended for production):**

```
Server=your-server.database.windows.net;Database=YourDb;Authentication=Active Directory Default;Encrypt=True;Connection Timeout=30;
```

**With specific user (user-assigned managed identity):**

```
Server=your-server.database.windows.net;Database=YourDb;Authentication=Active Directory Managed Identity;User Id=<client-id-of-user-assigned-identity>;Encrypt=True;
```

**C# connection example:**

```csharp
using Microsoft.Data.SqlClient;

await using var connection = new SqlConnection(connectionString);
await connection.OpenAsync();
```

### Migration Steps for Swimomatic Database

Based on the workspace structure showing `SwimomaticDB/` with `.dbp` and `.dbproj` files:

1. **Assessment:** Run DMA against the SwimomaticDB project to identify incompatibilities in the stored procedures under `Schema Objects/`
2. **Schema migration:** Use `sqlpackage` to export schema:
   ```bash
   sqlpackage /Action:Extract /SourceServerName:localhost /SourceDatabaseName:SwimomaticDB /TargetFile:Swimomatic.dacpac /p:ExtractAllTableData=false
   ```
3. **Publish to Azure SQL:**
   ```bash
   sqlpackage /Action:Publish /SourceFile:Swimomatic.dacpac /TargetServerName:your-server.database.windows.net /TargetDatabaseName:SwimomaticDB /TargetUser:admin /TargetPassword:password
   ```
4. **Data migration:** Use DMS or BCP for data
5. **Update compatibility level (post-migration):**
   ```sql
   ALTER DATABASE SwimomaticDB SET COMPATIBILITY_LEVEL = 150;
   ```
6. **Update statistics after migration:**
   ```sql
   EXEC sp_updatestats;
   ```

---

## Key Recommendations Summary

### Dapper / Data Layer
- Use `IDbConnectionFactory` (singleton) + per-operation `using var conn` pattern
- Register repositories as `Scoped`
- Always use `QueryAsync`, `ExecuteAsync` etc. — never sync Dapper in ASP.NET Core
- Use `DynamicParameters` for stored procedure output/return parameters
- Prefer Managed Identity + `Authentication=Active Directory Default` over SQL passwords

### React/Vite Front-end
- Scaffold with `pnpm create vite@latest` + `--template react-ts`
- Use feature-sliced folder structure (`features/swimmers/`, `features/teams/`, etc.)
- TanStack Query v5 for all server state; React Hook Form + Zod for all forms
- shadcn/ui + Tailwind CSS for component library
- Typed API client layer per domain in `src/api/`

### Azure Deployment
- React SPA → Azure Static Web Apps (Free tier for dev, Standard for prod)
- .NET 9 API → Azure App Service (B1 for low-traffic)
- Configure CORS in .NET API OR use SWA Standard linked backend (preferred)
- **Avoid Auth0 with SWA built-in auth** — use Auth0 SDK directly in React + JWT validation in .NET
- Enable system-assigned managed identity on App Service for passwordless Azure SQL access
- Use Key Vault References in App Service App Settings (no code changes)
- Use Azure Monitor OpenTelemetry Distro for Application Insights (not classic SDK)

### Azure SQL Migration
- Run DMA assessment first — especially check stored procedures for `msdb`, cross-DB refs, CLR
- SQL Server 2008 → Azure SQL: most T-SQL works; main risks are Agent jobs, CLR, linked servers
- Use `Microsoft.Data.SqlClient` (not `System.Data.SqlClient`)
- Set compatibility level to 150 after validating queries

---

## References

- Dapper GitHub: https://github.com/DapperLib/Dapper
- Dapper learn docs: https://www.learndapper.com/
- TanStack Query v5 overview: https://tanstack.com/query/latest/docs/framework/react/overview
- shadcn/ui Vite setup: https://ui.shadcn.com/docs/installation/vite
- Azure Static Web Apps config: https://learn.microsoft.com/en-us/azure/static-web-apps/configuration
- Azure Static Web Apps APIs: https://learn.microsoft.com/en-us/azure/static-web-apps/apis-overview
- App Service Managed Identity: https://learn.microsoft.com/en-us/azure/app-service/overview-managed-identity
- Key Vault + App Service tutorial: https://learn.microsoft.com/en-us/azure/key-vault/general/tutorial-net-create-vault-azure-web-app
- Application Insights .NET: https://learn.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core
- T-SQL differences in Azure SQL: https://learn.microsoft.com/en-us/azure/azure-sql/database/transact-sql-tsql-differences-sql-server
- SQL Server to Azure SQL migration guide: https://learn.microsoft.com/en-us/azure/azure-sql/database/migrate-to-database-from-sql-server
- Azure SQL .NET connection: https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-dotnet-core

