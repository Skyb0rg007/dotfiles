#!/bin/bash

cd "$(dirname "$0")" || { echo "Error changing dirs!" >&2; exit 1; }

# if (( $# < 1 )); then
    # set -- --no-folding
# fi

for dir in *; do
    if [[ -d $dir ]]; then
        echo "Stowing $dir..."
        stow "$@" "$dir"
    fi
done
