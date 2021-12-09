#!/usr/bin/env bash

git submodule deinit $1    
git rm $1
# Note: asubmodule (no trailing slash)
# or, if you want to leave it in your working tree
git rm --cached $1
rm -rf .git/modules/$1