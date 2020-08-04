FROM node:alpine
LABEL maintainer="Theo Paris"

# Install Git
RUN apk add --no-cache git

# Install pnpm
RUN npm install -g pnpm
