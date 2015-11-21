/*jslint node: true, indent: 4, stupid: true, nomen: true */
"use strict";

var express = require('express'),
    http = require('http'),
    util = require('util'),
    server,
    app,
    watson = require('watson-developer-cloud'),
    watsonusername,
    watsonpassword;


watsonpassword = "GsJmQk9pLqm2";
watsonusername = "f0e28200-3d71-4a34-b167-a30fd3b05c9d";



app = express();
app.set('port', process.env.PORT || 4080);

app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);


app.get('/v1/test', function (req, res) {
    res.send("test successful");
});

app.post('/v1/languageprocessing', function (req, res) {
    var text = req.body.text;


    var relationship_extraction = watson.relationship_extraction({
        username: watsonusername,
        password: watsonpassword,
        version: 'v1'
    });

    relationship_extraction.extract({
            text: text,
            dataset: 'ie-en-news'
        },
        function (err, response) {
            var resObj, statusCode = 500;

            if (err) {
                console.log('error:', err);
                resObj = {
                    status: 500
                };
            } else {
                var entities = response.doc.entities.entity;
                resObj = {
                    status: 200,
                    data : {
                        person : [],
                        cardinal : [],
                        ordinal :[],
                        measure: []
                    }
                };
                entities.forEach(function (e) {
                    switch(e.type) {
                    case "PERSON":
                        resObj.data.person.push(e.mentref[0].text);
                        break;
                    case 'CARDINAL':
                        resObj.data.cardinal.push(e.mentref[0].text);
                        break;
                    case "ORDINAL":
                        resObj.data.ordinal.push(e.mentref[0].text);
                        break;
                    case 'MEASURE':
                        resObj.data.measure.push(e.mentref[0].text);
                        break;
                    }

                });
                statusCode = 200;
            }

            res.json(statusCode, resObj);
        }
    );
});


server = http.createServer(app);
server.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});

module.exports = server;
