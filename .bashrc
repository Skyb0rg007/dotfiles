# shellcheck shell=bash

# Only run in interactive shells
[[ $- == *i* ]] || return

## Bash settings

HISTCONTROL=ignoreboth
HISTFILE="$XDG_STATE_HOME/bash/history"; mkdir -p "$XDG_STATE_HOME/bash"
HISTFILESIZE=1000
HISTIGNORE="exit"
HISTSIZE=1000
MAILCHECK=0

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs
shopt -s hostcomplete

set -o ignoreeof

# Prompt
__get_terminal_column () {
    local oldstty pos
    # We need to capture the output from the tty
    exec < /dev/tty
    oldstty="$(stty --save)"
    stty raw -echo min 0
    # tput u7 > /dev/tty
    printf '\e[6n' > /dev/tty
    IFS=';' read -r -d R -a pos
    stty "$oldstty"
    echo "$((pos[1] - 1))"
}

hexcode_truecolor () {
    printf '\e[38;2;%d;%d;%dm' "0x${1:0:2}" "0x${1:2:2}" "0x${1:4:2}"
}

case "$TERM" in
    xterm-color|xterm-kitty|*-256color) color_prompt=yes
esac

if command -v tput >&/dev/null && tput setaf 1 >&/dev/null; then
    color_prompt=yes
fi

if [ "$color_prompt" = yes ]; then
    _color_reset=$'\e[0m'
    _color_yellow="$(hexcode_truecolor e5c07b)"
    _color_green="$(hexcode_truecolor 98c379)"
    _color_white="$(hexcode_truecolor dcdfe4)"
    _color_cyan="$(hexcode_truecolor 56b6c2)"
    _color_blue="$(hexcode_truecolor 61afef)"
    _color_magenta="$(hexcode_truecolor c678dd)"
    _color_red="$(hexcode_truecolor e06c75)"
fi

_prompt_prefix=""
_prompt_jobs=""
_prompt_exit_status="0"
_prompt_exit_color="$_color_green"

prompt_command () {
    _prompt_exit_status="$?"
    local -a _jobs

    mapfile -t _jobs < <(jobs -p)
    if [[ "${#_jobs[@]}" -gt 0 ]]; then
        _prompt_jobs=" [${#_jobs[@]}]"
    else
        _prompt_jobs=""
    fi
    if [[ $_prompt_exit_status = 0 ]]; then
        _prompt_exit_color="$_color_green"
    else
        _prompt_exit_color="$_color_red"
    fi
    if [[ $TMPDIR =~ ^/tmp/nix-shell ]]; then
        if [[ -n $ENVOLUNTARY_ENV_STATE ]]; then
            _prompt_prefix="(env) "
        else
            _prompt_prefix="(nix) "
        fi
    elif [[ $SHLVL -gt 1 ]]; then
        _prompt_prefix="(sh) "
    else
        _prompt_prefix=""
    fi
}

# source __git_ps1
mapfile -td : _data_dirs <<<"$XDG_DATA_DIRS"
for _data_dir in "${_data_dirs[@]}"; do
    if [[ -e $_data_dir/git/contrib/completion/git-prompt.sh ]]; then
        # shellcheck source=/run/current-system/sw/share/git/contrib/completion/git-prompt.sh
        source "$_data_dir/git/contrib/completion/git-prompt.sh"
        break
    fi
done
unset _data_dir _data_dirs

PROMPT_COMMAND="prompt_command${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
PS1='\[$_color_cyan\]$_prompt_prefix\[$_color_reset\]'
PS1+='\[$_color_yellow\]\u@\h\[$_color_reset\]'
PS1+=' \[$_color_blue\]\w\[$_color_reset\]'
PS1+='\[$_color_red\]$_prompt_jobs\[$_color_reset\]'
if declare -pf __git_ps1 >&/dev/null; then
    PS1+='\[$_color_magenta\]$(__git_ps1)\[$_color_reset\]'
fi
PS1+='\n\[$_prompt_exit_color\]($_prompt_exit_status)\[$_color_reset\]'
PS1+=' \[$_color_white\]>\[$_color_reset\] '

alias ls='ls --color=auto'
alias l='ls -C'
alias la='ls --almost-all'
alias ll='ls --almost-all --classify -l'

if command -v adb >/dev/null && [[ -v ANDROID_USER_HOME ]]; then
    alias adb='HOME="$ANDROID_USER_HOME" adb'
fi

if command -v plocate >/dev/null; then
    alias locate='plocate'
fi

# Helpers
mkcd () {
    # shellcheck disable=SC2164
    mkdir -p "$1" && cd "$1"
}

# bat
if command -v batman >/dev/null; then
    eval "$(batman --export-env)"
fi
if command -v batpipe >/dev/null; then
    eval "$(batpipe)"
fi

# direnv
if command -v direnv >/dev/null; then
    eval "$(direnv hook bash)"
fi

# envoluntary
if command -v envoluntary >/dev/null; then
    eval "$(envoluntary shell hook bash)"
fi

# fzf
if command -v fzf >/dev/null && [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
    eval "$(fzf --bash)"
fi

# oci-cli
if command -v oci >/dev/null; then
    _oci_completion() {
        mapfile -t COMPREPLY < <(
            env COMP_WORDS="${COMP_WORDS[*]}" \
                COMP_CWORD="$COMP_CWORD" \
                _OCI_COMPLETE="complete" \
                "$1")
        return 0
    }
    complete -F _oci_completion -o default oci
fi

# gpg
# shellcheck disable=SC2155
export GPG_TTY="$(tty)"

# kitty
if [ -n "$KITTY_INSTALLATION_DIR" ]; then
    export KITTY_SHELL_INTEGRATION=enabled
    # shellcheck source=/dev/null
    source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi
if command -v kitten >/dev/null; then
    alias ssh='kitten ssh'
    alias clip='kitten clipboard'
    alias kdiff='kitten diff'
    alias khints='kitten hints'
    alias knotify='kitten notify'
fi

# less
if command -v lesspipe >/dev/null; then
    eval "$(lesspipe)"
fi

# nnn
export NNN_OPTS="eoR"
export NNN_ORDER=""
if command -v xdg-user-dir >/dev/null; then
    NNN_ORDER="$NNN_ORDER${NNN_ORDER:+;}t:$(xdg-user-dir DOWNLOAD)"
fi
if command -v saidar >/dev/null; then
    export NNN_LOCKER="saidar -c"
fi
if command -v trash-cli >/dev/null; then
    export NNN_TRASH="1"
fi
if command -v nnn >/dev/null; then
    n () {
        if [ "${NNNLVL:-0}" -ne 0 ]; then
            echo "nnn is already running"
            return
        fi
        command nnn "$@"
        if [ -f "$NNN_TMPFILE" ]; then
            # shellcheck source=/dev/null
            source "$NNN_TMPFILE"
            rm -f -- "$NNN_TMPFILE" >/dev/null
        fi
    }
fi

