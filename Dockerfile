FROM node:current-alpine3.10
LABEL author="Theo Paris" maintainer="theo@throw-out-error.dev"

# Install Git
RUN apk add --no-cache bash jq git && adduser -D -h /home/container container

# Install pnpm
RUN npm install -g pnpm

# Fix paths
USER container
WORKDIR /home/container/app

RUN pnpm config set store-dir /home/container/.pnpm-store
RUN npm config set store-dir /home/container/.pnpm-store
ENV TMPDIR /home/container/.tmp

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
