# Auth0 + ASP.NET Core .NET 9 + Vite/React Research

**Date:** 2026-06-23
**Status:** Complete
**Scope:** Auth0 integration for a Swimomatic rebuild using .NET 9 WebAPI backend + Vite/React TypeScript frontend

---

## Research Topics

1. Auth0 Integration with ASP.NET Core .NET 9 WebAPI
2. Auth0 Integration with Vite + React (TypeScript)
3. Admin Role Patterns for per-entity roles (team admin, league admin, etc.)

---

## Topic 1: Auth0 Integration with ASP.NET Core .NET 9 WebAPI

### Package Choice

As of 2025-2026, Auth0 recommends their own wrapper package rather than using `Microsoft.AspNetCore.Authentication.JwtBearer` directly:

```
dotnet add package Auth0.AspNetCore.Authentication.Api
```

This package wraps `Microsoft.AspNetCore.Authentication.JwtBearer` internally and provides a cleaner API. The package targets .NET 8+ and works fully on .NET 9.

**Alternative (manual, no Auth0 package):** You can still use `Microsoft.AspNetCore.Authentication.JwtBearer` directly if you want zero Auth0 dependencies on the API side. Both approaches are valid.

### Configuration: `appsettings.json`

```json
{
  "Auth0": {
    "Domain": "your-tenant.auth0.com",
    "Audience": "https://your-api-identifier"
  }
}
```

**Critical notes:**
- `Domain` must NOT include `https://` — the SDK constructs the authority URL automatically
- `Audience` is the API Identifier you set in the Auth0 Dashboard under Applications > APIs > Your API > Settings > Identifier

### Program.cs — Using the Auth0 SDK (Recommended)

```csharp
using Auth0.AspNetCore.Authentication.Api;
using Microsoft.AspNetCore.Authentication.JwtBearer;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddAuth0ApiAuthentication(options =>
{
    options.Domain = builder.Configuration["Auth0:Domain"]
        ?? throw new InvalidOperationException("Auth0:Domain is required");
    options.JwtBearerOptions = new JwtBearerOptions
    {
        Audience = builder.Configuration["Auth0:Audience"]
            ?? throw new InvalidOperationException("Auth0:Audience is required")
    };
});

builder.Services.AddAuthorization();
builder.Services.AddControllers();

var app = builder.Build();

app.UseAuthentication();  // MUST come before UseAuthorization
app.UseAuthorization();
app.MapControllers();
app.Run();
```

### Program.cs — Manual JWT Bearer (No Auth0 Package)

```csharp
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);

var domain = $"https://{builder.Configuration["Auth0:Domain"]}/";
var audience = builder.Configuration["Auth0:Audience"];

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = domain;
        options.Audience = audience;
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuerSigningKey = true,
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ClockSkew = TimeSpan.FromMinutes(5),
            NameClaimType = System.Security.Claims.ClaimTypes.NameIdentifier,
            // Map custom role claim if using Auth0 RBAC via Actions:
            RoleClaimType = "https://swimomatic.app/roles"
        };
    });

builder.Services.AddAuthorization();
```

The manual approach is simpler for developers already familiar with JwtBearer and avoids an extra dependency. Auth0 JWTs use RS256 signing, and the Authority URL causes the middleware to auto-fetch the JWKS public key from `https://your-tenant.auth0.com/.well-known/jwks.json` — no manual key configuration needed.

### Audience and Issuer Validation

- **Issuer** is auto-validated via `Authority` — set to `https://your-tenant.auth0.com/`
- **Audience** must exactly match the API Identifier string you registered in Auth0 Dashboard
- Both validations are enabled by default when using `AddJwtBearer` with `Authority`
- If audience validation fails → 401 with "invalid audience" error
- If issuer validation fails → 401 with "invalid issuer" error

### Extracting User Identity (Auth0 `sub` claim)

The `sub` claim is the Auth0 user ID (e.g., `auth0|abc123` or `google-oauth2|xyz`).

