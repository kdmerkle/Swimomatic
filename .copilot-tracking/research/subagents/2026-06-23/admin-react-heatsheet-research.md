# Admin React Heat Sheet Research

**Date:** 2026-06-23  
**Context:** Swimomatic modernization — ASP.NET MVC 3 → .NET 9 WebAPI + React SPA  
**Tech stack:** Vite + React + TypeScript, TanStack Query v5, shadcn/ui + Tailwind CSS, React Router v7, @auth0/auth0-react

---

## Existing Domain Model (from legacy codebase)

Key entities reverse-engineered from the legacy MVC controllers and data layer:

```
HeatSheet         { HeatSheetID, SwimMeetID, PoolConfigID }
HeatSheetEvent    { HeatSheetEventID, HeatSheetID, SwimEventID, Distance, Sequence }
Heat              { HeatID, HeatSheetEventID, HeatNumber }
HeatSwimmer       { HeatSwimmerID, HeatID, LaneNumber, SwimmerTeamSeasonID, Leg, SeedResultID }
                  + denormalized: FirstName, LastName, Abbrev, SeedTime, Description
```

The legacy `IncrementLane` action supported both individual and relay swimmers (`IsRelay` flag). The `ResequenceHeatSheetEvents` action accepted a `ViewHeatSheetEventSequence` containing a reordered list of IDs.

---

## Topic 1 — Heat Grid Component Architecture

### Decision: `<table>` over CSS Grid

Use an HTML `<table>` for the heat grid. Rationale:

- **Accessibility**: Screen readers announce table row/column headers automatically. ARIA roles (`role="grid"`, `aria-rowheader`, `aria-colindex`) are native to `<table>` semantics; replicating them on `<div>` grids requires significant extra ARIA work.
- **Keyboard navigation**: `<table>` with `tabIndex` on cells provides predictable arrow-key navigation patterns that screen-reader users expect from grids.
- **Column alignment**: Columns stay aligned across rows by definition; CSS Grid can misalign if cells contain varied content heights.
- **shadcn/ui Table**: Ships as a thin wrapper over `<table>` elements and integrates cleanly.

**Gotcha**: Tailwind's default `border-collapse` behavior differs by browser. Always apply `border-collapse: collapse` explicitly on the `<table>`.

### Cell State Management

Track active cell (the one waiting for swimmer assignment) in a single `useState` at the parent `HeatGrid` component level:

```tsx
// types.ts
export interface CellKey {
  heatId: number;
  lane: number;
}

// HeatGrid.tsx
const [activeCell, setActiveCell] = useState<CellKey | null>(null);

const handleCellClick = (heatId: number, lane: number, isEmpty: boolean) => {
  if (!isEmpty) return; // occupied cells handled separately
  setActiveCell((prev) =>
    prev?.heatId === heatId && prev?.lane === lane ? null : { heatId, lane }
  );
};
```

Passing `activeCell` down as a prop is sufficient — there are at most ~48 cells (8 lanes × 6 heats), so prop drilling two levels is acceptable without a context provider.

### Swimmer Selection Panel: Popover vs. Dialog

| Pattern | When to use |
|---|---|
| **Popover** (shadcn/ui `Popover`) | When the panel is small and positional context matters (i.e., the user needs to see the cell while selecting). Good for ≤ 10 swimmers. |
| **Dialog** (shadcn/ui `Dialog`) | When the swimmer list is long (dozens of eligible swimmers) or needs its own scroll region. Preferred for the heat grid cell assignment. |
| **Sheet** (shadcn/ui `Sheet`) | Right-side drawer; good for the eligible swimmers seeding panel. |

**Recommendation**: Use a `Dialog` for cell assignment. The swimmer list can be long, and the modal keeps focus trapped, improving keyboard accessibility.

