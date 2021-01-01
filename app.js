var http = require('http'),
    path = require('path'),
    express = require('express'),
    fs = require('fs'),
    xmlParse = require('xslt-processor').xmlParse,
    xslProcess = require('xslt-processor').xsltProcess;

var router = express();
var server = http.createServer(router);

router.get('/', function(req, res) {

    res.writeHead(200, {'Content-Type': 'text/html'});

    var xml = fs.readFileSync('PerfumeStore.xml', 'utf8');
    var xsl = fs.readFileSync('PerfumeStore.xsl', 'utf8');

    var xml_parse = xmlParse(xml);
    var xsl_parse = xmlParse(xsl);

    var result = xsltProcess(xml_parse, xsl_parse);

    res.end(result.toString());

});

server.listen(process.env.PORT || 3000, process.env.IP || "0.0.0.0", function () {
    var addr = server.address();
    console.log("Server listening at", addr.address + ":" + addr.port);
});