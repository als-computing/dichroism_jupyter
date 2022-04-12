#!/bin/bash
set -euo pipefail

if [ -d ./dist ]; then
   rm -rf ./dist
fi
python setup.py sdist

# ARGS=
# [[ $# -lt 1 ]] || ARGS=$@
# echo Using ARGS: ${ARGS}

run_container=
build_args=
docker_compose=

while [[ $# -gt 0 ]] 
do
    case "$1" in
        --run) echo "Will run container"; run_container=1
            ;;
        --compose) echo "Will run docker-compose"; docker_compose=1
            ;;
        # --no-cache) echo "--no-cache"
        #     ;;
        --*) build_args="${build_args} $1"
            ;;
        *) build_args="${build_args} $1"
            ;;
    esac
    shift
done
echo Using extra build_args: ${build_args}

PROJ_VERSION=$(python ./dxr_env/version_id.py)
TAG_NAME=latest
if [[ ${PROJ_VERSION} =~ \.dev ]]; then
   TAG_NAME=testing
fi

IMAGE_NAME=dichroism-jupyter
MODULE_NAME=dxr_env

DOCKER_BUILDKIT=1 docker build \
  -t ${IMAGE_NAME}:${PROJ_VERSION} \
  -t ${IMAGE_NAME}:${TAG_NAME} \
  --progress=plain . \
  --build-arg username=dxr_user \
  --build-arg uid=402 \
  --build-arg gid=100 \
  -f ./${MODULE_NAME}/${IMAGE_NAME}/Dockerfile ${build_args}

# REGISTRY=registry.services.nersc.gov
# SUB_REG=pshafer

REGISTRY=registry.nersc.gov
SUB_REG=als

# Upload docker images to registry
docker login ${REGISTRY}
docker tag ${IMAGE_NAME}:${PROJ_VERSION} \
  ${REGISTRY}/${SUB_REG}/${IMAGE_NAME}:${PROJ_VERSION}
docker tag ${IMAGE_NAME}:${TAG_NAME} \
  ${REGISTRY}/${SUB_REG}/${IMAGE_NAME}:${TAG_NAME}
docker push ${REGISTRY}/${SUB_REG}/${IMAGE_NAME}:${PROJ_VERSION}
docker push ${REGISTRY}/${SUB_REG}/${IMAGE_NAME}:${TAG_NAME}

if [[ -n "${docker_compose}" ]]; then
   cd ./dxr_env
   docker-compose up -d --build build-networks
   docker-compose up -d
fi

if [[ -z "${run_container}" ]]; then
   exit 0
fi

HOST_PORT=8889

docker run -it --rm \
  # --env DEFAULT_ENV_NAME=dbc_fastapi \
  -p 0.0.0.0:${HOST_PORT}:8888/tcp \
  ${IMAGE_NAME}:${TAG_NAME} /bin/bash
