#!/usr/bin/env bash

dir=/tmp/ssh-sockets

if [ -d "$dir" ]; then
    for socket in $dir/*; do
        echo Closing: $socket
        ssh -S $socket -O exit aio
    done
fi
