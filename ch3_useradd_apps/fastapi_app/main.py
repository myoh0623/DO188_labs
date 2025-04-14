from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pymysql
import os

app = FastAPI()

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 필요시 ["http://localhost:3000"]
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 유저 모델
class User(BaseModel):
    name: str

# DB 연결 함수
def get_connection():
    return pymysql.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER", "testuser"),
        password=os.getenv("DB_PASS", "testpass"),
        database=os.getenv("DB_NAME", "testdb"),
        cursorclass=pymysql.cursors.DictCursor
    )

@app.get("/")
def root():
    return {"message": "Hello from FastAPI DO188!"}

@app.get("/api/users")
def read_users():
    conn = get_connection()
    with conn:
        with conn.cursor() as cursor:
            cursor.execute("SELECT id, name FROM users")
            return cursor.fetchall()

@app.post("/api/users")
def add_user(user: User):
    conn = get_connection()
    with conn:
        with conn.cursor() as cursor:
            cursor.execute("INSERT INTO users (name) VALUES (%s)", (user.name,))
            conn.commit()
            return {"message": "User added"}

@app.delete("/api/users/{user_id}")
def delete_user(user_id: int):
    conn = get_connection()
    with conn:
        with conn.cursor() as cursor:
            cursor.execute("DELETE FROM users WHERE id = %s", (user_id,))
            conn.commit()
            return {"message": "User deleted"}