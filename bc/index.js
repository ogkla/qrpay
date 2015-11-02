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


app.post('/v1/money/getfromuseracount', function (req, res) {
    money.getFromUserAcount(req, res);
});

app.post('/v1/money/puttohomelessacount', function (req, res) {
    money.putToHomelessAcount(req, res);
});


server = http.createServer(app);
server.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});

module.exports = server;