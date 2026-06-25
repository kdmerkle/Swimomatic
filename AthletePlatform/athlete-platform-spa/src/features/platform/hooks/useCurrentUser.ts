import { useAuth0 } from '@auth0/auth0-react'

export function useCurrentUser() {
  const { user, isLoading, isAuthenticated, loginWithRedirect, logout, getAccessTokenSilently } =
    useAuth0()
  return { user, isLoading, isAuthenticated, loginWithRedirect, logout, getAccessTokenSilently }
}
