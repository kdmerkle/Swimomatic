import { Link } from 'react-router-dom'
import { useSwimMeets } from '../../hooks/useSwimMeets'

export function MeetList() {
  const { data: meets, isLoading, isError } = useSwimMeets()

  if (isLoading) return <div className="p-8 text-center text-gray-500">Loading meets…</div>
  if (isError) return <div className="p-8 text-center text-red-500">Failed to load meets.</div>
  if (!meets?.length) return <div className="p-8 text-center text-gray-400">No meets found.</div>

  return (
    <div className="p-6">
      <h2 className="text-xl font-semibold mb-4">Swim Meets</h2>
      <div className="overflow-x-auto">
        <table className="min-w-full border rounded-lg bg-white shadow-sm">
          <thead className="bg-gray-50">
            <tr>
              <th className="text-left px-4 py-3 text-sm font-medium text-gray-600">Meet</th>
              <th className="text-left px-4 py-3 text-sm font-medium text-gray-600">Start Date</th>
              <th className="text-left px-4 py-3 text-sm font-medium text-gray-600">End Date</th>
              <th className="px-4 py-3"></th>
            </tr>
          </thead>
          <tbody className="divide-y">
            {meets.map(meet => (
              <tr key={meet.swimMeetId} className="hover:bg-gray-50">
                <td className="px-4 py-3 font-medium">{meet.description}</td>
                <td className="px-4 py-3 text-gray-600">{meet.startDate}</td>
                <td className="px-4 py-3 text-gray-600">{meet.endDate}</td>
                <td className="px-4 py-3">
                  <Link
                    to={`/swim/meets/${meet.swimMeetId}`}
                    className="text-blue-600 hover:underline text-sm"
                  >
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