```csharp
[ApiController]
[Route("api/[controller]")]
public class ProfileController : ControllerBase
{
    [Authorize]
    [HttpGet]
    public IActionResult GetProfile()
    {
        // Auth0 user ID — unique across all users
        var userId = User.FindFirst("sub")?.Value;
        
        // Or using ClaimTypes.NameIdentifier if RoleClaimType is mapped
        var email = User.FindFirst("email")?.Value;
        var name = User.FindFirst("name")?.Value;
        
        return Ok(new { UserId = userId, Email = email, Name = name });
    }
}
```

**Note:** When using `Microsoft.AspNetCore.Authentication.JwtBearer` directly, Auth0's `sub` claim maps to `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier` (the .NET `ClaimTypes.NameIdentifier`) in `HttpContext.User`. You can read it either way:
- `User.FindFirst("sub")?.Value` — works with the raw JWT claim name
- `User.Identity?.Name` — works if `NameClaimType = ClaimTypes.NameIdentifier`

### Scope-Based Authorization

Define scopes (permissions) in Auth0 Dashboard → APIs → Your API → Permissions tab. Then protect endpoints:

```csharp
// In Program.cs
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("read:heats", policy =>
        policy.RequireClaim("scope", "read:heats"));
    options.AddPolicy("write:heats", policy =>
        policy.RequireClaim("scope", "write:heats"));
    options.AddPolicy("admin:meet", policy =>
        policy.RequireClaim("scope", "admin:meet"));
});
```

```csharp
[Authorize(Policy = "read:heats")]
[HttpGet("{meetId}/heats")]
public IActionResult GetHeats(int meetId) { ... }
```

**Scope claim format gotcha:** Auth0 puts all scopes in a single space-separated string in the `scope` claim (e.g., `"read:heats write:heats offline_access"`). The `RequireClaim("scope", "read:heats")` pattern only works if the policy checks substring — for proper scope validation, use the `HasScopeHandler` pattern described in Auth0 docs:

```csharp
// Authorization/HasScopeHandler.cs
public class HasScopeHandler : AuthorizationHandler<HasScopeRequirement>
{
    protected override Task HandleRequirementAsync(
        AuthorizationHandlerContext context,
        HasScopeRequirement requirement)
    {
        var scopeClaim = context.User
            .FindFirst(c => c.Type == "scope" && c.Issuer == requirement.Issuer);

        if (scopeClaim == null) return Task.CompletedTask;

        var scopes = scopeClaim.Value.Split(' ');
        if (scopes.Contains(requirement.Scope))
            context.Succeed(requirement);

        return Task.CompletedTask;
    }
}
```

### Role-Based Authorization Using Auth0 RBAC + Actions

Auth0 RBAC roles are NOT automatically included in access tokens. You must add a Post-Login Action to inject them as custom claims:

```javascript
// Auth0 Post-Login Action
exports.onExecutePostLogin = async (event, api) => {
    const namespace = 'https://swimomatic.app'; // must be a valid URI
    if (event.authorization) {
        api.idToken.setCustomClaim(`${namespace}/roles`, event.authorization.roles);
        api.accessToken.setCustomClaim(`${namespace}/roles`, event.authorization.roles);
    }
};
```

Then in .NET, configure the role claim type:

```csharp
options.TokenValidationParameters = new TokenValidationParameters
{
    RoleClaimType = "https://swimomatic.app/roles"
};
```

And use `[Authorize(Roles = "GlobalAdmin")]` or check in code:

```csharp
if (User.IsInRole("GlobalAdmin")) { ... }
```

**Important:** Custom claims in Auth0 tokens MUST use a namespaced URI format (e.g., `https://your-domain.com/claim-name`). Auth0 rejects custom claims that don't use a registered namespace to prevent claim collisions.

### CORS Configuration

For a React SPA on a different origin calling the API:

