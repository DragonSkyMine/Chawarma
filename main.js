var express = require('express');
var handlebars = require('handlebars');


var app = express();


app.get('/', function(req, res) {
    res.render('/layout/index.ejs');
});

app.listen(8080);