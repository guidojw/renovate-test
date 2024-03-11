FROM node:21.7.1@sha256:f952a494a2a70367beb148c885fab6b455085fc5969a7fd7409b1929b9336db8

ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV
ARG BUILD_HASH
ENV BUILD_HASH=$BUILD_HASH

WORKDIR /opt/app
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn .yarn
RUN yarn install --immutable

COPY . .
RUN yarn build

RUN chmod +x ./bin/wait-for-it.sh

EXPOSE 3000

CMD yarn start
