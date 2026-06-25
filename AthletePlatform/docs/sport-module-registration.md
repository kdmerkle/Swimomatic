# Sport Module Registration

Modules registered in `Program.cs`:

| Module | SportCode | Status |
|--------|-----------|--------|
| `SwimModule` | `swim` | Active |
| `TrackFieldModule` | `tf` | Scaffolded (WI-02 required for full implementation) |

## Adding a New Sport

1. Create a new class library project (e.g., `BasketballDomain.csproj`)
2. Implement `ISportModule` with `SportCode`, `RegisterServices`, and optionally `MapEndpoints`
3. Add migrations for `{sport}.*` schema tables
4. Register the module in `Program.cs` `modules` list
5. Add sport to `dbo.Sport` seed data
6. Register routes in `App.tsx` `AppRoutes` component
7. Create React `features/{sport}/` directory with `{Sport}Routes.tsx`
