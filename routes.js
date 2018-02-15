var express = require('express');
var router = express.Router();
var passport = require('./auth.js');

router
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

function isAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  req.flash('error','You must be logged in to access this page');
  res.redirect('/signin');

}

module.exports = router;
