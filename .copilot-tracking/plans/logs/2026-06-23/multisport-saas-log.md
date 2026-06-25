<!-- markdownlint-disable-file -->
# Planning Log: Multi-Sport SaaS Platform (Phases 0–3 + T&F Scaffold)

## Discrepancy Log

### Unaddressed Research Items

* DR-01: `Result` table generalization is listed in research as a "critical prerequisite" before T&F development
  * Source: .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md — Result Generalization section
  * Resolution: Addressed in Phase H, Step H.3 — V041 migration adds `MeasurementType` + `MeasurementValue` with `DEFAULT 'Time'` so existing swim rows are unaffected; swim stored procedures updated to pass explicit `MeasurementType = 'Time'`
  * Impact: none (addressed)

* DR-02: Research recommends "escape hatch" in `IConnectionFactory` for per-tenant connection string overrides (when a tenant outgrows shared schema)
  * Source: .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md — Tenancy Strategy section
  * Reason: Not in scope for Phase 0–3; single shared Azure SQL is appropriate for early stage
  * Resolution: `IDbConnectionFactory` interface is defined such that a future implementation can accept per-tenant connection strings without changing repository code
  * Impact: low (no rework needed; interface is already the extension point)

* DR-03: Research recommends `spSwimmerTeamRequestSave` / `spSwimmerTeamRequestApprove` naming — the existing Swimomatic stored procedure uses `Swimmer` terminology; plan uses `AthleteTeamRequest` naming
  * Source: .copilot-tracking/research/2026-06-23/swimomatic-modernization-research.md — SwimmerController section
  * Reason: `Swimmer` is renamed to `Athlete` throughout; stored procedures follow new naming
  * Impact: low (naming only; no functional change)

* DR-04: Research mentions DbUp/Flyway rolling migrations with live tenants
  * Source: .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md — Potential Next Research section
  * Reason: Single production environment + early stage — no live tenant impact during migrations at this stage
  * Impact: low (deferred to WI-03)

* DR-05: Auth0 Management API for programmatic Organization creation during tenant onboarding
  * Source: .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md — Recommended Next Research
  * Reason: Tenant onboarding is manual at early stage (set `app_metadata.tenantId` via Auth0 dashboard); this step is documented in Step B.4
  * Impact: low (manual onboarding is acceptable pre-revenue)

* DR-06: CORS pipeline order is incorrect in Step B.8 — **RESOLVED**
  * Fix applied: `app.UseCors("SpaOrigin")` moved to immediately after `app.UseRouting()`, before `app.UseAuthentication()`. Correct order in details Step B.8: `UseRouting → UseCors → UseAuthentication → UseAuthorization → TenantResolution → MapControllers`

* DR-07: DbUp `EmbeddedResource` path — **RESOLVED**
  * Fix applied: Changed `<EmbeddedResource Include="db\migrations\**\*.sql" />` to `<EmbeddedResource Include="..\db\migrations\**\*.sql" />` in Step A.4 details.

* DR-08: `GET /api/tenant` endpoint missing — **RESOLVED**
  * Fix applied: Added `dbo.TenantSport` join table DDL to B.1 schema; added new Step B.9 implementing `TenantController.GetTenantConfig()` + `ITenantRepository.GetConfigAsync()` + `spTenantGetConfig` stored procedure. Plan updated to include Step B.9 with Step B.9 (tests) renumbered to B.10.

* DR-09: Platform controllers in `Platform.Infrastructure` not discoverable — **RESOLVED**
  * Fix applied: All platform controllers (LeaguesController, TeamsController, LocationsController, LeagueRequestsController, TeamRequestsController) moved to `AthletePlatformAPI/Controllers/` in Steps G.1–G.5 and F.5 of the details file. Services remain in `Platform.Infrastructure/Services/`.

* DR-10: `VITE_AUTH0_AUDIENCE` missing from GitHub Actions SPA workflow — **RESOLVED**
  * Fix applied: Added `VITE_AUTH0_AUDIENCE: ${{ secrets.VITE_AUTH0_AUDIENCE }}` to the SPA workflow `env:` block in Step A.3 details.

* DR-11: `spSwimResultSave` update after `dbo.Result` generalization (H.3) has no dedicated step (minor — new finding)
  * Source: db/migrations/V022__result_sprocs.sql (D.5) creates `spSwimResultSave` before `MeasurementType` column exists; H.3 migration V041 adds the column and comments "handled in spSwimResultSave"
  * Reason: DR-01 resolution states "swim stored procedures updated to pass explicit `MeasurementType = 'Time'`" but no migration script or step implements this update. After H.3 runs, `spSwimResultSave` still does not pass `MeasurementType` — new swim results will get the DEFAULT 'Time' constraint value implicitly, but the stored procedure is not updated to be explicit, which is the stated resolution of DR-01.
  * Required fix: Add a V042 (or amend V041) migration that ALTERs `spSwimResultSave` (and any other swim result stored procedures) to explicitly include `@MeasurementType NVARCHAR(20) = 'Time'` as a parameter
  * Impact: low — swim results continue to work via DEFAULT constraint; the gap is documentation accuracy and the future risk that a developer might misread the stored procedure as supporting multi-type results when it does not explicitly handle them

