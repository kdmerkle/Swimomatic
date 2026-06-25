import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import { platformApi } from '../../api/platformApi'

export function LeagueList() {
  const { data: leagues, isLoading } = useQuery({
    queryKey: ['platform', 'leagues'],
    queryFn: () => platformApi.getLeagues(),
  })

  if (isLoading) return <div className="p-8 text-center text-gray-500">Loading leagues…</div>
  if (!leagues?.length) return <div className="p-8 text-center text-gray-400">No leagues found.</div>

  return (
    <div className="p-6">
      <h2 className="text-xl font-semibold mb-4">Leagues</h2>
      <div className="overflow-x-auto">
        <table className="min-w-full border rounded-lg bg-white shadow-sm">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-3 text-left text-sm font-medium text-gray-600">League</th>
              <th className="px-4 py-3 text-left text-sm font-medium text-gray-600">Sport</th>
              <th className="px-4 py-3"></th>
            </tr>
          </thead>
          <tbody className="divide-y">
            {leagues.map(l => (
              <tr key={l.leagueId} className="hover:bg-gray-50">
                <td className="px-4 py-3 font-medium">{l.name}</td>
                <td className="px-4 py-3 text-gray-600">{l.sportCode}</td>
                <td className="px-4 py-3">
                  <Link to={`/leagues/${l.leagueId}`} className="text-blue-600 hover:underline text-sm">
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
