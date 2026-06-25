import { useQuery } from '@tanstack/react-query'
import { swimApi } from '../api/swimApi'

export function useHeatSheet(meetId: number) {
  return useQuery({
    queryKey: ['swim', 'meets', meetId, 'heatsheet'],
    queryFn: () => swimApi.getHeatSheet(meetId),
    enabled: meetId > 0,
  })
}

export function useHeatSheetEvents(meetId: number, hsId: number) {
  return useQuery({
    queryKey: ['swim', 'meets', meetId, 'heatsheet', hsId, 'events'],
    queryFn: () => swimApi.getHeatSheetEvents(meetId, hsId),
    enabled: meetId > 0 && hsId > 0,
  })
}
