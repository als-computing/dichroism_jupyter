#!/bin/bash
set -euo pipefail

python -m pip install ./tmp/dist/"${MODULE_PROJ_NAME}"-*.tar.gz
# pip install ./tmp/dist/"${MODULE_PROJ_NAME}"-*.tar.gz
