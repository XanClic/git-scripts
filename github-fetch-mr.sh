#!/bin/bash

set -e

mr=$1
remote="${2:-origin}"

if [[ ! $mr =~ ^[0-9]+$ || $3 != "" ]]; then
    echo "Usage: $0 <MR ID> [remote]" >&2
    exit 1
fi

if [ -n "$2" ]; then
    infix="$2-"
else
    infix=""
fi

max_ver=$(git branch --list "mr-$infix$mr-v*" | sort | tail -n 1 | sed -e "s/^\*\? *mr-$infix$mr-v//")
branch="mr-$infix$mr-v$((max_ver + 1))"
cmd="git fetch $remote pull/$mr/head:$branch"

echo "\$ $cmd"
$cmd

git checkout $branch