### Plan Deviations from Research

* DD-01: CORS position in pipeline — **RESOLVED**
  * Correct pipeline order `UseRouting → UseCors → UseAuthentication → UseAuthorization → TenantResolution → MapControllers` now reflected in Step B.8 of the details file.

* DD-02: Admin authorization handlers registered as `AddScoped` (not `AddSingleton`)
  * Research pattern shows handler registered without specifying lifetime
  * Plan registers as `AddScoped` because handlers call `IDbConnectionFactory.OpenAsync()` which is scoped
  * Rationale: Singleton services cannot consume Scoped services; handlers making DB calls MUST be Scoped
  * Impact: correctness fix — Singleton handler with Scoped dependency throws at runtime

* DD-03: `TenantResolutionMiddleware` in `InvokeAsync` uses `ITenantContext` from DI parameters, not constructor injection
  * Research code example has the middleware resolving ITenantContext from DI parameter `InvokeAsync(HttpContext ctx, ITenantContext tenantContext)`
  * Plan follows the same pattern — this is the correct ASP.NET Core approach for scoped services in middleware
  * Rationale: Scoped services cannot be injected into middleware constructor (middleware is Singleton); they must be injected into `InvokeAsync` method parameters
  * Impact: correctness confirmation

* DD-04: `AthletesController` placed in `AthletePlatformAPI/Controllers/` rather than `SwimDomain`
  * Research places athlete management under platform primitives, not a sport domain
  * Plan places `AthletesController` in the platform host, not `SwimDomain`
  * Rationale: Athletes are platform-level entities (shared across sports); placing them in SwimDomain would require every sport to duplicate the controller
  * Impact: correct architectural decision; consistent with research intent

* DD-05: Grafana Cloud free tier used instead of Azure Managed Grafana
  * Research mentions "Grafana dashboards" without specifying which Grafana product
  * Plan implements: Grafana Cloud free tier + Azure Monitor data source plugin
  * Rationale: Azure Managed Grafana costs ~$199/month (Standard tier); Grafana Cloud free tier provides equivalent dashboard capability at zero cost. Service Principal with Monitoring Reader role provides read-only access
  * Impact: cost saving of ~$200/month with equivalent functionality at early stage

* DD-06: `ISportModule` missing `MapEndpoints` default method — **RESOLVED**
  * Fix applied: Added `default void MapEndpoints(WebApplication app) { }` to `ISportModule` interface in Step B.7 details. Controller-based sports (swim) call this no-op; future Minimal API sports can override.

* DD-07: `TenantIdTelemetryInitializer` adds only `TenantKey`, omits `TenantId` integer — **RESOLVED**
  * Fix applied: Step B.5 telemetry initializer now sets both `Properties["TenantKey"]` (slug) and `Properties["TenantId"]` (integer string) as custom dimensions.

* DD-08: `dbo.League` missing `SportId` FK — **RESOLVED**
  * Fix applied: `dbo.League` DDL in Step B.1 now includes `SportId INT NOT NULL REFERENCES dbo.Sport(SportId)`. `GET /api/leagues` can filter by `?sport=swim` at the SQL level.

* DD-09: `dbo.AthleteTeamSeason` missing `SportID` FK recommended by subagent research
  * Research recommends: multisport-domain-extensibility-research.md adds `SportID INT FK → Sport.SportID` to `AthleteTeamSeason` so sport-specific roster queries (`WHERE SportID = @SwimSportID`) are direct; without it, sport must be resolved through the TeamSeason → Season → League chain
  * Plan implements: `dbo.AthleteTeamSeason` in Step B.1 has no `SportID`; plan follows swimomatic-saas-multisport-research.md which states "no SportID needed — TeamSeason → Season → League → Sport resolves via join"
  * Rationale: primary research explicitly justifies the omission via join traversal; subagent research adds SportID for query efficiency
  * Impact: low for Phase 0–3 (single-sport queries are fast via join); medium when T&F is live and sport-filtered roster reports are needed; acceptable deferral; should be added as WI item

---

## Implementation Paths Considered

### Selected: Monorepo .NET Class Libraries + Single App Service

* Approach: `SwimDomain.csproj` + `TrackField.Domain.csproj` as class libraries, referenced by a single `AthletePlatformAPI` host; deployed as one App Service
* Rationale: Appropriate for 1-developer team; no operational overhead; sport module isolation via `ISportModule` interface without microservice complexity; all research sources confirm this
* Evidence: .copilot-tracking/research/subagents/2026-06-23/multisport-domain-extensibility-research.md — Sport Module Architecture section

