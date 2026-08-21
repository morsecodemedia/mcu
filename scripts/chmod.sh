#!/usr/bin/env bash

set -euo pipefail

ROOT="$(
    cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1
    pwd
)"

cd "${ROOT}"

find \
    bin \
    capabilities \
    lib \
    scripts \
    -type f \
    -name "*.sh" \
    -exec chmod +x {} +