# (1단계) 빌더 단계
FROM registry.access.redhat.com/ubi8/nodejs-18 AS builder

USER root
# install 명령어를 사용해 /app 디렉토리를 소유자 1001, 그룹 0으로 생성 (chmod나 chown 없이)
RUN install -d -o 1001 -g 0 /app
WORKDIR /app

# 패키지 파일 복사 시 --chown 옵션 사용 (디렉토리에 이미 소유자가 올바르므로, 옵션은 보증용)
COPY --chown=1001:0 ./nextjs_app/package*.json ./

# 비root 사용자로 npm install 실행
USER 1001
RUN npm install

# 전체 소스 복사 시 --chown 옵션 사용하여 파일 소유자가 1001로 지정됨
COPY --chown=1001:0 ./nextjs_app ./
RUN npm run build

# (2단계) nginx 단계
FROM registry.access.redhat.com/ubi8/nginx-120

WORKDIR /opt/app-root/src

# Next.js export 결과 복사
COPY --from=builder /app/out/ ./

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]