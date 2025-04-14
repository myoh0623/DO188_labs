#!/bin/bash

# 네트워크 생성
echo "Podman 네트워크 생성"
podman network exists appnet || podman network create appnet

# MySQL 실행
echo "MySQL 컨테이너 실행"
podman rm -f mysql >/dev/null 2>&1
podman run -d --name mysql \
  --net appnet \
  quay.io/apollo11plus/do_test/mysql:latest

# FastAPI 실행
echo "FastAPI 컨테이너 실행"
podman rm -f fastapi >/dev/null 2>&1
podman run -d --name fastapi \
  --net appnet \
  -p 8000:8000 \
  -e DB_HOST=mysql \
  -e DB_USER=testuser \
  -e DB_PASS=testpass \
  -e DB_NAME=testdb \
  quay.io/apollo11plus/do_test/fastapi:latest

# Next.js 실행
echo "Next.js 컨테이너 실행"
podman rm -f nextjs >/dev/null 2>&1
podman run -d --name nextjs \
  --net appnet \
  -p 3000:3000 \
  quay.io/apollo11plus/do_test/nextjs:latest

# 상태 출력
podman ps