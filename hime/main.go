package main

import(
	"fmt"
	"net/http"
)

func login(w http.ResponseWriter,r *http.Request){
	fmt.Println("login not implemented error")
}

func register(w http.ResponseWriter,r *http.Request){
	fmt.Println("register is not implemented")
}

func main(){
	fmt.Println("server is up")
	http.HandleFunc("/login",login)
	http.HandleFunc("/reg",register)
	http.ListenAndServe(":8647",nil)
}