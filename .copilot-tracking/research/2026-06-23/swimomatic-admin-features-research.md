<!-- markdownlint-disable-file -->
# Task Research: Swimomatic Admin Features

Research for the admin feature set of the Swimomatic modernization, consistent with the architecture decisions documented in `swimomatic-modernization-research.md`. Admin features were explicitly deferred to Phase 5 of the original plan; this document provides the full API design, authorization model, React SPA structure, and implementation patterns for them.

## Task Implementation Requests

* Research and document the full admin feature set as found in the existing codebase
* Map admin controller actions to .NET 9 WebAPI endpoints
* Define per-entity authorization model for admin operations
* Design React SPA admin pages consistent with the core feature SPA structure
* Document scoring scheme administration (per-season, per-meet-type)
* Document approval workflow administration (TeamLeagueRequest, SwimmerTeamRequest)
* Document reference data administration (Locations, Pools, PoolConfigs, AgeClassRules)
* Document heat sheet administration (event CRUD, heat CRUD, swimmer seeding, lane management)

## Scope and Success Criteria

* Scope: All admin-gated operations across all controllers; reference data management; scoring configuration; approval workflows; heat sheet administration
* Assumptions:
  * Same stack as core: .NET 9 WebAPI + Dapper + React + TanStack Query + shadcn/ui
  * Per-entity admin roles remain in Azure SQL (`UserTeam.IsAdmin`, `UserLeague.IsAdmin`, `UserSwimMeet.IsAdmin`)
  * Auth0 RBAC does NOT replace per-entity admin — custom `IAuthorizationHandler` checks DB per-entity
  * All existing admin operations from ASP.NET MVC controllers are preserved in functionality
* Success Criteria:
  * Complete admin API endpoint surface area
  * Per-entity authorization handler patterns for all admin resources
  * React admin page structure in feature-sliced architecture
  * Scoring scheme administration fully mapped
  * Approval workflow endpoints and React flows fully mapped
  * Reference data (Location/Pool/PoolConfig) admin endpoints fully mapped
  * Heat sheet administration (events, heats, seeding, lane management) fully mapped

## Outline

1. Admin feature inventory (from codebase analysis)
2. Authorization model — per-entity admin via custom handlers
3. Admin API endpoint surface area (all controllers)
4. Heat sheet administration API detail
5. Scoring scheme administration API detail
6. Approval workflow API detail
7. Reference data administration API detail
8. React SPA admin pages structure
9. Technical scenarios with examples

## Admin Feature Inventory (from codebase analysis)

### Admin Scope Types Identified
| Scope | Flag | Table | Who Gets It |
|-------|------|-------|-------------|
| Swim Meet Admin | `IsAdmin` | `UserSwimMeet` | Created by user who created the swim meet + all team admins of participating teams |
| Team Admin | `IsAdmin` | `UserTeam` | User who created the team (via `SaveUserTeam` on `SaveTeam`) |
| League Admin | `IsAdmin` | `UserLeague` | User who created the league (via `SaveUserLeague` on `SaveLeague`) |

### Admin-Gated Operations by Domain

#### Swim Meet Admin
| Operation | Controller | Method | Notes |
|-----------|-----------|--------|-------|
| Edit swim meet | SwimMeetController | `SaveSwimMeet` | `CanEdit = StartDate > DateTime.Today && IsAdmin` |
| Delete swim meet | SwimMeetController | `DeleteSwimMeet` | Only if no results exist |
| Create heat sheet | HeatSheetController | `HeatSheets` (admin check) | `vhsl.IsAdmin` gated |
| Add/delete heats | HeatSheetController | `AddHeat`, `DeleteHeat` | Delete blocked if results exist |
| Add/remove heat sheet events | HeatSheetController | `HeatSheetEvent`, `DeleteHeatSheetEvent` | Delete blocked if results exist |
| Add/remove swimmers from heats | HeatSheetController | `AddHeatSwimmer`, `RemoveHeatSwimmer` | |
| Resequence heat sheet events | HeatSheetController | `ResequenceHeatSheetEvents` | POST with ordered ID list |
| Move swimmers between lanes | HeatSheetController | `IncrementLane` | Swap logic for individual and relay events |
| Seed heat sheet event | HeatSheetController | (implied from `SeedHeatSheetEvent`) | Business manager complex algorithm |

#### League Admin
| Operation | Controller | Method | Notes |
|-----------|-----------|--------|-------|
| Edit league | LeagueController | `SaveLeague` | |
| Create/edit season | LeagueController | `SaveSeason` | Includes scoring schemes per season per meet type |
| View/approve team league requests | LeagueController | `TeamLeagueRequests`, `ApproveRequest` | Creates TeamSeason on approval |

#### Team Admin
| Operation | Controller | Method | Notes |
|-----------|-----------|--------|-------|
| Edit team | TeamController | `SaveTeam` | |
| View/approve swimmer team requests | TeamController | `SwimmerTeamRequests`, `ApproveRequest` | Creates SwimmerTeamSeason on approval |
| View team seasons | TeamController | `TeamSeasons` | |
| View swimmer team seasons | TeamController | `SwimmerTeamSeasons` | |

#### Reference Data Admin (Any Authenticated User — Creator-Owned)
| Operation | Controller | Method | Notes |
|-----------|-----------|--------|-------|
| Create/edit location | LocationController | `SaveLocation` | Audit trail: CreatedByUserID, ModifiedByUserID |
| Create/edit pool | LocationController | `SavePool` | |
| Create/edit pool config | LocationController | `SavePoolConfig` | |

