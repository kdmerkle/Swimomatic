import { useState } from 'react'
import { z } from 'zod'
import { useSaveAthlete } from '../../hooks/useAthletes'
import type { Athlete } from '../../types'

const athleteSchema = z.object({
  firstName: z.string().min(1, 'First name is required'),
  lastName: z.string().min(1, 'Last name is required'),
  birthDate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Date must be YYYY-MM-DD'),
  gender: z.enum(['M', 'F', 'X'], { message: 'Gender must be M, F, or X' }),
})

interface Props {
  athlete?: Athlete
  onDone: () => void
}

export function AthleteForm({ athlete, onDone }: Props) {
  const mutation = useSaveAthlete()
  const [form, setForm] = useState({
    firstName: athlete?.firstName ?? '',
    lastName: athlete?.lastName ?? '',
    birthDate: athlete?.birthDate ?? '',
    gender: (athlete?.gender ?? 'M') as 'M' | 'F' | 'X',
  })
  const [errors, setErrors] = useState<Partial<Record<keyof typeof form, string>>>({})

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    const parsed = athleteSchema.safeParse(form)
    if (!parsed.success) {
      const fieldErrors: Partial<Record<keyof typeof form, string>> = {}
      for (const issue of parsed.error.issues) {
        const field = issue.path[0] as keyof typeof form
        fieldErrors[field] = issue.message
      }
      setErrors(fieldErrors)
      return
    }
    setErrors({})
    mutation.mutate(
      { ...parsed.data, athleteId: athlete?.athleteId ?? 0 } as Athlete,
      { onSuccess: onDone },
    )
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-3 max-w-md">
      <h3 className="font-semibold">{athlete ? 'Edit Athlete' : 'Add Athlete'}</h3>
      {(['firstName', 'lastName', 'birthDate'] as const).map(field => (
        <div key={field}>
          <label className="block text-sm font-medium capitalize mb-1">
            {field.replace(/([A-Z])/g, ' $1')}
          </label>
          <input
            type="text"
            value={form[field]}
            onChange={e => setForm(prev => ({ ...prev, [field]: e.target.value }))}
            placeholder={field === 'birthDate' ? 'YYYY-MM-DD' : ''}
            className="border rounded px-3 py-1.5 text-sm w-full focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          {errors[field] && <p className="text-red-500 text-xs mt-1">{errors[field]}</p>}
        </div>
      ))}
      <div>
        <label className="block text-sm font-medium mb-1">Gender</label>
        <select
          value={form.gender}
          onChange={e => setForm(prev => ({ ...prev, gender: e.target.value as 'M' | 'F' | 'X' }))}
          className="border rounded px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
        >
          <option value="M">Male</option>
          <option value="F">Female</option>
          <option value="X">Non-binary</option>
        </select>
        {errors.gender && <p className="text-red-500 text-xs mt-1">{errors.gender}</p>}
      </div>
      <div className="flex gap-2">
        <button
          type="submit"
          disabled={mutation.isPending}
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50 text-sm"
        >
          {mutation.isPending ? 'Saving…' : 'Save'}
        </button>
        <button
          type="button"
          onClick={onDone}
          className="px-4 py-2 border rounded hover:bg-gray-50 text-sm"
        >
          Cancel
        </button>
      </div>
    </form>
  )
}
