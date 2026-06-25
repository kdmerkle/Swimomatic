export interface TFMeet {
  tfMeetId: number
  meetId: number
  description: string
  startDate: string
  endDate: string
}

export interface TFEvent {
  tfEventId: number
  name: string
  measurementType: 'Time' | 'Distance' | 'Height'
  isField: boolean
}

export interface TFResult {
  tfResultId: number
  athleteId: number
  tfEventId: number
  measurementType: 'Time' | 'Distance' | 'Height'
  measurementValue?: number
  isDQ: boolean
}
