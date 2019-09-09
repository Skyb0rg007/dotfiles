# ssoss .bashrc

# Source global definitions
[[ -f /etc/bashrc ]] && \
    source /etc/bashrc

# Shell completions/settings
[[ -f /home/ssoss/.config/bash/kerl_completion.bash ]] && \
    source /home/ssoss/.config/bash/kerl_completion.bash
[[ -f /home/ssoss/.config/bash/exercism_completion.bash ]] && \
    source /home/ssoss/.config/bash/exercism_completion.bash
[[ -f /home/ssoss/.config/bash/rebar3_completion.bash ]] && \
    source /home/ssoss/.config/bash/rebar3_completion.bash
[[ -f /home/ssoss/.config/bash/cabal_completion.bash ]] && \
    source /home/ssoss/.config/bash/cabal_completion.bash
command -v stack >/dev/null 2>&1 && \
    eval "$(stack --bash-completion-script stack)"

# Disable Ctrl+S
stty -ixon

# Go no further in uninteractive shells
[[ $- != *i* ]] && return

# User specific aliases and functions
alias ..="cd .."
alias ...="cd ../.."
alias bc="bc -l"
alias chx="chmod +x"
alias cls="clear"
alias cp="cp -i"
alias gv="gvim"
alias gvim="gvim 2>/dev/null"
alias hack="unimatrix -w -s 95"
alias info="info --vi-keys"
alias l="command ls --color=auto"
alias ln="ln -i"
alias ls="ls -A --color=auto"
alias luajitrl="rlwrap luajit -e \"dofile'/home/ssoss/.config/lua/setup.lua'\" -i"
alias mk='make -k -j "$(nproc)"'
alias mv="mv -i"
alias o="xdg-open"
alias :q="exit"
alias :e="vim"
alias restart="exec bash"
alias rm="rm -I"
alias scp="scp -p"
alias t="discrete true"
alias tuftsbash='ssh -t -Y $tuftscs bash'
alias tufts='ssh $tuftscs'
alias valg="valgrind --leak-check=full"
alias vim="vimx"
alias vimdiff="vimx -d"
alias xcopy="tee >(xsel --clipboard --input)"
alias xorw='echo $XDG_SESSION_TYPE'
alias xpaste="xsel --clipboard --output"
alias yank="yank-cli"

# alias fk=thefuck
eval "$(thefuck --alias fk)"

# ---- Shopt-ions ----
# histverify: makes sure history expansions require confirmation
# checkjobs: confirm exiting when background jobs are running
# autocd: listing a directory just cd's to it
# dirspell, cdspell: correct spellings of directories and filenames
# histreedit: if a history expansion fails, let me redo it
# shift_verbose: let me know if I shift n positional params by more than n
# extglob: use extended globs - regex equivalent for file globbing
shopt -s histverify checkjobs autocd dirspell cdspell \
    histreedit shift_verbose extglob

# ---- Set-tings ----
# ignoreeof: Ctrl+D doesn't exit terminal
# noclobber: 'cmd > file' fails when file exists, use 'cmd >| file' instead
# pipefail: allows 'cmd1 | cmd2' to fail if 'cmd1' fails
set -o ignoreeof -o noclobber -o pipefail

# Don't save these commands in history
HISTIGNORE="t:cls:clear"

# cd + ls
c () {
    cd "$@" || { echo "Error with command \"cd $*\""; return 1; }
    command ls --color=auto
}

# open nautilus in background
f () {
    if [[ -d $1 ]]; then
        nautilus "$1" >/dev/null 2>&1 &
    elif [[ ! $1 ]]; then
        nautilus . >/dev/null 2>&1 &
    else
        echo "\"$1\" is not a directory" >&2
    fi
} 

# Executes command(s) without showing up in history
discrete () {
    "$@"
    history -d $((HISTCMD-1))
}

