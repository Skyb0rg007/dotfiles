# shellcheck shell=bash

if command -v adb >/dev/null && [[ -v ANDROID_USER_HOME ]]; then
    alias adb='HOME="$ANDROID_USER_HOME" adb'
fi
