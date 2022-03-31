.ONESHELL:
.SILENT:

export MINIKUBE_PROFILE=k8s-webhooks
export K8S_VERSION=1.21.11

create:
	minikube --kubernetes-version $(K8S_VERSION) start

start: create
	minikube tunnel &
	minikube dashboard &

delete:
	minikube delete
