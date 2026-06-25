---
applyTo: '.copilot-tracking/changes/2026-06-24/swagger-changes.md'
---
<!-- markdownlint-disable-file -->
# Implementation Plan: Swagger / OpenAPI for AthletePlatformAPI

## Overview

Add Swashbuckle.AspNetCore to AthletePlatformAPI so that `GET /swagger` serves an interactive OpenAPI UI with JWT Bearer token support in Development.

## Objectives

### User Requirements

* Swagger UI available at `/swagger` when running locally — Source: conversation

### Derived Objectives

* JWT Bearer security definition enabled so the Authorize button accepts an Auth0 token — Derived from: API already uses `[Authorize]` on all controllers
* Swagger UI restricted to Development environment — Derived from: standard practice; production APIs should not expose schema
* Controllers from `SwimDomain` and `TrackField.Domain` (added via `AddApplicationPart`) appear in Swagger — Derived from: multi-assembly controller discovery already configured in Program.cs

## Context Summary

### Project Files

* AthletePlatformAPI/AthletePlatformAPI.csproj — target project; no Swagger packages present
* AthletePlatformAPI/Program.cs — DI registration + middleware pipeline; Swagger wired here
* SwimDomain/Controllers/SwimMeetsController.cs — representative controller; uses `[Authorize]` and `[ApiController]`; no `[ProducesResponseType]` attributes today

### References

* Swashbuckle.AspNetCore 7.x — compatible with .NET 9 / ASP.NET Core 9

## Implementation Checklist

### [x] Phase 1: Add NuGet Package

<!-- parallelizable: false -->

* [x] Step 1.1: Add `Swashbuckle.AspNetCore` to `AthletePlatformAPI.csproj`
  * Details: .copilot-tracking/details/2026-06-24/swagger-details.md (Lines 10-20)

### [x] Phase 2: Register Swagger Services and Middleware

<!-- parallelizable: false -->

* [x] Step 2.1: Add `AddSwaggerGen` with OpenApiInfo + JWT Bearer security definition to `Program.cs`
  * Details: .copilot-tracking/details/2026-06-24/swagger-details.md (Lines 23-65)
* [x] Step 2.2: Add `UseSwagger` + `UseSwaggerUI` middleware (Development environment guard) to `Program.cs`
  * Details: .copilot-tracking/details/2026-06-24/swagger-details.md (Lines 68-82)

### [x] Phase 3: Validation

<!-- parallelizable: false -->

* [x] Step 3.1: Run `dotnet build AthletePlatform.sln` — 0 errors
* [x] Step 3.2: Run `dotnet run` from `AthletePlatformAPI/` and navigate to `http://localhost:5001/swagger`
  * Verify Swagger UI loads with all swim + platform controllers listed
  * Verify Authorize button appears and accepts a Bearer token value

## Planning Log

See .copilot-tracking/plans/logs/2026-06-24/swagger-log.md

## Dependencies

* `Swashbuckle.AspNetCore` NuGet package (7.x)
* .NET 9 SDK
* `ASPNETCORE_ENVIRONMENT=Development` (set in launchSettings.json — already configured)

## Success Criteria

* `dotnet build` succeeds with 0 errors
* `GET http://localhost:5001/swagger/index.html` returns 200 with Swagger UI
* `GET http://localhost:5001/swagger/v1/swagger.json` returns valid OpenAPI JSON listing all controllers
* Authorize dialog appears with a JWT Bearer input field
* Swagger UI is NOT available when `ASPNETCORE_ENVIRONMENT=Production`
