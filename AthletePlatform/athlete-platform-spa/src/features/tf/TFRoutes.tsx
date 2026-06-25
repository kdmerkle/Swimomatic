import { Routes, Route } from 'react-router-dom'

function TFHome() {
  return (
    <div className="p-8">
      <h1 className="text-2xl font-bold">Track & Field</h1>
      <p className="text-gray-600 mt-2">
        Track & Field features are coming soon. This module is currently in development.
      </p>
      <div className="mt-6 p-4 bg-blue-50 rounded-lg border border-blue-200">
        <p className="text-blue-800 text-sm">
          T&F meet management, event entry, and results will be available in a future update.
        </p>
      </div>
    </div>
  )
}

export default function TFRoutes() {
  return (
    <Routes>
      <Route index element={<TFHome />} />
    </Routes>
  )
}
