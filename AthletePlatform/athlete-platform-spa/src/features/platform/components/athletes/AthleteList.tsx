import { useState } from 'react'
import { useAthletes } from '../../hooks/useAthletes'
import { AthleteForm } from './AthleteForm'
import type { Athlete } from '../../types'

export function AthleteList() {
  const { data: athletes, isLoading } = useAthletes()
  const [editing, setEditing] = useState<Athlete | null>(null)
  const [adding, setAdding] = useState(false)

  if (isLoading) return <div className="p-8 text-center text-gray-500">Loading athletes…</div>

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-xl font-semibold">Athletes</h2>
        <button
          onClick={() => setAdding(true)}
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 text-sm"
        >
          Add Athlete
        </button>
      </div>

      {(adding || editing) && (
        <div className="mb-6 p-4 border rounded-lg bg-gray-50">
          <AthleteForm
            athlete={editing ?? undefined}
            onDone={() => { setAdding(false); setEditing(null) }}
          />
        </div>
      )}

      <div className="overflow-x-auto">
        <table className="min-w-full border rounded-lg bg-white shadow-sm">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-3 text-left text-sm font-medium text-gray-600">Name</th>
              <th className="px-4 py-3 text-left text-sm font-medium text-gray-600">Birth Date</th>
              <th className="px-4 py-3 text-left text-sm font-medium text-gray-600">Gender</th>
              <th className="px-4 py-3"></th>
            </tr>
          </thead>
          <tbody className="divide-y">
            {athletes?.map(a => (
              <tr key={a.athleteId} className="hover:bg-gray-50">
                <td className="px-4 py-3 font-medium">{a.firstName} {a.lastName}</td>
                <td className="px-4 py-3 text-gray-600">{a.birthDate}</td>
                <td className="px-4 py-3 text-gray-600">{a.gender}</td>
                <td className="px-4 py-3">
                  <button
                    onClick={() => setEditing(a)}
                    className="text-blue-600 hover:underline text-sm"
                  >
                    Edit
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