```tsx
// HeatCell.tsx
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";

interface HeatCellProps {
  heatId: number;
  lane: number;
  swimmer: HeatSwimmerDto | null;
  isActive: boolean;
  isAdmin: boolean;
  onCellClick: (heatId: number, lane: number) => void;
  onRemoveSwimmer: (heatSwimmerId: number) => void;
  onMoveLane: (heatSwimmerId: number, direction: -1 | 1, isRelay: boolean) => void;
}

export function HeatCell({
  heatId, lane, swimmer, isActive, isAdmin,
  onCellClick, onRemoveSwimmer, onMoveLane,
}: HeatCellProps) {
  if (!swimmer) {
    return (
      <td
        className={cn(
          "border border-border h-16 w-28 cursor-pointer text-center text-muted-foreground text-xs",
          isActive && "bg-primary/10 ring-2 ring-primary ring-inset"
        )}
        onClick={() => isAdmin && onCellClick(heatId, lane)}
        aria-label={`Lane ${lane}, empty. Click to assign swimmer.`}
        tabIndex={isAdmin ? 0 : -1}
        onKeyDown={(e) => e.key === "Enter" && isAdmin && onCellClick(heatId, lane)}
      >
        {isAdmin ? "+" : "—"}
      </td>
    );
  }

  return (
    <td
      className="border border-border h-16 w-28 px-1 py-0.5 align-top"
      aria-label={`Lane ${lane}: ${swimmer.firstName} ${swimmer.lastName}`}
    >
      <div className="flex flex-col gap-0.5">
        <span className="text-xs font-medium truncate">
          {swimmer.lastName}, {swimmer.firstName}
        </span>
        <Badge variant="secondary" className="w-fit text-[10px]">
          {swimmer.teamAbbrev}
        </Badge>
        <span className="text-[10px] text-muted-foreground">
          {formatSeedTime(swimmer.seedTime)}
        </span>
        {isAdmin && (
          <div className="flex gap-0.5 mt-0.5">
            <Button
              size="icon"
              variant="ghost"
              className="h-4 w-4"
              onClick={() => onMoveLane(swimmer.heatSwimmerId, -1, swimmer.isRelay)}
              aria-label="Move swimmer left one lane"
            >
              ←
            </Button>
            <Button
              size="icon"
              variant="ghost"
              className="h-4 w-4"
              onClick={() => onRemoveSwimmer(swimmer.heatSwimmerId)}
              aria-label={`Remove ${swimmer.firstName} ${swimmer.lastName}`}
            >
              ×
            </Button>
            <Button
              size="icon"
              variant="ghost"
              className="h-4 w-4"
              onClick={() => onMoveLane(swimmer.heatSwimmerId, 1, swimmer.isRelay)}
              aria-label="Move swimmer right one lane"
            >
              →
            </Button>
          </div>
        )}
      </div>
    </td>
  );
}
```

### Full Grid Component Skeleton

```tsx
// HeatGrid.tsx
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";

interface HeatGridProps {
  heatSheetEventId: number;
  laneCount: number;           // from PoolConfig
  heats: HeatDto[];            // sorted by HeatNumber
  isAdmin: boolean;
}

export function HeatGrid({ heatSheetEventId, laneCount, heats, isAdmin }: HeatGridProps) {
  const [activeCell, setActiveCell] = useState<CellKey | null>(null);
  const [assignDialogOpen, setAssignDialogOpen] = useState(false);

  const lanes = Array.from({ length: laneCount }, (_, i) => i + 1);

  const getSwimmer = (heatId: number, lane: number): HeatSwimmerDto | null => {
    const heat = heats.find((h) => h.heatId === heatId);
    return heat?.swimmers.find((s) => s.laneNumber === lane) ?? null;
  };

  const handleCellClick = (heatId: number, lane: number) => {
    setActiveCell({ heatId, lane });
    setAssignDialogOpen(true);
  };

  return (
    <>
      <Table className="border-collapse table-fixed w-full">
        <TableHeader>
          <TableRow>
            <TableHead className="w-16">Heat</TableHead>
            {lanes.map((l) => (
              <TableHead key={l} className="text-center w-28">
                Lane {l}
              </TableHead>
            ))}
          </TableRow>
        </TableHeader>
        <TableBody>
          {heats.map((heat) => (
            <TableRow key={heat.heatId}>
              <TableCell className="font-medium">{heat.heatNumber}</TableCell>
              {lanes.map((lane) => (
                <HeatCell
                  key={lane}
                  heatId={heat.heatId}
                  lane={lane}
                  swimmer={getSwimmer(heat.heatId, lane)}
                  isActive={activeCell?.heatId === heat.heatId && activeCell?.lane === lane}
                  isAdmin={isAdmin}
                  onCellClick={handleCellClick}
                  onRemoveSwimmer={/* mutation callback */}
                  onMoveLane={/* mutation callback */}
                />
              ))}
            </TableRow>
          ))}
        </TableBody>
      </Table>

      {/* Swimmer assignment dialog */}
      {activeCell && (
        <AssignSwimmerDialog
          open={assignDialogOpen}
          onOpenChange={setAssignDialogOpen}
          heatSheetEventId={heatSheetEventId}
          heatId={activeCell.heatId}
          lane={activeCell.lane}
          onAssigned={() => { setAssignDialogOpen(false); setActiveCell(null); }}
        />
      )}
    </>
  );
}
```

### shadcn/ui Components Used