### Season Scoring Scheme Configuration (complex)
Season admin requires saving:
1. Season (dates, description, AgeClassRuleID, optional AgeClassRuleCustomDate)
2. Two ScoringScheme records: Dual-Triangle (SwimMeetTypeID=1) and Invitational-Championship (SwimMeetTypeID=3)
3. Two SeasonScoringScheme records linking above

Fields per scoring scheme:
- `IndividualPoints`: comma-delimited string (e.g., "6,4,3,2")
- `RelayPoints`: comma-delimited string (e.g., "12,8,6,4")

### Heat Generation Algorithm (complex — stay in service layer)
`SeedHeatSheetEvent` in `SwimomaticBusinessManager` is a complex seeding algorithm:
1. Get swimmers grouped by team, sorted by seed time (fastest first; 0-time swimmers last)
2. Calculate available lanes per team per heat
3. Determine if new heats are needed (relay: count/4; individual: count)
4. Assign swimmers to heats in order: fastest swimmers go to higher-numbered heats (slowest heats first for seeding purposes, fastest heat is the last heat number)
5. Relay: assign 4 swimmers per lane per relay group

### Lane Swap Logic (complex — stay in service layer)
`IncrementHeatSwimmerLane`: Swaps lanes between two individual swimmers using a -1 temp value to avoid constraint violations. `IncrementHeatSwimmerLaneForRelay`: Moves all 4 swimmers in a relay lane together, swapping with the destination lane's relay group.

## Potential Next Research

* Auth0 JWT `.sub` claim mapping to `ClaimTypes.NameIdentifier` in .NET 9 — verify the exact claim type used (Auth0 may use `nameidentifier` rather than the full `ClaimTypes.NameIdentifier` URI)
* Dapper `QueryMultiple` for batched admin status queries (check multiple resources in one DB round-trip)
* `PATCH` resequence endpoint payload design: ordered IDs array vs `{ id, sortOrder }` object array
* `@dnd-kit/modifiers` auto-scroll for long heat-sheet event lists
* Pool config lane count flow into `HeatGrid` column headers (how PoolConfig.LaneCount drives grid width)
* Relay leg display — how to render legs 1–4 within a single lane cell in the heat grid
* Concurrent admin edit conflicts — ETag/optimistic locking strategy or SignalR for multi-admin scenarios

## Research Executed

### File Analysis

* SwimomaticMVC\Controllers\HeatSheetController.cs
  * Admin check for heat sheet creation: `swimMeets.Where(vl => vl.SwimMeetID == SwimMeetID && vl.IsAdmin)` — IsAdmin from UserSwimMeet
  * Admin-gated: AddHeat, DeleteHeat, AddHeatSwimmer, RemoveHeatSwimmer, IncrementLane, ResequenceHeatSheetEvents, DeleteHeatSheetEvent, HeatSheetEvent (CRUD)
  * DataCache pattern (`DataCache.Get<T>("Heats" + HeatSheetEventID, ...)`) — replaced by TanStack Query cache in React

* SwimomaticMVC\Controllers\SwimMeetController.cs
  * `CanEdit = swimMeet.StartDate > DateTime.Today && swimMeet.IsAdmin`
  * `SaveSwimMeet`: delete all SwimMeetTeams then re-insert (no partial update)
  * `DeleteSwimMeet`: guarded in BizMgr — only if no results exist
  * When a new swim meet is saved, `UserSwimMeet` records are auto-created for all team admins of participating teams

* SwimomaticMVC\Controllers\LeagueController.cs
  * `GetSeasons`: `vss.IsAdmin = leagues.Where(l => l.LeagueID == LeagueID && l.IsAdmin).Count() > 0`
  * `SaveSeason`: saves season + two ScoringSchemes + two SeasonScoringSchemes (Dual/Triangle and Invitational/Championship)
  * `ApproveRequest`: creates `TeamSeason` record on approval

* SwimomaticMVC\Controllers\TeamController.cs
  * `ApproveRequest`: creates `SwimmerTeamSeason` record on approval
  * `SaveTeam`: calls `SaveUserTeam` immediately after save (creator becomes admin)

* SwimomaticMVC\Controllers\LocationController.cs
  * `SaveLocation`: audit trail CreatedByUserID/ModifiedByUserID
  * `SavePool` + `SavePoolConfig`: single action creates both Pool and PoolConfig together
  * Location search with `Merge=1` returns union of user's locations + searched locations

* SwimomaticBusinessLib\SwimomaticBusinessManager.cs (admin methods)
  * `ApproveSwimmerTeamRequest` (line 1559): marks request approved, creates SwimmerTeamSeason
  * `ApproveTeamLeagueRequest` (line 1587): marks request approved, creates TeamSeason
  * `DeleteSwimMeet` (line 1141): guarded — only deletes if no results
  * `DeleteHeat` (line 608): re-sequences remaining heats after delete
  * `DeleteHeatSheetEvent` (line 666): transactional — deletes HeatSwimmers, Heats, HeatSheetEvent, then resequences
  * `SeedHeatSheetEvent`: complex assignment algorithm — team-grouped, fastest-first, relay-aware
  * `IncrementHeatSwimmerLane`/`IncrementHeatSwimmerLaneForRelay`: swap logic with -1 temp lane

### Project Conventions

* Standards referenced: existing core feature research in `swimomatic-modernization-research.md`
* Instructions followed: feature-sliced React architecture, Dapper repository pattern, Auth0 JWT + custom IAuthorizationHandler for per-entity admin

## Key Discoveries

### Authorization Model

The existing app uses three `IsAdmin` flags — one per relationship table:
- `UserSwimMeet.IsAdmin` — implied from `swimMeet.IsAdmin` returned from `SwimMeetGetAllBySystemUserID` stored procedure
- `UserTeam.IsAdmin` — present in entity from `TeamGetAllBySystemUserID`
- `UserLeague.IsAdmin` — present in entity from `LeagueGetAllBySystemUserID`

