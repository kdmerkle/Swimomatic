import { useState } from 'react'
import { useHeatSheetEvents } from '../../hooks/useHeatSheet'

interface Props {
  meetId: number
  heatSheetId: number
  isAdmin: boolean
}

export function HeatSheetAdminPanel({ meetId, heatSheetId, isAdmin }: Props) {
  const { data: events } = useHeatSheetEvents(meetId, heatSheetId)
  const [generating, setGenerating] = useState(false)
  const [message, setMessage] = useState('')

  if (!isAdmin) return null

  async function handleGenerate() {
    setGenerating(true)
    setMessage('')
    try {
      const { apiClient } = await import('../../../../lib/apiClient')
      await apiClient.post(
        `/api/swim/meets/${meetId}/heatsheets/${heatSheetId}/generate`,
        {},
      )
      setMessage('Heats generated successfully.')
    } catch {
      setMessage('Failed to generate heats.')
    } finally {
      setGenerating(false)
    }
  }

  return (
    <div className="mt-6 p-4 border rounded-lg bg-amber-50">
      <h3 className="font-semibold text-amber-900 mb-3">Admin: Heat Sheet Management</h3>
      <div className="flex gap-3 items-center">
        <button
          onClick={handleGenerate}
          disabled={generating}
          className="px-4 py-2 bg-amber-600 text-white rounded hover:bg-amber-700 disabled:opacity-50 text-sm"
        >
          {generating ? 'Generating…' : 'Generate Heats'}
        </button>
        {message && <span className="text-sm text-amber-800">{message}</span>}
      </div>
      <p className="text-xs text-amber-700 mt-2">
        {events?.length ?? 0} events in heat sheet
      </p>
    </div>
  )
}
