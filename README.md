# Certificate Refresher and mTLS in go

This repo is simply intended to refresh my memory of how to create
certs with openssl, and use those certs in a go service that requires
mTLS auth.

## How to use this repo
First, generate each certificate:
```bash
./makeRootCert.sh
```

```bash
./makeDomainCert.sh
```

```bash
./makeClientCert.sh
```

With the certificates created, start the service:
```bash
go run .
```

With the service running, use curl to initiate a request to the
service:
```
./makeRequest.sh
```

Upon the request arriving at the server, the common name from the
client cert will be printed on the server's standard output. The
server will then respond with a "Hello world" message.