In the modernized app, these flags are checked via custom `IAuthorizationHandler` implementations that query the DB using the Auth0 sub claim as user identifier.

**Key finding:** With endpoint routing in .NET 9, `context.Resource` inside an `AuthorizationHandler` IS the `HttpContext` — cast directly to access `RouteValues`. `IHttpContextAccessor` is not needed in the handler. Use `HttpContext.Items` to cache the admin check result within a single request — not `IMemoryCache`.

**`[Authorize(Policy)]` runs after routing but before model binding** — always put admin resource IDs in route parameters, never the request body, to prevent authorization bypass.

### Auth0 `.sub` Claim Mapping
Auth0 access tokens use the `sub` claim for user identity. In .NET 9 with `JwtBearerDefaults`, this maps to `ClaimTypes.NameIdentifier` automatically. Verify in integration tests — Auth0 Management API tokens vs. access tokens may differ.

### Swim Meet Auto-Admin Assignment
When a new swim meet is created, `UserSwimMeet` records are auto-created for ALL team admins of ALL participating teams. Multiple users can be admins of a single swim meet. This logic must be preserved in `SwimMeetService.CreateAsync`.

### Heat Sheet Admin Scope
Heat sheet admin is scoped to the swim meet's admin list — no separate `HeatSheet.IsAdmin`. Any swim meet admin can administer any heat sheet for that meet.

### Deletion Guards
All delete operations have data-integrity guards:
- `DeleteSwimMeet`: blocked if any results exist for the meet → **HTTP 409 Conflict**
- `DeleteHeat`: blocked if any result exists for any swimmer in the heat; re-sequences surviving heats → **HTTP 409 Conflict**
- `DeleteHeatSheetEvent`: transactional (HeatSwimmers → Heats → HeatSheetEvent); blocked if results exist; re-sequences surviving events → **HTTP 409 Conflict**

Use `ProblemDetails` (RFC 7807) for 409 responses: `return Conflict(new ProblemDetails { Title = "Cannot delete — results exist", Status = 409 })`. Note: `Results.Problem()` is Minimal API only; use `Conflict(new ProblemDetails {...})` in controller-based WebAPI.

### Dapper Transaction Pattern for Admin Operations
Multiple admin operations require transactions. Use explicit `BeginTransactionAsync()` on a single `SqlConnection`. Avoid `TransactionScope` — without `TransactionScopeAsyncFlowOption.Enabled` it silently loses context across `await` boundaries. Extract a `DapperTransactionRunner` helper to avoid nested `using` pyramids. Repositories accept `(IDbConnection conn, IDbTransaction tx)` parameters and are stateless.

Transactional admin operations:
- `SaveSeason`: Season + two ScoringSchemes + two SeasonScoringSchemes (4 operations)
- `DeleteHeatSheetEvent`: HeatSwimmers → Heats → HeatSheetEvent + resequence (3+ operations)
- `ApproveTeamLeagueRequest`: update request + create TeamSeason (2 operations)
- `ApproveSwimmerTeamRequest`: update request + create SwimmerTeamSeason (2 operations)

### Heat Grid UI Architecture
- Use `<table>` (not CSS Grid) — native ARIA semantics (`role="grid"`) are free; shadcn/ui `Table` wraps cleanly
- Track `activeCell: { heatId, lane } | null` in parent `HeatGrid` state — prop drilling 2 levels is fine for ≤48 cells
- Use `Dialog` for swimmer assignment (not `Popover`) — swimmer lists can be long, modal keeps focus trapped
- Lane swap: **do NOT debounce** — it is a discrete click; disable arrow button via `isPending` to prevent double-fire

### Drag-and-Drop Event Resequencing
Use `@dnd-kit/sortable` for heat sheet event reorder:
- Spread `{...listeners}` only on a drag handle `<button>`, not the entire row — rest of row stays clickable for navigation
- `KeyboardSensor` + `sortableKeyboardCoordinates` gives WCAG 2.1-compliant keyboard navigation
- Use `restrictToVerticalAxis` modifier from `@dnd-kit/modifiers` to prevent horizontal drift
- Fire API call only in `onDragEnd` — `onDragMove` fires hundreds of times per drag

### Admin Permission Gating in React
- Put `swimMeetId` in React context; leaf components call `useSwimMeetAdmin(swimMeetId)` which derives `isAdmin` from cached TanStack Query data — no extra network calls
- Route-level admin guard: use React Router v7 `loader` to redirect non-admins before component render
- Client-side hiding is UX; server `[Authorize(Policy = "SwimMeetAdmin")]` is the real security gate
- Admin status is per-resource — global React context is wrong; per-query derived state is correct

### DataCache Replacement
MVC uses `DataCache.Get<T>(key, factory)` for heat sheet data. TanStack Query handles client-side caching in the modernized app. Server-side `IMemoryCache` can be added for read-heavy heat sheet reads if needed.

## Technical Scenarios

### Scenario 1: Per-Entity Admin Authorization in .NET 9

**Description:** Custom `IAuthorizationHandler` implementations that check the `UserSwimMeet`, `UserTeam`, and `UserLeague` tables using the Auth0 sub claim as the user identifier.

**Requirements:**
* Retrieve userId from JWT `sub` claim (maps to `ClaimTypes.NameIdentifier` in .NET 9 with JwtBearer)
* Extract resource ID from route parameters via `context.Resource as HttpContext`
* Check relevant DB table for `IsAdmin` flag
* Three separate handlers: `SwimMeetAdminHandler`, `TeamAdminHandler`, `LeagueAdminHandler`
* Cache admin check result in `HttpContext.Items` for the request scope

