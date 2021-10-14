#!/usr/bin/env bash

env_filename=${1:-environment}
conda env export --no-builds | grep -v "^prefix: " > "$env_filename.yml"
