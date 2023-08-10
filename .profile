# ~/.profile
# Sourced by POSIX sh and Bash, write shell-agnostic configuration here

# user::rwx, group::r-x, other::r-x
umask 022

# Setup $DISPLAY for the X server
local_ip="$(grep nameserver /etc/resolv.conf | awk '{ print $2 }')"
export DISPLAY="$local_ip:0"

export EDITOR=vim
export VISUAL=vim

# XDG Base Directory Specicication (https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
# XDG_DATA_HOME:
#   User-specific data files.
#   Analogous to /usr/share.
# XDG_CONFIG_HOME:
#   User-specific configuration files.
#   Analogous to /etc.
# XDG_STATE_HOME:
#   User-specific state data.
#   Data here should persist between application restarts,
#   but not important or portable enough for XDG_DATA_HOME.
#   Ex. command history, logfiles, recently used, layout at close.
#   Analogous to /var/lib.
# XDG_CACHE_HOME:
#   User-specific, non-essential data.
#   Analogous to /var/cache.
# XDG_RUNTIME_DIR:
#   User-specific non-essential runtime files and other file objects.
#   The runtime directory must have access mode 0700 and be locally mounted.
#   It is created at login and is removed at last logout.
# XDG_DATA_DIRS:
#   Preference ordered paths to search for data files.
# XDG_CONFIG_DIRS:
#   Preference ordered paths to search for configuration files.
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME
export XDG_RUNTIME_DIR XDG_DATA_DIRS XDG_CONFIG_DIRS
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"
XDG_RUNTIME_DIR="/run/user/$(id -u)"
XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/snapd/desktop"
XDG_CONFIG_DIRS="/etc/xdg"

# Check the validity of the above assignments
# XDG_DATA_DIRS and XDG_CONFIG_DIRS don't require any checking
for var in XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME; do
    eval val="\$$var"
    # shellcheck disable=2154 # Doing indirect expansion
    if [ ! -d "$val" ]; then
        echo >&2 "$var ($val) does not exist"
    fi
done
unset var val
if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    echo >&2 "XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) does not exist"
elif [ "$(stat -c "%U" "$XDG_RUNTIME_DIR")" != "$USER" ]; then
    echo >&2 "XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) is not owned by current user ($USER)"
elif [ "$(stat -c "%a" "$XDG_RUNTIME_DIR")" != 700 ]; then
    echo >&2 "XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) does not have the right access rights"
elif [ "$(df -T "$XDG_RUNTIME_DIR" | tail -n +2 | awk '{ print $2 }')" != tmpfs ]; then
    echo >&2 "XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) is not mounted on a tmpfs file system"
fi

# path_prepend var dir
# path_append var dir
# Modifies $var to include dir, if not already included
path_prepend() {
    case ":$(eval "echo \$$1"):" in
        *":$2:"*) :;;
        *) eval "export $1=\"$2\${$1:+\":\$$1\"}\""
    esac
}
path_append() {
    case ":$(eval "echo \$$1"):" in
        *":$2:"*) :;;
        *) eval "export $1=\"\${$1:+\"\$$1:\"}$2\""
    esac
}

## PATH,MANPATH,INFOPATH
path_prepend PATH "$HOME/.local/bin"
path_append  PATH "$XDG_DATA_HOME/cabal/bin"
path_append  PATH "$XDG_DATA_HOME/cargo/bin"
path_append  PATH "$XDG_DATA_HOME/elan/bin"
path_append  PATH "$XDG_DATA_HOME/go/bin"
path_append  PATH "$XDG_DATA_HOME/luarocks/bin"
path_append  PATH "$XDG_DATA_HOME/npm/bin"
path_append  PATH "/mnt/c/Program Files/Mozilla Firefox"

# These utilities require sourcing their own scripts
if [ -f "$XDG_CONFIG_HOME/nvm/nvm.sh" ]; then
    # shellcheck source=.config/nvm/nvm.sh
    . "$XDG_CONFIG_HOME/nvm/nvm.sh"
fi
if [ -f "$XDG_DATA_HOME/opam/opam-init/variables.sh" ]; then
    # shellcheck source=.local/share/opam/opam-init/variables.sh
    . "$XDG_DATA_HOME/opam/opam-init/variables.sh"
fi

# XDG compliance (https://wiki.archlinux.org/title/XDG_Base_Directory)
# agda
export AGDA_DIR="$XDG_CONFIG_HOME/agda"
# bash
export HISTFILE="$XDG_STATE_HOME/bash/history"
# bc
export BC_ENV_ARGS="--mathlib $XDG_CONFIG_HOME/bcrc"
# cabal
export CABAL_DIR="$XDG_DATA_HOME/cabal"
# cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# ccache
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache/ccache.config"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
# elm
export ELM_HOME="$XDG_CONFIG_HOME/elm"
# gforth
export GFORTHHIST="$XDG_STATE_HOME/gforth/history"
# GnuPG
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# golang
export GOPATH="$XDG_DATA_HOME/go"
export GOCACHE="$XDG_CACHE_HOME/go-build"
export GOENV="$XDG_CONFIG_HOME/go/env"
export GOBIN="$XDG_DATA_HOME/go/bin"
# irb
export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"
# java
#export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
# jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
# lean
export ELAN_HOME="$XDG_DATA_HOME/elan"
# lein
export LEIN_HOME="$XDG_DATA_HOME/lein"
# less
export LESS="--QUIET --RAW-CONTROL-CHARS"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
# lua / luarocks
export LUA_PATH_5_4=";;$XDG_DATA_HOME/luarocks/share/lua/5.4/?.lua;$XDG_DATA_HOME/luarocks/share/lua/5.4/?/init.lua"
export LUA_CPATH_5_4=";;$XDG_DATA_HOME/luarocks/lib/lua/5.4/?.so"
# node
export NODE_PATH="$XDG_DATA_HOME/npm/lib/node_modules"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/history"
# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
# opam
export OPAMROOT="$XDG_DATA_HOME/opam"
# pylint
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
# python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python_startup.py"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
# rakubrew
export RAKUBREW_HOME="$XDG_DATA_HOME/rakubrew"
# rakudo
export RAKUDO_HIST="$XDG_STATE_HOME/rakudo-history"
# readline
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
# rlwrap
export RLWRAP_HOME="$XDG_STATE_HOME/rlwrap"
# rustup
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
# screen
export SCREENRC="$XDG_CONFIG_HOME/screen/config"
# sqlite3
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite/history"
# stack
export STACK_ROOT="$XDG_DATA_HOME/stack"
# texlive
export TEXMFCONFIG="$XDG_CONFIG/texlive/texmf-config"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
# wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
sed --in-place --expression='/hsts-file/c\\hsts-file = '"$XDG_CONFIG_HOME"'/wget/hosts' "$WGETRC"
# zef
export ZEF_CONFIG_STOREDIR="$XDG_DATA_HOME/zef"
export ZEF_CONFIG_PATH="$XDG_CONFIG_HOME/zef/config.json"
export ZEF_CONFIG_TEMPDIR="$XDG_CACHE_HOME/zef"
