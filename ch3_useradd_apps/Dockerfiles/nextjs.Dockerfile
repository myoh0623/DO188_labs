FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

COPY ./nextjs_app/package.json ./nextjs_app/package-lock.json ./

USER root
RUN chown -R 1001:0 /app

USER 1001
RUN npm install

COPY ./nextjs_app/tsconfig.json ./tsconfig.json
COPY ./nextjs_app/next.config.ts ./next.config.ts
COPY ./nextjs_app/app ./app

RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]