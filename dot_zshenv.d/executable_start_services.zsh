#!/usr/bin/env zsh

file=~/scripts/enabled_services.txt

running_services=$(sudo service --status-all 2>/dev/null | grep +)

cat $file | while read svc
do
    if ! grep -q "  $svc$" <<< "$running_services"; then
        sudo service $svc start 1>/dev/null
    fi
done
