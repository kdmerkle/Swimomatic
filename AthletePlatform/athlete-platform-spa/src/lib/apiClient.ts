const API_BASE = import.meta.env.VITE_API_BASE_URL ?? ''

let getTokenFn: (() => Promise<string>) | null = null

export function setTokenProvider(fn: () => Promise<string>) {
  getTokenFn = fn
}

async function getAuthHeaders(): Promise<Record<string, string>> {
  if (!getTokenFn) return {}
  try {
    const token = await getTokenFn()
    return { Authorization: `Bearer ${token}` }
  } catch {
    return {}
  }
}

async function request<T>(path: string, init?: RequestInit): Promise<T> {
  const headers = await getAuthHeaders()
  const response = await fetch(`${API_BASE}${path}`, {
    ...init,
    headers: {
      'Content-Type': 'application/json',
      ...headers,
      ...init?.headers,
    },
  })
  if (!response.ok) {
    throw new Error(`API error ${response.status}: ${response.statusText}`)
  }
  return response.json() as Promise<T>
}

export const apiClient = {
  get: <T>(path: string) => request<T>(path),
  post: <T>(path: string, body: unknown) =>
    request<T>(path, { method: 'POST', body: JSON.stringify(body) }),
  put: <T>(path: string, body: unknown) =>
    request<T>(path, { method: 'PUT', body: JSON.stringify(body) }),
  delete: (path: string) => request<void>(path, { method: 'DELETE' }),
}
