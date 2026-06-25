import { NavLink } from 'react-router-dom'
import { useTenant } from '../hooks/useTenant'
import { useCurrentUser } from '../hooks/useCurrentUser'

export function NavBar() {
  const { data: tenant } = useTenant()
  const { isAuthenticated, loginWithRedirect, logout } = useCurrentUser()

  return (
    <nav className="flex items-center gap-4 p-4 border-b bg-white shadow-sm">
      <NavLink to="/dashboard" className="font-semibold text-blue-600">
        Athlete Platform
      </NavLink>
      {tenant?.enabledSports.includes('swim') && (
        <NavLink to="/swim" className="text-gray-700 hover:text-blue-600">
          Swimming
        </NavLink>
      )}
      {tenant?.enabledSports.includes('tf') && (
        <NavLink to="/tf" className="text-gray-700 hover:text-blue-600">
          Track & Field
        </NavLink>
      )}
      <NavLink to="/athletes" className="text-gray-700 hover:text-blue-600">
        Athletes
      </NavLink>
      <NavLink to="/leagues" className="text-gray-700 hover:text-blue-600">
        Leagues
      </NavLink>
      <NavLink to="/teams" className="text-gray-700 hover:text-blue-600">
        Teams
      </NavLink>
      <div className="ml-auto">
        {isAuthenticated ? (
          <button
            onClick={() => logout({ logoutParams: { returnTo: window.location.origin } })}
            className="px-4 py-2 text-sm rounded border hover:bg-gray-50"
          >
            Sign Out
          </button>
        ) : (
          <button
            onClick={() => loginWithRedirect()}
            className="px-4 py-2 text-sm rounded bg-blue-600 text-white hover:bg-blue-700"
          >
            Sign In
          </button>
        )}
      </div>
    </nav>
  )
}
