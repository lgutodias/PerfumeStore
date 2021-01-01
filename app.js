var http = require('http'),
    path = require('path'),
    express = require('express'),
    fs = require('fs'),
    xmlParse = require('xslt-processor').xmlParse,
    xslProcess = require('xslt-processor').xsltProcess;

    var router = express();
    var server = http.createServer(router);
