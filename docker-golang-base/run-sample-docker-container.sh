#!/bin/sh
GOVER="$(wget -q -O - https://golang.org/doc/devel/release.html | grep "<h2 id=\"go" | awk 'BEGIN {FS=OFS=" "}{print $2}' | awk 'BEGIN {FS=OFS="\""}{print $2}'|head -1|awk 'BEGIN {FS=OFS="go"}{print $2}')"

# Removing previous containers
if [ "" != "$(docker ps -a|grep -v IMAGE|grep "golang-$GOVER")" ] {
	docker rm -f golang-$GOVER
}

# Checking custom docker image version from command line argument(s)
DOCKER_VERSION="universal"
if [ "" != "$1" ]; then
	DOCKER_VERSION="$1"
fi

# Running and logging universal container without code
docker run -d -it --name golang-$GOVER hellgate75/golang:$DOCKER_VERSION bash
echo "Logging docker container: golang-$GOVER ..."
docker logs -f golang-$GOVER
