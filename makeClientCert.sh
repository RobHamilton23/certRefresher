 export PASSPHRASE=pantheor

 openssl req -passout pass:$PASSPHRASE -newkey rsa:2048 -keyout client.key -out client.csr -nodes -subj "/CN=client.pantheon.io"



openssl x509 -passin pass:$PASSPHRASE -req -CA root.crt -CAkey ./root.key -in client.csr -out client.crt -days 365 -CAcreateserial -sha256
