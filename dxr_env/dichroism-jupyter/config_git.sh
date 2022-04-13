#!/bin/bash
set -euo pipefail

source ./use_secret.sh

git init
git config user.name "Padraic Shafer"
git config user.email pshafer@lbl.gov
git config --global url."https://${GITHUB_TOKEN}:@github.com/".insteadOf "https://github.com/" \
