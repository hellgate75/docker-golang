#!/bin/sh
FOLDER="$(realpath "$(dirname "$0")")"
VARRGS=""
if [ "" != "$(which dos2unix)" ]; then
	dos2unix golang.env
fi
for argument in $(cat $FOLDER/golang.env); do
	if [ "" != "$(echo $argument|awk 'BEGIN {FS=OFS="="}{print $2}')" ]; then
		VARRGS="$VARRGS --build-arg $argument"
	fi
done
echo "Using arguments:$VARRGS"
if [ "" != "$(docker image ls|awk 'BEGIN {FS=OFS=" "}{print $1":"$2}'| grep 'golang:1.14')" ]; then
	echo "Removing existing docker image ..."
	docker rmi -f golang:1.14
fi
docker build --rm --force-rm --no-cache $VARRGS -t golang:1.14 .
