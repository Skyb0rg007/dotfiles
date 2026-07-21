# shellcheck shell=bash

if command -v batman >/dev/null; then
    eval "$(batman --export-env)"
fi

if command -v batpipe >/dev/null; then
    eval "$(batpipe)"
fi
