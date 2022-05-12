package main

import(
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"encoding/json"
	"errors"
)

var users = map[string]string{}

type User struct{
	Username string `json:"username"`
	PwHash string `json:"pwhash"`
}
func login(w http.ResponseWriter,r *http.Request){
	var u User
	err:=json.NewDecoder(r.Body).Decode(&u)
	if err!=nil{
		http.Error(w,err.Error(),http.StatusBadRequest)
		return
	}
	pw,exist:=users[u.Username]
	if(!exist){
		http.Error(w,errors.New("User Does Not Exist!").Error(),http.StatusBadRequest)
		return
	}else if(pw==u.PwHash){
		http.Error(w,errors.New("Login Success").Error(),http.StatusOK)
		return
	}else{
		http.Error(w,errors.New("Login Failed").Error(),http.StatusOK)
		return
	}
}

func register(w http.ResponseWriter,r *http.Request){
	var u User
	err:=json.NewDecoder(r.Body).Decode(&u)
	if err!=nil{
		http.Error(w,err.Error(),http.StatusBadRequest)
		return
	}
	_,exist:=users[u.Username]
	if(exist){
		http.Error(w,errors.New("Username Taken!").Error(),http.StatusOK)
		return
	}else{
		users[u.Username]=u.PwHash
		http.Error(w,errors.New("Account Creation Success").Error(),http.StatusOK)
		return
	}
}

func main(){
	fmt.Println("server is up")
	http.HandleFunc("/login",login)
	http.HandleFunc("/reg",register)
	http.ListenAndServe(":8647",nil)
}