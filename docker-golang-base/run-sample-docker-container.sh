#!/bin/sh

# Checking custom docker image version from command line argument(s)
DOCKER_VERSION="1.14"
GOVER="1.14"

# Removing previous containers
if [ "" != "$(docker ps -a|grep -v IMAGE|grep "golang-$GOVER")" ]; then
	echo "Removing existing docker container: golang-$GOVER ..."
	docker rm -f golang-$GOVER
fi

# Running and logging universal container without code
echo "Running docker container: golang-$GOVER (Go version $GOVER) ..."
docker run -d -it --name golang-$GOVER hellgate75/golang:$DOCKER_VERSION bash
echo "Logging docker container: golang-$GOVER ..."
docker logs -f golang-$GOVER
