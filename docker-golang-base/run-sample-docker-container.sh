#!/bin/sh
DOCKER_VERSION="universal"
if [ "" != "$1" ]; then
	DOCKER_VERSION="$1"
fi
docker run -it --rm --name golang-1.14 golang:$DOCKER_VERSION bash
