/*jslint node: true, indent: 4, stupid: true, nomen: true */
"use strict";

var getFromUserAcount,
    putToHomelessAcount,
    transferServiceClass = require('../mastercard-api-node-master/services/moneysend/TransferService'),
    environment = require('../mastercard-api-node-master/common/Environment'),
    cardMappingServiceClass = require('../mastercard-api-node-master/services/moneysend/CardMappingService'),
    transferService,
    cardMapService,
    generatePrivateKeyForTest,
    fs = require("fs"),
    request = require("request"),
    testKey = "ERjubJ3eMUmKscVjjdnD5anAIhHqFN2Ye1irjL5a57092308!4772764a4e4c353033764d2b35575155704c654f56673d3d",
    keyPath,
    pathLib = require('path'),
    createCardMapping,
    enquireCardMapping;

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
                "4000000601010101011"
            ],
            "FundingCard": [
                {
                    "AccountNumber": [
                        5184680430000006
                    ],
                    "ExpiryMonth": [
                        "09"
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

    function transferServiceCallBack (result) {
        res.send(JSON.stringify(result));
    }

    transferService = new transferServiceClass.TransferService(testKey, generatePrivateKeyForTest(environment.sandbox), environment.sandbox, transferServiceCallBack);
    transferService.getTransfer(requestObj);
};

putToHomelessAcount = function () {

};

createCardMapping = function (req, res) {
    var requestObj;
    requestObj = {
        CreateMappingRequest: {
            SubscriberId: "varunmagnite_1@yandex.com",
            SubscriberType: "EMAIL_ADDRESS",
            AccountUsage:  "SEND_RECV",
            DefaultIndicator: "T",
            Alias: "varunmagnite1 Card",
            ICA: "009674",
            AccountNumber: 5184680430000006,
            ExpiryDate: "201909",
            CardholderFullName: {
                CardholderFirstName: "John",
                CardholderMiddleName: "Q",
                CardholderLastName: "Public"
            },
            Address: {
                Line1: "123 Main Street",
                Line2: "#5A",
                City: "OFallon",
                CountrySubdivision: "MO",
                PostalCode: "63368",
                Country: "USA"
            },
            DateOfBirth: "19460102"
        }
    };

    function cardMapServiceCallBack (result) {
        res.send(JSON.stringify(result));
    }

    cardMapService = new cardMappingServiceClass.CardMappingService(testKey, generatePrivateKeyForTest(environment.sandbox), environment.sandbox, cardMapServiceCallBack);
    cardMapService.getCreateMapping(requestObj);

};

enquireCardMapping = function (req, res) {
    var requestObj;
    requestObj = {
        InquireMappingRequest: {
            SubscriberId: "varunmagnite_1@yandex.com",
            SubscriberType: "EMAIL_ADDRESS",
            AccountUsage: "SEND_RECV",
            Alias: "varunmagnite1 Card",
            DataResponseFlag: "3"
        }
    };

    function cardMapServiceCallBack (result) {
        res.send(JSON.stringify(result));
    }

    cardMapService = new cardMappingServiceClass.CardMappingService(testKey, generatePrivateKeyForTest(environment.sandbox), environment.sandbox, cardMapServiceCallBack);
    cardMapService.getInquireMapping(requestObj);

};

module.exports = {
    getFromUserAcount: getFromUserAcount,
    putToHomelessAcount: putToHomelessAcount,
    createCardMapping: createCardMapping,
    enquireCardMapping: enquireCardMapping
};