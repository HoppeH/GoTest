package main

import (
	"fmt"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello from the 1235!")
}

func main() {
	http.HandleFunc("/", handler)
	log.Println("listening on 5555")
	log.Fatal(http.ListenAndServe(":5000", nil))
} 