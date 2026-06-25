import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { apiClient } from '../../../lib/apiClient'
import type { Athlete } from '../types'

export function useAthletes() {
  return useQuery({
    queryKey: ['platform', 'athletes'],
    queryFn: () => apiClient.get<Athlete[]>('/api/athletes'),
  })
}

export function useSaveAthlete() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: (athlete: Athlete) =>
      athlete.athleteId === 0
        ? apiClient.post<Athlete>('/api/athletes', athlete)
        : apiClient.put<Athlete>(`/api/athletes/${athlete.athleteId}`, athlete),
    onSuccess: () => qc.invalidateQueries({ queryKey: ['platform', 'athletes'] }),
  })
}
