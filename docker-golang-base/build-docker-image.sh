#!/bin/sh
FOLDER="$(realpath "$(dirname "$0")")"
ARGS=""
VARRGS=""
for argument in $(cat $FOLDER/golang.env); do
  VARRGS="$VARRGS --build-arg $argument"
done
echo "Using arguments:$VARRGS"
docker build --rm --force-rm --no-cache $VARRGS -t golang:1.14 .
