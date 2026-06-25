export interface SwimMeet {
  swimMeetId: number
  meetId: number
  description: string
  startDate: string
  endDate: string
  locationId: number
  seasonId: number
  swimMeetTypeId: number
  poolConfigId?: number
}

export interface HeatSheet {
  heatSheetId: number
  tenantId: number
  swimMeetId: number
}

export interface HeatSheetEvent {
  heatSheetEventId: number
  heatSheetId: number
  swimEventId: number
  ageClassId: number
  gender: string
  sequence: number
  isScratch: boolean
}

export interface SwimResult {
  resultId: number
  heatSwimmerId: number
  elapsedTime?: number
  isDQ: boolean
  score?: number
  measurementType: string
  measurementValue?: number
}
