# shellcheck shell=bash

HISTCONTROL=ignoreboth
HISTFILE="$XDG_STATE_HOME/bash/history"
HISTFILESIZE=1000
HISTIGNORE="exit"
HISTSIZE=1000
MAILCHECK=0

mkdir -p "$XDG_STATE_HOME/bash"
