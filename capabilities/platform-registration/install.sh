#!/usr/bin/env bash

set -euo pipefail

################################################################################
# Repository
################################################################################

SCRIPT_DIR="$(
    cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 || exit
    pwd
)"

ROOT="$(
    cd "${SCRIPT_DIR}/../.." >/dev/null 2>&1 || exit
    pwd
)"

################################################################################
# SDK
################################################################################

# shellcheck source=../../lib/sdk/loader.sh
# shellcheck disable=SC1091
source "${ROOT}/lib/sdk/loader.sh"

################################################################################
# Installation
################################################################################

INSTALL_DIR="${HOME}/.config/mcu"

mkdir -p "${INSTALL_DIR}"

tempfile="$(mktemp "${INSTALL_DIR}/installation.env.XXXXXX")"

mcu_template_render \
    "${ROOT}/config/mcu/installation.env.in" \
    "${tempfile}" \
    INSTALLATION_SCHEMA="installation/v1" \
    PRODUCT_ID="mcu" \
    PRODUCT_NAME="MCU" \
    PRODUCT_ROOT="${ROOT}" \
    PRODUCT_REPOSITORY="https://github.com/morsecodemedia/mcu.git" \
    PRODUCT_CHANNEL="development" \
    PRODUCT_VERSION="1.0.0"

mv -f "${tempfile}" "${INSTALL_DIR}/installation.env"

jq -n \
    --arg root "${ROOT}" '
{
    schema: "installation-state/v1",
    status: "installed",
    root: $root
}
'