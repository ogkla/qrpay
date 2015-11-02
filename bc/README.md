<h2>Command to generate keys.</h2>

openssl genrsa -out ~/ssl/mastercard.test.com.key 2048 <br>
openssl req -new -sha256 -key ~/ssl/mastercard.test.com.key -out ~/ssl/mastercard.test.com.csr