### IP-01: Microservices per Sport Domain

* Approach: Separate .NET 9 WebAPI per sport (`swim-api`, `tf-api`) behind an Azure API Gateway
* Trade-offs: Independent scaling, independent deployment; BUT requires API Gateway (~$200/mo APIM), separate deployments, cross-service auth (each service validates JWT), shared infrastructure complexity
* Rejection rationale: 1-developer team; no divergent scaling requirements at early stage; adds $200+/mo infra cost; research explicitly recommends against this until independent scaling is needed

### IP-02: Vertical Slice Architecture (All Sport Code in One Project)

* Approach: Single `AthletePlatformAPI` project with `Features/Swim/` and `Features/TrackField/` folder slices; no separate class library projects
* Trade-offs: Simpler project structure; fewer .csproj files; BUT no clear module boundary — a developer CAN reference swim types from platform layers by accident; harder to extract to microservice later
* Rejection rationale: Class library boundaries enforce the ISportModule contract; compile-time isolation is valuable when adding 3rd/4th sports

### IP-03: Auth0 Organizations from Day One

* Approach: Use Auth0 Organizations for multi-tenancy from the start
* Trade-offs: Native multi-tenant; `org_id` claim; BUT requires Professional tier ($240/month)
* Rejection rationale: Pre-revenue; custom claim via Post-Login Action achieves the same isolation at zero cost; migration to Organizations is mechanical (change claim name read in middleware)

### IP-04: Azure Managed Grafana

* Approach: Azure Managed Grafana resource connected to Application Insights
* Trade-offs: Fully managed; Azure AD integration; Managed Identity auth; BUT ~$199/month Standard tier
* Rejection rationale: Grafana Cloud free tier is functionally equivalent for dashboards; saves $199/month at early stage; Service Principal auth to Azure Monitor is a documented, supported pattern

---

## Suggested Follow-On Work

Items identified during planning that fall outside current scope.

* WI-01: Auth0 Organizations migration — Replace custom `tenant_id` claim with Auth0 Organizations + `org_id` at commercial launch (High)
  * Source: .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md
  * Dependency: Phase 0–3 plan complete; revenue sufficient for Professional tier ($240/mo)

* WI-02: T&F full implementation — Implement `TrackField.Domain` controllers, services, repositories; `tf.*` schema complete with Flight, FieldAttempt, T&F-specific result entry (High)
  * Source: .copilot-tracking/research/subagents/2026-06-23/multisport-domain-extensibility-research.md
  * Dependency: Phase H scaffolding complete (WI-02 builds directly on T&F stubs)

* WI-03: Zero-downtime DbUp migrations — Implement backward-compatible migration strategy for future schema changes with live tenants (Medium)
  * Source: .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md — Potential Next Research
  * Dependency: First live tenant onboarded

* WI-04: Integration tests (TestContainers) — Add `SwimDomain.IntegrationTests` project using TestContainers with SQL Server container to test repository + stored procedure integration (Medium)
  * Source: User selected unit-tests-only as a simplification; integration tests are the natural next step
  * Dependency: Phase D complete

* WI-05: Azure SQL Elastic Pool migration — Move shared database to Elastic Pool when tenant count reaches 10–15 (Low)
  * Source: .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md
  * Dependency: Tenant count growth milestone

* WI-06: Tenant self-service onboarding — `POST /api/admin/tenants` API endpoint that creates `dbo.Tenant` row + calls Auth0 Management API to set `app_metadata.tenantId` for the tenant user (Medium)
  * Source: .copilot-tracking/research/subagents/2026-06-23/saas-tenancy-azure-research.md — tenant onboarding automation
  * Dependency: Phase B complete

* WI-07: Per-tenant `enabledSports` configuration — API and admin UI for a platform admin to enable/disable sport modules per tenant (Medium)
  * Source: .copilot-tracking/research/2026-06-23/swimomatic-saas-multisport-research.md — Potential Next Research
  * Dependency: Phase H (T&F scaffolding shows why this is needed)

* WI-08: Multi-sport athlete results page — `useQueries` TanStack pattern to aggregate swim times + T&F marks on one athlete profile page (Low)
  * Source: .copilot-tracking/research/subagents/2026-06-23/multisport-domain-extensibility-research.md
  * Dependency: WI-02 (T&F must be implemented)

* WI-09: Browser print views — CSS `@media print` styles for heat sheets and meet results replacing ActiveReports PDF export (Medium)
  * Source: .copilot-tracking/research/2026-06-23/swimomatic-modernization-research.md — Phase 6 Deferred
  * Dependency: Phase E (React heat sheet pages must exist)

* WI-10: Azure App Service deployment slots — staging → production swap for zero-downtime deploys (Low)
  * Source: .copilot-tracking/research/2026-06-23/swimomatic-modernization-research.md — Potential Next Research
  * Dependency: Phase A CI/CD pipeline complete; warrants staging environment decision
