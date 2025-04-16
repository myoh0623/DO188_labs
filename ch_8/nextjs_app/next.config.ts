/** @type {import('next').NextConfig} */
const nextConfig = {
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'http://fastapi:8000/api/:path*' // 내부 DNS 기반 FastAPI 서비스 접근 CORS 문제 해결
      }
    ]
  }
}

module.exports = nextConfig