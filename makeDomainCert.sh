export PASSPHRASE=pantheor

# Make private key and signing request for cert
openssl req -passout pass:$PASSPHRASE -newkey rsa:2048 -keyout domain.key -out domain.csr -nodes -subj "/CN=domain.pantheon.io"

# Create cert
openssl x509 -passin pass:$PASSPHRASE -req -CA root.crt -CAkey root.key -in domain.csr -out domain.crt -days 365 -CAcreateserial -sha256
