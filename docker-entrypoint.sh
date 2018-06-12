#!/bin/sh
set -e

isCommand() {
  for cmd in \
    "bootstrap" \
    "build" \
    "clean" \
    "console" \
    "dry-run" \
    "help" \
    "init" \
    "list" \
    "run" \
    "config:validate" \
    "generate:cept" \
    "generate:cest" \
    "generate:environment" \
    "generate:feature" \
    "generate:groupobject" \
    "generate:helper" \
    "generate:pageobject" \
    "generate:scenarios" \
    "generate:stepobject" \
    "generate:suite" \
    "generate:test" \
    "gherkin:snippets" \
    "gherkin:steps"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

if [ "${1:0:1}" = "-" ]; then
  set -- /sbin/tini -- php /vendor/bin/codecept "$@"
elif [ "$1" = "/vendor/bin/codecept" ]; then
  set -- /sbin/tini -- php "$@"
elif [ "$1" = "codecept" ]; then
  set -- /sbin/tini -- php /vendor/bin/"$@"
elif isCommand "$1"; then
  set -- /sbin/tini -- php /vendor/bin/codecept "$@"
fi

exec "$@"
