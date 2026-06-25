import { useState } from 'react'
import { z } from 'zod'
import { useResultEntry } from '../../hooks/useResultEntry'
import type { SwimResult } from '../../types'

const timeSchema = z
  .string()
  .regex(/^\d+(\.\d{1,2})?$/, 'Enter time as seconds (e.g. 65.4)')
  .transform(Number)

interface Props {
  meetId: number
  heatSheetId: number
  eventId: number
  swimmers: Array<{ heatSwimmerId: number; athleteName: string }>
}

export function ResultEntryForm({ meetId, heatSheetId, eventId, swimmers }: Props) {
  const mutation = useResultEntry()
  const [times, setTimes] = useState<Record<number, string>>({})
  const [errors, setErrors] = useState<Record<number, string>>({})
  const [saved, setSaved] = useState(false)

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    const results: SwimResult[] = []
    const newErrors: Record<number, string> = {}

    for (const swimmer of swimmers) {
      const raw = times[swimmer.heatSwimmerId] ?? ''
      if (!raw) continue
      const parsed = timeSchema.safeParse(raw)
      if (!parsed.success) {
        newErrors[swimmer.heatSwimmerId] = parsed.error.errors[0].message
      } else {
        results.push({
          resultId: 0,
          heatSwimmerId: swimmer.heatSwimmerId,
          elapsedTime: parsed.data,
          isDQ: false,
          score: undefined,
          measurementType: 'Time',
        } as SwimResult)
      }
    }

    setErrors(newErrors)
    if (Object.keys(newErrors).length > 0) return

    mutation.mutate(
      { meetId, heatSheetId, eventId, results },
      {
        onSuccess: () => setSaved(true),
        onError: () => setErrors({ 0: 'Failed to save results. Please try again.' }),
      },
    )
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      {saved && (
        <div className="p-3 bg-green-50 text-green-700 rounded border border-green-200 text-sm">
          Results saved successfully.
        </div>
      )}
      {errors[0] && (
        <div className="p-3 bg-red-50 text-red-700 rounded border border-red-200 text-sm">
          {errors[0]}
        </div>
      )}
      {swimmers.map(swimmer => (
        <div key={swimmer.heatSwimmerId} className="flex items-center gap-4">
          <span className="w-48 text-sm font-medium">{swimmer.athleteName}</span>
          <input
            type="text"
            placeholder="65.40"
            value={times[swimmer.heatSwimmerId] ?? ''}
            onChange={e => setTimes(prev => ({ ...prev, [swimmer.heatSwimmerId]: e.target.value }))}
            className="border rounded px-3 py-1 text-sm w-28 focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          {errors[swimmer.heatSwimmerId] && (
            <span className="text-red-500 text-xs">{errors[swimmer.heatSwimmerId]}</span>
          )}
        </div>
      ))}
      <button
        type="submit"
        disabled={mutation.isPending}
        className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50 text-sm"
      >
        {mutation.isPending ? 'Saving…' : 'Save Results'}
      </button>
    </form>
  )
}
