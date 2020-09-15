FROM node:current-alpine
LABEL author="Theo Paris" maintainer="theo@throw-out-error.dev"

# Install Git
RUN adduser -D -h /home/container container && mkdir -p /home/container/.tmp


# Install dependencies
RUN apk add --no-cache bash jq git && npm install -g pnpm

RUN pnpm config set store-dir /home/container/.pnpm-store && \
    npm config set store-dir /home/container/.pnpm-store
ENV TMPDIR /home/container/.tmp

# Fix paths
WORKDIR /home/container/app
RUN chmod 777 -R /home/container/app
RUN chmod 777 -R /home/container/.tmp

USER container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
