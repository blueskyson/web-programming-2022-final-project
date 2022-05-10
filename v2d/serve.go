package main

import (
	"log"
	"net/http"
)

func serve(w http.ResponseWriter, r *http.Request) {
	p := "." + r.URL.Path
	if p == "./" {
		p = "index.html"
	}
	http.ServeFile(w, r, p)
}

func main() {
	http.HandleFunc("/", serve)
	log.Fatal(http.ListenAndServe(":8090", nil))
}
