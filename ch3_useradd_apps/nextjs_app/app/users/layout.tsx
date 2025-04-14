// app/users/layout.tsx
export default function UsersLayout({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ padding: '2rem', backgroundColor: '#f5f5f5', minHeight: '100vh' }}>
      <h2>User Management Section</h2>
      {children}
    </div>
  )
}