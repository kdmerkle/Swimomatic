# Multi-Sport Domain Extensibility Research

**Date:** 2026-06-23  
**Workspace:** c:\GitHub\Swimomatic  
**Purpose:** Architecture research for evolving Swimomatic into a multi-sport SaaS platform

---

## Existing Model Baseline (from codebase inspection)

The current `_Swimmer` entity fields: `SwimmerID`, `FirstName`, `LastName`, `BirthDate`, `IsMale` — no swim-specific attributes beyond identity.

The current `SwimmerTeamSeason` fields: `SwimmerTeamSeasonID`, `SwimmerID`, `TeamSeasonID`, `StartDate`, `EndDate`.

The current `UserSwimmer` fields: `UserSwimmerID`, `SystemUserID`, `SwimmerID` — a simple two-key link table.

The current `Result` fields include `ElapsedTime` (swim-centric) but no `Distance`, `Height`, or measurement-type discriminator — this is the key generalization gap.

The current `AgeClass` fields: `AgeClassID`, `Description`, `IsMale`, `MinAge`, `MaxAge` — fully sport-agnostic already.

---

## Topic 1: Central Athlete Identity Model

### Recommendation: Introduce `Athlete` as the central entity; rename `Swimmer` to `SwimProfile`

#### Rationale

`_Swimmer` currently holds only `FirstName`, `LastName`, `BirthDate`, `IsMale` — exactly the fields that belong on a cross-sport identity. No swim-specific attributes (stroke preference, certification level, etc.) exist on `Swimmer`. This makes the rename low-risk and the lift minimal.

Keeping `Swimmer` as the universal identity would force `Track & Field` to create a `Runner` entity that duplicates the same four fields, with no shared FK. The platform has no single place to query "all athletes in this league" across sports.

#### Central `Athlete` Entity

```
Athlete
├── AthleteID          int PK
├── FirstName          nvarchar(100)
├── LastName           nvarchar(100)
├── BirthDate          date
├── IsMale             bit
├── CreatedDate        datetime2
└── ModifiedDate       datetime2
```

`Athlete` is sport-agnostic. It lives in the `platform` schema (or `dbo` during the transition). No sport-specific FK lives here.

#### Sport-Specific Profile: `swim.SwimProfile`

```
swim.SwimProfile
├── SwimProfileID      int PK
├── AthleteID          int FK → Athlete.AthleteID
└── (future swim-only fields: USASwimmingNumber, ClubMembership, etc.)
```

For the initial migration, `SwimProfile` is nearly empty beyond the FK — that is correct. It is the extension point for swim-specific attributes that accumulate over time (USA Swimming registration ID, qualifying times record, etc.).

#### Track & Field profile (preview): `tf.TFProfile`

```
tf.TFProfile
├── TFProfileID        int PK
├── AthleteID          int FK → Athlete.AthleteID
└── (future: USATFNumber, CertificationLevel, etc.)
```

#### User → Athlete link: `UserAthlete`

Replace `UserSwimmer` (`SystemUserID` → `SwimmerID`) with:

```
UserAthlete
├── UserAthleteID      int PK
├── SystemUserID       int FK → SystemUser.SystemUserID
├── AthleteID          int FK → Athlete.AthleteID
└── IsPrimary          bit   -- one user may manage multiple athletes (parent/child)
```

A single row per user-athlete relationship regardless of how many sports that athlete competes in. The old `UserSwimmer` table is retired.

#### Roster link: `AthleteTeamSeason`

Replace `SwimmerTeamSeason` with:

```
AthleteTeamSeason
├── AthleteTeamSeasonID  int PK
├── AthleteID            int FK → Athlete.AthleteID
├── TeamSeasonID         int FK → TeamSeason.TeamSeasonID
├── SportID              int FK → Sport.SportID        -- new
├── StartDate            date
└── EndDate              date
```

`SportID` is a new platform lookup:

