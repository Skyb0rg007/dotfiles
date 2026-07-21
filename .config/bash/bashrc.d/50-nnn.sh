# shellcheck shell=bash

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
