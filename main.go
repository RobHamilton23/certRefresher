package main

import (
	"crypto/tls"
	"crypto/x509"
	_ "embed"
	"fmt"
	"log"
	"net/http"
)

//go:embed root.der.crt
var root []byte

func main() {
	// Load the root cert used for verifying client certificates and add it to a cert pool
	rootCert, err := x509.ParseCertificate(root)
	if err != nil {
		log.Fatalf("Unable to parse root cert: %v", err.Error())
	}
	caCertPool := x509.NewCertPool()
	caCertPool.AddCert(rootCert)

	// Create an http.Server instance with a TLSConfig that requires client certs
	s := http.Server{
		Addr: ":8443",
		TLSConfig: &tls.Config{
			ClientAuth: tls.RequireAndVerifyClientCert,
			ClientCAs:  caCertPool.Clone(),
		},
	}

	// Register a hello world handler
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		for _, x := range r.TLS.PeerCertificates {
			fmt.Println(x.Subject)
		}
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("Hello world"))
	})

	// Start listening for requests
	err = s.ListenAndServeTLS("domain.crt", "domain.key")
	if err != nil {
		log.Fatal(err.Error())
	}
}
