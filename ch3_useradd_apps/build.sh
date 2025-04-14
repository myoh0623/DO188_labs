#!/bin/bash
set -e

echo "== FastAPI 이미지 빌드 및 푸시 =="
podman build -f Dockerfiles/fastapi.Dockerfile -t quay.io/apollo11plus/do_test/fastapi:latest .
podman push quay.io/apollo11plus/do_test/fastapi:latest

echo "== Next.js 이미지 빌드 및 푸시 =="
podman build -f Dockerfiles/nextjs.Dockerfile -t quay.io/apollo11plus/do_test/nextjs:latest .
podman push quay.io/apollo11plus/do_test/nextjs:latest

echo "== MySQL 이미지 빌드 및 푸시 =="
podman build -f Dockerfiles/mysql.Dockerfile -t quay.io/apollo11plus/do_test/mysql:latest .
podman push quay.io/apollo11plus/do_test/mysql:latest