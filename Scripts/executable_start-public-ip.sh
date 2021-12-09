#!/usr/bin/env bash

nPort=${1:-10}

dir=/tmp/ssh-sockets

mkdir -p $dir

for (( port=2000; port<2000+$nPort; port++ ))
do
echo Opening port: $port
ssh -M -S "$dir/ip-$port" -fNT -R $port:localhost:$port win
done