# pnpm docker image

nodejs pnpm docker image based off of `node:alpine`

## Usage

You can either base your image off of this image
and copy the files to `/mnt/server`,
or run the following command to run it with docker:

`docker run -d -v yourvolume:/mnt/server -e INSTALL_REPO="" -e INDEX_JS="index.js" creepinson/pnpm`

Here, the `INSTALL_REPO` variable means that it will clone your repository.
By default, it will run `pnpm install` and `node INDEX_JS` on the repository
if there is an `INDEX_JS` variable defined.
