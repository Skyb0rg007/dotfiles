# ~/.profile - initialize the shell environment
# This should mostly be limited to setting environment variables

# This configuration is now in
# ~/.config/environment.d/ and ~/.config/user-tmpfiles.d/

for dir in /run/current-system/sw /usr; do
    gen="$dir/lib/systemd/user-environment-generators/30-systemd-environment-d-generator"
    if [ -x "$gen" ]; then
        _systemd_environment_d_generator="$gen"
        # shellcheck disable=SC2016
        eval "$("$gen" | sed 's/^PATH=/PATH=$PATH:/; s/^/export /')"
        break
    fi
done
unset dir gen
