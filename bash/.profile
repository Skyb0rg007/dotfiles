# ssoss .profile

### XDG-support ###
# XDG directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"

### Generally useful paths ##
export PATH=$HOME/.local/bin/:"$PATH"    # Local scripts
export PATH+=:$XDG_DATA_HOME/ghcup/bin/ # ghcup
export SUDO_EDITOR=vimx                  # Using sudoedit starts vimx
export HISTCONTROL=ignoreboth            # Ignore duplicates + spaced commands
export VISUAL=vimx EDITOR=vimx           # Vim as default editor
export BC_ENV_ARGS=$HOME/.config/bc/bcrc     # Custom bc functions
# Add /usr/local/ to pkg-config and ld
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64

# less
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
# bash
export HISTFILE=$XDG_DATA_HOME/bash/history
# libice
export ICEAUTHORITY=$XDG_CACHE_HOME/ICEauthority
# wget
export WGETRC=$XDG_CONFIG_HOME/wget/wgetrc
# readline
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
# rlwrap
export RLWRAP_HOME=$XDG_DATA_HOME/rlwrap/
# ccache
export CCACHE_CONFIGPATH=$XDG_CONFIG_HOME/ccache.config
export CCACHE_DIR=$XDG_CACHE_HOME/ccache/
# luarocks
export LUAROCKS_CONFIG_5_1=$XDG_CONFIG_HOME/luarocks/config-5.1.lua
export LUAROCKS_CONFIG_5_3=$XDG_CONFIG_HOME/luarocks/config-5.3.lua
# vim
export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc/vimrc"
# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# gforth
export GFORTHHIST=$XDG_CACHE_HOME/gforth/
# cabal
export CABAL_CONFIG=$XDG_CONFIG_HOME/cabal/config

### Lua ###
LUA_CPATH="$(luarocks-5.1 --lr-cpath path)"
LUA_PATH="$(luarocks-5.1 --lr-path path);./?.lua"
LUA_CPATH_5_3="$(luarocks-5.3 --lr-cpath path)"
LUA_PATH_5_3="$(luarocks-5.3 --lr-path path);./?.lua"
export LUA_CPATH LUA_PATH LUA_CPATH_5_3 LUA_PATH_5_3

### Erlang ###
[[ -e /home/ssoss/.local/share/erlang/21.3-plt/activate ]] && \
    . /home/ssoss/.local/share/erlang/21.3-plt/activate
