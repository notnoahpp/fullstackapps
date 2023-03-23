# syntax=docker/dockerfile:1.4
# @see https://nodejs.org/en/docs/guides/nodejs-docker-webapp/

FROM node:19.2.0

RUN mkdir -p /usr/src/web/apps/nirvai-web-bff && \
  mkdir /usr/src/web/packages

WORKDIR /usr/src/web

COPY \
  .eslintignore \
  .eslintrc.cjs \
  .npmrc \
  package*.json \
  pnpm*.yaml \
  tsconfig.json \
  turbo.json \
  /usr/src/web
COPY \
  ./apps/apps.backend.tsconfig.json \
  ./apps/apps.tsconfig.json \
  /usr/src/web/apps
COPY ./apps/nirvai-web-bff/package.json \
  ./apps/nirvai-web-bff/bff.compose.bootstrap.sh \
  /usr/src/web/apps/nirvai-web-bff

WORKDIR  /usr/src/web/apps/nirvai-web-bff

RUN npm install -g pnpm@7.17.1 && \
  pnpm fetch && \
  CI=true pnpm install -r --offline --frozen-lockfile

EXPOSE 3001