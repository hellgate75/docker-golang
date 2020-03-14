#!/bin/sh
DOCKER_VERSION="universal"
if [ "" != "$1" ]; then
	DOCKER_VERSION="$1"
fi
docker run -it --rm --name golang-$DOCKER_VERSION golang:$DOCKER_VERSION bash
