#!/bin/bash
set -u

if [ "$GITHUB_EVENT_NAME" != "milestone" ]; then
  echo "::debug::The event name was '$GITHUB_EVENT_NAME'"
  exit 0
fi

event_type=$(jq --raw-output .action $GITHUB_EVENT_PATH)

if [ $event_type != "closed" ]; then
  echo "::debug::The event type was '$event_type'"
  exit 0
fi

milestone_name=$(jq --raw-output .milestone.title $GITHUB_EVENT_PATH)

# Splits the string in $GITHUB_REPOSITORY which takes
# the form "owner/repository" into two variables
# called $owner and $repository
IFS='/' read owner repository <<< "$GITHUB_REPOSITORY"

release_url=$(dotnet gitreleasemanager create \
--milestone $milestone_name \
--name $milestone_name \
--targetcommitish $GITHUB_SHA \
--token $GITHUB_TOKEN \
--owner $owner \
--repository $repository)

echo "::set-output name=release-url::https://example.com"

exit 0
