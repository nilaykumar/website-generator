#!/usr/bin/env bash
set -euo pipefail

# make sure a commit message is provided
if [ $# -eq 0 ]; then
    echo "No commit message provided, exiting..."
    exit 1
fi

# use metalsmith to build the static site
node build.js
cd nilaykumar.github.io
# commit new site to github
git add -A
git commit -m "$1"
git push origin master
cd - > /dev/null
