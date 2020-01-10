#!/bin/bash
set -u

if [ "$GITHUB_EVENT_NAME" != "milestone" ]; then
  echo "::debug::The event name was '$GITHUB_EVENT_NAME'"
  exit 0
fi

event_type=$(jq .action $GITHUB_EVENT_PATH)

if [ $event_type != "closed" ]; then
  echo "::debug::The event type was '$event_type'"
  exit 0
fi

echo "::set-output name=release-url::https://example.com"

exit 0
