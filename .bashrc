# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't exit on EOF
set -o ignoreeof

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# history length
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

hexcode_truecolor () {
    local hex="$1"
    local r="0x${hex:0:2}" g="0x${hex:2:2}" b="0x${hex:4:2}"
    printf '\e[38;2;%d;%d;%dm' "$r" "$g" "$b"
}

## Settings for __git_ps1
# There are unstaged (*) changes or staged (+) changes
# shellcheck disable=SC2034
GIT_PS1_SHOWDIRTYSTATE=yes
# Something is stashed ($)
# shellcheck disable=SC2034
GIT_PS1_SHOWSTASHSTATE=yes
# A file is untracked (%)
# shellcheck disable=SC2034
GIT_PS1_SHOWUNTRACKEDFILES=yes
# Repo is behind (<), ahead (>), diverged (<>), or up-to-date (=) with upstream
# shellcheck disable=SC2034
GIT_PS1_SHOWUPSTREAM=auto

if [ "$color_prompt" = yes ]; then
    _color_reset=$'\e[0m'
    _color_yellow="$(hexcode_truecolor e5c07b)"
    _color_green="$(hexcode_truecolor 98c379)"
    _color_white="$(hexcode_truecolor dcdfe4)"
    _color_cyan="$(hexcode_truecolor 56b6c2)"
    _color_blue="$(hexcode_truecolor 61afef)"
    _color_magenta="$(hexcode_truecolor c678dd)"
    _color_red="$(hexcode_truecolor e06c75)"
else
    _color_reset=""
    _color_yellow=""
    _color_green=""
    _color_white=""
    _color_cyan=""
    _color_blue=""
    _color_magenta=""
    _color_red=""
fi

_prompt_exit_color="$_color_green"
_prompt_exit_status=0
_prompt_in_nix_shell=""

# Include indicator if in a chroot of another system
PS1='${debian_chroot:+($debian_chroot) }'
# If in nix shell, include (nix) in cyan
PS1+='\[${_color_cyan}\]${_prompt_in_nix_shell}\[${_color_reset}\]'
# user@host in yellow
PS1+='\[${_color_yellow}\]\u@\h\[${_color_reset}\]'
# pwd in blue
PS1+=' \[${_color_blue}\]\w\[${_color_reset}\]'
# If in git, include (git information) in magenta
PS1+='\[${_color_magenta}\]$(__git_ps1)\[${_color_reset}\]'
# Include most recent command exit status
PS1+='\n\[${_prompt_exit_color}\](${_prompt_exit_status})\[${_color_reset}\]'
# Prompt in white
PS1+=' \[${_color_white}\]>\[${_color_reset}\] '

__get_terminal_column() {
    local oldstty pos
    exec < /dev/tty
    oldstty="$(stty -g)"
    stty raw -echo min 0
    printf '\e[6n' > /dev/tty
    IFS=';' read -r -d R -a pos
    stty "$oldstty"
    echo "$((pos[1] - 1))"
}

prompt_command () {
    _prompt_exit_status="$?"
    if [[ $_prompt_exit_status = 0 ]]; then
        _prompt_exit_color="$_color_green"
    else
        _prompt_exit_color="$_color_red"
    fi
    if [[ $(__get_terminal_column) != 0 ]]; then
        printf '\e[7m%%\e[m\n'
    fi
    if [[ -n $IN_NIX_SHELL ]] || grep -q /nix/store <<<"$PATH"; then
        _prompt_in_nix_shell="(nix) "
    else
        _prompt_in_nix_shell=""
    fi
    return "$_prompt_exit_status"
}

PROMPT_COMMAND="prompt_command${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host: dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    elif [ -r "${XDG_CONFIG_HOME:-~/.config}/dircolors" ]; then
        eval "$(dircolors -b "${XDG_CONFIG_HOME:-~/.config}/dircolors")"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls --all --classify -l'
alias la='ls --almost-all'
alias l='ls -C'

# XXX: WSL2 doesn't support this
alert () {
    local icon=terminal body
    # shellcheck disable=SC2181
    if [[ $? != 0 ]]; then
        icon=error
    fi
    body="$(history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\+\s*alert$//')"
    notify-send --urgency=low --icon="$icon" "$body"
}

mkcd () { 
    mkdir "$1" && cd "$1" || return
}

# Update the system
update-all () {
    # WSL2 bug workaround
    sudo hwclock --hctosys
    sudo apt update --assume-yes
    sudo apt upgrade --assume-yes
    sudo apt autoremove --assume-yes
}

# Remove all stack files, leaving configuration files intact
nuke-stack () {
    if [[ ! -d $STACK_ROOT ]]; then
        return 1
    fi
    rm --force --recursive -- "$STACK_ROOT/.stack-work"
    rm --force --recursive -- "$STACK_ROOT/pantry"
    rm --force --recursive -- "$STACK_ROOT/programs"
    rm --force --recursive -- "$STACK_ROOT/templates"
    rm --force -- "$STACK_ROOT/stack.sqlite3"
    rm --force -- "$STACK_ROOT/stack.sqlite3.pantry-write-lock"
}

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# warn me if completions are unneeded or out-of-date
for f in "$XDG_DATA_HOME/bash-completion/completions"/*; do
    if cmd="$(command -v "$(basename "$f")")"; then
        if [[ $f -ot $cmd ]]; then
            # Some commands' completions can be updated automatically
            case "$f" in
                */stack|*/ghcup)
                    command "$cmd" --bash-completion-script "$cmd" > "$f"
                    ;;
                */elan|*/rustup)
                    command "$cmd" completions bash > "$f"
                    ;;
                */luarocks)
                    command "$cmd" completion bash > "$f"
                    ;;
                */pip|*/pip3)
                    command "$cmd" completion --bash > "$f"
                    ;;
                */latest-release)
                    command "$cmd" --completion > "$f"
                    ;;
                *) echo >&2 "completion for '$cmd' is older than the binary"
            esac
        fi
    else
        echo >&2 "completion for nonexistant binary '$f'"
    fi
done
unset f cmd

# Adding wsl-open as a browser for Bash for Windows
if [[ $(uname -r) =~ (m|M)icrosoft ]]; then
    if [[ -z $BROWSER ]]; then
        export BROWSER=wsl-open
    else
        export BROWSER=$BROWSER:wsl-open
    fi
fi

# other shell completions
if [[ -f $NVM_DIR/bash_completion ]]; then
    # shellcheck source=.config/nvm/bash_completion
    source "$NVM_DIR/bash_completion"
fi
if [[ -f $OPAMROOT/opam-init/complete.sh ]]; then
    # shellcheck source=.local/share/opam/opam-init/complete.sh
    source "$OPAMROOT/opam-init/complete.sh"
fi
if [[ -f $OPAMROOT/opam-init/env_hook.sh ]]; then
    # shellcheck source=.local/share/opam/opam-init/env_hook.sh
    source "$OPAMROOT/opam-init/env_hook.sh"
fi
if [[ -f "$XDG_DATA_HOME/ghcup/env" ]]; then
    # shellcheck source=.local/share/ghcup/env
    source "$XDG_DATA_HOME/ghcup/env"
fi
if [[ -f "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
    # shellcheck source=.local/share/sdkman/bin/sdkman-init.sh
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