# Print the signal corresponding to the recent fail
inspect () {
    local pipe=("${PIPESTATUS[@]}")
    for ((i=0; i < ${#pipe[@]}; i++)); do
        if (( ${pipe[$i]} > 128 )); then
            printf '%d: SIG%s\n' "${pipe[$i]}" "$(kill -l "${pipe[$i]}")"
        else
            printf '%d\n' "${pipe[$i]}"
        fi
    done
}

# ---- Prompt setup ----
# Handles showing return values
__prompt_err () {
    local __pipe=("${PIPESTATUS[@]}")
    for i in "${__pipe[@]}"; do
        if [[ $i != 0 ]]; then
            local pipestr="${__pipe[*]}"
            if [[ ${#pipestr} -gt ${#USER} ]]; then
                pipestr="${pipestr:0:${#USER}-1}>"
            fi
            printf '%-*.*s' "${#USER}" "${#USER}" "$pipestr"
            return
        fi
    done
}
# Shows username if no errors
__prompt_user () {
    local __pipe=("${PIPESTATUS[@]}")
    for i in "${__pipe[@]}"; do
        if [[ $i != 0 ]]; then
            return
        fi
    done
    printf '%s' "$USER"
}
_dir_chomp () {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != "${p//\/}" ]]&&((s>$2))
    do
        p=${p#/}
        [[ $p =~ \.?. ]]
        b=$b/${BASH_REMATCH[0]}
        p=${p#*/}
        ((s=${#b}+${#p}))
    done
    local fin="${b/\/~/\~}${b+/}$p"
    if (( ${#fin} > $2 )); then
        fin="..${fin:${#fin}-$2}"
    fi
    echo "$fin"
}
# Make sure to surround ansi color codes with \[ and \]
PS1=$'[\[\e[31m\]$(__prompt_err)\[\e[0m\]$(__prompt_user) $(_dir_chomp "$PWD" 20)]\$ '
# Show 3 directories above current in prompt
PROMPT_DIRTRIM=2

# Make all terminals share the same history
sync () {
    PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"
}

# Easy editing of vim/bash configs
edit () {
    case "${1,,}" in
        "vim")
            vim ~/.config/vim/vimrc/vimrc
            return
            ;;
        "bash")
            vim /home/ssoss/.bashrc
            . /home/ssoss/.bashrc
            return
            ;;
        "profile")
            vim /home/ssoss/.profile
            . /home/ssoss/.profile
            ;;
        "tmux")
            vim /home/ssoss/.tmux.conf
            return
            ;;
        *)
            echo "Please type 'vim', 'bash', 'tmux', 'profile'"
            return
            ;;
    esac
}
complete -W 'vim bash tmux profile' edit

# Easier to go to ~/Documents/Programming/
program () {
    local language="${1^}"
    [[ $language = "CS" ]] && language=15
    local directory="/home/ssoss/Documents/Programming"
    local cdspell; cdspell=$(shopt -p cdspell)
    shopt -s cdspell
    cd "$directory/${language}" || \
        cd "$directory/School/${language}" || \
        echo "Directory \"${language}\" does not exist in Programming/ or School/"
    eval "$cdspell"
}
_program_complete () {
    local langs; langs="$(ls ~/Documents/Programming/) CS" 
    readarray -t COMPREPLY < <( \
        compgen -W "$langs" -- "${COMP_WORDS[$COMP_CWORD]^}")
}
complete -F _program_complete program

# Usually you go into a new directory when you make it
mkcd () {
    mkdir "$1" || { echo "Could not make directory '$1'" >&2; return 1; }
    cd "$1"    || { echo "Could not cd to '$1'" >&2; return 1; }
}

# Searching history is common
hs () {
    history | ag "$1"
}

# For running GUI applications with root privileges
xsudo () {
    xhost +SI:localuser:root
    sudo "$@"
    xhost -SI:localuser:root
    xhost
}

# ---- Tufts Commands ----
# shellcheck disable=SC2034
tuftscs="ssoss01@homework.cs.tufts.edu" # Simple shortcut

