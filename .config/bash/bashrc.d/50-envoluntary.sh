# shellcheck shell=bash

if _envoluntary_path="$(command -v envoluntary)"; then
    # eval "$(envoluntary shell hook bash)"
    _envoluntary_hook() {
        local prev_status=$?
        local vars
        if [ -x "$_envoluntary_path" ]; then
            vars="$("$_envoluntary_path" shell export bash)"
            trap -- '' SIGINT
            eval "$vars"
            trap - SIGINT
        fi
        return $prev_status
    }
    if [[ ";${PROMPT_COMMAND[*]:-};" != *";_envoluntary_hook;"* ]]; then
        if [[ "$(declare -p PROMPT_COMMAND 2>&1)" == "declare -a"* ]]; then
            PROMPT_COMMAND=(_envoluntary_hook "${PROMPT_COMMAND[@]}")
        else
            # shellcheck disable=2128,2178
            PROMPT_COMMAND="_envoluntary_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
        fi
    fi
fi
