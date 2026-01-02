# ~/.profile - initialize the shell environment
# This should mostly be limited to setting environment variables

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.local/state}"

# editor
export EDITOR=vim
export VISUAL="$EDITOR"

# bash
export BASH_HISTORY="$XDG_STATE_HOME/bash/history"
mkdir -p "$XDG_STATE_HOME/bash"
# cargo (rust)
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
# gforth
export GFORTHHIST="$XDG_STATE_HOME/gforth/history"
# golang
export GOCACHE="$XDG_CACHE_HOME/go/build"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export GOPATH="$XDG_DATA_HOME/go"
# gpg
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# kubectl
export KUBECONFIG="$XDG_CONFIG_HOME/kube"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"
# minikube
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
# minio-client
export MC_CONFIG_DIR="$XDG_CONFIG_HOME/minio-client"
# nodejs
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/history"
# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
# ocaml
export OPAMROOT="$XDG_DATA_HOME/opam"
# openssl
export OPENSSL_CONF="$XDG_CONFIG_HOME/openssl/openssl.conf"
# php
export PHP_HISTFILE="$XDG_STATE_HOME/php/history"
# python
export PYTHONCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
# radicle
export RAD_HOME="$XDG_DATA_HOME/radicle"
# export RAD_SOCKET="${XDG_RUNTIME_DIR:-/run/user/$UID}/radicle-node/control.sock"
# raku
export RAKUDO_HIST="$XDG_STATE_HOME/rakudo/history"
# readline
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
# rlwrap
export RLWRAP_HOME="$XDG_STATE_HOME/rlwrap"
# screen
export SCREENRC="$XDG_CONFIG_HOME/screen/config"
# sigstore
export TUF_ROOT="$XDG_DATA_HOME/sigstore/root"
# stack
export STACK_XDG="1"
# step-cli
export STEPPATH="$XDG_DATA_HOME/step"
# tmux
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
# w3m
export W3M_DIR="$XDG_DATA_HOME/w3m"
# wakatime
export WAKATIME_HOME="$XDG_DATA_HOME/wakatime"
mkdir -p "$WAKATIME_HOME"
# wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

case ":${PATH:=$HOME/.local/bin}:" in
	*:"$HOME/.local/bin":*) ;;
	*) PATH="$HOME/.local/bin:$PATH" ;;
esac
