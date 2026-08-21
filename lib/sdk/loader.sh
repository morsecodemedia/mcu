#!/usr/bin/env bash

################################################################################
# Repository
################################################################################

SDK_DIR="$(
    cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 || exit
    pwd
)"

LIB_DIR="$(
    cd "${SDK_DIR}/.." >/dev/null 2>&1 || exit
    pwd
)"

################################################################################
# Template Rendering
################################################################################

# shellcheck source=../utilities/template.sh
# shellcheck disable=SC1091
source "${LIB_DIR}/utilities/template.sh"