FROM cribl/scope:1.3.1 AS appscopebuild

FROM node:19.7.0-alpine as base

FROM base as builder

RUN apk add --update --no-cache \
    python3 \
    make \
    gdb \
    g++

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production

COPY --from=appscopebuild /usr/local/bin/scope /usr/local/bin/scope

# Just to extract scope
RUN /usr/local/bin/scope ls

COPY . .
