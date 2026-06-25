import { useHeatSheetEvents } from '../../hooks/useHeatSheet'
import { HeatSheetEventRow } from './HeatSheetEventRow'

interface Props {
  meetId: number
  heatSheetId: number
}

export function HeatSheetGrid({ meetId, heatSheetId }: Props) {
  const { data: events, isLoading } = useHeatSheetEvents(meetId, heatSheetId)

  if (isLoading) return <div className="text-gray-500">Loading heat sheet…</div>
  if (!events?.length) return <div className="text-gray-400">No events in heat sheet.</div>

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full border rounded-lg bg-white shadow-sm text-sm">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-4 py-2 text-left font-medium text-gray-600">#</th>
            <th className="px-4 py-2 text-left font-medium text-gray-600">Event</th>
            <th className="px-4 py-2 text-left font-medium text-gray-600">Age Class</th>
            <th className="px-4 py-2 text-left font-medium text-gray-600">Gender</th>
            <th className="px-4 py-2 text-left font-medium text-gray-600">Scratch</th>
          </tr>
        </thead>
        <tbody className="divide-y">
          {events.map(evt => (
            <HeatSheetEventRow
              key={evt.heatSheetEventId}
              event={evt}
              meetId={meetId}
              heatSheetId={heatSheetId}
            />
          ))}
        </tbody>
      </table>
    </div>
  )
}
