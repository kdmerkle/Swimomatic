---
applyTo: '.copilot-tracking/changes/2026-06-23/multisport-saas-changes.md'
---
<!-- markdownlint-disable-file -->
# Implementation Plan: Multi-Sport SaaS Platform (Phases 0–3 + T&F Scaffold)

## Overview

Build a greenfield SaaS multi-sport athlete management platform from the existing Swimomatic design research, delivering a .NET 9 WebAPI + Vite/React SPA with SaaS tenant isolation, swim meet management as the first sport domain, full admin features, organization workflows, and a Track & Field scaffolding stub — deployed to a single Azure production environment via Bicep IaC and GitHub Actions.

## Objectives

### User Requirements

* Deliver SaaS multi-tenancy with shared Azure SQL schema and Row Level Security — Source: conversation, swimomatic-saas-multisport-research.md
* Implement swim meet management as the first sport domain — Source: conversation, swimomatic-modernization-research.md
* Include full admin features (heat sheet management, approval workflows, scoring) — Source: conversation, swimomatic-admin-features-research.md
* Include organization features (leagues, seasons, teams, athlete join requests) — Source: conversation, swimomatic-modernization-research.md
* Include Track & Field scaffolding to prove multi-sport extensibility — Source: conversation
* Unit tests for all service and handler logic — Source: conversation (unit tests only)
* Application Insights telemetry with TenantId custom dimension + Grafana Cloud dashboards — Source: conversation
* Azure infrastructure provisioned via Bicep IaC — Source: conversation
* GitHub Actions CI/CD pipeline to single production environment — Source: conversation
* Use DbUp for SQL schema migration management — Source: conversation

### Derived Objectives

* Define `ISportModule` extension contract so future sports require only one class library + one line in Program.cs — Derived from: multi-sport extensibility requirement
* Generalize `dbo.Result` with `MeasurementType` discriminator before any T&F work — Derived from: research finding that ElapsedTime-only schema blocks T&F, swimomatic-saas-multisport-research.md
* Rename Swimomatic `Swimmer` → `dbo.Athlete` as the central cross-sport identity — Derived from: research finding that Swimmer has zero swim-specific attributes, swimomatic-saas-multisport-research.md
* Set `TenantResolutionMiddleware` AFTER `UseAuthentication()`/`UseAuthorization()` in request pipeline — Derived from: research critical finding, swimomatic-saas-multisport-research.md (Scenario 1)
* Namespace Auth0 custom claims (`https://athleteplatform.com/tenant_id`) — Derived from: Auth0 requirement that unnamespaced claims from Actions are rejected

## Context Summary

### Project Files

* SwimomaticDataLib/Swimomatic.Entity/ — 40+ entity classes; source of truth for domain model
* SwimomaticMVC/Controllers/ — All controllers; source of truth for API endpoint mapping
* SwimomaticBusinessLib/SwimomaticBusinessManager.cs — God-class business manager; decomposed into per-domain services
* SwimomaticDB/Schema Objects/ — Existing stored procedures; preserved as DbUp baseline migration

### References

* .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md — Primary SaaS + multi-sport architecture reference; all technical scenarios with code examples
* .copilot-tracking/research/2026-06-23/swimomatic-modernization-research.md — Stack decisions, controller→endpoint mapping, entity inventory
* .copilot-tracking/research/2026-06-23/swimomatic-admin-features-research.md — Admin features, per-entity admin authorization, heat grid, approval workflows
* .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md — Tenancy strategy, Azure infra, Auth0, tenant middleware patterns with code
* .copilot-tracking/research/subagents/2026-06-23/multisport-domain-extensibility-research.md — ISportModule pattern, athlete identity, T&F domain analysis, React structure

### Standards References

* c:\Users\kmerkle\.vscode\extensions\ise-hve-essentials.hve-core-3.2.2\.github\instructions\hve-core\markdown.instructions.md — Markdown conventions for .md files

## Implementation Checklist

### [x] Phase A: Solution Structure + Azure Infrastructure

<!-- parallelizable: false -->
<!-- Foundational: all subsequent phases depend on this structure existing -->

* [x] Step A.1: Scaffold .NET 9 solution with all project references
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 12–60)
* [x] Step A.2: Provision Azure resources with Bicep IaC
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 62–120)
* [x] Step A.3: Configure GitHub Actions CI/CD pipeline (API + SPA)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 122–175)
* [x] Step A.4: Configure DbUp migration runner in API host project
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 177–215)

### [ ] Phase B: SaaS Platform Foundation (.NET)

<!-- parallelizable: false -->
<!-- Depends on Phase A; all sport domain phases depend on this -->

