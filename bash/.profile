#!/bin/sh

### XDG support ###
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"

### PATH ###
PATH="$HOME/.local/bin:$PATH"                  # XDG
PATH="$PATH:$XDG_DATA_HOME/ghcup/bin"          # ghcup
PATH="$PATH:/opt/intel/system_studio_2019/bin" # icc

### Shell config ###
# general
export SUDO_EDITOR=vimx VISUAL=vimx EDITOR=vimx # Vim as default editor
# bash
export HISTCONTROL=ignoreboth # Ignore duplicates + spaced commands
# bc
export BC_ENV_ARGS=$HOME/.config/bc/bcrc # Custom bc functions
# pkg-config
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig
# ld
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
export RLWRAP_HOME=$XDG_DATA_HOME/rlwrap
# ccache
export CCACHE_CONFIGPATH=$XDG_CONFIG_HOME/ccache.config
export CCACHE_DIR=$XDG_CACHE_HOME/ccache
# lua
export LUAROCKS_CONFIG_5_1=$XDG_CONFIG_HOME/luarocks/config-5.1.lua
export LUAROCKS_CONFIG_5_3=$XDG_CONFIG_HOME/luarocks/config-5.3.lua
LUA_CPATH="$(luarocks-5.1 --lr-cpath path);/usr/local/lib64/lib?51.so"
LUA_PATH="$(luarocks-5.1 --lr-path path);./?.lua"
LUA_CPATH_5_3="$(luarocks-5.3 --lr-cpath path);/usr/local/lib64/lib?53.so"
LUA_PATH_5_3="$(luarocks-5.3 --lr-path path);./?.lua"
export LUA_CPATH LUA_PATH LUA_CPATH_5_3 LUA_PATH_5_3
# vim
export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc/vimrc"
# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# gforth
export GFORTHHIST=$XDG_CACHE_HOME/gforth
# cabal
export CABAL_CONFIG=$XDG_CONFIG_HOME/cabal/config
# stack
export STACK_ROOT=$XDG_DATA_HOME/stack
# ruby
export GEM_HOME=$XDG_DATA_HOME/gem
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem
export GEMRC=$XDG_CONFIG_HOME/gem/config
# rustup
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
# lein
export LEIN_HOME=$XDG_DATA_HOME/lein
# erlang
if [ -r /home/ssoss/.local/share/erlang/21.3-plt/activate ]; then
    . /home/ssoss/.local/share/erlang/21.3-plt/activate >/dev/null 2>&1
fi
# opam
export OPAMROOT=$XDG_DATA_HOME/opam
if [ -r /home/ssoss/.local/share/opam/opam-init/init.sh ]; then
    . /home/ssoss/.local/share/opam/opam-init/init.sh >/dev/null 2>&1
fi
# emscripten
if [ -f /home/ssoss/Documents/Programming/C++/emsdk/emsdk_env.sh ]; then
    . /home/ssoss/Documents/Programming/C++/emsdk/emsdk_env.sh >/dev/null 2>&1
fi
