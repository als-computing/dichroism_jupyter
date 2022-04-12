#!/bin/bash
set -euo pipefail

python -m pip install ./dist/"${MODULE_NAME}"-*.tar.gz
