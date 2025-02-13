#!/usr/bin/env sh
#MISE description="Check formatting with rustfmt"
#USAGE flag '--all' "Run on all files in the repository"
#USAGE flag '--fix' "Apply formatting changes automatically"

set -e

CMD="cargo fmt"
if [ ! -z $usage_all ]; then
    CMD="${CMD} --all"
else
    CMD="git diff --name-only HEAD | grep .rs | ${CMD}"
fi

if [ $usage_fix ]; then
    CMD="${CMD} -- --check"
fi

eval ${CMD}
