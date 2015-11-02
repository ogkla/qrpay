Command to generate keys.

openssl genrsa -out ~/ssl/mastercard.test.com.key 2048
openssl req -new -sha256 -key ~/ssl/mastercard.test.com.key -out ~/ssl/mastercard.test.com.csr
