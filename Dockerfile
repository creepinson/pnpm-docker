FROM node:alpine
LABEL author="Theo Paris" maintainer="theo@throw-out-error.dev"

# Install Git
RUN apk add --no-cache bash jq git && adduser -D -h /home/container container

# Install pnpm
RUN npm install -g pnpm

# Fix paths
RUN pnpm config set store-dir /home/container/.pnpm-store
RUN pnpm config set tmp /home/container/.tmp

WORKDIR /home/container/app

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