**Preferred Approach:**

```csharp
// Infrastructure/Authorization/SwimMeetAdminRequirement.cs
public record SwimMeetAdminRequirement : IAuthorizationRequirement;

// Infrastructure/Authorization/SwimMeetAdminHandler.cs
// NOTE: context.Resource IS the HttpContext with endpoint routing in .NET 9 — no IHttpContextAccessor needed
public class SwimMeetAdminHandler(IUserSwimMeetRepository repo)
    : AuthorizationHandler<SwimMeetAdminRequirement>
{
    protected override async Task HandleRequirementAsync(
        AuthorizationHandlerContext context,
        SwimMeetAdminRequirement requirement)
    {
        var userId = context.User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (userId is null) return;

        var httpContext = context.Resource as HttpContext;
        if (httpContext?.Request.RouteValues.TryGetValue("swimMeetId", out var idObj) is true
            && int.TryParse(idObj?.ToString(), out var swimMeetId))
        {
            // Cache per-request to avoid duplicate DB calls (e.g. middleware + handler)
            var cacheKey = $"SwimMeetAdmin:{userId}:{swimMeetId}";
            if (!httpContext.Items.TryGetValue(cacheKey, out var cached))
            {
                cached = await repo.IsAdminAsync(userId, swimMeetId);
                httpContext.Items[cacheKey] = cached;
            }
            if ((bool)cached!) context.Succeed(requirement);
        }
    }
}
```

```csharp
// Program.cs
builder.Services.AddScoped<IAuthorizationHandler, SwimMeetAdminHandler>();
builder.Services.AddScoped<IAuthorizationHandler, TeamAdminHandler>();
builder.Services.AddScoped<IAuthorizationHandler, LeagueAdminHandler>();
builder.Services.AddAuthorization(options => {
    options.AddPolicy("SwimMeetAdmin", p => p.Requirements.Add(new SwimMeetAdminRequirement()));
    options.AddPolicy("TeamAdmin", p => p.Requirements.Add(new TeamAdminRequirement()));
    options.AddPolicy("LeagueAdmin", p => p.Requirements.Add(new LeagueAdminRequirement()));
});
// NOTE: services.AddHttpContextAccessor() is NOT required for the handler (uses context.Resource cast)
// but IS needed if IHttpContextAccessor is injected elsewhere
```

```csharp
// Controllers/HeatSheetsController.cs (example admin-gated actions)
[Authorize(Policy = "SwimMeetAdmin")]
[HttpPost("{swimMeetId}/heatsheets/{heatSheetId}/events")]
public Task<IActionResult> AddHeatSheetEvent(int swimMeetId, int heatSheetId, AddHeatSheetEventRequest request) { }

[Authorize(Policy = "SwimMeetAdmin")]
[HttpDelete("{swimMeetId}/heatsheets/{heatSheetId}/events/{eventId}")]
public async Task<IActionResult> DeleteHeatSheetEvent(int swimMeetId, int heatSheetId, int eventId)
{
    var success = await _heatSheetService.DeleteEventAsync(eventId, ct);
    if (!success)
        return Conflict(new ProblemDetails
        {
            Title = "Cannot delete event — results exist",
            Status = StatusCodes.Status409Conflict
        });
    return NoContent();
}
```

**Considered Alternatives:**
* `IHttpContextAccessor` injected into the handler: Rejected — redundant in .NET 9 endpoint routing since `context.Resource as HttpContext` gives the same result without the extra service registration.
* Auth0 FGA (Fine-Grained Authorization): Supports entity-scoped relationships. Rejected — overkill for a small app; introduces Auth0 FGA SDK, separate data-store synchronization, and cost. Can be adopted if the app scales.
* Global role claims in JWT: Rejected — cannot express "admin of meet 42 but not meet 43".

### Scenario 2: Admin API Endpoint Surface Area

**Description:** Complete admin-only endpoint mapping for .NET 9 WebAPI.

#### Swim Meet Admin Endpoints (`/api/swimmeets/{swimMeetId}/...`)
| Method | Endpoint | Auth Policy | Notes |
|--------|----------|-------------|-------|
| PUT | `/api/swimmeets/{id}` | SwimMeetAdmin | Edit swim meet (future-dated only) |
| DELETE | `/api/swimmeets/{id}` | SwimMeetAdmin | Guarded: blocked if results exist |
| POST | `/api/swimmeets/{id}/heatsheets` | SwimMeetAdmin | Create heat sheet with PoolConfigID |
| POST | `/api/swimmeets/{swimMeetId}/heatsheets/{id}/events` | SwimMeetAdmin | Add HeatSheetEvent |
| PUT | `/api/swimmeets/{swimMeetId}/heatsheets/{id}/events/resequence` | SwimMeetAdmin | POST ordered event IDs |
| DELETE | `/api/swimmeets/{swimMeetId}/heatsheets/{hid}/events/{eid}` | SwimMeetAdmin | Guarded: blocked if results |
| POST | `/api/swimmeets/{swimMeetId}/heatsheets/{hid}/events/{eid}/heats` | SwimMeetAdmin | Add heat |
| DELETE | `/api/swimmeets/{swimMeetId}/heatsheets/{hid}/events/{eid}/heats/{heatId}` | SwimMeetAdmin | Guarded: blocked if results |
| POST | `/api/swimmeets/{swimMeetId}/heatsheets/{hid}/events/{eid}/seed` | SwimMeetAdmin | Trigger seeding algorithm |
| POST | `/api/swimmeets/{swimMeetId}/heats/{heatId}/swimmers` | SwimMeetAdmin | Add swimmer to heat lane |
| DELETE | `/api/swimmeets/{swimMeetId}/heats/{heatId}/swimmers/{heatSwimmerId}` | SwimMeetAdmin | Remove swimmer from lane |
| PUT | `/api/swimmeets/{swimMeetId}/heats/{heatId}/swimmers/{heatSwimmerId}/lane` | SwimMeetAdmin | Move lane (+1/-1), relay-aware |

