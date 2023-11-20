package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/bytedance/sonic"
)

func HelloHandler(w http.ResponseWriter, r *http.Request) {
	base()
	fmt.Fprintf(w, "Hello World")
}

func main() {
	http.HandleFunc("/", HelloHandler)
	http.ListenAndServe(":8005", nil)
}

func base() {
	m := map[string]interface{}{
		"name": "z3",
		"age":  20,
	}

	// sonic序列化
	byt, err := sonic.Marshal(&m)
	if err != nil {
		log.Println(err)
	}
	fmt.Printf("json: %+v\n", string(byt))

	// sonic反序列化
	um := make(map[string]interface{})
	err = sonic.Unmarshal(byt, &um)
	if err != nil {
		log.Println(err)
	}
	fmt.Printf("unjson: %+v\n", um)
}