```csharp
// Program.cs
var allowedOrigins = builder.Configuration.GetSection("AllowedOrigins").Get<string[]>()
    ?? new[] { "http://localhost:5173" };

builder.Services.AddCors(options =>
{
    options.AddPolicy("SpaPolicy", policy =>
    {
        policy.WithOrigins(allowedOrigins)
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials(); // Only if using cookies; omit for JWT-only
    });
});

// Later in app configuration — BEFORE UseAuthentication:
app.UseCors("SpaPolicy");
app.UseAuthentication();
app.UseAuthorization();
```

For production, configure origins in `appsettings.Production.json`:

```json
{
  "AllowedOrigins": ["https://swimomatic.app"]
}
```

**CORS gotcha:** `AllowCredentials()` is only needed if using cookies or if the SPA sends credentials with requests. For JWT bearer tokens via the `Authorization` header, you do NOT need `AllowCredentials()`. However, `Authorization` header must be in `AllowAnyHeader()` or explicitly listed.

### Protecting Controllers

```csharp
[ApiController]
[Route("api/[controller]")]
[Authorize]  // Requires authentication for ALL actions in this controller
public class HeatsController : ControllerBase
{
    [HttpGet]  // inherits [Authorize] from controller
    public IActionResult GetHeats() { ... }

    [AllowAnonymous]  // explicitly override for public endpoints
    [HttpGet("public")]
    public IActionResult GetPublicHeats() { ... }

    [Authorize(Policy = "admin:meet")]  // scope-based policy
    [HttpPost]
    public IActionResult CreateHeat() { ... }
}
```

### Custom Token Validation Options

```csharp
options.JwtBearerOptions = new JwtBearerOptions
{
    Audience = audience,
    TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ClockSkew = TimeSpan.FromMinutes(5),
        NameClaimType = ClaimTypes.NameIdentifier,
        RoleClaimType = "https://swimomatic.app/roles"
    },
    Events = new JwtBearerEvents
    {
        OnAuthenticationFailed = context =>
        {
            Console.WriteLine($"Auth failed: {context.Exception.Message}");
            return Task.CompletedTask;
        },
        OnTokenValidated = context =>
        {
            var userId = context.Principal?.FindFirst("sub")?.Value;
            return Task.CompletedTask;
        }
    }
};
```

### Common Troubleshooting

| Error | Cause | Fix |
|---|---|---|
| 401 Invalid audience | Audience in config doesn't match API Identifier | Ensure exact string match |
| 401 Invalid issuer | Domain includes `https://` or trailing slash | Use bare domain: `your-tenant.auth0.com` |
| 401 on all requests | Middleware order wrong | `UseAuthentication()` before `UseAuthorization()` |
| Scopes not working | Space-separated scope string | Use `HasScopeHandler` pattern |
| Roles not in token | RBAC not enabled or no Action | Enable RBAC + add Post-Login Action |

---

## Topic 2: Auth0 Integration with Vite + React (TypeScript)

### Package Installation

```bash
npm add @auth0/auth0-react
npm install
```

### Auth0 Application Setup

In Auth0 Dashboard:
1. Applications > Applications > Create Application
2. Select **Single Page Application**
3. In Settings, configure:
   - **Allowed Callback URLs:** `http://localhost:5173` (prod: `https://swimomatic.app`)
   - **Allowed Logout URLs:** `http://localhost:5173`
   - **Allowed Web Origins:** `http://localhost:5173` (needed for silent authentication / token refresh)

### Environment Variables

```bash
# .env (Vite uses VITE_ prefix for client-side variables)
VITE_AUTH0_DOMAIN=your-tenant.auth0.com
VITE_AUTH0_CLIENT_ID=your-client-id
VITE_AUTH0_AUDIENCE=https://your-api-identifier
VITE_API_BASE_URL=http://localhost:5000
```

### Auth0Provider Setup — `main.tsx`

```tsx
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { Auth0Provider } from '@auth0/auth0-react';
import App from './App.tsx';

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <Auth0Provider
      domain={import.meta.env.VITE_AUTH0_DOMAIN}
      clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
      authorizationParams={{
        redirect_uri: window.location.origin,
        audience: import.meta.env.VITE_AUTH0_AUDIENCE,  // Required to get JWT access token
        scope: "openid profile email"                   // Add custom scopes as needed
      }}
    >
      <App />
    </Auth0Provider>
  </StrictMode>
);
```

