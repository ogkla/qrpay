<h2>Command to generate keys.</h2>

openssl genrsa -out &lt;path&gt;/mastercard.test.com.key 2048 <br>
openssl req -new -sha256 -key &lt;path&gt;/mastercard.test.com.key -out &lt;path&gt;/mastercard.test.com.csr
