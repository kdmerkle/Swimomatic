export interface Athlete {
  athleteId: number
  firstName: string
  lastName: string
  birthDate: string
  gender: 'M' | 'F' | 'X'
}

export interface League {
  leagueId: number
  name: string
  description?: string
  sportCode: string
}

export interface Team {
  teamId: number
  name: string
  homeLocationId?: number
}

export interface TenantConfig {
  tenantKey: string
  name: string
  enabledSports: string[]
}
