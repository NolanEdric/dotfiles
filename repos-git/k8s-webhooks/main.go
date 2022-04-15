package main

import (
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", HandleRoot)
	http.HandleFunc("/livez", HandleLivez)
	http.HandleFunc("/readyz", HandleReadyz)
	http.HandleFunc("/mutate", HandleMutate)
	log.Fatal(http.ListenAndServe(":80", nil))
}
