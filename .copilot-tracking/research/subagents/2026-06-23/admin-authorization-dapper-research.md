# Admin Authorization, Dapper Transactions, HTTP Responses & Drag-and-Drop Research

**Date:** 2026-06-23
**Project:** Swimomatic modernization to ASP.NET Core .NET 9 WebAPI + React

---

## Topic 1: ASP.NET Core .NET 9 Resource-Based Authorization with Dapper

### Summary

Resource-based authorization is the correct pattern when the authorization decision depends on data that must be retrieved from a database — which is exactly the Swimomatic scenario. The `[Authorize(Policy = "...")]` attribute alone is insufficient because it runs before model binding and cannot access the entity being acted upon.

### 1.1 IAuthorizationHandler vs IAuthorizationHandlerProvider

**Use `AuthorizationHandler<TRequirement>` (strongly preferred).**

`IAuthorizationHandlerProvider` is an internal infrastructure type — its job is to resolve all registered `IAuthorizationHandler` implementations from DI, not to be subclassed directly. The right extension point is:

```csharp
// Requirement (marker — no logic here)
public class SwimMeetAdminRequirement : IAuthorizationRequirement { }

// Handler (DB logic lives here)
public class SwimMeetAdminHandler : AuthorizationHandler<SwimMeetAdminRequirement>
{
    private readonly IAdminRepository _repo;
    private readonly IHttpContextAccessor _httpContextAccessor;

    public SwimMeetAdminHandler(IAdminRepository repo, IHttpContextAccessor httpContextAccessor)
    {
        _repo = repo;
        _httpContextAccessor = httpContextAccessor;
    }

    protected override async Task HandleRequirementAsync(
        AuthorizationHandlerContext context,
        SwimMeetAdminRequirement requirement)
    {
        var httpContext = _httpContextAccessor.HttpContext;
        if (httpContext is null) return;

        // Route values are available because Authorization Middleware runs AFTER routing
        if (!httpContext.Request.RouteValues.TryGetValue("swimMeetId", out var idObj)
            || !int.TryParse(idObj?.ToString(), out var swimMeetId))
        {
            return; // cannot determine resource — deny implicitly
        }

        var sub = context.User.FindFirstValue(ClaimTypes.NameIdentifier); // Auth0 sub claim
        if (sub is null) return;

        var isAdmin = await _repo.IsSwimMeetAdminAsync(sub, swimMeetId);
        if (isAdmin)
            context.Succeed(requirement);
    }
}
```

Register in `Program.cs`:

```csharp
builder.Services.AddScoped<IAuthorizationHandler, SwimMeetAdminHandler>();
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("SwimMeetAdmin", policy =>
        policy.Requirements.Add(new SwimMeetAdminRequirement()));
});
```

### 1.2 Accessing RouteValues Inside a Handler

With **endpoint routing** (the default in .NET 9 WebAPI), the Authorization Middleware runs *after* routing middleware has matched the route. This means `context.Resource` is an `HttpContext` instance:

```csharp
// Preferred — cast context.Resource directly (no IHttpContextAccessor needed)
if (context.Resource is HttpContext httpContext)
{
    if (httpContext.Request.RouteValues.TryGetValue("swimMeetId", out var id))
    {
        // use id
    }
}
```

**`IHttpContextAccessor` is an alternative** but introduces an extra dependency. Casting `context.Resource` is cleaner and does not require the extra service registration. Both approaches work; the `context.Resource` cast is the MS-documented pattern.

> **Caveat:** With traditional MVC routing or `[Authorize]` as an MVC action filter, `context.Resource` is `AuthorizationFilterContext`, not `HttpContext`. In .NET 9 WebAPI with endpoint routing this is not an issue — always use endpoint routing.

### 1.3 Avoiding N+1 DB Calls for Multiple Admin Checks

When a single action requires checking multiple resource types (e.g., must be SwimMeet admin AND Team admin), register **separate handlers for separate requirements** and combine them in a policy:

```csharp
// OR: Use a single batched handler if you need all three at once
public class CompoundAdminHandler : IAuthorizationHandler
{
    private readonly IAdminRepository _repo;
    private readonly IHttpContextAccessor _httpContext;

    public CompoundAdminHandler(IAdminRepository repo, IHttpContextAccessor httpContext)
    {
        _repo = repo;
        _httpContext = httpContext;
    }

    public async Task HandleAsync(AuthorizationHandlerContext context)
    {
        var http = _httpContext.HttpContext;
        if (http is null) return;

        var sub = context.User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (sub is null) return;

        // Issue a single batched DB call instead of 3 round trips
        var adminStatus = await _repo.GetAdminStatusAsync(sub, http.Request.RouteValues);

        foreach (var requirement in context.PendingRequirements.ToList())
        {
            if (requirement is SwimMeetAdminRequirement && adminStatus.IsSwimMeetAdmin)
                context.Succeed(requirement);
            else if (requirement is TeamAdminRequirement && adminStatus.IsTeamAdmin)
                context.Succeed(requirement);
            else if (requirement is LeagueAdminRequirement && adminStatus.IsLeagueAdmin)
                context.Succeed(requirement);
        }
    }
}
```

The repository query:

```sql
-- Single batched query — replace NULLs with actual route param values
SELECT
    EXISTS (
        SELECT 1 FROM UserSwimMeet
        WHERE Auth0Sub = @sub AND SwimMeetID = @swimMeetId AND IsAdmin = 1
    ) AS IsSwimMeetAdmin,
    EXISTS (
        SELECT 1 FROM UserTeam
        WHERE Auth0Sub = @sub AND TeamID = @teamId AND IsAdmin = 1
    ) AS IsTeamAdmin
```

### 1.4 `AuthorizationHandlerContext.Resource` vs Route Values — When to Use Which

| Scenario | Recommendation |
|---|---|
| Simple ID from route param | Cast `context.Resource` as `HttpContext`, read `RouteValues` |
| Full entity needed (owner check against loaded entity) | Load the entity in the controller, call `_authorizationService.AuthorizeAsync(user, entity, policy)` imperatively; the entity becomes `context.Resource` |
| Imperative in-action check | `await _authorizationService.AuthorizeAsync(User, document, "SameAuthorPolicy")` |

For Swimomatic's pattern (IsAdmin is a column — no full entity needed), **route values are appropriate**. The entity-as-resource pattern is better when you need to compare a user ID to an entity property (e.g., "can only edit your own profile").

### 1.5 Caching Admin Status Per-Request

**Recommended: Use `IMemoryCache` with a very short TTL (5–10 seconds) or use `HttpContext.Items` for zero-latency per-request caching.**

#### Option A: `HttpContext.Items` (per-request, no TTL management needed)

```csharp
public class AdminStatusCache
{
    private const string CacheKey = "AdminStatus";

    public static bool TryGet(HttpContext ctx, string cacheKey, out bool isAdmin)
    {
        if (ctx.Items.TryGetValue($"{CacheKey}:{cacheKey}", out var val) && val is bool b)
        {
            isAdmin = b;
            return true;
        }
        isAdmin = false;
        return false;
    }

    public static void Set(HttpContext ctx, string cacheKey, bool isAdmin)
        => ctx.Items[$"{CacheKey}:{cacheKey}"] = isAdmin;
}
```

Usage in handler:

```csharp
var itemKey = $"swimMeetAdmin:{sub}:{swimMeetId}";
if (AdminStatusCache.TryGet(httpContext, itemKey, out var cached))
{
    if (cached) context.Succeed(requirement);
    return;
}

var isAdmin = await _repo.IsSwimMeetAdminAsync(sub, swimMeetId);
AdminStatusCache.Set(httpContext, itemKey, isAdmin);
if (isAdmin) context.Succeed(requirement);
```

`HttpContext.Items` is the right tool here — it is scoped exactly to the request lifetime, requires no cache eviction logic, and avoids the risk of stale data persisting beyond a single request.

#### Option B: `IMemoryCache` with sliding TTL

