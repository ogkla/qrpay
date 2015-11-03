<h2>Command to generate keys.</h2>

openssl genrsa -out &lt;path&gt;/mastercard.test.com.key 2048 <br>
openssl req -new -sha256 -key &lt;path&gt;/mastercard.test.com.key -out &lt;path&gt;/mastercard.test.com.csr

<h2>Curl calls to create card mapping and enquiring about the mapping</h2>
curl -X POST -d {} "http://localhost:4080/v1/money/createmappedcard?type=org/sender/reciever" <br>
curl -X POST -d {} "http://localhost:4080/v1/money/enquiremappedcard?type=org/sender/reciever"

<h2>Curl calls to send and recieve money</h2>

curl -X POST -d '{"fromSubscriberId":"testsend_varun@yandex.com","fromSubscriberAlias":"testsend_varun Card","amount":"50","toSubscriberId":"testreceive_varun@yandex.com"}' --header "Content-Type: application/json" "http://localhost:4080/v1/money/getfromuseracount"

<br>
curl -X POST -d '{"toSubscriberId":"testreceive_varun@yandex.com","toSubscriberAlias":"testreceive Card","amount":"50"}' --header "Content-Type: application/json" "http://localhost:4080/v1/money/putToHomelessAcount" 
