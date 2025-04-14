#!/bin/bash
set -e

echo "== 8080 포트를 점유 중인 컨테이너 확인 =="
PORT_IN_USE=$(podman ps --format "{{.ID}} {{.Ports}}" | grep "0.0.0.0:8080" | awk '{print $1}')

if [ -n "$PORT_IN_USE" ]; then
  echo "포트 8080을 사용 중인 컨테이너가 감지됨. 삭제합니다: $PORT_IN_USE"
  podman rm -f "$PORT_IN_USE"
else
  echo "8080 포트를 사용하는 컨테이너가 없습니다."
fi

echo "== Dockerfile.4_0_httpd 빌드 =="
podman build -f Dockerfile.4_0_httpd -t 4_0_httpd .

echo "== 4_0_httpd 컨테이너 실행 (8080) =="
podman rm -f httpd_4_0 >/dev/null 2>&1 || true
podman run -d --name httpd_4_0 -p 8080:8080 4_0_httpd

echo "== Dockerfile.4_1_httpd 빌드 =="
podman build -f Dockerfile.4_1_httpd -t 4_1_httpd .

echo "== 4_1_httpd 컨테이너 실행 (9090 with APP_PORT=9090) =="
podman rm -f httpd_4_1_9090 >/dev/null 2>&1 || true
podman run -d --name httpd_4_1_9090 -p 9090:9090 -e APP_PORT=9090 4_1_httpd

echo "== 3초 후 curl 테스트 시작 (http://localhost:9090) =="
sleep 3
curl -s http://localhost:9090 || echo "요청 실패"

echo "== 컨테이너 상태 확인 =="
podman ps

echo "== 테스트 컨테이너 정리 =="
podman rm -f httpd_4_0 httpd_4_1_9090
