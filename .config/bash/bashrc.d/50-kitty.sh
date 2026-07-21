# shellcheck shell=bash

if [[ -n $KITTY_INSTALLATION_DIR ]]; then
    export KITTY_SHELL_INTEGRATION=enabled
    # shellcheck source=/dev/null
    source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi

if command -v kitten >/dev/null; then
    # alias ssh='kitten ssh'
    alias clip='kitten clipboard'
    alias kdiff='kitten diff'
    alias khints='kitten hints'
    alias knotify='kitten notify'
fi
