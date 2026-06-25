import { useMutation, useQueryClient } from '@tanstack/react-query'
import { swimApi } from '../api/swimApi'
import type { SwimResult } from '../types'

interface ResultBatch {
  meetId: number
  heatSheetId: number
  eventId: number
  results: SwimResult[]
}

export function useResultEntry() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: ({ meetId, heatSheetId, eventId, results }: ResultBatch) =>
      swimApi.saveResults(meetId, heatSheetId, eventId, results),
    onSuccess: (_data, variables) => {
      qc.invalidateQueries({
        queryKey: ['swim', 'meets', variables.meetId],
      })
    },
  })
}
