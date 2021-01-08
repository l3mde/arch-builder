#!/usr/bin/env bash
CURR_DIR_PATH="$(cd "$(dirname "${0}")"; pwd)"
CURR_DIR_NAME="${CURR_DIR_PATH##*/}"
PKG_DIR_PATH="${CURR_DIR_PATH}/packages"

IMAGE_TAG="${CURR_DIR_NAME}:latest"

if [[ -n ${NO_CACHE} ]]; then
    NO_CACHE="--no-cache"
fi

mkdir "${PKG_DIR_PATH}"

docker build ${NO_CACHE} -t "${IMAGE_TAG}" "${CURR_DIR_PATH}"
docker run -ti --rm --name "arch-builder" -v "${PKG_DIR_PATH}:/packages" "${IMAGE_TAG}" ${@}
