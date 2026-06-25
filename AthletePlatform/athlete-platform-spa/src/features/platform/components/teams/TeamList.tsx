import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import { platformApi } from '../../api/platformApi'

export function TeamList() {
  const { data: teams, isLoading } = useQuery({
    queryKey: ['platform', 'teams'],
    queryFn: platformApi.getTeams,
  })

  if (isLoading) return <div className="p-8 text-center text-gray-500">Loading teams…</div>
  if (!teams?.length) return <div className="p-8 text-center text-gray-400">No teams found.</div>

  return (
    <div className="p-6">
      <h2 className="text-xl font-semibold mb-4">Teams</h2>
      <div className="overflow-x-auto">
        <table className="min-w-full border rounded-lg bg-white shadow-sm">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-3 text-left text-sm font-medium text-gray-600">Team Name</th>
              <th className="px-4 py-3"></th>
            </tr>
          </thead>
          <tbody className="divide-y">
            {teams.map(t => (
              <tr key={t.teamId} className="hover:bg-gray-50">
                <td className="px-4 py-3 font-medium">{t.name}</td>
                <td className="px-4 py-3">
                  <Link to={`/teams/${t.teamId}`} className="text-blue-600 hover:underline text-sm">
                    View →
                  </Link>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
