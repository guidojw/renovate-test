FROM node:17.9.1@sha256:1845a99ada85e286535bbf12e1261ea688b28b7e8bcf6521590edbbea9f41cf9

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
