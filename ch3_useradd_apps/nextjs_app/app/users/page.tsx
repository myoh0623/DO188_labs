'use client'

import { useEffect, useState } from 'react'

type User = {
  id: number
  name: string
}

export default function UsersPage() {
  const [users, setUsers] = useState<User[]>([])
  const [name, setName] = useState("")
  const [activeTab, setActiveTab] = useState<"view" | "add" | "delete">("view")

  useEffect(() => {
    fetchUsers()
  }, [])

  const fetchUsers = () => {
    fetch('http://localhost:8000/api/users')
      .then(res => res.json())
      .then(data => setUsers(data))
      .catch(err => console.error('Error fetching users:', err))
  }

  const handleAdd = async () => {
    if (!name.trim()) return
    await fetch('http://localhost:8000/api/users', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name })
    })
    setName("")
    fetchUsers()
  }

  const handleDelete = async (id: number) => {
    await fetch(`http://localhost:8000/api/users/${id}`, {
      method: 'DELETE'
    })
    fetchUsers()
  }

  return (
    <div>
      <div style={{ marginBottom: '1rem' }}>
        <button onClick={() => setActiveTab("view")} style={{ marginRight: 10 }}>👀 View</button>
        <button onClick={() => setActiveTab("add")} style={{ marginRight: 10 }}>➕ Add</button>
        <button onClick={() => setActiveTab("delete")}>❌ Delete</button>
      </div>

      {activeTab === "view" && (
        <div>
          <h3>👥 Current Users</h3>
          <ul>
            {users.map((u) => (
              <li key={u.id}>{u.name}</li>
            ))}
          </ul>
        </div>
      )}

      {activeTab === "add" && (
        <div>
          <h3>➕ Add New User</h3>
          <input
            type="text"
            value={name}
            placeholder="Enter name"
            onChange={(e) => setName(e.target.value)}
          />
          <button onClick={handleAdd} style={{ marginLeft: 10 }}>Add</button>
        </div>
      )}

      {activeTab === "delete" && (
        <div>
          <h3>❌ Delete Users</h3>
          <ul>
            {users.map((u) => (
              <li key={u.id}>
                {u.name}
                <button onClick={() => handleDelete(u.id)} style={{ marginLeft: 10 }}>Delete</button>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  )
}