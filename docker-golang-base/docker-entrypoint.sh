#!/bin/sh
FOLDER="$(realpath "$(dirname "$0")")"
git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_EMAIL}"

if [ "" != "${APP_REPO}" ] && [ "" != "${APP_USER}" ] && [ "" != "${APP_NAME}" ]; then
	sh -c /root/scripts/clone-app-repository.sh
fi

if [ 0 -eq $# ]; then
    if [ "" != "$GO_CMD" ]; then
		sh -c /root/scripts/run-golang-app.sh
	else
		echo "Executing shell command: $@"
		sh -c "$@"
    fi
else
	echo "Executing shell command: $@"
	sh -c "$@"
fi