#### League Admin Endpoints
| Method | Endpoint | Auth Policy | Notes |
|--------|----------|-------------|-------|
| PUT | `/api/leagues/{id}` | LeagueAdmin | Edit league |
| POST | `/api/leagues/{leagueId}/seasons` | LeagueAdmin | Create season + scoring schemes |
| PUT | `/api/leagues/{leagueId}/seasons/{id}` | LeagueAdmin | Edit season + scoring schemes |
| GET | `/api/leagues/{leagueId}/seasons/{id}/join-requests` | LeagueAdmin | Pending team requests |
| POST | `/api/leagues/{leagueId}/seasons/{id}/join-requests/{reqId}/approve` | LeagueAdmin | Approve → create TeamSeason |

#### Team Admin Endpoints
| Method | Endpoint | Auth Policy | Notes |
|--------|----------|-------------|-------|
| PUT | `/api/teams/{id}` | TeamAdmin | Edit team |
| GET | `/api/teams/{id}/seasons` | TeamAdmin | View team seasons |
| GET | `/api/teams/{id}/seasons/{tsId}/swimmers` | TeamAdmin | View swimmer team seasons |
| GET | `/api/teams/{id}/seasons/{tsId}/join-requests` | TeamAdmin | Pending swimmer requests |
| POST | `/api/teams/{id}/seasons/{tsId}/join-requests/{reqId}/approve` | TeamAdmin | Approve → create SwimmerTeamSeason |

#### Reference Data Endpoints (Authenticated — Creator-Ownership)
| Method | Endpoint | Auth | Notes |
|--------|----------|------|-------|
| POST | `/api/locations` | Authenticated | Creates location with CreatedByUserId audit |
| PUT | `/api/locations/{id}` | Authenticated + ownership | Updates with ModifiedByUserId audit |
| POST | `/api/locations/{locationId}/pools` | Authenticated | Creates Pool + PoolConfig together |
| PUT | `/api/locations/{locationId}/pools/{poolId}/configs/{configId}` | Authenticated | Edit pool config |

### Scenario 3: Season Scoring Scheme Administration

**Description:** Saving a season requires saving two scoring schemes and linking them. This is an atomic operation.

**Request DTO:**
```csharp
public record SaveSeasonRequest(
    int SeasonID,
    int LeagueID,
    string Description,
    DateOnly StartDate,
    DateOnly EndDate,
    int AgeClassRuleID,
    DateOnly? AgeClassRuleCustomDate,
    // Dual/Triangle scoring (SwimMeetTypeID=1)
    string DualTriangleIndividualPoints,   // "6,4,3,2"
    string DualTriangleRelayPoints,        // "12,8,6,4"
    // Invitational/Championship scoring (SwimMeetTypeID=3)
    string InvitationalIndividualPoints,
    string InvitationalRelayPoints
);
```

**Validation (Zod on React side):**
```tsx
const pointsPattern = /^\d+(,\d+)*$/;
const seasonSchema = z.object({
  description: z.string().min(1),
  startDate: z.string(),
  endDate: z.string(),
  ageClassRuleId: z.number(),
  dualTriangleIndividualPoints: z.string().regex(pointsPattern, "Format: 6,4,3,2"),
  dualTriangleRelayPoints: z.string().regex(pointsPattern, "Format: 12,8,6,4"),
  invitationalIndividualPoints: z.string().regex(pointsPattern),
  invitationalRelayPoints: z.string().regex(pointsPattern),
});
```

**Service layer transaction (Dapper):**
```csharp
public async Task<int> SaveSeasonAsync(SaveSeasonRequest request, CancellationToken ct)
{
    using var conn = _connectionFactory.CreateConnection();
    conn.Open();
    using var tx = conn.BeginTransaction();
    try {
        var seasonId = await conn.ExecuteScalarAsync<int>(
            "spSeasonSave", request.ToSeasonParams(), transaction: tx,
            commandType: CommandType.StoredProcedure);

        // Dual/Triangle scoring (SwimMeetTypeID = 1)
        var ssId1 = await conn.ExecuteScalarAsync<int>("spSchemeSave",
            new { IndividualPoints = request.DualTriangleIndividualPoints, RelayPoints = request.DualTriangleRelayPoints },
            transaction: tx, commandType: CommandType.StoredProcedure);
        await conn.ExecuteAsync("spSeasonSchemeSave",
            new { SeasonID = seasonId, ScoringSchemeID = ssId1, SwimMeetTypeID = 1 },
            transaction: tx, commandType: CommandType.StoredProcedure);

        // Invitational/Championship scoring (SwimMeetTypeID = 3)
        var ssId3 = await conn.ExecuteScalarAsync<int>("spSchemeSave",
            new { IndividualPoints = request.InvitationalIndividualPoints, RelayPoints = request.InvitationalRelayPoints },
            transaction: tx, commandType: CommandType.StoredProcedure);
        await conn.ExecuteAsync("spSeasonSchemeSave",
            new { SeasonID = seasonId, ScoringSchemeID = ssId3, SwimMeetTypeID = 3 },
            transaction: tx, commandType: CommandType.StoredProcedure);

        tx.Commit();
        return seasonId;
    }
    catch { tx.Rollback(); throw; }
}
```

### Scenario 4: React SPA Admin Pages Structure