* [ ] Step B.1: Create platform database schema migrations (DbUp SQL scripts)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 218–310)
* [ ] Step B.2: Implement `ITenantContext`, `TenantContext`, `TenantResolutionMiddleware`
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 312–375)
* [ ] Step B.3: Implement `TenantAwareConnectionFactory` with RLS session context
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 377–425)
* [ ] Step B.4: Configure Auth0 tenant, API audience, and Post-Login Action (custom tenant_id claim)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 427–475)
* [ ] Step B.5: Configure Application Insights SDK + `TenantIdTelemetryInitializer`
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 477–520)
* [ ] Step B.6: Connect Grafana Cloud free tier to Application Insights via Azure Monitor data source
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 522–565)
* [ ] Step B.7: Implement `ISportModule` interface + register `SwimModule` + stub `TrackFieldModule`
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 567–620)
* [ ] Step B.8: Configure request pipeline order in Program.cs (critical: UseCors → UseAuthentication → UseAuthorization → TenantResolution)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md
* [ ] Step B.9: Implement `GET /api/tenant` endpoint + `TenantController` (required by React SPA for `enabledSports`)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md
* [ ] Step B.10: Write unit tests for `TenantResolutionMiddleware` and `TenantContext`
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md

### [ ] Phase C: React SPA Foundation

<!-- parallelizable: true -->
<!-- Can start in parallel with Phase B after Step A.1 is complete -->
<!-- File set: athlete-platform-spa/ — no overlap with Phase B (.NET files) -->

* [ ] Step C.1: Scaffold Vite + React + TypeScript SPA with dependencies
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 698–755)
* [ ] Step C.2: Implement Auth0 PKCE provider + `useCurrentUser` hook
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 757–800)
* [ ] Step C.3: Implement `useTenant` hook + sport-aware `NavBar` component
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 802–845)
* [ ] Step C.4: Implement route-based lazy loading for sport modules in `App.tsx`
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 847–890)
* [ ] Step C.5: Create `staticwebapp.config.json` with `navigationFallback` for React Router
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 892–910)

### [ ] Phase D: Core Swim API + Unit Tests

<!-- parallelizable: false -->
<!-- Depends on Phase B completion -->

* [ ] Step D.1: Create swim database schema migrations (`swim.*` tables via DbUp)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 913–985)
* [ ] Step D.2: Implement platform-level repositories (`AthleteRepository`, `LeagueRepository`, `TeamRepository`)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 987–1050)
* [ ] Step D.3: Implement `SwimMeetRepository` + `SwimMeetService` + `/api/swim/meets` controller
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1052–1120)
* [ ] Step D.4: Implement `HeatSheetRepository` + `HeatSheetService` (heat generation algorithm) + `/api/swim/meets/{id}/heatsheets` controller
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1122–1200)
* [ ] Step D.5: Implement `ResultRepository` + `ResultService` (scoring algorithm) + `/api/swim/results` controller
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1202–1265)
* [ ] Step D.6: Implement `AthleteRepository` + `AthleteService` + `/api/athletes` controller
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1267–1320)
* [ ] Step D.7: Write unit tests for all swim domain services
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1322–1385)
* [ ] Step D.8: Validate Phase D (build + unit test run)
  * Run `dotnet build` and `dotnet test` for SwimDomain.Tests; fix any failures

### [ ] Phase E: Core Swim React Pages

<!-- parallelizable: true -->
<!-- Can start after Step D.3 exposes /api/swim/meets endpoint -->
<!-- File set: athlete-platform-spa/src/features/swim/ — no overlap with Phase D .NET files -->

* [ ] Step E.1: Implement swim meet list + detail pages with TanStack Query
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1388–1440)
* [ ] Step E.2: Implement heat sheet grid view component
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1442–1500)
* [ ] Step E.3: Implement result entry form component
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1502–1550)
* [ ] Step E.4: Implement athlete management pages (list, add, edit)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1552–1600)

### [ ] Phase F: Admin Authorization + Admin Features API

<!-- parallelizable: false -->
<!-- Depends on Phase D (all swim API endpoints must exist before admin layer is added) -->

* [ ] Step F.1: Implement `SwimMeetAdminHandler`, `TeamAdminHandler`, `LeagueAdminHandler` (IAuthorizationHandler pattern with HttpContext.Items caching)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1603–1665)
* [ ] Step F.2: Implement admin swim meet endpoints (PUT/DELETE with admin gate)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1667–1720)
* [ ] Step F.3: Implement heat sheet event CRUD + resequencing + seeding + lane management admin endpoints
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1722–1800)
* [ ] Step F.4: Implement scoring scheme admin endpoints (season + dual/championship scheme pair)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1802–1850)
* [ ] Step F.5: Implement approval workflow admin endpoints (TeamLeagueRequest, SwimmerTeamRequest)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1852–1900)
* [ ] Step F.6: Implement React admin pages (heat grid with @dnd-kit sortable, seeding AlertDialog, scoring Zod form)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1902–1980)
* [ ] Step F.7: Write unit tests for admin authorization handlers
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 1982–2025)
* [ ] Step F.8: Validate Phase F (build + admin unit tests)
  * Run `dotnet test SwimDomain.Tests/SwimDomain.Tests.csproj --filter Category=Admin`; fix failures

### [ ] Phase G: Organization Features (League, Team, Location)

