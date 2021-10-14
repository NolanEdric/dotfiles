#! /usr/bin/env bash

if (( "$#" < 1 )); then
    echo "require 1 arg: cluster name!"
    exit 1
else
    CLUSTER=$1
    kubectl --context=kind-$CLUSTER --kubeconfig=$HOME/.kube/$CLUSTER-config ${@:2}
fi