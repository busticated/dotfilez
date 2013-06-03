#!/usr/bin/env bash
set -e         # exit on error
set -o nounset # disallow unset vars

for dir in $(find $(pwd)/* -type d -maxdepth 0)
do
    if [[ ! -d ${dir}/.git ]]; then
        echo ":::: ${dir} is NOT a git repo SKIPPING"

    else
        echo ":::: pulling ${dir}"
        (cd $dir && git pull)
    fi
done
