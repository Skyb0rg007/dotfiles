# shellcheck shell=bash

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

if command -v tput &>/dev/null && tput setaf 1 &>/dev/null; then
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
    if [[ -n $DIRENV_DIR ]]; then
        _prompt_prefix="(dir) "
    elif [[ -n $ENVOLUNTARY_ENV_STATE ]]; then
        _prompt_prefix="(env) "
    elif [[ $TMPDIR =~ ^/tmp/nix-shell ]]; then
        _prompt_prefix="(nix) "
    elif [[ $SHLVL -gt 1 ]]; then
        _prompt_prefix="(sh) "
    else
        _prompt_prefix=""
    fi
}

# source __git_ps1
IFS=: read -ra _data_dirs <<<"$XDG_DATA_DIRS"
for _data_dir in "${_data_dirs[@]}"; do
    if [[ -e $_data_dir/git/contrib/completion/git-prompt.sh ]]; then
        # shellcheck source=/run/current-system/sw/share/git/contrib/completion/git-prompt.sh
        source "$_data_dir/git/contrib/completion/git-prompt.sh"
        break
    fi
done
unset _data_dir _data_dirs

# __git_ps1 configuration
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWCONFLICTSTATE=1

PROMPT_COMMAND+=(prompt_command)
PS1='\[$_color_cyan\]$_prompt_prefix\[$_color_reset\]'
PS1+='\[${_color_yellow}\]\u@\h\[$_color_reset\]'
PS1+=' \[${_color_blue}\]\w\[$_color_reset\]'
PS1+='\[$_color_red\]$_prompt_jobs\[$_color_reset\]'
if declare -pf __git_ps1 &>/dev/null; then
    PS1+='\[$_color_magenta\]$(__git_ps1)\[$_color_reset\]'
fi
PS1+='\n\[$_prompt_exit_color\]($_prompt_exit_status)\[$_color_reset\]'
PS1+=' \[$_color_white\]>\[$_color_reset\] '

