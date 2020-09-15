FROM node:current-alpine3.12
LABEL author="Theo Paris" maintainer="theo@throw-out-error.dev"

# Install Git
RUN apk add --no-cache bash jq git && adduser -D -h /home/container container

# Install pnpm
RUN npm install -g pnpm

# Fix paths
WORKDIR /home/container/app
RUN chmod 777 -R /home/container/app
USER container

RUN pnpm config set store-dir /home/container/.pnpm-store
RUN npm config set store-dir /home/container/.pnpm-store
ENV TMPDIR /home/container/.tmp

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
