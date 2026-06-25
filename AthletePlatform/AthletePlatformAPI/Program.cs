using System.Security.Claims;
using AthletePlatformAPI.Infrastructure.Auth;
using AthletePlatformAPI.Infrastructure.Migrations;
using AthletePlatformAPI.Infrastructure.Telemetry;
using AthletePlatformAPI.Infrastructure.Tenancy;
using Microsoft.AspNetCore.Authorization;
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Platform.Core;
using Platform.Core.Data;
using Platform.Core.Repositories;
using Platform.Core.Tenancy;
using Platform.Infrastructure.Data;
using Platform.Infrastructure.Repositories;
using SwimDomain;
using TrackField.Domain;

var builder = WebApplication.CreateBuilder(args);

// ── Sport modules ─────────────────────────────────────────────────────────────
// TrackFieldModule is registered but disabled (RegisterServices is empty)
// Enable T&F features by implementing WI-02 (see planning log)
var modules = new List<ISportModule> { new SwimModule(), new TrackFieldModule() };

// ── MVC + application parts per sport module ──────────────────────────────────
var mvcBuilder = builder.Services.AddControllers();
foreach (var module in modules)
{
    mvcBuilder.AddApplicationPart(module.GetType().Assembly);
}

// ── CORS ──────────────────────────────────────────────────────────────────────
builder.Services.AddCors(options =>
    options.AddPolicy("SpaOrigin", policy =>
        policy.WithOrigins(builder.Configuration["AllowedOrigins"]!.Split(','))
              .AllowAnyMethod()
              .AllowAnyHeader()
              .AllowCredentials()));

// ── Auth0 JWT Bearer ──────────────────────────────────────────────────────────
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

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("SwimMeetAdmin", p => p.AddRequirements(new AdminRequirement("SwimMeet")));
    options.AddPolicy("TeamAdmin", p => p.AddRequirements(new AdminRequirement("Team")));
    options.AddPolicy("LeagueAdmin", p => p.AddRequirements(new AdminRequirement("League")));
});
builder.Services.AddScoped<IAuthorizationHandler, SwimMeetAdminHandler>();
builder.Services.AddScoped<IAuthorizationHandler, TeamAdminHandler>();
builder.Services.AddScoped<IAuthorizationHandler, LeagueAdminHandler>();

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

// ── Tenancy ───────────────────────────────────────────────────────────────────
builder.Services.AddScoped<ITenantContext, TenantContext>();
builder.Services.AddScoped<TenantContext>();

// ── Database connection factory ───────────────────────────────────────────────
var connectionString = builder.Configuration.GetConnectionString("Default")
    ?? throw new InvalidOperationException("ConnectionStrings:Default is not configured.");

builder.Services.AddScoped<IDbConnectionFactory>(sp =>
    new DbConnectionFactory(
        connectionString,
        sp.GetRequiredService<ITenantContext>()));

// ── Application Insights ──────────────────────────────────────────────────────
builder.Services.AddApplicationInsightsTelemetry();
builder.Services.AddHttpContextAccessor();
builder.Services.AddSingleton<ITelemetryInitializer, TenantIdTelemetryInitializer>();

// ── Repositories ──────────────────────────────────────────────────────────────
builder.Services.AddScoped<ITenantRepository, TenantRepository>();
builder.Services.AddScoped<Platform.Core.Repositories.IAthleteRepository, Platform.Infrastructure.Repositories.AthleteRepository>();
builder.Services.AddScoped<Platform.Core.Repositories.ILeagueRepository, Platform.Infrastructure.Repositories.LeagueRepository>();
builder.Services.AddScoped<Platform.Core.Repositories.ITeamRepository, Platform.Infrastructure.Repositories.TeamRepository>();
builder.Services.AddScoped<Platform.Core.Repositories.ISeasonRepository, Platform.Infrastructure.Repositories.SeasonRepository>();
builder.Services.AddScoped<Platform.Core.Repositories.ILocationRepository, Platform.Infrastructure.Repositories.LocationRepository>();

// ── Sport module services ─────────────────────────────────────────────────────
foreach (var module in modules)
{
    module.RegisterServices(builder.Services, builder.Configuration);
}

var app = builder.Build();

// ── Database migrations ───────────────────────────────────────────────────────
if (!builder.Environment.IsEnvironment("Testing"))
{
    DatabaseMigrator.MigrateDatabase(connectionString);
}

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

// ── HTTP pipeline (order is critical) ────────────────────────────────────────
app.UseRouting();
app.UseCors("SpaOrigin");                                // 1. CORS (before auth for OPTIONS preflight)
app.UseAuthentication();                                 // 2. Validate JWT
app.UseAuthorization();                                  // 3. Check [Authorize] attributes
app.UseMiddleware<TenantResolutionMiddleware>();          // 4. Resolve tenant from claim → ITenantContext

app.MapControllers();

app.Run();
