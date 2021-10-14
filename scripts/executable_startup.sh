#!/usr/bin/env zsh

startup_services=(
    # postgresql
    # ssh
    # nginx
    # fcgiwrap
    # mysql
    haproxy
)

running_services=$(sudo service --status-all 2>/dev/null | grep +)

# Read the array values with space
for val in "${startup_services[@]}"; do
    if ! grep -q $val <<< "$running_services"; then
        sudo service $val start > /dev/null
    fi
done
