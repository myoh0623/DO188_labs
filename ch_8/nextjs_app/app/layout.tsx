// app/layout.tsx
export const metadata = {
  title: 'Test DO188 App',
  description: 'A simple Next.js app',
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body style={{ margin: 0, fontFamily: 'Arial, sans-serif' }}>
        {children}
      </body>
    </html>
  )
}