```
Sport
├── SportID     int PK
├── SportCode   nvarchar(20)   -- 'SWIM', 'TF', 'SOCCER'
└── SportName   nvarchar(100)
```

This allows a single query "show all athletes on Team X in Season Y" without knowing the sport. It also keeps sport-specific roster queries cheap: `WHERE SportID = @SwimSportID`.

#### Entity Relationship Sketch

```
SystemUser ──< UserAthlete >── Athlete ──< AthleteTeamSeason >── TeamSeason
                                  │
                         ┌────────┴────────┐
                   swim.SwimProfile     tf.TFProfile
```

#### Rejected Alternatives

| Alternative | Reason Rejected |
|---|---|
| Keep `Swimmer` as the universal identity, add sport FK | Forces T&F to import the swim schema; `SwimmerID` is semantically wrong for a runner |
| One `AthleteProfile` table with nullable sport columns | Schema rot; every new sport adds nullable columns; queries need `COALESCE` and discriminators |
| Separate `Athlete` per sport with no shared table | No platform-level "find this person across sports"; parent lookup is impossible |

---

## Topic 2: Sport Domain Module Architecture (.NET 9)

### Recommendation: Monorepo with sport-specific class libraries + `ISportModule` extension contract

#### Rationale

A small team (1–3 developers) cannot sustain the operational overhead of microservices (separate deployments, service mesh, distributed tracing, inter-service HTTP calls for cross-sport queries). A vertical-slice monolith in one WebAPI project loses physical isolation — sport domains inevitably bleed into each other without hard project boundaries.

**Class libraries** give hard compilation boundaries, independent unit testing, and zero runtime deployment overhead. The host `SwimomaticAPI` project references `SwimDomain` and `TrackFieldDomain`; adding `SoccerDomain` later is `dotnet add reference`.

#### ISportModule Contract

The host project defines this interface in the platform core project (`PlatformCore`):

```csharp
// PlatformCore/Contracts/ISportModule.cs
namespace Platform.Core.Contracts;

public interface ISportModule
{
    /// <summary>Short code used in route prefixes and DB schema names.</summary>
    string SportCode { get; }

    /// <summary>Register sport-specific services, repositories, and handlers.</summary>
    void RegisterServices(IServiceCollection services, IConfiguration configuration);

    /// <summary>Map sport-specific Minimal API endpoints or register controller assemblies.</summary>
    void MapEndpoints(WebApplication app);
}
```

#### Swim Domain Library Implementation

```csharp
// SwimDomain/SwimModule.cs
namespace SwimDomain;

public sealed class SwimModule : ISportModule
{
    public string SportCode => "SWIM";

    public void RegisterServices(IServiceCollection services, IConfiguration configuration)
    {
        services.AddScoped<ISwimMeetRepository, SwimMeetRepository>();
        services.AddScoped<IHeatSheetService, HeatSheetService>();
        services.AddScoped<ISwimEventRepository, SwimEventRepository>();
        // Dapper connection is already registered by platform core
    }

    public void MapEndpoints(WebApplication app)
    {
        // Option A: Register controller assembly (controller-based API)
        // Handled via AddApplicationPart in RegisterServices (see below)

        // Option B: Map Minimal API route groups
        app.MapGroup("/api/swim")
           .WithTags("Swim")
           .MapSwimMeetEndpoints()
           .MapHeatSheetEndpoints();
    }
}
```

For controller-based APIs (matching the stated stack), register the assembly part in `RegisterServices`:

```csharp
public void RegisterServices(IServiceCollection services, IConfiguration configuration)
{
    // Adds SwimDomain controllers to the MVC pipeline
    services.AddControllers()
            .AddApplicationPart(typeof(SwimModule).Assembly);

    services.AddScoped<ISwimMeetRepository, SwimMeetRepository>();
    services.AddScoped<IHeatSheetService, HeatSheetService>();
}
```

#### Host Startup (Program.cs)

