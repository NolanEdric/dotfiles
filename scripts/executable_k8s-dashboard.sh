#! /usr/bin/env bash

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "no cluster name supplied!"

CLUSTER=$1

td:kc $1 apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml

td:kc $1 apply -f ~/repos/tidu-k8s/k8s-dashboard/dashboard-admin.yml

TOKEN=$(td:kc $1 -n kubernetes-dashboard describe secret $(td:kc $1 -n kubernetes-dashboard get secret | awk '/^admin-user-token-/{print $1}') | awk '$1=="token:"{print $2}')

echo -e "Token is:\n$TOKEN"

PORT=$(td:free-port)

echo -e "Dashboard:\nhttp://localhost:$PORT/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy"

# echo -e "URL: https://localhost:$PORT"
# td:kc $1 port-forward svc/kubernetes-dashboard -n kubernetes-dashboard $PORT:443

td:kc $1 proxy --port $PORT

