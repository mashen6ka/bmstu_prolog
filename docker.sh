#!/usr/bin/env sh

set -x

export IMAGE_NAME="masha/swipl"

docker build -t ${IMAGE_NAME} .
docker run --rm -it -v $(pwd):/data ${IMAGE_NAME}