<!-- parallelizable: false -->
<!-- Depends on Phase D (platform repositories must exist); can start after Phase F or in parallel if independent endpoints -->

* [ ] Step G.1: Implement League/Season API (`/api/leagues`, `/api/leagues/{id}/seasons`) + unit tests
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2028–2090)
* [ ] Step G.2: Implement Team API (`/api/teams`) + unit tests
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2092–2145)
* [ ] Step G.3: Implement athlete join request workflow API (`/api/teams/{id}/join-requests`) + unit tests
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2147–2200)
* [ ] Step G.4: Implement Location/Pool/PoolConfig API (`/api/locations`, `/api/pools`) + unit tests
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2202–2250)
* [ ] Step G.5: Implement React organization pages (league list, team detail, join request flows, location/pool management)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2252–2310)

### [ ] Phase H: Track & Field Scaffolding

<!-- parallelizable: true -->
<!-- Can run in parallel with Phase G; different files (TrackField.Domain project + tf.* schema) -->
<!-- File set: TrackField.Domain/, db/migrations/V0xx__tf_schema.sql, athlete-platform-spa/src/features/tf/ -->

* [ ] Step H.1: Create `TrackField.Domain` class library project + `TrackFieldModule : ISportModule` stub
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2313–2360)
* [ ] Step H.2: Create `tf.*` schema stub migrations (TFMeet, TFMeetConfig, TFEvent, TFResult with MeasurementType)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2362–2420)
* [ ] Step H.3: Generalize `dbo.Result` — add `MeasurementType` and `MeasurementValue` columns via DbUp migration
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2422–2460)
* [ ] Step H.4: Add T&F route placeholder in React SPA + update `App.tsx` module registration
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2462–2495)
* [ ] Step H.5: Register `TrackFieldModule` in `Program.cs` (disabled until T&F features are implemented)
  * Details: .copilot-tracking/details/2026-06-23/multisport-saas-details.md (Lines 2497–2520)

### [x] Phase I: Final Validation

<!-- parallelizable: false -->
<!-- Runs after all implementation phases; iterates on discovered issues -->
<!-- COMPLETED: 2026-06-24 — all validations passing -->

* [x] Step I.1: Run full .NET solution build (`dotnet build AthletePlatform.sln`)
* [x] Step I.2: Run full unit test suite (`dotnet test --verbosity normal`)
* [x] Step I.3: Run TypeScript type check (`npm run type-check` in athlete-platform-spa)
* [x] Step I.4: Run React lint (`npm run lint` in athlete-platform-spa)
* [x] Step I.5: Verify Bicep IaC compiles (`az bicep build --file infra/main.bicep`)
* [x] Step I.6: Fix minor validation issues discovered in Steps I.1–I.5
* [x] Step I.7: Document any blocking issues requiring additional research and planning

## Planning Log

See .copilot-tracking/plans/logs/2026-06-23/multisport-saas-log.md for discrepancy tracking, implementation paths considered, and suggested follow-on work.

## Dependencies

* .NET 9 SDK
* Node.js 20 LTS + npm
* Azure CLI (`az`) with Bicep extension
* Auth0 tenant (free tier) with Management API access
* GitHub repository with Actions enabled
* Azure subscription (Contributor role on resource group)
* DbUp NuGet package (`DbUp-SqlServer`)
* xUnit + Moq NuGet packages (test projects)

### NuGet Packages (API)
* `Microsoft.AspNetCore.Authentication.JwtBearer`
* `Dapper`
* `Microsoft.Data.SqlClient`
* `Microsoft.ApplicationInsights.AspNetCore`
* `dbup-sqlserver`
* `Serilog.AspNetCore` + `Serilog.Sinks.ApplicationInsights`
* `Microsoft.AspNetCore.Authorization`

### npm Packages (SPA)
* `@auth0/auth0-react`
* `@tanstack/react-query` v5
* `react-router-dom` v7
* `@radix-ui/react-*` (via shadcn/ui)
* `tailwindcss`
* `zod`
* `@dnd-kit/core` ^6.x, `@dnd-kit/sortable` ^8.x, `@dnd-kit/modifiers` ^7.x

## Success Criteria

* All DbUp migrations apply cleanly to a fresh Azure SQL database — Traces to: SaaS foundation requirement
* JWT from Auth0 correctly resolves `TenantId` via `TenantResolutionMiddleware`; RLS blocks cross-tenant data — Traces to: tenancy isolation requirement
* `SwimModule` controller endpoints respond with tenant-scoped data — Traces to: core swim features requirement
* `TrackFieldModule` registered with empty controllers compiles without error — Traces to: T&F scaffolding requirement
* All unit tests pass for service, handler, and middleware logic — Traces to: testing requirement
* Grafana Cloud dashboard shows per-tenant request count from Application Insights — Traces to: observability requirement
* GitHub Actions deploys API to App Service and SPA to Static Web Apps on `main` push — Traces to: CI/CD requirement
* `az bicep build infra/main.bicep` exits 0 — Traces to: IaC requirement
