#!/bin/bash

set -e

mr=$1
remote="${2:-origin}"

if [[ ! $mr =~ ^[0-9]+$ || $3 != "" ]]; then
    echo "Usage: $0 <MR ID> [remote]" >&2
    exit 1
fi

max_ver=$(git branch --list "mr-$mr-v*" | grep "mr-$mr-v[0-9]\\+$" | sort | tail -n 1 | sed -e "s/^\*\? *mr-$mr-v//")
branch="mr-$mr-v$((max_ver + 1))"
cmd="git fetch $remote merge-requests/$mr/head:$branch"

echo "\$ $cmd"
$cmd

git checkout $branch
