// app/page.tsx
import Link from 'next/link'

export default function HomePage() {
  return (
    <div style={{ padding: '2rem' }}>
      <h1>Welcome to DO188 Test App</h1>
      <p>This is the homepage.</p>
      <Link href="/users">
        <button style={{ padding: '0.5rem 1rem', marginTop: '1rem' }}>
          Go to Users Page
        </button>
      </Link>
    </div>
  )
}