```csharp
// SwimomaticAPI/Program.cs
var builder = WebApplication.CreateBuilder(args);

// Platform core services
builder.Services.AddPlatformCore(builder.Configuration);
builder.Services.AddControllers();

// Discover and register sport modules
// Option A: Explicit registration (recommended for small teams — no magic)
var sportModules = new List<ISportModule>
{
    new SwimDomain.SwimModule(),
    new TrackFieldDomain.TrackFieldModule(),
};

foreach (var module in sportModules)
{
    module.RegisterServices(builder.Services, builder.Configuration);
}
builder.Services.AddSingleton<IReadOnlyList<ISportModule>>(sportModules);

var app = builder.Build();

app.MapControllers();

foreach (var module in sportModules)
{
    module.MapEndpoints(app);
}

app.Run();
```

**Option B (assembly scanning):** Scan the entry assembly's referenced assemblies for `ISportModule` implementations using reflection. Useful if the project grows to 5+ sports, but adds startup magic that is hard to debug. Avoid until needed.

#### Database Schema Organisation

Use sport-prefixed SQL schemas:

```
dbo (or platform schema)
  ├── Athlete
  ├── UserAthlete
  ├── AthleteTeamSeason
  ├── League, Season, Team, TeamSeason
  ├── Location, Region, UOM, Sport
  └── AgeClass, AgeClassRule (shared — see Topic 3)

swim
  ├── swim.SwimProfile
  ├── swim.SwimMeet
  ├── swim.HeatSheet
  ├── swim.Heat
  ├── swim.HeatSwimmer
  ├── swim.SwimEvent
  ├── swim.Stroke
  ├── swim.PoolConfig
  └── swim.Split

tf
  ├── tf.TFProfile
  ├── tf.TFMeet
  ├── tf.TFEvent
  ├── tf.EventType
  ├── tf.Flight
  ├── tf.FlightAthlete
  └── tf.FieldAttempt
```

Dapper stored procedures use two-part names (`swim.usp_GetHeatSheet`, `tf.usp_GetFlight`). The platform core procedures stay in `dbo`.

#### Rejected Alternatives

| Alternative | Reason Rejected |
|---|---|
| Separate microservices per sport | Too much ops overhead for a 1–3 person team; cross-sport queries (e.g., athlete profile across sports) require distributed joins or API aggregation |
| Vertical slices inside one project | No hard compilation boundary; refactor discipline breaks down over time; cannot independently test sport logic |
| Plugin/MEF-based dynamic loading | No benefit at this scale; complicates debugging and deployment |

---

## Topic 3: Shared Platform Primitives vs Sport-Specific Entities

### Platform-Generic Entities (live in `dbo` / platform schema)

| Entity | Rationale for Sharing |
|---|---|
| `Athlete` | Cross-sport identity — see Topic 1 |
| `UserAthlete` | User manages athlete profiles regardless of sport |
| `AthleteTeamSeason` | Roster membership pattern is identical across sports; filtered by `SportID` |
| `Sport` | Lookup for sport codes and display names |
| `League` | Organizes competitions regardless of sport (needs `SportID` FK for filtering) |
| `Season` | League-scoped competition calendar |
| `Team` | Same concept in swim, T&F, soccer |
| `TeamSeason` | Team enrollment in a season |
| `Location` / `Venue` | Physical location of a meet |
| `Region` | Geographic grouping |
| `UOM` | Unit of measure (meters, yards, seconds, feet) |
| `AgeClass` / `AgeClassRule` | Age groupings apply identically to swim and T&F (see below) |
| `SystemUser` / `Profile` | Authentication identity |
| `UserTeam` / `UserLeague` | Admin/member relationships |
| `Meet` (generalized) | See below |
| `ScoringScheme` / `SeasonScoringScheme` | Point allocation patterns are sport-specific config, but the _pattern_ is shared |

### Recommendation: Generalize `Meet` / `Competition`

Introduce a platform-level `Meet` with a `SportID`:

