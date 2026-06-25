import type { HeatSheetEvent } from '../../types'

interface Props {
  event: HeatSheetEvent
  meetId: number
  heatSheetId: number
}

export function HeatSheetEventRow({ event }: Props) {
  return (
    <tr className="hover:bg-gray-50">
      <td className="px-4 py-2">{event.sequence}</td>
      <td className="px-4 py-2">Event #{event.swimEventId}</td>
      <td className="px-4 py-2">Age Class #{event.ageClassId}</td>
      <td className="px-4 py-2">{event.gender}</td>
      <td className="px-4 py-2">
        {event.isScratch ? (
          <span className="text-red-500 text-xs font-medium">SCRATCH</span>
        ) : (
          <span className="text-green-600 text-xs font-medium">Active</span>
        )}
      </td>
    </tr>
  )
}
