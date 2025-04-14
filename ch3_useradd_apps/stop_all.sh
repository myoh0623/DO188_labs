#!/bin/bash

echo "컨테이너 종료 및 삭제 중..."

# 컨테이너 정리
podman rm -f mysql fastapi nextjs >/dev/null 2>&1 && echo "✔️ 컨테이너 삭제 완료"

# 네트워크 정리
podman network rm appnet >/dev/null 2>&1 && echo "✔️ 네트워크(appnet) 삭제 완료"

# 상태 확인
echo ""
echo "📦 현재 컨테이너 상태:"
podman ps -a