Use only when you have a valid reason to share the cached value across multiple requests (e.g., a very expensive check that you know won't change mid-session). For admin status that may change at any time, `HttpContext.Items` is safer.

### 1.6 `[Authorize(Policy = "SwimMeetAdmin")]` — Execution Order & Security

In ASP.NET Core with endpoint routing, the Authorization Middleware runs **after routing and before model binding**. This means:

- The route template is matched and route values are populated.
- The authorization policy runs.
- **Model binding has not yet occurred.**

**Security implication:** The `swimMeetId` in `context.Resource`/`RouteValues` comes from the raw route data — not a model-bound object. This is correct and safe: route values are parsed from the URL path, not from request bodies, so there is no risk of a body-injection attack affecting the route value check. However:

> **Gotcha:** If you put the resource ID in the request body instead of the route (e.g., `[FromBody]`), the authorization handler runs before the body is bound. In that case you **must** use imperative authorization in the action body, not a declarative policy attribute.

**Always put admin resource IDs in the route** (e.g., `DELETE /swim-meets/{swimMeetId}`) rather than the request body for endpoints that require admin checks.

### 1.7 `services.AddHttpContextAccessor()` in .NET 9

**Not registered automatically.** You must add it explicitly:

```csharp
builder.Services.AddHttpContextAccessor(); // required — not auto-registered
```

However, as noted in §1.2, when using endpoint routing you can often avoid `IHttpContextAccessor` entirely by casting `context.Resource` as `HttpContext`. If you do inject `IHttpContextAccessor`, register it as a singleton (it is thread-safe):

```csharp
// Correct: AddHttpContextAccessor registers as singleton internally
builder.Services.AddHttpContextAccessor();
```

### Required NuGet Packages

| Package | Notes |
|---|---|
| `Microsoft.AspNetCore.Authorization` | Included in ASP.NET Core 9 shared framework |
| `Microsoft.Extensions.Caching.Memory` | Included in ASP.NET Core 9 shared framework |

### Reference URLs

- <https://learn.microsoft.com/en-us/aspnet/core/security/authorization/resourcebased?view=aspnetcore-9.0>
- <https://learn.microsoft.com/en-us/aspnet/core/security/authorization/policies?view=aspnetcore-9.0>

---

## Topic 2: Dapper Transactional Patterns for Multi-Table Admin Operations

### Summary

Dapper is a micro-ORM with no built-in Unit of Work. Transaction management is explicit. The patterns below cover the four Swimomatic transactional operations.

### 2.1 Core Dapper Transaction Pattern

```csharp
public async Task SaveSeasonWithSchemesAsync(Season season, ScoringScheme scheme1, ScoringScheme scheme2)
{
    await using var conn = new SqlConnection(_connectionString);
    await conn.OpenAsync();

    await using var tx = await conn.BeginTransactionAsync();
    try
    {
        // Each Dapper call receives the transaction explicitly
        var seasonId = await conn.ExecuteScalarAsync<int>(
            "INSERT INTO Season (...) OUTPUT INSERTED.SeasonID VALUES (@Name, @StartDate, @EndDate)",
            new { season.Name, season.StartDate, season.EndDate },
            transaction: tx);

        var scheme1Id = await conn.ExecuteScalarAsync<int>(
            "INSERT INTO ScoringScheme (...) OUTPUT INSERTED.ScoringSchemeID VALUES (@Name, @SeasonID)",
            new { scheme1.Name, SeasonID = seasonId },
            transaction: tx);

        var scheme2Id = await conn.ExecuteScalarAsync<int>(
            "INSERT INTO ScoringScheme (...) OUTPUT INSERTED.ScoringSchemeID VALUES (@Name, @SeasonID)",
            new { scheme2.Name, SeasonID = seasonId },
            transaction: tx);

        await conn.ExecuteAsync(
            "INSERT INTO SeasonScoringScheme (SeasonID, ScoringSchemeID, SortOrder) VALUES (@SeasonID, @SchemeID, @Sort)",
            new[] {
                new { SeasonID = seasonId, SchemeID = scheme1Id, Sort = 1 },
                new { SeasonID = seasonId, SchemeID = scheme2Id, Sort = 2 }
            },
            transaction: tx);

        await tx.CommitAsync();
    }
    catch
    {
        await tx.RollbackAsync();
        throw;
    }
}
```

**Key principles:**
- Open the connection, then begin the transaction on the same connection.
- Pass `transaction: tx` to every Dapper call.
- Use `await tx.RollbackAsync()` in the catch; re-throw to preserve the stack trace.
- `await using` ensures disposal even if commit/rollback throws.

### 2.2 `TransactionScope` (Ambient Transactions) — Use With Caution

`TransactionScope` works with SQL Server and Dapper because ADO.NET auto-enlists opened connections into the ambient transaction:

```csharp
// Works but NOT recommended for async code without careful options
using var scope = new TransactionScope(
    TransactionScopeOption.Required,
    new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted },
    TransactionScopeAsyncFlowOption.Enabled); // REQUIRED for async

await using var conn = new SqlConnection(_connectionString);
await conn.OpenAsync(); // auto-enlists

await conn.ExecuteAsync("INSERT INTO Season ...", season);
await conn.ExecuteAsync("INSERT INTO ScoringScheme ...", scheme);

scope.Complete(); // commit
```

**Gotchas with `TransactionScope`:**

1. You **must** pass `TransactionScopeAsyncFlowOption.Enabled` or the transaction context will be lost across `await` boundaries.
2. If you open two connections, SQL Server will escalate to a **Distributed Transaction (MSDTC)** — expensive and often disabled in modern environments.
3. `TransactionScope` with a single SQL Server connection remains a lightweight transaction (no MSDTC escalation).
4. **Recommendation:** For Swimomatic's single-database operations, prefer the explicit `BeginTransactionAsync()` pattern (§2.1). It is simpler, has no DTC risk, and does not require the ambient transaction infrastructure.

### 2.3 Clean Transactional Pattern — No Using-Statement Pyramid

Extract a reusable `ExecuteInTransactionAsync` helper to avoid nesting:

```csharp
// Infrastructure helper — register as a scoped service
public class DapperTransactionRunner
{
    private readonly string _connectionString;

    public DapperTransactionRunner(IConfiguration config)
        => _connectionString = config.GetConnectionString("Swimomatic")!;

    public async Task ExecuteAsync(Func<SqlConnection, SqlTransaction, Task> work)
    {
        await using var conn = new SqlConnection(_connectionString);
        await conn.OpenAsync();
        await using var tx = (SqlTransaction)await conn.BeginTransactionAsync();
        try
        {
            await work(conn, tx);
            await tx.CommitAsync();
        }
        catch
        {
            await tx.RollbackAsync();
            throw;
        }
    }

    public async Task<T> ExecuteAsync<T>(Func<SqlConnection, SqlTransaction, Task<T>> work)
    {
        await using var conn = new SqlConnection(_connectionString);
        await conn.OpenAsync();
        await using var tx = (SqlTransaction)await conn.BeginTransactionAsync();
        try
        {
            var result = await work(conn, tx);
            await tx.CommitAsync();
            return result;
        }
        catch
        {
            await tx.RollbackAsync();
            throw;
        }
    }
}
```

Usage — the `DeleteHeatSheetEvent` transactional cascade:

```csharp
public async Task DeleteHeatSheetEventAsync(int heatSheetEventId)
{
    await _txRunner.ExecuteAsync(async (conn, tx) =>
    {
        // Step 1: delete HeatSwimmers
        await conn.ExecuteAsync(
            @"DELETE hs FROM HeatSwimmer hs
              INNER JOIN Heat h ON hs.HeatID = h.HeatID
              WHERE h.HeatSheetEventID = @id",
            new { id = heatSheetEventId }, transaction: tx);

        // Step 2: delete Heats
        await conn.ExecuteAsync(
            "DELETE FROM Heat WHERE HeatSheetEventID = @id",
            new { id = heatSheetEventId }, transaction: tx);

        // Step 3: delete HeatSheetEvent (only if no Results exist — enforced by FK or pre-check)
        await conn.ExecuteAsync(
            "DELETE FROM HeatSheetEvent WHERE HeatSheetEventID = @id",
            new { id = heatSheetEventId }, transaction: tx);
    });
}
```

### 2.4 Connection Management: Per-Method vs Caller-Managed

**Recommendation: Caller (service layer) manages the connection lifetime for transactional operations.**

| Pattern | Pros | Cons |
|---|---|---|
| Repository opens/closes per method | Simple, no coordination needed | Cannot span multiple repositories in one transaction |
| Caller manages connection | Transactional operations across repositories | More coordination; repositories need to accept `(IDbConnection conn, IDbTransaction? tx)` |
| Unit of Work wrapping | Clean abstraction | More ceremony; may be over-engineering for Swimomatic |

For Swimomatic, the `DapperTransactionRunner` approach in §2.3 works well: the service method owns the connection + transaction lifetime and passes them down. Repositories become **stateless execution helpers** that accept the connection/transaction as parameters.

```csharp
public class HeatRepository
{
    // Stateless — accepts the ambient connection
    public Task DeleteByEventAsync(int eventId, SqlConnection conn, SqlTransaction tx)
        => conn.ExecuteAsync(
            "DELETE FROM Heat WHERE HeatSheetEventID = @id",
            new { id = eventId }, transaction: tx);
}
```

### 2.5 `IDbConnection` vs `SqlConnection` — Dapper Compatibility

- All Dapper extension methods (`QueryAsync`, `ExecuteAsync`, etc.) are defined on `IDbConnection` via extension methods — they work with any connection type.
- `BeginTransaction()` / `BeginTransactionAsync()` is defined on `SqlConnection` (the concrete type) and returns `SqlTransaction`.
- `IDbConnection.BeginTransaction()` returns `IDbTransaction`, which Dapper also accepts.

**Pattern: Accept `IDbConnection` in repositories; use `SqlConnection` in the service layer for transaction control:**

```csharp
// Repository parameter type — accepts any ADO.NET connection
public Task<IEnumerable<Heat>> GetByEventAsync(int eventId, IDbConnection conn, IDbTransaction? tx = null)
    => conn.QueryAsync<Heat>(
        "SELECT * FROM Heat WHERE HeatSheetEventID = @eventId",
        new { eventId }, transaction: tx);

// Service layer — uses concrete SqlConnection to call BeginTransactionAsync
await using var conn = new SqlConnection(_cs);
await conn.OpenAsync();
await using var tx = await conn.BeginTransactionAsync(); // returns DbTransaction (SqlTransaction)
await _heatRepo.GetByEventAsync(id, conn, tx);
```

**Note:** `BeginTransactionAsync()` returns `DbTransaction` (not `IDbTransaction`). Dapper accepts `IDbTransaction`, and `DbTransaction` implements `IDbTransaction`, so this is compatible.

---

## Topic 3: .NET 9 WebAPI Response for Blocked Delete Operations

### Summary

When a delete is blocked because dependent data exists (e.g., Results prevent deleting a SwimMeet), the correct HTTP status is **409 Conflict**, not 422. Use `ProblemDetails` for structured error responses.

### 3.1 Status Code Decision

| Status | When to Use |
|---|---|
| `409 Conflict` | The request conflicts with the current state of the resource (dependent records exist) |
| `422 Unprocessable Entity` | The request body is syntactically valid but semantically invalid (validation failures on input) |
| `400 Bad Request` | Malformed request |

For "blocked delete due to existing results," **409 Conflict** is semantically correct. The resource exists and cannot be deleted in its current state due to related data.

### 3.2 `ProblemDetails` — Recommended Response Body

`ProblemDetails` (RFC 7807) is the standard for .NET 9 WebAPI error responses:

```csharp
// Controller action
[HttpDelete("{swimMeetId:int}")]
[Authorize(Policy = "SwimMeetAdmin")]
[ProducesResponseType(StatusCodes.Status204NoContent)]
[ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status409Conflict)]
public async Task<IActionResult> DeleteSwimMeet(int swimMeetId)
{
    var hasResults = await _repo.SwimMeetHasResultsAsync(swimMeetId);
    if (hasResults)
    {
        return Conflict(new ProblemDetails
        {
            Title = "Cannot delete swim meet",
            Detail = "This swim meet has recorded results and cannot be deleted. " +
                     "Remove all results before deleting the meet.",
            Status = StatusCodes.Status409Conflict,
            Type = "https://swimomatic.app/errors/has-results",
            Extensions =
            {
                ["swimMeetId"] = swimMeetId
            }
        });
    }

    await _repo.DeleteSwimMeetAsync(swimMeetId);
    return NoContent();
}
```

### 3.3 Using `Results.Problem()` / `TypedResults.Problem()` (Minimal API style in controllers)

`Results.Problem()` is designed for **Minimal API endpoints**, not controller actions. In controllers, `Conflict(new ProblemDetails {...})` is the idiomatic equivalent.

However, if you ever use Minimal APIs in the same project, the pattern is:

```csharp
// Minimal API equivalent
app.MapDelete("/swim-meets/{swimMeetId:int}", async (int swimMeetId, ISwimMeetRepository repo) =>
{
    var hasResults = await repo.SwimMeetHasResultsAsync(swimMeetId);
    if (hasResults)
    {
        return Results.Problem(
            title: "Cannot delete swim meet",
            detail: "This swim meet has recorded results and cannot be deleted.",
            statusCode: StatusCodes.Status409Conflict,
            type: "https://swimomatic.app/errors/has-results");
    }

    await repo.DeleteSwimMeetAsync(swimMeetId);
    return Results.NoContent();
});
```

### 3.4 Global ProblemDetails Configuration (.NET 9)

Register `ProblemDetails` services globally so all error responses are consistent:

```csharp
builder.Services.AddProblemDetails(options =>
{
    options.CustomizeProblemDetails = ctx =>
    {
        ctx.ProblemDetails.Extensions["traceId"] =
            Activity.Current?.Id ?? ctx.HttpContext.TraceIdentifier;
    };
});
```

This ensures 4xx and 5xx responses automatically include `traceId` for correlation.

### 3.5 Custom Error Response DTO vs ProblemDetails

**Prefer `ProblemDetails`.** Reasons:
- It is the RFC 7807 standard — clients can handle it predictably.
- ASP.NET Core 9 returns `ProblemDetails` automatically for model validation failures (via `[ApiController]`).
- Swagger/OpenAPI tooling understands `ProblemDetails`.
- No custom serialization needed.

Only use a custom DTO if you have very specific structural requirements that `ProblemDetails.Extensions` cannot accommodate.

---

## Topic 4: @dnd-kit for Heat Sheet Event Resequencing in React

### Summary

`@dnd-kit` is the modern React drag-and-drop library recommended to replace jQuery UI sortable. It is accessibility-first, works without a DOM plugin, and integrates cleanly with TanStack Query v5.

### 4.1 `@dnd-kit/sortable` SortableContext + `arrayMove` Pattern

**Install:**

```bash
npm install @dnd-kit/core @dnd-kit/sortable @dnd-kit/utilities
```

**Vertical sortable list component:**

```tsx
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
  DragEndEvent,
} from '@dnd-kit/core';
import {
  arrayMove,
  SortableContext,
  sortableKeyboardCoordinates,
  verticalListSortingStrategy,
  useSortable,
} from '@dnd-kit/sortable';
import { CSS } from '@dnd-kit/utilities';

// ---- Sortable Item ----
interface SortableItemProps {
  id: number;
  label: string;
}

function SortableItem({ id, label }: SortableItemProps) {
  const { attributes, listeners, setNodeRef, transform, transition, isDragging } =
    useSortable({ id });

  const style: React.CSSProperties = {
    transform: CSS.Transform.toString(transform),
    transition,
    opacity: isDragging ? 0.5 : 1,
    cursor: 'grab',
  };

  return (
    <li ref={setNodeRef} style={style} {...attributes} {...listeners}>
      {label}
    </li>
  );
}

// ---- Sortable List ----
interface HeatSheetEvent {
  heatSheetEventId: number;
  description: string;
}

interface Props {
  heatSheetId: number;
  events: HeatSheetEvent[];
  onResequence: (orderedIds: number[]) => void;
}

export function SortableHeatSheetEventList({ heatSheetId, events, onResequence }: Props) {
  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates, // accessibility
    })
  );

  const handleDragEnd = (event: DragEndEvent) => {
    const { active, over } = event;
    if (!over || active.id === over.id) return;

    const oldIndex = events.findIndex((e) => e.heatSheetEventId === active.id);
    const newIndex = events.findIndex((e) => e.heatSheetEventId === over.id);
    const reordered = arrayMove(events, oldIndex, newIndex);

    // Fire API call ONLY on drag-end, not on intermediate moves
    onResequence(reordered.map((e) => e.heatSheetEventId));
  };

  return (
    <DndContext sensors={sensors} collisionDetection={closestCenter} onDragEnd={handleDragEnd}>
      <SortableContext
        items={events.map((e) => e.heatSheetEventId)}
        strategy={verticalListSortingStrategy}
      >
        <ul>
          {events.map((event) => (
            <SortableItem
              key={event.heatSheetEventId}
              id={event.heatSheetEventId}
              label={event.description}
            />
          ))}
        </ul>
      </SortableContext>
    </DndContext>
  );
}
```

### 4.2 Firing the API Call Only on Drag-End

`@dnd-kit` fires callbacks for each drag phase:

| Callback | When it fires |
|---|---|
| `onDragStart` | User picks up item |
| `onDragMove` | Every pointer move (many times per second) |
| `onDragOver` | Item hovers over a new droppable |
| `onDragEnd` | User drops item — **call API here** |
| `onDragCancel` | Drag cancelled (e.g., Escape key) |

**The `onDragEnd` callback fires exactly once per drag interaction.** Do not call the API in `onDragMove` or `onDragOver`.

```tsx
// Correct — API call in onDragEnd only
const handleDragEnd = (event: DragEndEvent) => {
  const { active, over } = event;
  if (!over || active.id === over.id) return;

  // Recompute order locally
  const reordered = arrayMove(localItems, oldIndex, newIndex);

  // Single API call
  resequenceMutation.mutate({ heatSheetId, orderedIds: reordered.map((e) => e.id) });
};
```

### 4.3 Optimistic Update with TanStack Query v5

TanStack Query v5 introduces a slight signature change in `onMutate` — the `context` (with `client`) is the first argument:

```tsx
import { useMutation, useQueryClient } from '@tanstack/react-query';

interface ResequencePayload {
  heatSheetId: number;
  orderedIds: number[];
}

function useResequenceEvents(heatSheetId: number) {
  const queryClient = useQueryClient();
  const queryKey = ['heatSheetEvents', heatSheetId];

  return useMutation<void, Error, ResequencePayload>({
    mutationFn: (payload) =>
      fetch(`/api/heat-sheets/${payload.heatSheetId}/events/resequence`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ orderedIds: payload.orderedIds }),
      }).then((r) => { if (!r.ok) throw new Error('Resequence failed'); }),

    onMutate: async (payload) => {
      // Cancel any in-flight refetches that would overwrite our optimistic update
      await queryClient.cancelQueries({ queryKey });

      // Snapshot current data for rollback
      const previousEvents = queryClient.getQueryData<HeatSheetEvent[]>(queryKey);

      // Optimistically reorder the cache
      if (previousEvents) {
        const reordered = payload.orderedIds
          .map((id) => previousEvents.find((e) => e.heatSheetEventId === id))
          .filter(Boolean) as HeatSheetEvent[];
        queryClient.setQueryData(queryKey, reordered);
      }

      return { previousEvents }; // passed to onError as context
    },

    onError: (_err, _payload, context) => {
      // Roll back to the snapshot
      if (context?.previousEvents) {
        queryClient.setQueryData(queryKey, context.previousEvents);
      }
    },

    onSettled: () => {
      // Always refetch to reconcile with server state
      queryClient.invalidateQueries({ queryKey });
    },
  });
}
```

**Usage with the sortable list:**

```tsx
function HeatSheetEventAdmin({ heatSheetId }: { heatSheetId: number }) {
  const { data: events = [] } = useQuery({
    queryKey: ['heatSheetEvents', heatSheetId],
    queryFn: () => fetch(`/api/heat-sheets/${heatSheetId}/events`).then((r) => r.json()),
  });

  const { mutate: resequence } = useResequenceEvents(heatSheetId);

  return (
    <SortableHeatSheetEventList
      heatSheetId={heatSheetId}
      events={events}
      onResequence={(orderedIds) => resequence({ heatSheetId, orderedIds })}
    />
  );
}
```

> **TanStack Query v5 Note:** The `onMutate` signature changed — the second argument is now a context object with a `client` property. The example above uses the hook-level `useQueryClient()` (the recommended pattern), which avoids the context parameter altogether.

### 4.4 Accessibility Considerations

`@dnd-kit` has first-class accessibility support:

1. **Keyboard sorting** via `sortableKeyboardCoordinates` — users can Tab to items and use Space to pick up, arrow keys to move, Space/Enter to drop.
2. **Screen reader announcements** — `DndContext` accepts an `accessibility` prop with `announcements` and `screenReaderInstructions` to provide meaningful ARIA live region output:

```tsx
<DndContext
  sensors={sensors}
  collisionDetection={closestCenter}
  onDragEnd={handleDragEnd}
  accessibility={{
    announcements: {
      onDragStart({ active }) {
        return `Picked up event: ${getEventLabel(active.id)}.`;
      },
      onDragOver({ active, over }) {
        if (over) {
          return `Event ${getEventLabel(active.id)} is over position ${getPosition(over.id)}.`;
        }
      },
      onDragEnd({ active, over }) {
        if (over) {
          return `Event ${getEventLabel(active.id)} was dropped at position ${getPosition(over.id)}.`;
        }
      },
      onDragCancel({ active }) {
        return `Sorting cancelled. Event ${getEventLabel(active.id)} was returned to its original position.`;
      },
    },
  }}
>
```

3. **Touch support** — `PointerSensor` handles mouse, touch, and stylus. No separate mobile implementation needed.
4. **Drag overlay** — Use `DragOverlay` to show a lifted clone of the dragged item at pointer position:

```tsx
const [activeId, setActiveId] = useState<number | null>(null);

<DndContext
  onDragStart={({ active }) => setActiveId(active.id as number)}
  onDragEnd={(e) => { setActiveId(null); handleDragEnd(e); }}
  onDragCancel={() => setActiveId(null)}
>
  {/* ... sortable context */}
  <DragOverlay>
    {activeId != null && (
      <div className="drag-overlay">{getEventLabel(activeId)}</div>
    )}
  </DragOverlay>
</DndContext>
```

The `DragOverlay` renders in a portal at the document root, avoiding CSS transform / overflow clipping issues common with jQuery UI sortable.

### npm Packages

| Package | Version | Purpose |
|---|---|---|
| `@dnd-kit/core` | ^6.x | Core drag-and-drop primitives |
| `@dnd-kit/sortable` | ^8.x | `useSortable`, `SortableContext`, `arrayMove` |
| `@dnd-kit/utilities` | ^3.x | `CSS.Transform.toString` utility |
| `@tanstack/react-query` | ^5.x | Server state + optimistic updates |

---

## Gotchas & Caveats Summary

### Authorization
- **Handler lifetime:** Register `IAuthorizationHandler` implementations as `Scoped` (not `Singleton`) when they inject scoped services like `IAdminRepository`. Registering as `Singleton` while injecting a scoped dependency causes a captive dependency runtime error.
- **Route parameter naming:** Route parameter names in the handler must exactly match the route template (e.g., `{swimMeetId}` → `RouteValues["swimMeetId"]`).
- **Auth0 sub claim:** Auth0 maps the `sub` claim to `ClaimTypes.NameIdentifier` in the default JWT handler. Confirm with `context.User.FindFirstValue(ClaimTypes.NameIdentifier)` not `"sub"` directly.
- **Handler registration order matters for `context.Fail()`:** By default all handlers run even after one fails (`InvokeHandlersAfterFailure = true`). Set it to `false` for early-exit on explicit denial.

### Dapper Transactions
- **Async + `await using`:** Always `await conn.OpenAsync()` before `BeginTransactionAsync()`. Never open the connection inside the `using` block — it will dispose before you use it.
- **`BeginTransactionAsync()` vs `BeginTransaction()`:** `BeginTransactionAsync()` returns `DbTransaction`. Use `await using` (not just `using`) to properly async-dispose it.
- **`TransactionScope` + MSDTC:** Using two separate `SqlConnection` objects inside one `TransactionScope` will escalate to a Distributed Transaction. This requires MSDTC to be configured, which is often unavailable in containerized/Azure environments. Use a single connection per transaction.
- **Isolation level:** Default for `BeginTransaction()` is `ReadCommitted` on SQL Server. This is usually correct. Only escalate to `Serializable` if you need to prevent phantom reads.

### HTTP Responses
- **`Conflict()` helper returns `ObjectResult` with status 409.** It accepts any object as the value, so `return Conflict(problemDetails)` works in controller-based APIs.
- **`[ApiController]` automatically wraps validation errors as `ProblemDetails` with 400.** This means your 409 for blocked deletes requires explicit construction — it is not automatic.
- **`type` field in `ProblemDetails`:** Use a URI. If you don't have a documentation URL yet, use `about:blank` as a placeholder, or a path like `https://yourapi/errors/has-results`.

### @dnd-kit
- **`items` prop in `SortableContext` must use stable IDs** (not array indices). Using indices will cause incorrect animations when the list reorders. Use the `heatSheetEventId` integer.
- **`arrayMove` from `@dnd-kit/sortable`:** Imported directly from the sortable package — do not re-implement it or use `Array.prototype.splice` (mutates the original array).
- **`DragOverlay` is optional but strongly recommended** — without it, the dragged element disappears from its original position during drag, which confuses users.
- **TanStack Query v5:** `onMutate` context is now typed differently. The `context` variable returned from `onMutate` is passed as the third argument to `onError` and `onSettled`. TypeScript will enforce the correct shape if you type your `useMutation` generics.

---

## Recommended Next Research

1. **Auth0 JWT validation setup for .NET 9** — specifically mapping the `sub` claim and verifying audience/issuer configuration with `Microsoft.AspNetCore.Authentication.JwtBearer`.
2. **Dapper `QueryMultiple`** — for the batched admin status check (§1.3), consider using `conn.QueryMultiple` with a multi-result-set stored procedure or multi-statement query to reduce round trips further.
3. **`PATCH` resequence endpoint design** — research whether to accept an ordered array of IDs or an array of `{ id, sortOrder }` objects; the latter is more resilient to concurrent updates.
4. **`@dnd-kit` auto-scroll for long heat sheet event lists** — the `@dnd-kit/modifiers` package and the `autoScrollEnabled` option on `DndContext` for better UX when the list is longer than the viewport.
5. **SQL Server `OUTPUT` clause in Dapper transactions** — confirm that `OUTPUT INSERTED.ID` works correctly when the insert is part of a transaction (it does, but good to document the pattern explicitly).
