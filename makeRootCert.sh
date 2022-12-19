export PASSPHRASE=pantheor

# Create private key for cert
openssl genrsa -des3 -passout pass:$PASSPHRASE -out root.key 2048

# Create signing request using the private key
openssl req -passin pass:$PASSPHRASE -key root.key -new -out root.csr -subj "/CN=root.pantheon.io"

# Create the cert
openssl x509 -passin pass:$PASSPHRASE -signkey root.key -in root.csr -req -days 365 -out root.crt -sha256

# Export the cert in der format used by go's http library
openssl x509 -passin pass:$PASSPHRASE -in root.crt -out root.der.crt -outform der
