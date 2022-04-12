#!/bin/bash --login
set -e
conda activate $DEFAULT_ENV_PREFIX
exec "$@"