**Critical:** The `audience` parameter in `authorizationParams` is what causes Auth0 to return a JWT access token (vs. an opaque token). Without it, `getAccessTokenSilently()` will return a token that cannot be validated by your API.

### PKCE Authorization Code Flow

The `@auth0/auth0-react` SDK automatically uses **Authorization Code flow with PKCE** for SPAs. This is correct and required:

- **Why not Implicit flow?** The Implicit flow (deprecated by OAuth 2.1 and Auth0) returns tokens in the URL fragment, exposing them to browser history, referrer headers, and third-party scripts. PKCE prevents authorization code interception by binding the code to a code verifier that only the original initiator knows.
- **Why not Client Credentials?** That flow is for machine-to-machine (M2M) — no user interaction.
- PKCE is the only safe flow for public clients (SPAs) as of 2025.

### Login/Logout Components

```tsx
// LoginButton.tsx
import { useAuth0 } from "@auth0/auth0-react";

const LoginButton = () => {
  const { loginWithRedirect } = useAuth0();
  return (
    <button onClick={() => loginWithRedirect()}>
      Log In
    </button>
  );
};
```

```tsx
// LogoutButton.tsx
import { useAuth0 } from "@auth0/auth0-react";

const LogoutButton = () => {
  const { logout } = useAuth0();
  return (
    <button onClick={() => logout({ logoutParams: { returnTo: window.location.origin } })}>
      Log Out
    </button>
  );
};
```

**Logout note:** Always pass `returnTo` to redirect after logout. Without it, the user lands on the Auth0 logout page.

### Getting the Access Token and Calling the API

```tsx
// api.ts — HTTP client helper
import { useAuth0 } from "@auth0/auth0-react";

export function useApiClient() {
  const { getAccessTokenSilently } = useAuth0();
  const baseUrl = import.meta.env.VITE_API_BASE_URL;

  const get = async <T>(path: string): Promise<T> => {
    const token = await getAccessTokenSilently();
    const response = await fetch(`${baseUrl}${path}`, {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    });
    if (!response.ok) throw new Error(`API error: ${response.status}`);
    return response.json();
  };

  const post = async <T>(path: string, body: unknown): Promise<T> => {
    const token = await getAccessTokenSilently();
    const response = await fetch(`${baseUrl}${path}`, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    });
    if (!response.ok) throw new Error(`API error: ${response.status}`);
    return response.json();
  };

  return { get, post };
}
```

**`getAccessTokenSilently` behavior:**
- Returns a cached token if not expired
- Silently refreshes via hidden iframe or refresh token if expired
- Refresh tokens require `offline_access` scope and enabling "Allow Offline Access" in Auth0 API settings
- Throws `login_required` error if the user's session has expired — handle by calling `loginWithRedirect()`

```tsx
// Usage in a component
const { get } = useApiClient();

const heats = await get<Heat[]>(`/api/meets/${meetId}/heats`);
```

### Protecting React Routes

```tsx
// components/ProtectedRoute.tsx
import { Navigate } from 'react-router-dom';
import { useAuth0 } from '@auth0/auth0-react';

interface ProtectedRouteProps {
  children: React.ReactNode;
}

export function ProtectedRoute({ children }: ProtectedRouteProps) {
  const { isAuthenticated, isLoading } = useAuth0();

  if (isLoading) return <div>Loading...</div>;
  if (!isAuthenticated) return <Navigate to="/" replace />;

  return <>{children}</>;
}
```

```tsx
// App.tsx
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { ProtectedRoute } from './components/ProtectedRoute';
import { Dashboard } from './pages/Dashboard';
import { Home } from './pages/Home';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route
          path="/dashboard"
          element={
            <ProtectedRoute>
              <Dashboard />
            </ProtectedRoute>
          }
        />
      </Routes>
    </BrowserRouter>
  );
}
```

