<!-- markdownlint-disable-file -->
# Implementation Details: Swagger / OpenAPI for AthletePlatformAPI

## Context Reference

Sources: AthletePlatformAPI/AthletePlatformAPI.csproj, AthletePlatformAPI/Program.cs, SwimDomain/Controllers/SwimMeetsController.cs

---

## Phase 1: Add NuGet Package

### Step 1.1: Add Swashbuckle.AspNetCore to AthletePlatformAPI.csproj

Files:
* AthletePlatformAPI/AthletePlatformAPI.csproj — add one PackageReference to the existing ItemGroup

Add inside the `<ItemGroup>` that contains `PackageReference` elements:

```xml
<PackageReference Include="Swashbuckle.AspNetCore" Version="7.*" />
```

Full csproj ItemGroup after change:
```xml
<ItemGroup>
  <PackageReference Include="Dapper" Version="2.1.79" />
  <PackageReference Include="dbup-sqlserver" Version="7.2.0" />
  <PackageReference Include="Microsoft.ApplicationInsights.AspNetCore" Version="2.22.0" />
  <PackageReference Include="Microsoft.AspNetCore.Authentication.JwtBearer" Version="9.*" />
  <PackageReference Include="Microsoft.AspNetCore.Authorization" Version="9.0.17" />
  <PackageReference Include="Microsoft.Data.SqlClient" Version="7.0.1" />
  <PackageReference Include="Serilog.AspNetCore" Version="10.0.0" />
  <PackageReference Include="Serilog.Sinks.ApplicationInsights" Version="5.0.1" />
  <PackageReference Include="Swashbuckle.AspNetCore" Version="7.*" />
</ItemGroup>
```

Success criteria:
* `dotnet restore` completes without error

---

## Phase 2: Register Swagger Services and Middleware

### Step 2.1: Add AddSwaggerGen to Program.cs

Files:
* AthletePlatformAPI/Program.cs — add after `builder.Services.AddControllers()` block, before `var app = builder.Build()`

Add the following using directives at the top of Program.cs (after existing usings):
```csharp
using Microsoft.OpenApi.Models;
```

Add service registration after the `builder.Services.AddAuthorization(...)` block:
```csharp
// ── Swagger / OpenAPI ──────────────────────────────────────────────────────────
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Athlete Platform API",
        Version = "v1",
        Description = "Multi-sport SaaS athlete management platform API"
    });

    // JWT Bearer security definition — enables the Authorize button in Swagger UI
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Enter your Auth0 JWT token (without the 'Bearer ' prefix)"
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});
```

Success criteria:
* `builder.Services.AddSwaggerGen` compiles without error
* `Microsoft.OpenApi.Models` resolves (provided by Swashbuckle.AspNetCore)

Dependencies:
* Step 1.1 (Swashbuckle package must be restored)

---

### Step 2.2: Add UseSwagger + UseSwaggerUI middleware to Program.cs

Files:
* AthletePlatformAPI/Program.cs — add after `var app = builder.Build()` and before `app.UseRouting()`

```csharp
// ── Swagger UI (Development only) ────────────────────────────────────────────
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/swagger/v1/swagger.json", "Athlete Platform API v1");
        options.RoutePrefix = "swagger";
    });
}
```

Success criteria:
* `GET /swagger/index.html` returns 200 in Development
* `GET /swagger/index.html` returns 404 in Production (middleware not registered)

Dependencies:
* Step 2.1

---

## Phase 3: Validation

### Step 3.1: Build

```powershell
cd C:\GitHub\Swimomatic\AthletePlatform
dotnet build AthletePlatform.sln
```

Expected: Build succeeded, 0 errors.

### Step 3.2: Run and verify Swagger UI

```powershell
cd C:\GitHub\Swimomatic\AthletePlatform\AthletePlatformAPI
dotnet run
```

Navigate to: `http://localhost:5001/swagger`

Verify:
* Swagger UI renders
* Controllers from `SwimDomain` (SwimMeets, HeatSheets, Results) and `AthletePlatformAPI` (Athletes, Leagues, Teams, etc.) all appear
* Authorize button is present
* `GET /swagger/v1/swagger.json` returns valid JSON

---

## Dependencies

* Swashbuckle.AspNetCore 7.x NuGet package

## Success Criteria

* 0 build errors after changes
* Swagger UI accessible at `http://localhost:5001/swagger` in Development
* All controllers discoverable in the OpenAPI JSON
* JWT Bearer Authorize dialog present
