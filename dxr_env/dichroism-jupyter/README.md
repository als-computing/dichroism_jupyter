# dichroism-jupyter

Conda environments for processing ALS Dichroism data

Jupyter lab is available with kernels for each conda environment

## Build docker image

From the top-level project directory run:

```
PROJ_VERSION=$(python ./dxr_env/version_id.py)
TAG_NAME=latest
if [[ ${PROJ_VERSION} =~ \.dev ]]; then
   TAG_NAME=testing
fi

DOCKER_BUILDKIT=1 docker build \
  -t dichroism-jupyter:${PROJ_VERSION} \
  -t dichroism-jupyter:${TAG_NAME} \
  --progress=plain . \
  --build-arg username=dxr_user \
  --build-arg uid=402 \
  --build-arg gid=100 \
  -f ./dxr_env/dichroism-jupyter/Dockerfile ${build_args}
```

### Push docker image to NERSC registry

```
REGISTRY=registry.nersc.gov
SUB_REG=als

# Upload docker images to registry
docker login ${REGISTRY}
docker tag dichroism-jupyter:${PROJ_VERSION} \
  ${REGISTRY}/${SUB_REG}/dichroism-jupyter:${PROJ_VERSION}
docker tag dichroism-jupyter:${TAG_NAME} \
  ${REGISTRY}/${SUB_REG}/dichroism-jupyter:${TAG_NAME}
docker push ${REGISTRY}/${SUB_REG}/dichroism-jupyter:${PROJ_VERSION}
docker push ${REGISTRY}/${SUB_REG}/dichroism-jupyter:${TAG_NAME}
```

## Customize container

Supply the following environment variables.

```
# Conda environment at shell startup
DEFAULT_ENV_NAME 
```

Example:

```
# Choose one of these options...
DEFAULT_ENV_NAME=bluesky
DEFAULT_ENV_NAME=dash_fastapi
DEFAULT_ENV_NAME=dbc_fastapi
```

Default values are provided for all environment variables (ENV).
