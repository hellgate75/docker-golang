#!/bin/sh
DOCKER_VERSION="universal"
if [ "" != "$1" ]; then
	DOCKER_VERSION="$1"
fi
if [ "" != "$(which dos2unix)" ]; then
	dos2unix golang.env
	dos2unix docker-entrypoint.sh
	dos2unix install-golang.sh
fi
FOLDER="$(realpath "$(dirname "$0")")"
ARGS=""
VARRGS=""
for argument in $(cat $FOLDER/golang.env); do
	if [ "" != "$(echo $argument|awk 'BEGIN {FS=OFS="="}{print $2}')" ]; then
		VARRGS="$VARRGS --build-arg $argument"
	fi
done
echo "Using arguments:$VARRGS"
if [ "" != "$(docker image ls|awk 'BEGIN {FS=OFS=" "}{print $1":"$2}'| grep 'hellgate75'| grep 'golang:universal')" ]; then
	echo "Removing existing docker image ..."
	docker rmi -f hellgate75/golang:universal
fi
echo "Building Go! Language base image v. universal ..."
docker build --rm --force-rm --no-cache $VARRGS -t hellgate75/golang:universal .