```
Meet (platform)
├── MeetID          int PK
├── SportID         int FK → Sport.SportID
├── SeasonID        int FK → Season.SeasonID
├── LocationID      int FK → Location.LocationID
├── Description     nvarchar(200)
├── StartDate       date
├── EndDate         date
└── MeetTypeID      int FK → MeetType.MeetTypeID  -- Regular, Championship, Invitational

swim.SwimMeetConfig  (sport-specific extension)
├── SwimMeetConfigID  int PK
├── MeetID            int FK → Meet.MeetID
├── PoolConfigID      int FK → swim.PoolConfig.PoolConfigID
└── IsTimedFinal      bit
```

This allows `UserMeet` to live in the platform core:

```
UserMeet
├── UserMeetID      int PK
├── SystemUserID    int FK → SystemUser.SystemUserID
└── MeetID          int FK → Meet.MeetID
```

Without generalization, `UserSwimMeet` and a future `UserTFMeet` must be managed separately by each sport, duplicating the admin/spectator access pattern.

### Recommendation: Keep `AgeClass` / `AgeClassRule` as Platform Primitives

`AgeClass` (as inspected: `AgeClassID`, `Description`, `IsMale`, `MinAge`, `MaxAge`) is perfectly sport-agnostic. T&F uses identical age groupings (8-Under, 9–10, 11–12, 13–14, 15–18, Open). USA Track & Field age group rules match USA Swimming age group rules structurally.

Add a `SportID` FK to `AgeClass` so that each sport's league can configure its own age groups independently while sharing the table:

```
AgeClass
├── AgeClassID   int PK
├── SportID      int FK → Sport.SportID   -- NEW
├── LeagueID     int FK → League.LeagueID -- already implied by usage
├── Description  nvarchar(100)
├── IsMale       bit
├── MinAge       int
└── MaxAge       int
```

### Recommendation: Generalize `Result` with a Measurement Type Discriminator

The existing `_Result` entity only has `ElapsedTime` — a swim-centric field. T&F results require a different measurement model:

```
Result (platform, generalized)
├── ResultID              int PK
├── AthleteTeamSeasonID   int FK → AthleteTeamSeason.AthleteTeamSeasonID
├── MeetID                int FK → Meet.MeetID
├── AgeClassID            int FK → AgeClass.AgeClassID
├── MeasurementType       tinyint  -- 1=Time, 2=Distance, 3=Height, 4=Points
├── TimeValue             decimal(10,4) NULL  -- seconds; used for swim + track
├── DistanceValue         decimal(10,4) NULL  -- meters/feet; used for T&F throws/jumps
├── HeightValue           decimal(10,4) NULL  -- meters; used for high jump/pole vault
├── PointsValue           decimal(10,2) NULL  -- used for combined events (decathlon)
├── UOMID                 int FK → UOM.UOMID
├── Place                 int
├── Disqualified          bit
├── IsCertified           bit
├── IsProtested           bit
└── EventDate             date
```

Sport-specific result extension tables can add sport-specific FK references (e.g., `swim.SwimResult` adds `HeatSwimmerID`, `StrokeID`).

### API Route Structure Recommendation

Use sport-prefixed route segments: `/api/swim/meets/{id}`, `/api/tf/meets/{id}`.

**Rationale:** Sport is structurally important, not just a query filter. A meet in swim has a pool config; a meet in T&F has flights and field events. Different controllers, different DTOs. Query-string sport resolution (`/api/meets/{id}?sport=swim`) conflates fundamentally different resources under a shared URL, complicating OpenAPI documentation and client code generation.

**Tenant context does NOT resolve the sport** because a tenant (league) can run both swim and T&F seasons. Sport must be explicit in the route.

Route structure:
```
/api/swim/meets
/api/swim/meets/{meetId}/heatsheets
/api/swim/meets/{meetId}/heatsheets/{heatSheetId}/heats
/api/tf/meets
/api/tf/meets/{meetId}/flights
/api/tf/meets/{meetId}/events/{eventId}/attempts
/api/athletes/{athleteId}            ← platform, sport-neutral
/api/athletes/{athleteId}/results    ← platform, aggregates across sports
```

