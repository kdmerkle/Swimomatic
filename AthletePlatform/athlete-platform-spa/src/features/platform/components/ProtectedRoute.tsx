import { useAuth0 } from '@auth0/auth0-react'

interface Props {
  children: React.ReactNode
}

export function ProtectedRoute({ children }: Props) {
  const { isAuthenticated, isLoading, loginWithRedirect } = useAuth0()

  if (isLoading) return <div className="p-8 text-center">Loading…</div>
  if (!isAuthenticated) {
    loginWithRedirect()
    return null
  }
  return <>{children}</>
}
