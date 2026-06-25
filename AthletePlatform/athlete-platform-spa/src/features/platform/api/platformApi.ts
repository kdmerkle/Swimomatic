import { apiClient } from '../../../lib/apiClient'
import type { League, Team } from '../types'

interface Season {
  seasonId: number
  leagueId: number
  name: string
  startDate: string
  endDate: string
}

interface Location {
  locationId: number
  name: string
  address?: string
}

export const platformApi = {
  getLeagues: (sport?: string) =>
    apiClient.get<League[]>(`/api/leagues${sport ? `?sport=${sport}` : ''}`),
  getLeague: (id: number) => apiClient.get<League>(`/api/leagues/${id}`),
  getSeasons: (leagueId: number) => apiClient.get<Season[]>(`/api/leagues/${leagueId}/seasons`),
  getTeams: () => apiClient.get<Team[]>('/api/teams'),
  getTeam: (id: number) => apiClient.get<Team>(`/api/teams/${id}`),
  getLocations: () => apiClient.get<Location[]>('/api/locations'),
  requestTeam: (athleteId: number, teamId: number) =>
    apiClient.post(`/api/athletes/${athleteId}/team-requests`, { teamId }),
  requestLeague: (teamId: number, leagueId: number) =>
    apiClient.post(`/api/teams/${teamId}/league-requests`, { leagueId }),
}