**Description:** Admin pages consistent with core feature-sliced architecture. Admin UIs are embedded within their parent feature folders (not a separate `/admin` prefix) — access is gated by `IsAdmin` prop from API responses.

**Preferred Approach:** Admin components live alongside their feature, guarded by `useIsAdmin` hooks.

```text
swimomatic-spa/
  src/
    features/
      swim-meets/
        components/
          SwimMeetForm.tsx         ← create/edit (admin only)
          SwimMeetWizard.tsx       ← multi-step create wizard
          SwimMeetCard.tsx         ← shows Edit/Delete if isAdmin
        pages/
          SwimMeetsPage.tsx
          SwimMeetDetailPage.tsx   ← links to heat sheet admin if isAdmin
        hooks/
          useSwimMeets.ts
          useCreateSwimMeet.ts
          useUpdateSwimMeet.ts     ← admin
          useDeleteSwimMeet.ts     ← admin (guarded by CanEdit=true)
      heat-sheets/
        components/
          HeatSheetAdmin.tsx       ← admin panel: add/delete events, heats
          HeatSheetEventList.tsx   ← drag-to-reorder via @dnd-kit/sortable
          HeatSheetEventForm.tsx   ← add event form (stroke, distance, age class, gender)
          HeatGrid.tsx             ← visual grid: lanes × heats with drag-drop swimmers
          SeedEventButton.tsx      ← triggers seeding for an event
          LaneCell.tsx             ← single cell: swimmer chip + move arrows
        hooks/
          useHeatSheetAdmin.ts
          useAddHeatSheetEvent.ts  ← admin
          useDeleteHeatSheetEvent.ts
          useResequenceEvents.ts   ← admin, uses @dnd-kit order
          useAddHeat.ts            ← admin
          useDeleteHeat.ts         ← admin
          useSeedHeatSheetEvent.ts ← admin
          useAddHeatSwimmer.ts     ← admin
          useRemoveHeatSwimmer.ts  ← admin
          useMoveLane.ts           ← admin, optimistic update
      leagues/
        components/
          LeagueForm.tsx           ← create/edit (admin only)
          SeasonForm.tsx           ← admin: description, dates, scoring schemes, age class rule
          TeamRequestList.tsx      ← admin: approve pending team join requests
        hooks/
          useLeagueAdmin.ts
          useSaveSeason.ts
          useApproveTeamRequest.ts
      teams/
        components/
          TeamForm.tsx             ← create/edit (admin)
          SwimmerRequestList.tsx   ← admin: approve pending swimmer join requests
          TeamRosterAdmin.tsx      ← admin: view/manage team roster
        hooks/
          useTeamAdmin.ts
          useApproveSwimmerRequest.ts
      locations/
        components/
          LocationForm.tsx         ← create/edit
          PoolConfigForm.tsx       ← create/edit pool + config
          LocationMap.tsx          ← Google Maps display (lat/lng from existing data)
        hooks/
          useSaveLocation.ts
          useSavePool.ts
    features/admin/
      ← Empty: no separate /admin section; admin is contextual per entity
```

**Key UI interaction patterns:**

1. **Event resequencing** (drag-and-drop):
```tsx
import { DndContext, closestCenter } from '@dnd-kit/core';
import { SortableContext, verticalListSortingStrategy, arrayMove } from '@dnd-kit/sortable';

// useResequenceEvents.ts
const mutation = useMutation({
  mutationFn: (orderedIds: number[]) =>
    api.heatSheets.resequenceEvents(swimMeetId, heatSheetId, orderedIds),
  onSuccess: () => queryClient.invalidateQueries({ queryKey: ['heatSheetEvents', heatSheetId] })
});
```

2. **Optimistic lane movement:**
```tsx
// useMoveLane.ts
const queryClient = useQueryClient();
return useMutation({
  mutationFn: ({ heatId, heatSwimmerId, move, isRelay }: MoveLaneParams) =>
    api.heats.moveLane(swimMeetId, heatId, heatSwimmerId, { move, isRelay }),
  onMutate: async ({ heatId, heatSwimmerId, move }) => {
    await queryClient.cancelQueries({ queryKey: ['heats', heatId] });
    const prev = queryClient.getQueryData(['heats', heatId]);
    queryClient.setQueryData(['heats', heatId], (old: HeatData) =>
      swapLanes(old, heatSwimmerId, move));   // optimistic swap
    return { prev };
  },
  onError: (_, __, ctx) =>
    queryClient.setQueryData(['heats', ctx!.prev.heatId], ctx!.prev),
  onSettled: (_, __, { heatId }) =>
    queryClient.invalidateQueries({ queryKey: ['heats', heatId] })
});
```

3. **Swimmer seeding trigger:**
```tsx
// SeedEventButton.tsx
const { mutate: seed, isPending } = useSeedHeatSheetEvent(swimMeetId, heatSheetId, eventId);
return (
  <Button
    onClick={() => seed({ swimmerTeamSeasonIds: selectedSwimmerIds })}
    disabled={isPending || selectedSwimmerIds.length === 0}
  >
    {isPending ? 'Seeding...' : 'Seed Event'}
  </Button>
);
```

**Admin route guards:**
```tsx
// Admin routes are embedded in existing routes; no separate /admin prefix
// Access to admin actions determined by isAdmin from API response
const { data: swimMeet } = useSwimMeet(id);
if (!swimMeet?.isAdmin) return null; // or <Navigate to="/" />
```

### Scenario 5: Approval Workflow (TeamLeagueRequest and SwimmerTeamRequest)

**Description:** Two parallel approval workflows: team requesting to join a league season, and swimmer requesting to join a team season.

