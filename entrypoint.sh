#!/bin/bash
set -u

if [ "$GITHUB_EVENT_NAME" != "milestone" ]; then
  echo "::debug::The event name was '$GITHUB_EVENT_NAME'"
  exit 0
fi

echo "::set-output name=release-url::https://example.com"

exit 0
