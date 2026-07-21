# shellcheck shell=bash

# Only run in interactive shells
[[ $- == *i* ]] || return

# Split Bash configuration à-la UAPI.6
# Will end up loading ~/.config/bash/bashrc and ~/.config/bash/bashrc.d/*.sh

# _uapi6_load_sourced_files prefix suffix dirs...
_uapi6_load_sourced_files() {
    local d f dropin prefix="$1" suffix="$2"
    shift 2
    local -A dropins
    local -a dirs=("$@") sorted_dropins

    for d in "${dirs[@]}"; do
        if [[ -f "$d/$prefix" ]]; then
            _uapi6_sourced_files+=("$d/$prefix")
            break
        fi
    done

    for d in "${dirs[@]}"; do
        [[ -d "$d/$prefix.d" ]] || continue
        for f in "$d/$prefix.d/"*"$suffix"; do
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
        _uapi6_sourced_files+=("$f")
    done
}

declare -a _uapi6_sourced_files=()
declare -a _uapi6_directories=(
    "${XDG_CONFIG_HOME:-$HOME/.config}"
    ${XDG_RUNTIME_DIR:+"$XDG_RUNTIME_DIR"}
    /etc
    /run
    /usr/local/lib
    /usr/lib)

_uapi6_load_sourced_files bash/bashrc sh "${_uapi6_directories[@]}"

# Perform the sourcing at toplevel to avoid scoping issues
for _uapi6_src in "${_uapi6_sourced_files[@]}"; do
    # shellcheck disable=1090
    source "$_uapi6_src"
done

unset _uapi6_src