**TeamLeagueRequest workflow:**
1. Team admin submits request: `POST /api/leagues/{leagueId}/seasons/{seasonId}/join-requests` with `userTeamId`
2. League admin views pending: `GET /api/leagues/{leagueId}/seasons/{seasonId}/join-requests`
3. League admin approves: `POST /api/.../join-requests/{id}/approve`
4. On approval: `TeamLeagueRequest.IsApproved = true` + create `TeamSeason` record

**SwimmerTeamRequest workflow:**
1. Swimmer's user submits request: `POST /api/teams/{teamId}/seasons/{teamSeasonId}/join-requests` with `userSwimmerId`
2. Team admin views pending: `GET /api/teams/{teamId}/seasons/{teamSeasonId}/join-requests`
3. Team admin approves: `POST /api/.../join-requests/{id}/approve`
4. On approval: `SwimmerTeamRequest.IsApproved = true` + create `SwimmerTeamSeason` record

**React components:**
```tsx
// teams/components/SwimmerRequestList.tsx
const { data: requests } = useSwimmerJoinRequests(teamId, teamSeasonId);
const { mutate: approve } = useApproveSwimmerRequest(teamId, teamSeasonId);

return (
  <Table>
    {requests?.map(req => (
      <TableRow key={req.id}>
        <TableCell>{req.swimmerName}</TableCell>
        <TableCell>{req.requestDate}</TableCell>
        <TableCell>
          <Button onClick={() => approve(req.id)}>Approve</Button>
        </TableCell>
      </TableRow>
    ))}
  </Table>
);
```

### Scenario 6: Reference Data Administration (Location/Pool/PoolConfig)

**Description:** Locations, Pools, and PoolConfigs are user-created reference data. Any authenticated user can create them; only the creator can edit (enforced via `CreatedByUserID` audit column).

**Ownership enforcement:**
```csharp
[Authorize]
[HttpPut("/api/locations/{id}")]
public async Task<IActionResult> UpdateLocation(int id, UpdateLocationRequest request)
{
    var userId = User.FindFirst(ClaimTypes.NameIdentifier)!.Value;
    var location = await _locationRepo.GetByIdAsync(id);
    if (location.CreatedByUserId != userId) return Forbid();
    // proceed with update
}
```

Note: In the existing app, there's no explicit ownership check in the controller — it just calls `SaveLocation`. In the modernized app, the `ModifiedByUserId` from JWT and the `CreatedByUserId` audit trail enforce ownership at the service layer.

**Pool + PoolConfig creation pattern:**
`SavePool` in `LocationController` creates both Pool and PoolConfig in the same action. In the .NET 9 API, this is a single endpoint `POST /api/locations/{locationId}/pools` that creates both atomically:
```csharp
public record CreatePoolRequest(
    string Description,          // Pool description
    string PoolConfigDescription,
    decimal LengthMajor,
    decimal LengthMinor,
    int UOMID,
    int LaneCount,
    int PoolConfigID             // 0 for new
);
```

## Implementation Roadmap for Admin Features

### Phase 5a — Authorization Infrastructure (prerequisite for all admin features)
1. Add `UserSwimMeet`, `UserTeam`, `UserLeague` IsAdmin lookup repositories
2. Implement `SwimMeetAdminHandler`, `TeamAdminHandler`, `LeagueAdminHandler` using `context.Resource as HttpContext`
3. Register policies and handlers (as `AddScoped`) in `Program.cs`
4. Add `[Authorize(Policy = "SwimMeetAdmin")]` etc. to existing endpoints that need it

### Phase 5b — League/Season Admin
1. `PUT /api/leagues/{id}` — edit league
2. `POST/PUT /api/leagues/{leagueId}/seasons` — create/edit season with scoring schemes (transactional Dapper)
3. `GET/POST /api/leagues/{leagueId}/seasons/{id}/join-requests` — view/approve
4. React: `LeagueForm`, `SeasonForm` (scoring scheme inputs with Zod point-array validation), `TeamRequestList`

### Phase 5c — Team Admin
1. `PUT /api/teams/{id}` — edit team
2. `GET/POST /api/teams/{id}/seasons/{tsId}/join-requests` — view/approve swimmer requests
3. React: `TeamForm`, `SwimmerRequestList` (TanStack Table with row selection), `TeamRosterAdmin`

### Phase 5d — Heat Sheet Administration
1. `POST /api/swimmeets/{id}/heatsheets` — create heat sheet
2. `POST/DELETE /api/.../events` — add/remove heat sheet events (409 if results exist)
3. `PUT /api/.../events/resequence` — reorder events (array of ordered IDs)
4. `POST/DELETE /api/.../heats` — add/remove heats (409 if results exist)
5. `POST /api/.../seed` — trigger seeding algorithm with `swimmerTeamSeasonIds[]` body
6. `POST/DELETE /api/.../swimmers` — add/remove swimmers from heats
7. `PUT /api/.../lane` — move swimmer lane (`{ move: 1|-1, isRelay: bool }`) with optimistic update
8. React: `HeatSheetAdmin`, `HeatSheetEventList` (drag-to-reorder with `@dnd-kit/sortable`), `HeatGrid` (`<table>` with Dialog), `LaneCell` (arrow buttons + swimmer chip), `SeedEventButton` with `AlertDialog` confirm

### Phase 5e — Reference Data Admin
1. `POST/PUT /api/locations` — create/edit location
2. `POST /api/locations/{id}/pools` — create pool + config atomically
3. `PUT /api/locations/{id}/pools/{poolId}/configs/{configId}` — edit pool config
4. React: `LocationForm`, `PoolConfigForm`

## Complete Examples

