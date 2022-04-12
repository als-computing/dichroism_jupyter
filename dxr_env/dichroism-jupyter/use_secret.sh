#!/bin/bash
set -euo pipefail

if [ -f /run/secrets/github ]; then
   export GITHUB_TOKEN=$(cat /run/secrets/github)
fi