---

## Topic 4: React SPA Multi-Sport Structure

### Recommendation: Route-based code splitting with `React.lazy()` + TanStack Query namespace keys

#### Rationale

Module Federation (Vite plugin-federation) is designed for teams of 10+ deploying independently. For a 1–3 person team on an early-stage SaaS, it introduces: separate build pipelines per sport, remote entry coordination, type sharing complexity across federation boundaries, and harder debugging. The benefit (independent sport deployments) is not needed yet.

A single SPA with route-level code splitting delivers the same lazy-loading behavior, keeps the codebase in one repo, and uses Vite's native `import()` bundler support with zero extra plugins.

#### Folder Structure

```
src/
├── platform/                    ← shared platform primitives
│   ├── types.ts                 ← Athlete, Meet, Team, Season, User, etc.
│   ├── api/                     ← base axios/fetch client, auth interceptors
│   ├── components/              ← shared UI: PageHeader, DataTable, etc.
│   └── hooks/                   ← useAthleteProfile, useCurrentUser, etc.
│
├── features/
│   ├── swim/                    ← swim feature module
│   │   ├── types.ts             ← SwimMeet, HeatSheet, Heat, SwimEvent, etc.
│   │   ├── routes.tsx           ← lazy route definitions for swim
│   │   ├── api/                 ← TanStack Query hooks for swim endpoints
│   │   │   ├── useSwimMeets.ts
│   │   │   └── useHeatSheet.ts
│   │   ├── components/          ← HeatSheetView, SwimmerCard, etc.
│   │   └── pages/               ← SwimMeetsPage, HeatSheetPage, etc.
│   │
│   └── tf/                      ← track & field feature module (future)
│       ├── types.ts
│       ├── routes.tsx
│       ├── api/
│       ├── components/
│       └── pages/
│
├── app/
│   ├── router.tsx               ← root router with lazy sport routes
│   ├── nav.tsx                  ← sport-aware navigation
│   └── App.tsx
└── main.tsx
```

#### Router with Lazy Sport Modules

```tsx
// src/app/router.tsx
import { createBrowserRouter, lazy } from 'react-router';

const SwimRoutes = lazy(() => import('../features/swim/routes'));
const TFRoutes   = lazy(() => import('../features/tf/routes'));

export const router = createBrowserRouter([
  {
    path: '/',
    element: <AppShell />,
    children: [
      // Platform routes (always loaded)
      { path: 'athletes/:id', element: <AthleteProfilePage /> },
      { path: 'leagues',      element: <LeaguesPage /> },

      // Swim — lazy loaded on first navigation to /swim/*
      {
        path: 'swim',
        element: (
          <Suspense fallback={<SportLoadingSpinner />}>
            <SwimRoutes />
          </Suspense>
        ),
      },

      // Track & Field — lazy loaded on first navigation to /tf/*
      {
        path: 'tf',
        element: (
          <Suspense fallback={<SportLoadingSpinner />}>
            <TFRoutes />
          </Suspense>
        ),
      },
    ],
  },
]);
```

#### TanStack Query Key Namespacing

Sport code is always the first segment of the query key tuple. This ensures:
- Cache isolation between sports (a swim meet and a T&F meet share `meetId` integer space)
- DevTools show clear sport groupings
- Invalidation is sport-scoped: `queryClient.invalidateQueries({ queryKey: ['swim'] })`

```typescript
// src/features/swim/api/useSwimMeets.ts
export const swimKeys = {
  all:    ['swim', 'meets']                        as const,
  list:   (seasonId: number) =>
            [...swimKeys.all, 'list', seasonId]    as const,
  detail: (meetId: number) =>
            [...swimKeys.all, 'detail', meetId]    as const,
};

export function useSwimMeets(seasonId: number) {
  return useQuery({
    queryKey: swimKeys.list(seasonId),
    queryFn:  () => api.get<SwimMeet[]>(`/swim/meets?seasonId=${seasonId}`),
  });
}
```

