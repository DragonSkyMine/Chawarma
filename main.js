var express = require('express');
var app = express();

app
.get('/', function (req, res) {
  res.render('index.ejs');
})
.get('/accueil', function (req, res) {
  res.render('accueil.ejs');
})
.use(function(req, res) {
  res.setHeader('Content-type', 'text/html; charset=utf-8');
  res.status(404).send("404");
});

app.listen(8080);
