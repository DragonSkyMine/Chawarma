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
passport.use('local', new LocalStrategy({
  usernameField: 'etu_mail',
  passwordField: 'etu_mdp',
  passReqToCallback: true //passback entire req to call back
} , function (req, username, password, done){
  if(!username || !password ) { return done(null, false, {'message': 'All fields are required.'}); }
  var salt = '7fa73b47df808d36c5fe328546ddef8b9011b2c6';
  connection.query("select * from Etudiant where etu_mail = ?", [username], function(err, rows){
    if (err) {
      console.log(err);
    }
    if (err) return done({'message': err});
    if(!rows.length){ return done(null, false,{'message': 'Invalid username or password.'}); }
    salt = salt+''+password;
    var encPassword = crypto.createHash('sha1').update(salt).digest('hex');
    var dbPassword  = rows[0].etu_mdp;
    if(dbPassword != encPassword){
      return done(null, false, {'message':'Invalid username or password.'});
    }
    return done(null, rows[0]);
  });
}
));
passport.serializeUser(function(user, done){
    done(null, user.etu_id);
});
passport.deserializeUser(function(id, done){
    connection.query("select * from Etudiant where etu_id = "+ id, function (err, rows){
        if (err) {
          console.log(err);
        }
        done(err, rows[0]);
    });
});

app
.get('/', function(req, res){
  res.redirect('/signin');
})
.get('/accueil', isAuthenticated, function(req, res){
  res.render('accueil.ejs');
})
.get('/signin', function(req, res){
  res.render('index.ejs',{'loginError' :req.flash('error')});
})
.post("/signin", passport.authenticate('local', {
    successRedirect: '/accueil',
    failureRedirect: '/signin',
    failureFlash: true
}), function(req, res, info){
    res.render('index.ejs',{'loginError' :req.flash('error')});
})
.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
});

app.listen(8080);

function isAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  req.flash('error','You must be logged in to access this page');
  res.redirect('/signin');

}