### Heat Sheet Event Resequencing (React + @dnd-kit)
```tsx
// heat-sheets/components/HeatSheetEventList.tsx
import { DndContext, closestCenter, KeyboardSensor, PointerSensor, useSensor, useSensors } from '@dnd-kit/core';
import { SortableContext, sortableKeyboardCoordinates, verticalListSortingStrategy, arrayMove, useSortable } from '@dnd-kit/sortable';
import { restrictToVerticalAxis } from '@dnd-kit/modifiers';
import { CSS } from '@dnd-kit/utilities';

function SortableEventRow({ event }: { event: HeatSheetEventItem }) {
  const { attributes, listeners, setNodeRef, transform, transition } = useSortable({ id: event.id });
  const style = { transform: CSS.Transform.toString(transform), transition };
  return (
    <TableRow ref={setNodeRef} style={style}>
      <TableCell>
        {/* Drag handle ONLY — rest of row remains clickable */}
        <button {...attributes} {...listeners} aria-label="Drag to reorder" className="cursor-grab">
          <GripVerticalIcon />
        </button>
      </TableCell>
      <TableCell>{event.description}</TableCell>
      {/* ... delete button, etc. */}
    </TableRow>
  );
}

export function HeatSheetEventList({ swimMeetId, heatSheetId }: Props) {
  const { data: events } = useHeatSheetEvents(heatSheetId);
  const { mutate: resequence } = useResequenceEvents(swimMeetId, heatSheetId);
  const [localOrder, setLocalOrder] = useState(() => events ?? []);

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor, { coordinateGetter: sortableKeyboardCoordinates })
  );

  function handleDragEnd(event: DragEndEvent) {
    const { active, over } = event;
    if (over && active.id !== over.id) {
      const oldIndex = localOrder.findIndex(e => e.id === active.id);
      const newIndex = localOrder.findIndex(e => e.id === over.id);
      const newOrder = arrayMove(localOrder, oldIndex, newIndex);
      setLocalOrder(newOrder);
      resequence(newOrder.map(e => e.id)); // API call only on drag-end
    }
  }

  return (
    <DndContext sensors={sensors} collisionDetection={closestCenter} onDragEnd={handleDragEnd}
      modifiers={[restrictToVerticalAxis]}>
      <SortableContext items={localOrder.map(e => e.id)} strategy={verticalListSortingStrategy}>
        <Table>
          {localOrder.map(event => <SortableEventRow key={event.id} event={event} />)}
        </Table>
      </SortableContext>
    </DndContext>
  );
}
```

### Lane Swap with Optimistic Update (React + TanStack Query v5)
```tsx
// heat-sheets/hooks/useMoveLane.ts
export function useMoveLane(swimMeetId: number) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: ({ heatId, heatSwimmerId, move, isRelay }: MoveLaneParams) =>
      api.heats.moveLane(swimMeetId, heatId, heatSwimmerId, { move, isRelay }),
    onMutate: async ({ heatId, heatSwimmerId, move, isRelay }) => {
      await queryClient.cancelQueries({ queryKey: ['heats', heatId] });
      const previousHeats = queryClient.getQueryData<HeatData>(['heats', heatId]);
      queryClient.setQueryData(['heats', heatId], (old: HeatData) =>
        isRelay ? swapRelayLanes(old, heatSwimmerId, move)
                : swapIndividualLanes(old, heatSwimmerId, move));
      return { previousHeats, heatId };
    },
    onError: (_, __, ctx) => {
      if (ctx) queryClient.setQueryData(['heats', ctx.heatId], ctx.previousHeats);
    },
    onSettled: (_, __, { heatId }) =>
      queryClient.invalidateQueries({ queryKey: ['heats', heatId] })
  });
}
```

### Seeding Confirm + Trigger (React)
```tsx
// heat-sheets/components/SeedEventButton.tsx
export function SeedEventButton({ swimMeetId, heatSheetId, eventId, eligibleSwimmerIds }: Props) {
  const { mutate: seed, isPending } = useSeedHeatSheetEvent(swimMeetId, heatSheetId, eventId);
  return (
    <AlertDialog>
      <AlertDialogTrigger asChild>
        <Button disabled={eligibleSwimmerIds.length === 0}>Seed Event</Button>
      </AlertDialogTrigger>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle>Seed this event?</AlertDialogTitle>
          <AlertDialogDescription>
            This will overwrite any existing heat assignments for this event.
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel>Cancel</AlertDialogCancel>
          <AlertDialogAction
            onClick={() => seed({ swimmerTeamSeasonIds: eligibleSwimmerIds })}
            disabled={isPending}
          >
            {isPending ? 'Seeding...' : 'Seed'}
          </AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
```

### Season Scoring Scheme Form (Zod validation)
```tsx
// leagues/components/SeasonForm.tsx
const pointsPattern = /^\d+(,\d+)*$/;
const seasonSchema = z.object({
  description: z.string().min(1, 'Description is required'),
  startDate: z.string().min(1),
  endDate: z.string().min(1),
  ageClassRuleId: z.number().min(1),
  dualTriangleIndividualPoints: z.string().regex(pointsPattern, 'Format: 6,4,3,2'),
  dualTriangleRelayPoints: z.string().regex(pointsPattern, 'Format: 12,8,6,4'),
  invitationalIndividualPoints: z.string().regex(pointsPattern),
  invitationalRelayPoints: z.string().regex(pointsPattern),
});
```

### Required npm Packages for Admin Features
```
@dnd-kit/core        ^6.x
@dnd-kit/sortable    ^8.x
@dnd-kit/modifiers   ^7.x
@dnd-kit/utilities   ^3.x
```
(All @dnd-kit packages must be the same major release line to avoid peer dependency conflicts.)
