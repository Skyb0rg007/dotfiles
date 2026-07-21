# shellcheck shell=bash

alias ls='ls --color=auto'
alias l='ls -C'
alias la='ls --almost-all'
alias ll='ls --almost-all --classify -l'

if command -v nvim >/dev/null; then
    alias vim=nvim
fi

if command -v plocate >/dev/null; then
    alias locate=plocate
fi
