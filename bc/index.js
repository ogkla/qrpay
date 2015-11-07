/*jslint node: true, indent: 4, stupid: true, nomen: true */
"use strict";

var express = require('express'),
    http = require('http'),
    util = require('util'),
    server,
    app,
    money = require("./controller/money.js");

app = express();
app.set('port', process.env.PORT || 4080);

app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);


app.get('/test', function (req, res) {
	console.log("GET :: /test");
	res.send("yeah it works");
});
app.post('/v1/money/getfromuseracount', function (req, res) {
    console.log("POST:: /v1/money/getfromuseracount");
    money.getFromUserAcount(req, res);
});

app.post('/v1/money/puttohomelessacount', function (req, res) {
    console.log("POST:: /v1/money/puttohomelessacount");
    money.putToHomelessAcount(req, res);
});

app.post('/v1/money/createmappedcard', function (req, res) {
    console.log("POST:: /v1/money/createmappedcard");
    money.createCardMapping(req, res);
});

app.post('/v1/money/enquiremappedcard', function (req, res) {
    console.log("POST:: /v1/money/enquiremappedcard");
    money.enquireCardMapping(req, res);
});

app.post('/v1/money/createuser', function (req, res) {
    console.log("POST:: /v1/money/createuser");
    money.createUser(req, res);
});

app.post('/v1/money/getuserdetails', function (req, res) {
    console.log("POST:: /v1/money/getuserdetails");
    money.getUserDetails(req, res);
});

server = http.createServer(app);
server.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});

module.exports = server;
