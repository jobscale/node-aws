#!/usr/bin/env bash
set -eu

[[ -x /etc/init.d/ssh ]] && /etc/init.d/ssh start
[[ -x /etc/init.d/docker ]] && /usr/sbin/dockerd &

# Run command with node if the first argument contains a "-" or is not a system command. The last
# part inside the "{}" is a workaround for the following bug in ash/dash:
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=874264
if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ] || { [ -f "${1}" ] && ! [ -x "${1}" ]; }; then
  set -- node "$@"
fi

exec "$@"