**Alternative:** Use `withAuthenticationRequired` HOC from `@auth0/auth0-react` which also handles redirect back to the intended URL after login:

```tsx
import { withAuthenticationRequired } from '@auth0/auth0-react';

export const Dashboard = withAuthenticationRequired(DashboardComponent, {
  onRedirecting: () => <LoadingSpinner />,
});
```

### Reading User Claims

```tsx
import { useAuth0 } from "@auth0/auth0-react";

function UserProfile() {
  const { user, isAuthenticated } = useAuth0();

  if (!isAuthenticated || !user) return null;

  const roles = user['https://swimomatic.app/roles'] as string[] | undefined;

  return (
    <div>
      <p>Sub (Auth0 ID): {user.sub}</p>
      <p>Email: {user.email}</p>
      <p>Name: {user.name}</p>
      <p>Roles: {roles?.join(', ')}</p>
    </div>
  );
}
```

**Note:** Custom claims added by Auth0 Actions (with namespace prefix) are accessible via `user['https://namespace/claim-name']`. The `user` object from `useAuth0()` reflects the ID token claims, not the access token claims.

### Handling Token Refresh Errors

```tsx
const callApi = async () => {
  try {
    const token = await getAccessTokenSilently();
    // ... make API call
  } catch (error) {
    if (error.error === 'login_required') {
      await loginWithRedirect();
    } else if (error.error === 'consent_required') {
      await loginWithRedirect();
    } else {
      console.error('Unexpected auth error:', error);
    }
  }
};
```

---

## Topic 3: Admin Role Patterns for Per-Entity Roles

### The Problem

Swimomatic has multi-level authorization:
- A user can be an admin of a specific **team** (but not other teams)
- A user can be an admin of a specific **league** (but not other leagues)
- A user can manage a specific **swim meet** (but not others)
- There may be a global "system admin" role

This is NOT global role-based authorization — it's **entity-scoped** authorization. Auth0's built-in RBAC system (roles assigned per user globally) does NOT natively support entity-scoped roles.

### Option A: Auth0 Roles (Global Only — Limited)

Auth0 Roles work well for global roles (`GlobalAdmin`, `Coach`, `TimeKeeper`) but cannot express entity-level permissions like "Admin of Team #42."

**Use when:** You have a small number of global roles that don't vary by entity.

**Limitation:** Cannot express "user X is admin of team Y but not team Z."

### Option B: Auth0 Organizations (B2B Multi-Tenant Pattern)

Auth0 Organizations is Auth0's built-in multi-tenant feature. Each Organization maps to a business entity (team, league, etc.). Organization-specific roles can be assigned per-member.

**How it works:**
- Create one Auth0 Organization per team/league
- Assign users to organizations with organization-specific roles
- During login, user selects which organization context to use
- The access token includes `org_id` and organization-specific roles

**Limitations:**
- Designed for B2B SaaS (business customers), not fine-grained entity roles within a single app
- Requires the user to pick an active organization at login — doesn't support "acting as admin of multiple teams simultaneously"
- Overkill for a swim app unless teams/leagues are separate tenants
- **Not recommended** for Swimomatic's use case

### Option C: Store Roles in Application Database (Recommended for Swimomatic)

This is the pragmatic pattern for apps with entity-scoped permissions. Auth0 handles identity and authentication; your database stores authorization.

**Schema example:**