```typescript
// src/features/tf/api/useTFMeets.ts
export const tfKeys = {
  all:    ['tf', 'meets']                        as const,
  list:   (seasonId: number) =>
            [...tfKeys.all, 'list', seasonId]    as const,
  detail: (meetId: number) =>
            [...tfKeys.all, 'detail', meetId]    as const,
};
```

Platform-level hooks use no sport prefix:

```typescript
// src/platform/hooks/useAthleteProfile.ts
export const athleteKeys = {
  detail: (athleteId: number) => ['athletes', athleteId] as const,
  results: (athleteId: number) => ['athletes', athleteId, 'results'] as const,
};
```

#### Sport-Aware Navigation

Navigation reflects only the sports enabled for the current tenant (returned from the platform API):

```tsx
// src/app/nav.tsx
interface TenantSport { sportCode: string; sportName: string; }

export function SportNav({ tenantSports }: { tenantSports: TenantSport[] }) {
  return (
    <nav>
      {tenantSports.map(s => (
        <NavLink key={s.sportCode} to={`/${s.sportCode.toLowerCase()}`}>
          {s.sportName}
        </NavLink>
      ))}
    </nav>
  );
}
```

The tenant context (`/api/me/tenant`) returns `enabledSports: ['SWIM', 'TF']`. The nav renders only those links, and the lazy chunks for disabled sports are never fetched.

#### Type Organisation

```typescript
// src/platform/types.ts — sport-neutral entities
export interface Athlete {
  athleteId:  number;
  firstName:  string;
  lastName:   string;
  birthDate:  string;  // ISO 8601
  isMale:     boolean;
}

export interface Meet {
  meetId:      number;
  sportCode:   string;
  description: string;
  startDate:   string;
  endDate:     string;
  locationId:  number;
}
```

```typescript
// src/features/swim/types.ts — swim-specific extensions
import type { Meet } from '../../platform/types';

export interface SwimMeet extends Meet {
  poolConfigId:  number;
  isTimedFinal:  boolean;
}

export interface HeatSheet {
  heatSheetId: number;
  meetId:      number;
  events:      HeatSheetEvent[];
}
```

#### Rejected Alternatives

| Alternative | Reason Rejected |
|---|---|
| Module Federation | Overkill for 1–3 devs; separate build/deploy per sport; complex type sharing at runtime |
| Single flat SPA (no code splitting) | All sport code loads for all tenants; grows unbounded as sports are added |
| Tenant-context sport resolution (no route prefix) | URL `/meets/123` is ambiguous — same integer means different things per sport |

---

## Topic 5: Track & Field Domain Preview

### T&F Fundamental Event Types

| Category | Event Examples | Result Type |
|---|---|---|
| Sprints | 100m, 200m, 400m | Elapsed time (ms precision) |
| Middle Distance | 800m, 1500m, mile | Elapsed time |
| Long Distance | 5K, 10K, marathon | Elapsed time |
| Hurdles | 100mH, 110mH, 400mH | Elapsed time |
| Relays | 4×100, 4×400, 4×800 | Elapsed time; relay team as unit |
| Jumps | Long jump, triple jump, high jump, pole vault | Distance (m) or Height (m) |
| Throws | Shot put, discus, hammer, javelin | Distance (m) |
| Combined Events | Decathlon, heptathlon | Points (accumulated from sub-events) |
| Road | Cross country, road race | Elapsed time; may not have lanes |

### T&F Meet vs Swim Meet: Structural Comparison

