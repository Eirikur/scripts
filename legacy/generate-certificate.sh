#!/bin/bash
set -x # echo commands
openssl genrsa -aes256 -passout pass:INSECURE -out server.pass.key 2048
openssl rsa -passin pass:INSECURE -in server.pass.key -out server.key

rm server.pass.key

openssl req -new -key server.key -out server.csr
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
