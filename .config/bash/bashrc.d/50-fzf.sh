# shellcheck shell=bash

if command -v fzf >/dev/null && [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
    eval "$(fzf --bash)"
fi
