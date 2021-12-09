#!/usr/bin/env bash

dir=${1:-.}

find $dir -type d ! -path "*.git*" -empty -exec touch '{}'/.gitkeep \;