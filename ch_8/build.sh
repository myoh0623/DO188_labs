#!/bin/bash
set -e

echo "== FastAPI 이미지 빌드 및 푸시 =="
podman build -f Dockerfiles/fastapi.Dockerfile --no-cache -t quay.io/apollo11plus/do_test/fastapi:openshift .
podman push quay.io/apollo11plus/do_test/fastapi:openshift

echo "== Next.js 이미지 빌드 및 푸시 =="
podman build -f Dockerfiles/nextjs.Dockerfile --no-cache -t quay.io/apollo11plus/do_test/nextjs:openshift .
podman push quay.io/apollo11plus/do_test/nextjs:openshift

echo "== MySQL 이미지 빌드 및 푸시 =="
podman build -f Dockerfiles/mysql.Dockerfile --no-cache -t quay.io/apollo11plus/do_test/mysql:openshift .
podman push quay.io/apollo11plus/do_test/mysql:openshift