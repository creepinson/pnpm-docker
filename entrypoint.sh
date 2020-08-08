#!/bin/ash

if [[ ! ${INSTALL_REPO} = *\.git ]]; then
    INSTALL_REPO=$(echo -e ${INSTALL_REPO} | sed 's:/*$::')
    INSTALL_REPO="${INSTALL_REPO}.git"
fi

echo "working on installing a node project from ${INSTALL_REPO}"

if [ ! ${INSTALL_REPO} ]; then
    echo "assuming user will add files manually."
else
    if [ "$(ls -A /home/container/app)" ]; then
        echo "/home/container/app directory is not empty."
        if [ -d .git ]; then
            echo ".git directory exists"
            if [ -f .git/config ]; then
                echo "loading info from git config"
                ORIGIN=$(git config --get remote.origin.url)
            else
                echo "files found with no git config"
                echo "closing out without touching things to not break anything"
                exit 10
            fi
        fi
        if [ "${ORIGIN}" == "${INSTALL_REPO}" ]; then
            echo "pulling latest from github"
            git pull
        fi
    else
        echo "/home/container/app is empty.\ncloning files into repo"
        if [ -z ${INSTALL_BRANCH} ]; then
            echo "assuming master branch"
            INSTALL_BRANCH=master
        fi

        echo "running 'git clone --single-branch --branch ${INSTALL_BRANCH} ${INSTALL_REPO} .'"
        git clone --single-branch --branch ${INSTALL_BRANCH} ${INSTALL_REPO} .
    fi
fi

if [ -f package.json ] && [ ! ${NO_INSTALL} ]; then
    pnpm i --reporter=append-only
    echo "install complete"
fi

PNPM_ARGUMENTS="${PNPM_ARGUMENTS//\'/}"
readarray -t array < <(jq -r .[] <<<"$PNPM_ARGUMENTS")
echo "Found pnpm arguments: $array"

output=()

for pnpmArgument in "${array[@]}"; do
    echo "Running pnpm command: $pnpmArgument"
    pnpm $pnpmArgument
    output+=($?)
done

if [ -z ${INDEX_JS} ] && [ -f ${INDEX_JS} ]; then
    node "$INDEX_JS"
    output+=($?)
else
    echo "No node.js file found to run."
fi

for i in "${output[@]}"; do
    if [[ "0" != "$i" ]]; then
        echo "An error occurred while running pnpm commands."
        exit 1
    fi
done
