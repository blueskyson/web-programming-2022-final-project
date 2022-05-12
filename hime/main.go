package main

import(
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"io/ioutil"
)

func login(w http.ResponseWriter,r *http.Request){
	var bodyBytes []byte
	var err error
	if r.Body != nil {
		bodyBytes, err = ioutil.ReadAll(r.Body)
		if err != nil {
			fmt.Printf("Body reading error: %v", err)
			return
		}
		defer r.Body.Close()
	}

	if len(bodyBytes) > 0 {
		var prettyJSON bytes.Buffer
		if err = json.Indent(&prettyJSON, bodyBytes, "", "\t"); err != nil {
			fmt.Printf("JSON parse error: %v", err)
			return
		}
		fmt.Println(string(prettyJSON.Bytes()))
	} else {
		fmt.Printf("Body: No Body Supplied\n")
	}
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