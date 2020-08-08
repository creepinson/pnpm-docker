# pnpm docker image

nodejs pnpm docker image based off of `node:alpine`

## Usage

You can either base your image off of this image
and copy the files to `/home/container/app`, or run the following command to run it with docker:

`docker run -d -v yourvolume:/home/container/app -e INSTALL_REPO="" -e INDEX_JS="index.js" creepinson/pnpm`

Here, the `INSTALL_REPO` variable means that it will clone your repository. By default, it will run `pnpm install` if there is NOT a `NO_INSTALL` variable defined. It will also run `node INDEX_JS` on the repository if there is an `INDEX_JS` variable defined. You can also use the `PNPM_ARGUMENTS` environment variable in order to specifY custom commandS for pnpm to use (ex. `PNPM_ARGUMENTS='["run start"]'`). The pnpm arguments variable, if defined, has to be in a json array format due to github actions restrictions.

### Docker Compose Usage

To use this with docker compose, you can specify the image and the volume as seen below, and then pass the environment variables to it using `environment: `  
Example:
```yaml
version: "3"

services:
    test:
        image: creepinson/pnpm
        volumes:
            - ./test-data:/home/container/app
        environment:
            - INSTALL_REPO=https://github.com/creepinson/uwu-bot
            - PNPM_ARGUMENTS='["run start"]'
```
