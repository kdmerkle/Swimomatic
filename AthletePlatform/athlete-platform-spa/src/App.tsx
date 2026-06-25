import React, { Suspense } from 'react'
import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom'
import { useAuth0 } from '@auth0/auth0-react'
import { setTokenProvider } from './lib/apiClient'
import { NavBar } from './features/platform/components/NavBar'
import { useTenant } from './features/platform/hooks/useTenant'
import { AthleteList } from './features/platform/components/athletes/AthleteList'
import { LeagueList } from './features/platform/components/leagues/LeagueList'
import { TeamList } from './features/platform/components/teams/TeamList'

const SwimRoutes = React.lazy(() => import('./features/swim/SwimRoutes'))
const TFRoutes = React.lazy(() => import('./features/tf/TFRoutes'))

function Dashboard() {
  return (
    <div className="p-8">
      <h1 className="text-2xl font-bold">Dashboard</h1>
      <p className="text-gray-600 mt-2">Welcome to Athlete Platform.</p>
    </div>
  )
}

function AppRoutes() {
  const { data: tenant } = useTenant()
  return (
    <Suspense fallback={<div className="p-8 text-center">Loading…</div>}>
      <Routes>
        <Route path="/" element={<Navigate to="/dashboard" replace />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route
          path="/swim/*"
          element={
            tenant?.enabledSports.includes('swim') ? <SwimRoutes /> : <Navigate to="/dashboard" replace />
          }
        />
        <Route
          path="/tf/*"
          element={
            tenant?.enabledSports.includes('tf') ? <TFRoutes /> : <Navigate to="/dashboard" replace />
          }
        />
        <Route path="/athletes" element={<AthleteList />} />
        <Route path="/leagues" element={<LeagueList />} />
        <Route path="/teams" element={<TeamList />} />
      </Routes>
    </Suspense>
  )
}

export function App() {
  const { getAccessTokenSilently } = useAuth0()

  // Wire token provider into apiClient on mount
  React.useEffect(() => {
    setTokenProvider(getAccessTokenSilently)
  }, [getAccessTokenSilently])

  return (
    <BrowserRouter>
      <div className="min-h-screen bg-gray-50">
        <NavBar />
        <main>
          <AppRoutes />
        </main>
      </div>
    </BrowserRouter>
  )
}
