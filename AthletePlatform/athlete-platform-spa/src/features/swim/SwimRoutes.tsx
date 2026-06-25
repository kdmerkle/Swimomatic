import { Routes, Route, Navigate } from 'react-router-dom'
import { MeetList } from './components/meets/MeetList'
import { MeetDetail } from './components/meets/MeetDetail'

export default function SwimRoutes() {
  return (
    <Routes>
      <Route index element={<Navigate to="meets" replace />} />
      <Route path="meets" element={<MeetList />} />
      <Route path="meets/:id" element={<MeetDetail />} />
    </Routes>
  )
}
