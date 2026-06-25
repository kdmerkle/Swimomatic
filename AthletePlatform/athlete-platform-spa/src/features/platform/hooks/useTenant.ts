import { useQuery } from '@tanstack/react-query'
import { apiClient } from '../../../lib/apiClient'
import type { TenantConfig } from '../types'

export function useTenant() {
  return useQuery({
    queryKey: ['platform', 'tenant'],
    queryFn: () => apiClient.get<TenantConfig>('/api/tenant'),
    staleTime: Infinity,
  })
}
