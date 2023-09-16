package main

import (
	"fmt"
	"net/http"
	"os"
	"os/exec"
)

var wallet = os.Getenv("KRAANA_WALLET")

func drip(w http.ResponseWriter, r *http.Request) {
	cmd := exec.Command("uptime")

	// Capture the output
	output, err := cmd.CombinedOutput()
	if err != nil {
		http.Error(w, "Failed to execute command: "+err.Error(), http.StatusInternalServerError)
		return
	}

	// Write the output to the response
	w.Write(output)
}

func main() {
	if wallet == "" {
		panic("KRAANA_WALLET missing")
	}

	http.HandleFunc("/drip", drip)
	fmt.Println("Server started on :8080")
	http.ListenAndServe(":8080", nil)
}