| Dimension | Swim Meet | T&F Meet |
|---|---|---|
| Competition unit | Heat (all athletes in same heat swim simultaneously) | Heat (track) or Flight (field) |
| Result grouping | HeatSheet → HeatSheetEvent → Heat → HeatSwimmer | Program → TFEvent → Heat/Flight → FlightAthlete |
| Lane assignment | Always assigned (1–8, 1–10) | Track events: lanes assigned for sprints; distance: lanes may be shared/staggered. Field: no lanes |
| Seeding | Fastest to slowest, bottom-up heat fill | Track: seed by personal best time; Field: seed by best distance/height |
| Finals | Timed finals (one swim, result is final) or Prelim/Final | Often Prelim→Semifinal→Final structure for sprints; field events have prelim flights and final flight |
| Relay | Relay leg order in same lane | Relay leg order in exchange zone; no per-leg lane beyond handoff |
| Combined events | Not applicable | Decathlon (10 events, 2 days); Heptathlon (7 events) — daily totals accumulate |
| Result precision | Time to .01s or .001s | Time to .01s; distance to .01m; height to .01m |

### T&F "Heat" Equivalent

Track events use `Heat` identically to swimming — a group of athletes racing simultaneously, each in an assigned lane (for sprints) or sharing the track (for distance).

Field events use `Flight` — a group of athletes competing in the same throwing or jumping session with multiple attempts:

```
swim.Heat equivalent in T&F
│
├── tf.Heat    (track events: sprints, hurdles, relays)
│     ├── HeatID
│     ├── TFEventID
│     ├── HeatNumber
│     └── RoundType  (Prelim, Semifinal, Final)
│
└── tf.Flight  (field events: jumps, throws, vaults)
      ├── FlightID
      ├── TFEventID
      ├── FlightNumber
      └── RoundType  (Prelim, Final)
```

### T&F Athlete Participation: `FlightAthlete` vs `HeatSwimmer`

```
tf.FlightAthlete
├── FlightAthleteID    int PK
├── FlightID           int FK → tf.Flight.FlightID
├── AthleteTeamSeasonID int FK → AthleteTeamSeason.AthleteTeamSeasonID
├── DrawOrder          int     -- order of attempts within flight
└── SeedMark           decimal(10,4)  -- seeding distance/height

tf.FieldAttempt
├── FieldAttemptID     int PK
├── FlightAthleteID    int FK → tf.FlightAthlete.FlightAthleteID
├── AttemptNumber      int     -- 1, 2, 3 (up to 6 in finals)
├── MeasuredValue      decimal(10,4)  -- distance in meters or height in meters
├── UOMID              int FK → UOM.UOMID
├── IsFoul             bit     -- foul attempt (no mark)
├── IsPassedAttempt    bit     -- athlete passes this height (high jump/vault)
└── WindReading        decimal(5,2) NULL  -- m/s; required for sprints/jumps
```

For track events, the result model is simpler — a single elapsed time per heat entry, same as swim:

```
tf.HeatAthlete
├── HeatAthleteID       int PK
├── HeatID              int FK → tf.Heat.HeatID
├── AthleteTeamSeasonID int FK → AthleteTeamSeason.AthleteTeamSeasonID
├── LaneNumber          int NULL  -- NULL for distance events (no lane)
├── SeedTime            decimal(10,4)
└── ReactionTime        decimal(10,4) NULL
```

### Lanes in T&F

| Event Type | Lanes Used |
|---|---|
| Sprints (≤400m) | Full lane assignment; staggered start |
| 400m hurdles | Full lane assignment |
| 800m | Lane assignment through first curve only; then break to inside |
| Distance (≥1500m) | Waterfall start; no lane assignment |
| Cross country | No lanes |
| Field (jumps, throws) | No lanes; flight order used instead |

This means `LaneNumber` on `tf.HeatAthlete` is nullable — present for sprints, null for distance. This is a deliberate design difference from `swim.HeatSwimmer` where `LaneNumber` is always required.

### Seeding Differences

| Sport | Seeding Method | Direction |
|---|---|---|
| Swim | Seed by `SeedResultID` (best elapsed time) | Slowest heat first, fastest last (championship finals go fastest-to-slowest) |
| T&F Track | Seed by personal best time | Slowest heat first; fastest in final heat |
| T&F Field | Seed by personal best distance/height | Weakest performers in first flight; best in final flight |
| T&F Combined | Seed by points from previous competitions | Often unseeded (everyone competes together) |

