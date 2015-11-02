/*jslint node: true, indent: 4, stupid: true, nomen: true */
"use strict";

var getFromUserAcount,
    putToHomelessAcount,
    transferServiceClass = require('../mastercard-api-node-master/services/moneysend/TransferService'),
    environment = require('../mastercard-api-node-master/common/Environment'),
    service,
    generatePrivateKeyForTest,
    fs = require("fs"),
    request = require("request"),
    testKey = "ERjubJ3eMUmKscVjjdnD5anAIhHqFN2Ye1irjL5a57092308!4772764a4e4c353033764d2b35575155704c654f56673d3d",
    keyPath,
    pathLib = require('path');

keyPath = pathLib.dirname(process.mainModule.filename) + "/keys/mastercard.test.com.key";

generatePrivateKeyForTest = function(env){
    var pem;
    if (env == environment.production) {
        pem = fs.readFileSync(keyPath);
    } else {
        pem = fs.readFileSync(keyPath);
    }
    return pem.toString('utf8')
};

service = new transferServiceClass.TransferService(testKey, generatePrivateKeyForTest(environment.sandbox), environment.sandbox);


getFromUserAcount = function (req, res) {
    var requestObj, transfer;
    requestObj = {
        "FundingRequest": {
            "LocalDate": [
                "1101"
            ],
            "LocalTime": [
                "161222"
            ],
            "TransactionReference": [
                "4000000401010101011"
            ],
            "FundingCard": [
                {
                    "AccountNumber": [
                        5198946623783177
                    ],
                    "ExpiryMonth": [
                        "11"
                    ],
                    "ExpiryYear": [
                        "2019"
                    ]
                }
            ],
            "FundingUCAF": [
                "MjBjaGFyYWN0ZXJqdW5rVUNBRjU=1111"
            ],
            "FundingMasterCardAssignedId": [
                "123456"
            ],
            "FundingAmount": [
                {
                    "Value": [
                        "10"
                    ],
                    "Currency": [
                        "840"
                    ]
                }
            ],
            "ReceiverName": [
                "JoseLopez"
            ],
            "ReceiverAddress": [
                {
                    "Line1": [
                        "PuebloStreet"
                    ],
                    "Line2": [
                        "POBOX12"
                    ],
                    "City": [
                        "ElPASO"
                    ],
                    "CountrySubdivision": [
                        "TX"
                    ],
                    "PostalCode": [
                        "79906"
                    ],
                    "Country": [
                        "USA"
                    ]
                }
            ],
            "ReceiverPhone": [
                "1800639426"
            ],
            "Channel": [
                "W"
            ],
            "UCAFSupport": [
                "true"
            ],
            "ICA": [
                "009674"
            ],
            "ProcessorId": [
                "9000000442"
            ],
            "RoutingAndTransitNumber": [
                "990442082"
            ],
            "CardAcceptor": [
                {
                    "Name": [
                        "MyLocalBank"
                    ],
                    "City": [
                        "SaintLouis"
                    ],
                    "State": [
                        "MO"
                    ],
                    "PostalCode": [
                        "63101"
                    ],
                    "Country": [
                        "USA"
                    ]
                }
            ],
            "TransactionDesc": [
                "A2A"
            ],
            "MerchantId": [
                "123456"
            ]
        }
    };
    console.log("########################################");
    console.log("");
    console.log("requestObj " + JSON.stringify(requestObj));
    console.log("");
    console.log("########################################");
    console.log("");
    service.getTransfer(requestObj);

//    //Channel -  Accepted values are W-Web/Internet, M-Mobile, B-Bank Branch, K-Unmanned Kiosk
//
//    builder = new xml2js.Builder();
//    bodyObjXML = builder.buildObject(bodyObjJSON);
//    reqObj = {
//        method: "POST",
//        uri: "https://sandbox.api.mastercard.com/moneysend/v2/transfer?Format=XML",
//        headers: {
//            'Authorization': 'OAuth oauth_body_hash="W/bXAJvyRgqMjppBfKIj3/UG4TE=",oauth_consumer_key="ERjubJ3eMUmKscVjjdnD5anAIhHqFN2Ye1irjL5a57092308!4772764a4e4c353033764d2b35575155704c654f56673d3d",oauth_nonce="kqjqHwzH",oauth_signature="OvW3JBu4A%2FKG8aB8fJ%2Fw%2Fz9WsY1kcaA2EK%2BSB6zOA9PWWfKsEmuetp3yZ7JSVb7y5GxrPWIRF6wzYct5D9yzgtZHJXP%2FpeSUJniOW0Cg7xZMRNCPFY7cwoR72OFbSC%2F%2FiHO1tmu6zF%2BmQB0yLwMJc437dPgw6ydzIUY9xqk8Me5jfjpzl0%2BNBuBgt8J2xMArE21ARiEo6SfjywXDFNEJ1rz2kHoh4ZdLUBDhBaXOitn4LrpvdRBX1SSFa1Bo08nLktnsJzavATCq8tIGaswVCBa2embbz9aoZ%2F6n7IHFBcYkwEgSW%2BexxhCfslk%2BeCWIyBRIggnvr%2FYs1CA65jiUXw%3D%3D",oauth_signature_method="RSA-SHA1",oauth_timestamp="1446420896",oauth_version="1.0"',
//            'User-Agent': 'MC API OAuth Framework v1.0-node',
//            'content-type' : 'application/xml;charset=UTF-8',
//            'content-length': bodyObjXML.length
//        },
//        'body': bodyObjXML,
//        'cert': fs.readFileSync('/Users/siddesh/projects/test/mastercard-api-node-master/common/SSLCerts/EnTrust/cacert.pem')
//    };
//
//    request(reqObj, function (error, response, body) {
//        try {
//            console.log("error " + error) ;
//            console.log("response " + response) ;
//            console.log("body " + body) ;
//
//        } catch (e) {
//            console.log("Exception");
//        }
//    });
};

putToHomelessAcount = function () {

};

module.exports = {
    getFromUserAcount: getFromUserAcount,
    putToHomelessAcount: putToHomelessAcount
};