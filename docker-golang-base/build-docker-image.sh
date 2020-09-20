#!/bin/sh
DOCKER_VERSION="1.15"
if [ "" != "$(which dos2unix)" ]; then
	dos2unix golang.env
	dos2unix docker-entrypoint.sh
	dos2unix install-golang-*.sh
	dos2unix run-golang-app.sh
	dos2unix clone-app-repository.sh
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
if [ "" != "$(docker image ls|awk 'BEGIN {FS=OFS=" "}{print $1":"$2}'| grep 'hellgate75'| grep "golang:${DOCKER_VERSION}")" ]; then
	echo "Removing existing docker image: hellgate75/golang:${DOCKER_VERSION} ..."
	docker rmi -f hellgate75/golang:${DOCKER_VERSION}
fi
echo "Building Go! Language ${DOCKER_VERSION} image v. ${DOCKER_VERSION} ..."
docker build --rm --force-rm --no-cache $VARRGS -t hellgate75/golang:${DOCKER_VERSION} .
