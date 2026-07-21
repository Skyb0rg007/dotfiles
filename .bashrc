# shellcheck shell=bash

# Only run in interactive shells
[[ $- == *i* ]] || return

# Split Bash configuration à-la UAPI.6
# Will end up loading ~/.config/bash/bashrc and ~/.config/bash/bashrc.d/*.sh
_uapi6_source() {
    local d f dropin
    local -A dropins
    local -a dirs=("$@") sorted_dropins

    for d in "${dirs[@]}"; do
        if [[ -f "$d/bash/bashrc" ]]; then
            # shellcheck source=.config/bash/bashrc
            source "$d/bash/bashrc"
            break
        fi
    done

    for d in "${dirs[@]}"; do
        [[ -d "$d/bash/bashrc.d" ]] || continue
        for f in "$d/bash/bashrc.d/"*.sh; do
            [[ -f "$f" || -h "$f" ]] || continue
            dropin="${f##*/}"
            [[ -v dropins[$dropin] ]] || dropins[$dropin]="$f"
        done
    done

    [[ ${#dropins[@]} -gt 0 ]] || return

    mapfile -d '' -t sorted_dropins < <(
        printf '%s\0' "${!dropins[@]}" | LC_ALL=C sort --zero-terminated)

    for dropin in "${sorted_dropins[@]}"; do
        f="${dropins[$dropin]}"
        [[ -s "$f" ]] || continue
        # shellcheck disable=1090
        source "$f"
    done
}

_uapi6_source \
    "${XDG_CONFIG_HOME:-$HOME/.config}" \
    ${XDG_RUNTIME_DIR:+"$XDG_RUNTIME_DIR"}
# /etc /run /usr/local/lib /usr/lib

