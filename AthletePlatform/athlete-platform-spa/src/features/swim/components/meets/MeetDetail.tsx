import { useParams, Link } from 'react-router-dom'
import { useSwimMeet } from '../../hooks/useSwimMeets'
import { useHeatSheet } from '../../hooks/useHeatSheet'
import { HeatSheetGrid } from '../heatsheets/HeatSheetGrid'

export function MeetDetail() {
  const { id } = useParams<{ id: string }>()
  const meetId = Number(id)
  const { data: meet, isLoading } = useSwimMeet(meetId)
  const { data: heatSheet } = useHeatSheet(meetId)

  if (isLoading) return <div className="p-8 text-center text-gray-500">Loading…</div>
  if (!meet) return <div className="p-8 text-center text-red-500">Meet not found.</div>

  return (
    <div className="p-6">
      <Link to="/swim" className="text-blue-600 hover:underline text-sm">← Back to Meets</Link>
      <h2 className="text-2xl font-bold mt-4 mb-2">{meet.description}</h2>
      <p className="text-gray-600 mb-6">
        {meet.startDate} – {meet.endDate}
      </p>
      {heatSheet
        ? <HeatSheetGrid meetId={meetId} heatSheetId={heatSheet.heatSheetId} />
        : <p className="text-gray-400">No heat sheet generated yet.</p>}
    </div>
  )
}
