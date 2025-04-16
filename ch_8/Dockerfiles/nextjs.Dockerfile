FROM registry.access.redhat.com/ubi8/nodejs-18

# 1) 루트로 작업
USER root
WORKDIR /app

# 2) 소스 복사
COPY ./nextjs_app/package.json ./nextjs_app/package-lock.json ./

# 3) 권한 설정 (mkdir/node_modules 생성 등 가능하도록)
RUN chown -R 1001:0 /app && chmod -R g+rw /app

# 4) 일반 사용자로 변경
USER 1001

# 5) npm install
RUN npm install

# 6) 다시 루트로 돌아가서 나머지 파일 복사 (필요시)
USER root
COPY ./nextjs_app/tsconfig.json ./tsconfig.json
COPY ./nextjs_app/next.config.ts ./next.config.ts
COPY ./nextjs_app/app ./app
RUN chown -R 1001:0 /app && chmod -R g+rw /app

# 7) 일반 사용자로 돌아가 빌드
USER 1001
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]