FROM node:alpine
LABEL author="Theo Paris" maintainer="theo@throw-out-error.dev"

# Install Git
RUN apk add --no-cache git && adduser -D -h /home/container container

# Install pnpm
RUN npm install -g pnpm

RUN npm config set store-dir /home/container/.pnpm-store

WORKDIR /home/container/app

RUN chown -R container /home/container/app

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]
