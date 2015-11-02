<h2>Command to generate keys.</h2>

openssl genrsa -out <path>/mastercard.test.com.key 2048 <br>
openssl req -new -sha256 -key <path>/mastercard.test.com.key -out <path>/mastercard.test.com.csr
