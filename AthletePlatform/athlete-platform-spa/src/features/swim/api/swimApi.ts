import { apiClient } from '../../../lib/apiClient'
import type { SwimMeet, HeatSheet, HeatSheetEvent, SwimResult } from '../types'

export const swimApi = {
  getMeets: () => apiClient.get<SwimMeet[]>('/api/swim/meets'),
  getMeet: (id: number) => apiClient.get<SwimMeet>(`/api/swim/meets/${id}`),
  createMeet: (meet: Omit<SwimMeet, 'swimMeetId'>) =>
    apiClient.post<SwimMeet>('/api/swim/meets', meet),
  getHeatSheet: (meetId: number) =>
    apiClient.get<HeatSheet>(`/api/swim/meets/${meetId}/heatsheets`),
  getHeatSheetEvents: (meetId: number, hsId: number) =>
    apiClient.get<HeatSheetEvent[]>(`/api/swim/meets/${meetId}/heatsheets/${hsId}/events`),
  generateHeats: (meetId: number, hsId: number, laneCount = 6) =>
    apiClient.post(`/api/swim/meets/${meetId}/heatsheets/${hsId}/generate?laneCount=${laneCount}`, {}),
  getResults: (meetId: number, hsId: number, eventId: number) =>
    apiClient.get<SwimResult[]>(`/api/swim/meets/${meetId}/heatsheets/${hsId}/events/${eventId}/results`),
  saveResults: (meetId: number, hsId: number, eventId: number, results: SwimResult[]) =>
    apiClient.post(`/api/swim/meets/${meetId}/heatsheets/${hsId}/events/${eventId}/results`, results),
}
