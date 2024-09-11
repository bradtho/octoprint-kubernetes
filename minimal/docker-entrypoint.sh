#!/bin/sh
set -e

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- ./octoprint/bin/octoprint --basedir /octoprint/octoprint "$@"
fi

exec "$@"