| Component | Import Path | Usage |
|---|---|---|
| `Table`, `TableBody`, etc. | `@/components/ui/table` | Grid skeleton |
| `Badge` | `@/components/ui/badge` | Team abbreviation chip |
| `Button` | `@/components/ui/button` | Arrow move, remove buttons |
| `Dialog`, `DialogContent` | `@/components/ui/dialog` | Swimmer assignment panel |
| `Popover` | `@/components/ui/popover` | Tooltip / lightweight option |

### npm Packages

No additional packages needed beyond the base stack. shadcn/ui's `table` component is built-in.

---

## Topic 2 — Optimistic Updates for Lane Swap Operations

### Core Pattern: `useMutation` with `onMutate`

TanStack Query v5 optimistic update flow:

```
1. onMutate  → snapshot previous cache, apply optimistic update
2. mutationFn → fire API call
3. onError   → rollback to snapshot
4. onSettled → invalidate query to resync from server
```

### Type Definitions

```ts
// types.ts
export interface HeatDto {
  heatId: number;
  heatNumber: number;
  heatSheetEventId: number;
  swimmers: HeatSwimmerDto[];
}

export interface HeatSwimmerDto {
  heatSwimmerId: number;
  laneNumber: number;
  swimmerTeamSeasonId: number;
  firstName: string;
  lastName: string;
  teamAbbrev: string;
  seedTime: number;
  isRelay: boolean;
  leg: number;
}

export interface IncrementLaneRequest {
  heatId: number;
  heatSwimmerId: number;
  move: -1 | 1;        // -1 = left, 1 = right
  isRelay: boolean;
}
```

### Client-Side Swap Logic

When a swimmer moves to a new lane, another swimmer may already occupy it. The optimistic update must perform the swap locally:

```ts
function applyLaneSwap(
  heats: HeatDto[],
  heatId: number,
  heatSwimmerId: number,
  move: -1 | 1,
  isRelay: boolean
): HeatDto[] {
  return heats.map((heat) => {
    if (heat.heatId !== heatId) return heat;

    const mover = heat.swimmers.find((s) => s.heatSwimmerId === heatSwimmerId);
    if (!mover) return heat;

    const targetLane = mover.laneNumber + move;

    // For relay: find all swimmers sharing the same original lane (legs 1-4)
    const moverLaneNumbers = isRelay
      ? heat.swimmers
          .filter((s) => s.laneNumber === mover.laneNumber)
          .map((s) => s.laneNumber)
      : [mover.laneNumber];

    const displaced = heat.swimmers.filter((s) => s.laneNumber === targetLane);

    const updated = heat.swimmers.map((s) => {
      if (isRelay && s.laneNumber === mover.laneNumber) {
        return { ...s, laneNumber: targetLane };
      }
      if (!isRelay && s.heatSwimmerId === heatSwimmerId) {
        return { ...s, laneNumber: targetLane };
      }
      if (displaced.some((d) => d.heatSwimmerId === s.heatSwimmerId)) {
        return { ...s, laneNumber: mover.laneNumber };
      }
      return s;
    });

    return { ...heat, swimmers: updated };
  });
}
```

### `useIncrementLane` Mutation Hook

```tsx
// hooks/useIncrementLane.ts
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { heatKeys } from "@/lib/queryKeys";
import { applyLaneSwap } from "@/lib/heatGridUtils";

export function useIncrementLane(heatSheetEventId: number) {
  const queryClient = useQueryClient();
  const queryKey = heatKeys.byEvent(heatSheetEventId);

  return useMutation({
    mutationFn: (req: IncrementLaneRequest) =>
      apiClient.post(`/api/heats/${req.heatId}/swimmers/${req.heatSwimmerId}/lane`, {
        move: req.move,
        isRelay: req.isRelay,
      }),

    onMutate: async (req) => {
      // Cancel in-flight refetches so they don't overwrite our optimistic data
      await queryClient.cancelQueries({ queryKey });

      // Snapshot previous state for rollback
      const previousHeats = queryClient.getQueryData<HeatDto[]>(queryKey);

      // Apply optimistic update
      queryClient.setQueryData<HeatDto[]>(queryKey, (old = []) =>
        applyLaneSwap(old, req.heatId, req.heatSwimmerId, req.move, req.isRelay)
      );

      return { previousHeats };
    },

    onError: (_err, _req, context) => {
      // Rollback on failure
      if (context?.previousHeats) {
        queryClient.setQueryData(queryKey, context.previousHeats);
      }
    },

    onSettled: () => {
      // Always resync from server after success or error
      queryClient.invalidateQueries({ queryKey });
    },
  });
}
```

### Query Key Factory (v5 pattern)

