#!/usr/bin/env bash
set -eu

[[ -x /etc/init.d/ssh ]] && /etc/init.d/ssh start
if [[ -x /etc/init.d/docker ]]
then
  tryContainerd() {
    rm -f /var/run/containerd/containerd.sock
    echo "START containerd"
    containerd &
  }

  tryDockerd() {
    rm -f /var/run/docker-ssd.pid /var/run/docker.sock
    echo "START dockerd"
    dockerd &
  }

  for i in {1..3}
  do
    if [[ $(ps auxf | grep container[d] | wc -l) != 0 ]]
    then
      break
    fi
    tryContainerd
    sleep 1.1
  done

  for i in {1..3}
  do
    if [[ $(ps auxf | grep docker[d] | wc -l) != 0 ]]
    then
      break
    fi
    tryDockerd
    sleep 1.1
  done
fi

# Run command with node if the first argument contains a "-" or is not a system command. The last
# part inside the "{}" is a workaround for the following bug in ash/dash:
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=874264
if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ] || { [ -f "${1}" ] && ! [ -x "${1}" ]; }; then
  set -- node "$@"
fi

exec "$@"
