import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { swimApi } from '../api/swimApi'
import type { SwimMeet } from '../types'

export function useSwimMeets() {
  return useQuery({
    queryKey: ['swim', 'meets'],
    queryFn: swimApi.getMeets,
  })
}

export function useSwimMeet(id: number) {
  return useQuery({
    queryKey: ['swim', 'meets', id],
    queryFn: () => swimApi.getMeet(id),
    enabled: id > 0,
  })
}

export function useCreateMeet() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: (meet: Omit<SwimMeet, 'swimMeetId'>) => swimApi.createMeet(meet),
    onSuccess: () => qc.invalidateQueries({ queryKey: ['swim', 'meets'] }),
  })
}