### Architecture Validation: Does the Platform Model Accommodate T&F?

| Platform Entity | Works for T&F? | Notes |
|---|---|---|
| `Athlete` | Yes | Name, DOB, gender apply universally |
| `AthleteTeamSeason` | Yes | Roster pattern is identical |
| `Meet` (generalized) | Yes | With `SportID`; T&F meet adds `tf.TFMeetConfig` extension |
| `AgeClass` / `AgeClassRule` | Yes | T&F age groups are structurally identical |
| `Result` (generalized) | Yes | `MeasurementType` discriminator handles time/distance/height/points |
| `UOM` | Yes | Meters, seconds, feet already needed for swim |
| `ScoringScheme` | Partial | T&F team scoring by place-points is different from swim; both use a points-per-place pattern |
| `Sport` lookup | Yes | `SWIM`, `TF` as rows |

No fundamental incompatibility found. The generalized `Result` with `MeasurementType` is the critical unlock.

---

## Summary of Recommendations

| Topic | Recommended Approach |
|---|---|
| Athlete Identity | Central `Athlete` entity; sport-specific `SwimProfile`/`TFProfile`; `UserAthlete` replaces `UserSwimmer`; `AthleteTeamSeason` with `SportID` replaces `SwimmerTeamSeason` |
| .NET Module Architecture | Monorepo class libraries (`SwimDomain.csproj`, `TrackFieldDomain.csproj`) with `ISportModule` contract; sport-prefixed DB schemas |
| Platform vs Sport Boundary | `Meet`, `AgeClass`, `Result` (with discriminator), `ScoringScheme` promoted to platform; swim-specific entities (`HeatSheet`, `Heat`, `PoolConfig`, `Stroke`) stay sport-owned |
| React SPA Structure | Route-based code splitting with `React.lazy()`; TanStack Query keys prefixed by sport code; sport-aware nav from tenant context |
| T&F Compatibility | Platform model validates cleanly; `tf.Flight`/`tf.FlightAthlete`/`tf.FieldAttempt` cover field events; nullable `LaneNumber` handles distance track events |

---

## Recommended Next Research Items

1. **Migration strategy for existing `Swimmer` → `Athlete` data**: How to write the SQL migration script that creates `Athlete` from existing `Swimmer` rows, creates `swim.SwimProfile` FKs, migrates `UserSwimmer` → `UserAthlete`, and migrates `SwimmerTeamSeason` → `AthleteTeamSeason` without breaking existing stored procedures during the transition period.

2. **Stored procedure naming conventions for multi-schema Dapper**: How to organize stored procedure names, parameters, and result sets when `swim.*` procs join to `dbo.Athlete` — specifically, how to handle the SP parameter naming convention so `@SwimmerID` vs `@AthleteID` is handled cleanly in the transition.

3. **Tenant sport configuration API**: What does the `/api/me/tenant` response look like? How does `enabledSports` get set per tenant? Is it a feature flag in the platform, or a League-level configuration row? Research multi-tenant feature flag patterns for ASP.NET Core.

4. **T&F scoring schemes**: How do T&F team scoring systems work (place-scored dual meets, NFHS scoring, combined scoring for multis)? Determine if the existing `ScoringScheme` / `SeasonScoringScheme` pattern can be reused or needs extension.

5. **React multi-sport athlete results page**: How should `/athletes/{id}/results` aggregate swim times and T&F marks in a single view? Research TanStack Query `useQueries` (parallel queries) for fetching sport-specific results independently and combining them in the UI.

6. **API versioning strategy**: With sport modules as class libraries adding controllers, how does API versioning (`/api/v1/swim/meets` vs `/api/v2/swim/meets`) work across independently evolving sport domains without breaking the platform contract?