```ts
// lib/queryKeys.ts
export const heatKeys = {
  all: ["heats"] as const,
  byEvent: (heatSheetEventId: number) =>
    [...heatKeys.all, "event", heatSheetEventId] as const,
};
```

### Debouncing Decision

**Do NOT debounce.** Reasons:

1. Lane swap is a discrete state change, not a continuous value (it's not typing in a search box).
2. Debouncing complicates rollback — if two moves fire before the debounce timer elapses, you need to queue them, which adds complexity with no real gain since the API is fast.
3. The optimistic update makes the UI feel instant regardless of network latency.
4. **Do** add a brief `disabled` state on the arrow buttons for the duration of the mutation (`isPending`) to prevent double-firing.

```tsx
const { mutate: moveLane, isPending } = useIncrementLane(heatSheetEventId);

<Button
  disabled={isPending}
  onClick={() => moveLane({ heatId, heatSwimmerId, move: 1, isRelay })}
>
  →
</Button>
```

### Relay Lane Swap

The `applyLaneSwap` function above already handles the relay case: when `isRelay === true`, it finds all swimmers sharing the same `laneNumber` (legs 1–4) and moves them as a unit to the target lane, swapping the entire other relay team back.

### Error Recovery

The `onError` handler in the mutation hook restores `context.previousHeats`. The `onSettled` handler then re-fetches so that the server is the source of truth. This means:

- Brief flicker visible: optimistic state shows → API fails → reverts → server fetch completes.
- Acceptable UX for an admin tool; consider adding a `toast` notification on error.

```tsx
onError: (_err, _req, context) => {
  if (context?.previousHeats) {
    queryClient.setQueryData(queryKey, context.previousHeats);
  }
  toast.error("Lane move failed. Changes reverted.");
},
```

---

## Topic 3 — Eligible Swimmer Selection for Seeding

### DataTable with Multi-Select Checkboxes

shadcn/ui DataTable is built on TanStack Table v8. The multi-select pattern uses a `rowSelection` state object keyed by row index.

```tsx
// EligibleSwimmersTable.tsx
import {
  useReactTable,
  getCoreRowModel,
  flexRender,
  ColumnDef,
  RowSelectionState,
} from "@tanstack/react-table";
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";
import { Checkbox } from "@/components/ui/checkbox";

interface EligibleSwimmerDto {
  swimmerTeamSeasonId: number;
  firstName: string;
  lastName: string;
  teamAbbrev: string;
  seedTime: number;
  ageClass: string;
}

interface EligibleSwimmersTableProps {
  swimmers: EligibleSwimmerDto[];
  selectedIds: Set<number>;
  onSelectionChange: (ids: Set<number>) => void;
}

const columns: ColumnDef<EligibleSwimmerDto>[] = [
  {
    id: "select",
    header: ({ table }) => (
      <Checkbox
        checked={table.getIsAllPageRowsSelected()}
        onCheckedChange={(v) => table.toggleAllPageRowsSelected(!!v)}
        aria-label="Select all"
      />
    ),
    cell: ({ row }) => (
      <Checkbox
        checked={row.getIsSelected()}
        onCheckedChange={(v) => row.toggleSelected(!!v)}
        aria-label={`Select ${row.original.firstName} ${row.original.lastName}`}
      />
    ),
    enableSorting: false,
  },
  {
    accessorKey: "lastName",
    header: "Name",
    cell: ({ row }) =>
      `${row.original.lastName}, ${row.original.firstName}`,
  },
  {
    accessorKey: "teamAbbrev",
    header: "Team",
  },
  {
    accessorKey: "seedTime",
    header: "Seed Time",
    cell: ({ row }) => formatSeedTime(row.original.seedTime),
  },
  {
    accessorKey: "ageClass",
    header: "Age Class",
  },
];

export function EligibleSwimmersTable({
  swimmers,
  selectedIds,
  onSelectionChange,
}: EligibleSwimmersTableProps) {
  // Map external Set<number> → TanStack Table's rowSelection object
  const rowSelection: RowSelectionState = useMemo(() => {
    const state: RowSelectionState = {};
    swimmers.forEach((s, i) => {
      if (selectedIds.has(s.swimmerTeamSeasonId)) state[i] = true;
    });
    return state;
  }, [swimmers, selectedIds]);

  const table = useReactTable({
    data: swimmers,
    columns,
    state: { rowSelection },
    enableRowSelection: true,
    onRowSelectionChange: (updater) => {
      const next =
        typeof updater === "function" ? updater(rowSelection) : updater;
      // Convert back to Set<number>
      const newIds = new Set<number>(
        Object.entries(next)
          .filter(([, selected]) => selected)
          .map(([idx]) => swimmers[Number(idx)].swimmerTeamSeasonId)
      );
      onSelectionChange(newIds);
    },
    getCoreRowModel: getCoreRowModel(),
  });

  return (
    <Table>
      <TableHeader>
        {table.getHeaderGroups().map((hg) => (
          <TableRow key={hg.id}>
            {hg.headers.map((h) => (
              <TableHead key={h.id}>
                {flexRender(h.column.columnDef.header, h.getContext())}
              </TableHead>
            ))}
          </TableRow>
        ))}
      </TableHeader>
      <TableBody>
        {table.getRowModel().rows.map((row) => (
          <TableRow key={row.id} data-state={row.getIsSelected() ? "selected" : undefined}>
            {row.getVisibleCells().map((cell) => (
              <TableCell key={cell.id}>
                {flexRender(cell.column.columnDef.def, cell.getContext())}
              </TableCell>
            ))}
          </TableRow>
        ))}
      </TableBody>
    </Table>
  );
}
```

### Local State for Selected Swimmer IDs

Keep selected IDs in component-local state in the parent seeding panel, **not** in the query cache. This is ephemeral UI state — it only persists until the user seeds or closes the panel.

```tsx
// SeedingPanel.tsx
export function SeedingPanel({ heatSheetEventId }: { heatSheetEventId: number }) {
  const [selectedIds, setSelectedIds] = useState<Set<number>>(new Set());
  const [confirmOpen, setConfirmOpen] = useState(false);

  const { data: eligibleSwimmers } = useQuery({
    queryKey: ["eligibleSwimmers", heatSheetEventId],
    queryFn: () => apiClient.get<EligibleSwimmerDto[]>(
      `/api/heatsheetevents/${heatSheetEventId}/eligible-swimmers`
    ),
  });

  const seedMutation = useSeedHeatSheetEvent(heatSheetEventId);

  const handleSeedClick = () => {
    if (selectedIds.size === 0) return;
    setConfirmOpen(true);
  };

  const handleConfirmSeed = () => {
    setConfirmOpen(false);
    seedMutation.mutate(
      { heatSheetEventId, swimmerTeamSeasonIds: Array.from(selectedIds) },
      { onSuccess: () => setSelectedIds(new Set()) }
    );
  };

  return (
    <>
      <EligibleSwimmersTable
        swimmers={eligibleSwimmers ?? []}
        selectedIds={selectedIds}
        onSelectionChange={setSelectedIds}
      />
      <Button
        disabled={selectedIds.size === 0 || seedMutation.isPending}
        onClick={handleSeedClick}
      >
        Seed {selectedIds.size} Swimmer{selectedIds.size !== 1 ? "s" : ""}
      </Button>

      <AlertDialog open={confirmOpen} onOpenChange={setConfirmOpen}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Seed Heat Sheet Event?</AlertDialogTitle>
            <AlertDialogDescription>
              Seeding will overwrite all existing lane assignments for this event.
              This cannot be undone.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction onClick={handleConfirmSeed}>
              Seed {selectedIds.size} Swimmers
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </>
  );
}
```

### Seeding Mutation + Post-Seed Refresh

```ts
// hooks/useSeedHeatSheetEvent.ts
export function useSeedHeatSheetEvent(heatSheetEventId: number) {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (req: { heatSheetEventId: number; swimmerTeamSeasonIds: number[] }) =>
      apiClient.post(`/api/heatsheetevents/${req.heatSheetEventId}/seed`, {
        swimmerTeamSeasonIds: req.swimmerTeamSeasonIds,
      }),

    onSuccess: () => {
      // Invalidate both the heats grid and the event list (seeding creates heats)
      queryClient.invalidateQueries({ queryKey: heatKeys.byEvent(heatSheetEventId) });
      queryClient.invalidateQueries({
        queryKey: ["eligibleSwimmers", heatSheetEventId],
      });
    },

    onError: () => {
      toast.error("Seeding failed. Please try again.");
    },
  });
}
```

### shadcn/ui Components Used

| Component | Import Path |
|---|---|
| `Checkbox` | `@/components/ui/checkbox` |
| `Button` | `@/components/ui/button` |
| `AlertDialog`, `AlertDialogAction`, etc. | `@/components/ui/alert-dialog` |

### npm Packages

```json
{
  "@tanstack/react-table": "^8.x",
  "@tanstack/react-query": "^5.x"
}
```

`@tanstack/react-table` is already a transitive dependency of shadcn/ui DataTable; install it explicitly to control the version.

---

## Topic 4 — HeatSheetEvent Drag-to-Reorder

### Package

```bash
npm install @dnd-kit/core @dnd-kit/sortable @dnd-kit/utilities
```

Current stable: `@dnd-kit/core@^6.x`, `@dnd-kit/sortable@^8.x`, `@dnd-kit/utilities@^3.x`

### Minimal Setup

```tsx
// HeatSheetEventList.tsx
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
  DragEndEvent,
} from "@dnd-kit/core";
import {
  SortableContext,
  sortableKeyboardCoordinates,
  verticalListSortingStrategy,
  arrayMove,
} from "@dnd-kit/sortable";
import { restrictToVerticalAxis } from "@dnd-kit/modifiers";

interface HeatSheetEventListProps {
  heatSheetId: number;
  events: HeatSheetEventDto[];    // sorted by sequence
  isAdmin: boolean;
}

export function HeatSheetEventList({
  heatSheetId,
  events,
  isAdmin,
}: HeatSheetEventListProps) {
  const reorderMutation = useResequenceHeatSheetEvents(heatSheetId);

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates, // keyboard accessibility
    })
  );

  const handleDragEnd = (event: DragEndEvent) => {
    const { active, over } = event;
    if (!over || active.id === over.id) return;

    const oldIndex = events.findIndex((e) => e.heatSheetEventId === active.id);
    const newIndex = events.findIndex((e) => e.heatSheetEventId === over.id);
    const reordered = arrayMove(events, oldIndex, newIndex);

    reorderMutation.mutate({
      heatSheetId,
      heatSheetEventIds: reordered.map((e) => e.heatSheetEventId),
    });
  };

  const itemIds = events.map((e) => e.heatSheetEventId);

  return (
    <DndContext
      sensors={sensors}
      collisionDetection={closestCenter}
      onDragEnd={handleDragEnd}
      modifiers={[restrictToVerticalAxis]}
    >
      <SortableContext items={itemIds} strategy={verticalListSortingStrategy}>
        {events.map((event) => (
          <SortableHeatSheetEventRow
            key={event.heatSheetEventId}
            event={event}
            isAdmin={isAdmin}
          />
        ))}
      </SortableContext>
    </DndContext>
  );
}
```

### Sortable Row Item

```tsx
// SortableHeatSheetEventRow.tsx
import { useSortable } from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { GripVertical } from "lucide-react";

export function SortableHeatSheetEventRow({
  event,
  isAdmin,
}: {
  event: HeatSheetEventDto;
  isAdmin: boolean;
}) {
  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging,
  } = useSortable({ id: event.heatSheetEventId });

  const style: React.CSSProperties = {
    transform: CSS.Transform.toString(transform),
    transition,
    opacity: isDragging ? 0.5 : 1,
    zIndex: isDragging ? 10 : undefined,
  };

  return (
    <div
      ref={setNodeRef}
      style={style}
      className="flex items-center gap-3 p-3 border rounded-md bg-card mb-1"
      aria-describedby={`event-${event.heatSheetEventId}-desc`}
    >
      {/* Drag handle — ONLY the handle is draggable, not the entire row */}
      {isAdmin && (
        <button
          {...attributes}
          {...listeners}
          className="cursor-grab active:cursor-grabbing text-muted-foreground hover:text-foreground"
          aria-label={`Drag to reorder: ${event.description}`}
        >
          <GripVertical size={16} />
        </button>
      )}

      <span id={`event-${event.heatSheetEventId}-desc`} className="flex-1 text-sm">
        {event.sequence}. {event.description}
      </span>

      {/* Admin actions: delete, expand to heats, etc. */}
    </div>
  );
}
```

**CSS key distinction**: Spreading `{...listeners}` only on the drag-handle button means only that element triggers the drag. The rest of the row remains clickable for navigation or editing.

### Optimistic Reorder Mutation

```ts
// hooks/useResequenceHeatSheetEvents.ts
interface ResequenceRequest {
  heatSheetId: number;
  heatSheetEventIds: number[];
}

export function useResequenceHeatSheetEvents(heatSheetId: number) {
  const queryClient = useQueryClient();
  const queryKey = ["heatSheetEvents", heatSheetId];

  return useMutation({
    mutationFn: (req: ResequenceRequest) =>
      apiClient.post(`/api/heatsheets/${req.heatSheetId}/events/resequence`, {
        heatSheetEventIds: req.heatSheetEventIds,
      }),

    onMutate: async (req) => {
      await queryClient.cancelQueries({ queryKey });
      const previous = queryClient.getQueryData<HeatSheetEventDto[]>(queryKey);

      // Reorder the cached list to match the new sequence
      queryClient.setQueryData<HeatSheetEventDto[]>(queryKey, () =>
        req.heatSheetEventIds
          .map((id, index) => {
            const event = previous?.find((e) => e.heatSheetEventId === id);
            return event ? { ...event, sequence: index + 1 } : null;
          })
          .filter(Boolean) as HeatSheetEventDto[]
      );

      return { previous };
    },

    onError: (_err, _req, context) => {
      if (context?.previous) {
        queryClient.setQueryData(queryKey, context.previous);
      }
      toast.error("Reorder failed. Changes reverted.");
    },

    onSettled: () => {
      queryClient.invalidateQueries({ queryKey });
    },
  });
}
```

### Keyboard Navigation (Accessibility)

`@dnd-kit` with `KeyboardSensor` + `sortableKeyboardCoordinates` enables:

- **Space / Enter** on the drag handle: picks up the item
- **Arrow Up / Arrow Down**: moves the dragged item
- **Space / Enter** again: drops the item
- **Escape**: cancels the drag

This satisfies WCAG 2.1 SC 2.1.1 (keyboard accessible). The `aria-describedby` on each row announces the event name when the drag handle receives focus.

**Additional ARIA**: Add `aria-live="polite"` region to announce drag results to screen readers:

```tsx
// inside DndContext, add:
const [announcement, setAnnouncement] = useState("");

// In DragEndEvent handler:
setAnnouncement(`${movedEvent.description} moved to position ${newIndex + 1}`);

// Render:
<div aria-live="polite" aria-atomic="true" className="sr-only">
  {announcement}
</div>
```

---

## Topic 5 — Admin Permission Gating in React Components

### `useSwimMeetAdmin` Hook

The legacy `HeatSheetController` derived admin status from `BizMgr.GetSwimMeetsBySystemUserID` and checked `vl.IsAdmin`. In the React SPA, derive it from the cached swim meet query data:

```ts
// hooks/useSwimMeetAdmin.ts
import { useQuery } from "@tanstack/react-query";

interface SwimMeetDto {
  swimMeetId: number;
  description: string;
  isAdmin: boolean;
  // ... other fields
}

export function useSwimMeetAdmin(swimMeetId: number): boolean {
  const { data } = useQuery({
    queryKey: ["swimMeet", swimMeetId],
    queryFn: () => apiClient.get<SwimMeetDto>(`/api/swimmeets/${swimMeetId}`),
    staleTime: 5 * 60 * 1000, // 5 min — admin status doesn't change during a session
  });

  return data?.isAdmin ?? false;
}
```

**Why derived from query (not Context)**: The admin status is per-resource (`swimMeetId`), not per-user. If the user is admin for one meet but not another, you need the meet-specific `isAdmin` flag. Storing this in React Context requires a keyed map; TanStack Query already provides a keyed cache.

### Propagation Strategy: Avoid Deep Prop Drilling

For components nested more than 2 levels deep inside a `SwimMeetPage`, create a thin context that passes the resolved `swimMeetId` (not the `isAdmin` boolean), then let leaf components call `useSwimMeetAdmin` themselves:

```tsx
// SwimMeetContext.tsx
const SwimMeetContext = createContext<{ swimMeetId: number } | null>(null);

export function SwimMeetProvider({
  swimMeetId,
  children,
}: {
  swimMeetId: number;
  children: React.ReactNode;
}) {
  return (
    <SwimMeetContext.Provider value={{ swimMeetId }}>
      {children}
    </SwimMeetContext.Provider>
  );
}

export function useSwimMeetContext() {
  const ctx = useContext(SwimMeetContext);
  if (!ctx) throw new Error("useSwimMeetContext must be used within SwimMeetProvider");
  return ctx;
}

// Usage in leaf component:
function HeatCell({ ... }) {
  const { swimMeetId } = useSwimMeetContext();
  const isAdmin = useSwimMeetAdmin(swimMeetId); // hits TanStack cache — no network call
  // ...
}
```

This keeps the Context minimal (only the ID), and the derived boolean comes from the query cache with no extra fetches since the swim meet query is already warm.

### Conditional Rendering vs. Navigation Block

| Pattern | When to use |
|---|---|
| **Conditional render** (`isAdmin && <AdminControls />`) | Hiding admin UI elements from non-admins. Correct choice for action buttons, drag handles, add/delete controls. |
| **Route guard** | Blocking navigation to an admin-only page. Use React Router v7's `loader` to redirect non-admins before the component renders. |
| **Server authorization** | Always validate on the API (`[Authorize(Policy = "SwimMeetAdmin")]`). Client-side hiding is UX, not security. |

```tsx
// React Router v7 loader guard (admin-only route)
// routes/admin/heatsheet.tsx
export async function loader({ params }: LoaderFunctionArgs) {
  const swimMeet = await apiClient.get<SwimMeetDto>(
    `/api/swimmeets/${params.swimMeetId}`
  );
  if (!swimMeet.isAdmin) {
    throw redirect(`/swimmeets/${params.swimMeetId}`);
  }
  return { swimMeet };
}
```

### Conditional Rendering Pattern

```tsx
// In components that need admin controls:
function HeatSheetEventRow({ event }: { event: HeatSheetEventDto }) {
  const { swimMeetId } = useSwimMeetContext();
  const isAdmin = useSwimMeetAdmin(swimMeetId);

  return (
    <div className="flex items-center gap-2">
      <span>{event.description}</span>
      {isAdmin && (
        <Button
          variant="destructive"
          size="sm"
          onClick={() => deleteEvent(event.heatSheetEventId)}
        >
          Delete
        </Button>
      )}
    </div>
  );
}
```

### Auth0 Integration

Admin status comes from the API (per-swim-meet), not from Auth0 claims. Auth0 provides identity; the Swimomatic API provides authorization. The `useSwimMeetAdmin` hook calls the API; the Auth0 token is attached via the `apiClient` interceptor:

```ts
// lib/apiClient.ts
import { useAuth0 } from "@auth0/auth0-react";

// In your Axios/fetch wrapper, attach the bearer token:
const { getAccessTokenSilently } = useAuth0();
const token = await getAccessTokenSilently();
// Authorization: Bearer <token>
```

**Gotcha**: Do not call `useAuth0` inside `apiClient.ts` (it's not a component). Instead, pass the token as a parameter or use an Axios interceptor configured inside a component context.

---

## npm Package Summary

```json
{
  "dependencies": {
    "@dnd-kit/core": "^6.3.1",
    "@dnd-kit/sortable": "^8.0.0",
    "@dnd-kit/utilities": "^3.2.2",
    "@tanstack/react-query": "^5.80.7",
    "@tanstack/react-table": "^8.21.3",
    "lucide-react": "^0.511.0"
  }
}
```

All shadcn/ui components (`Table`, `Badge`, `Button`, `Dialog`, `AlertDialog`, `Checkbox`, `Popover`) are installed via `npx shadcn@latest add <component>` — they are copied into `src/components/ui/` and are not npm dependencies.

---

## Cross-Cutting Concerns

### Formatting Seed Times

The legacy codebase stores seed times as `double` seconds (e.g., `63.45`). The React UI needs a formatter:

```ts
export function formatSeedTime(seconds: number): string {
  if (seconds === 0) return "NT"; // No Time
  const mins = Math.floor(seconds / 60);
  const secs = (seconds % 60).toFixed(2).padStart(5, "0");
  return mins > 0 ? `${mins}:${secs}` : secs;
}
```

### API Shape Assumption

Research assumes the .NET 9 WebAPI will return heats in a flat structure per event:

```
GET /api/heatsheetevents/{id}/heats
→ HeatDto[]   (each with swimmers[])
```

This matches the legacy `Heats(HeatSheetEventID)` action which returned all heats for an event. The React component model assumes swimmers are embedded inside each heat (not fetched separately), which avoids N+1 fetch issues.

### Performance Considerations

- **Memoize** `getSwimmer()` lookup inside `HeatGrid` if the swimmer list grows large. Currently O(n) per cell render; at 48 cells × 24 swimmers it's fine, but a `Map<string, HeatSwimmerDto>` indexed by `"${heatId}-${lane}"` would be O(1).
- **`React.memo`** on `HeatCell`: prevents re-rendering all cells when only one lane changes from an optimistic update.
- **`staleTime`** on swimmer data: eligible swimmer lists rarely change mid-session; set `staleTime: 5 * 60 * 1000` to reduce redundant fetches.

---

## Recommended Next Research

1. **API contract definition** — document the exact request/response shapes for `POST /seed`, `POST /lane`, and `POST /resequence` so the React hooks and the .NET 9 controller can be built in parallel.
2. **Pool config and lane count** — research how `PoolConfig.LaneCount` flows from the API into the `HeatGrid` component. The grid needs this to render the correct number of column headers.
3. **Relay leg display** — the `Leg` field on `HeatSwimmer` was used in the legacy UI. Research how to display relay legs (1–4) within a single lane cell (stacked badges vs. a sub-grid).
4. **TanStack Query `suspense` mode** — investigate whether wrapping heat grid data queries in `<Suspense>` and `useSuspenseQuery` improves the loading state experience over manual `isLoading` checks.
5. **Conflict resolution for concurrent admin edits** — if two admins edit the same heat sheet simultaneously, the optimistic updates from one will be overwritten when the other's `onSettled` invalidation fires. Research WebSocket / SignalR patterns or optimistic locking (ETag headers) for multi-admin scenarios.
