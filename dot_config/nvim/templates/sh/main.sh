#! /usr/bin/env bash

set -ex

# get directory of script
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# set FOO to value of FOO from env if exists, otherwise "defaultvalue"
FOO="${FOO:-defaultvalue}"

main () {
    return 0
}

main "$@"
