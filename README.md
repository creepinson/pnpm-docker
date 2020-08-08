# pnpm docker image

nodejs pnpm docker image based off of `node:alpine`

## Usage

You can either base your image off of this image
and copy the files to `/home/container/app`, or run the following command to run it with docker:

`docker run -d -v yourvolume:/home/container/app -e INSTALL_REPO="" -e INDEX_JS="index.js" creepinson/pnpm`

Here, the `INSTALL_REPO` variable means that it will clone your repository. By default, it will run `pnpm install` if there is NOT a `NO_INSTALL` variable defined. It will also run `node INDEX_JS` on the repository if there is an `INDEX_JS` variable defined. You can also use the `START_COMMAND` environment variable in order to specify a custom command for pnpm to use (ex. `START_COMMAND=run start`).
