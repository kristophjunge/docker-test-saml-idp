# Certificates instructions for x509 authentication

## How to generate CA for the docker container
```bash
openssl genrsa -aes256 -out ca.key 2048
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt
```
Move `ca.*` generated files to `config/apache/ca` folder and rebuild the image.

## How to generate Certificate for user

```bash
openssl genrsa -aes256 -out client-test.key 2048
openssl req -new -key client-test.key -out client-test.csr
openssl x509 -req -in client-test.csr -out client-test.crt -sha1 -CA config/apache/ca/ca.crt -CAkey config/apache/ca/ca.key -CAcreateserial -days 3650
openssl pkcs12 -export -in client-test.crt -inkey client-test.key -out client-test.p12 -name "client certificate"
```

The `client-test.p12` it's the final certificate to give to the client to authenticate.