```sql
-- UserTeamRole: user's role within a specific team
CREATE TABLE UserTeamRole (
    UserId     NVARCHAR(128) NOT NULL,  -- Auth0 sub claim value
    TeamId     INT NOT NULL,
    Role       NVARCHAR(50) NOT NULL,   -- 'Admin', 'Coach', 'Swimmer'
    PRIMARY KEY (UserId, TeamId, Role)
);

-- UserLeagueRole: user's role within a specific league
CREATE TABLE UserLeagueRole (
    UserId    NVARCHAR(128) NOT NULL,
    LeagueId  INT NOT NULL,
    Role      NVARCHAR(50) NOT NULL,   -- 'Admin', 'Scorer', 'Viewer'
    PRIMARY KEY (UserId, LeagueId, Role)
);

-- UserMeetRole: user can manage specific swim meets
CREATE TABLE UserMeetRole (
    UserId    NVARCHAR(128) NOT NULL,
    MeetId    INT NOT NULL,
    Role      NVARCHAR(50) NOT NULL,   -- 'Organizer', 'Timer', 'Viewer'
    PRIMARY KEY (UserId, MeetId, Role)
);
```

**API enforcement pattern:**

```csharp
[ApiController]
[Route("api/teams/{teamId}")]
[Authorize]
public class TeamController : ControllerBase
{
    private readonly IAuthorizationService _authService;

    public TeamController(IAuthorizationService authService)
    {
        _authService = authService;
    }

    [HttpPut]
    public async Task<IActionResult> UpdateTeam(int teamId, [FromBody] UpdateTeamDto dto)
    {
        var userId = User.FindFirst("sub")?.Value;

        // Check entity-scoped authorization from DB
        var result = await _authService.AuthorizeAsync(User,
            new TeamResource(teamId), "TeamAdmin");

        if (!result.Succeeded)
            return Forbid();

        // ... update team
    }
}
```

With a custom `IAuthorizationHandler`:

```csharp
public class TeamAdminHandler : AuthorizationHandler<TeamAdminRequirement, TeamResource>
{
    private readonly ITeamRoleRepository _repo;

    public TeamAdminHandler(ITeamRoleRepository repo) => _repo = repo;

    protected override async Task HandleRequirementAsync(
        AuthorizationHandlerContext context,
        TeamAdminRequirement requirement,
        TeamResource resource)
    {
        var userId = context.User.FindFirst("sub")?.Value;
        if (userId == null) return;

        var isAdmin = await _repo.IsTeamAdminAsync(userId, resource.TeamId);
        if (isAdmin)
            context.Succeed(requirement);
    }
}
```

### Option D: Hybrid — Auth0 Global Roles + DB Entity Roles (Recommended for Swimomatic)

Combine Auth0 RBAC for global roles + database for entity-scoped roles:

| Role Type | Storage | Source |
|---|---|---|
| `GlobalAdmin` | Auth0 RBAC | Token claim |
| Team Admin | App database | DB query on each request |
| League Admin | App database | DB query on each request |
| Meet Organizer | App database | DB query on each request |

**Auth0 Action to add global roles to token:**

```javascript
exports.onExecutePostLogin = async (event, api) => {
    const namespace = 'https://swimomatic.app';
    if (event.authorization) {
        // Only global roles (GlobalAdmin, SystemUser) in token
        api.accessToken.setCustomClaim(`${namespace}/roles`, event.authorization.roles);
    }
};
```

**API logic:**

```csharp
[HttpDelete("{teamId}")]
[Authorize]
public async Task<IActionResult> DeleteTeam(int teamId)
{
    var userId = User.FindFirst("sub")?.Value;

    // Check: global admin can delete anything
    var isGlobalAdmin = User.IsInRole("GlobalAdmin");

    // Check: team admin can delete their own team
    var isTeamAdmin = await _teamRoleRepo.IsTeamAdminAsync(userId, teamId);

    if (!isGlobalAdmin && !isTeamAdmin)
        return Forbid();

    // ... delete team
}
```

### Auth0 Custom Actions for App-Level Claims

You can also use Auth0 Actions to embed additional custom data. For example, embed a list of team IDs the user admins:

