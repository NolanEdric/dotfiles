#!/bin/bash


BASE=${1:-9000}
INCREMENT=${2:-1}

port=$BASE
isfree=$(sudo netstat -tapln | grep $port)

while [[ -n "$isfree" ]]; do
  port=$[port+INCREMENT]
  isfree=$(sudo netstat -tapln | grep $port)
done

echo "$port"
exit 0