#!/usr/bin/env bash

################################################################################
# Runtime Primitive
#
# Template Rendering
################################################################################

mcu_template_render() {

    local template="$1"
    local destination="$2"

    shift 2

    local output
    local substitution

    output="$(
        cat "${template}"
    )"

    for substitution in "$@"; do

        local key="${substitution%%=*}"
        local value="${substitution#*=}"

        output="$(
            printf "%s" "${output}" \
                | sed "s|{{${key}}}|${value}|g"
        )"

    done

    printf "%s" "${output}" > "${destination}"
}