```javascript
// Post-Login Action — embed team admin IDs from external API
exports.onExecutePostLogin = async (event, api) => {
    const namespace = 'https://swimomatic.app';

    // Call your own API to get team memberships
    // NOTE: This is called on every login — keep it fast/cached
    const response = await fetch(`https://api.swimomatic.app/auth/user-roles/${event.user.user_id}`, {
        headers: { 'x-api-key': event.secrets.INTERNAL_API_KEY }
    });
    const data = await response.json();

    api.accessToken.setCustomClaim(`${namespace}/adminTeamIds`, data.adminTeamIds);
    api.accessToken.setCustomClaim(`${namespace}/roles`, event.authorization?.roles ?? []);
};
```

**Gotchas:**
- Tokens have a size limit — embedding large lists of entity IDs can exceed token size limits
- The Action is called on every login/token refresh — external calls add latency
- For Swimomatic (potentially many teams per user), DB lookup at request time is safer than embedding in token

### Recommendation for Swimomatic

Use the **Hybrid approach (Option D)**:

1. **Auth0 RBAC** for global roles (`GlobalAdmin`, `SystemUser`)
2. **Application database** (`UserTeamRole`, `UserLeagueRole`, `UserMeetRole`) for entity-scoped roles
3. **Custom Authorization Policies** in .NET for entity-resource checks
4. Do NOT try to embed all entity roles in the JWT — use DB lookup at request time for entity-scoped checks

This is the most common and scalable approach for multi-tenant applications where users can have different roles per entity.

---

## Summary of Key Decisions / Recommendations

### WebAPI (.NET 9)

| Decision | Recommendation |
|---|---|
| Auth package | `Auth0.AspNetCore.Authentication.Api` or `Microsoft.AspNetCore.Authentication.JwtBearer` (both valid) |
| JWT signing | RS256 (auto — fetched from JWKS endpoint) |
| Issuer validation | Auto via `Authority` setting |
| Audience validation | Required — must match API Identifier exactly |
| User ID extraction | `User.FindFirst("sub")?.Value` |
| CORS | `app.UseCors()` before `app.UseAuthentication()` |
| Entity roles | Store in DB, not in JWT |

### React (Vite + TypeScript)

| Decision | Recommendation |
|---|---|
| SDK | `@auth0/auth0-react` |
| Auth flow | PKCE Authorization Code (automatic with SDK) |
| Token acquisition | `getAccessTokenSilently()` |
| API calls | Pass token in `Authorization: Bearer {token}` header |
| Route protection | `ProtectedRoute` wrapper or `withAuthenticationRequired` HOC |
| Custom claims | Access via `user['https://namespace/claim-name']` |

### Admin Roles

| Scope | Pattern |
|---|---|
| Global admin | Auth0 RBAC + Post-Login Action to inject into token |
| Team/League/Meet admin | App database + custom `IAuthorizationHandler` |

---

## References

- Auth0 ASP.NET Core Web API Quickstart: https://auth0.com/docs/quickstart/backend/aspnet-core-webapi
- Auth0 React SPA Quickstart: https://auth0.com/docs/quickstart/spa/react
- Auth0 RBAC Overview: https://auth0.com/docs/manage-users/access-control/rbac
- Auth0 Configure Core RBAC: https://auth0.com/docs/manage-users/access-control/configure-core-rbac
- Auth0 Sample Use Cases: Actions with Authorization: https://auth0.com/docs/manage-users/access-control/sample-use-cases-actions-with-authorization
- Auth0 Organizations (B2B multi-tenant): https://auth0.com/docs/manage-users/organizations
- aspnetcore-api SDK GitHub: https://github.com/auth0/aspnetcore-api
- Auth0 Fine-Grained Authorization (FGA): https://docs.fga.dev/authorization-concepts

---

## Clarifying Questions (Cannot Be Answered by Research)

1. Will Swimomatic support a "GlobalAdmin" role at all, or is all authorization entity-scoped?
2. What is the expected number of entities (teams/leagues) per user? If large, embedding in JWT is not viable.
3. Is a user's entity role ever needed in the React UI (to show/hide UI elements)? If so, the DB-query-on-login + Action approach may be worth exploring.
4. Will the app use Auth0's social connections (Google, Facebook) or only email/password?
5. Is offline access (refresh tokens for long sessions) needed? If so, add `offline_access` scope and enable "Allow Offline Access" in Auth0 API settings.
