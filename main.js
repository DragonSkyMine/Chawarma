var express = require('express');
var flash = require('connect-flash');
var crypto = require('crypto');
var bodyParser = require("body-parser");
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
var connection = require('./lib/dbconn.js');
var sess = require('express-session');
var Store = require('express-session').Store;
var BetterMemoryStore = require('session-memory-store')(sess);
var store = new BetterMemoryStore({ expires: 60 * 60 * 1000, debug: true });
var app = express();

var routes = require('./routes.js');

app.use(express.static("public"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(sess({
  name: 'JSESSION',
  secret: 'MYSECRETISVERYSECRET',
  store:  store,
  resave: true,
  saveUninitialized: true
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());



app.use('/', routes);

app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});


if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


app.listen(8080);
