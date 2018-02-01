var express = require('express');
var handlebars = require('handlebars');
var fs = require('fs');

function loadHtml(page, data) {
  fs.readFile(page+'.html', function(err, source) {
    var template = Handlebars.compile(source);
    var result = template(data);
    return result;
  });
}

var app = express();

app.get('/', function(req, res) {
  res.render('/layout/index.ejs');
});

app.listen(8080);
