var express = require('express');
var router = express.Router();
var passport = require('./auth.js');
var dao = require('./DAO.js');

router
.get('/', function(req, res){
  res.redirect('/signin');
})
.get('/accueil', isAuthenticated, function(req, res) {
  var sondages;
  if (req.user.isProf) {

  } else {
    dao.getSondagesInfoByEtuId(req.user.etu_id, function(data) {
      console.log(data);
      sondages = data;
    });
  }
  res.render('accueil.ejs',{'user': req.user, 'sondages': sondages});
})
.get('/signin', function(req, res){
  res.render('sigin.ejs',{'loginError' :req.flash('error')});
})
.get('/signinprof', function(req, res){
  res.render('siginprof.ejs',{'loginError' :req.flash('error')});
})
.post("/signin", passport.authenticate('local-etu', {
  successRedirect: '/accueil',
  failureRedirect: '/signin',
  failureFlash: true
}), function(req, res, info){
  res.render('sigin.ejs',{'loginError' :req.flash('error')});
})
.post("/signinprof", passport.authenticate('local-ens', {
  successRedirect: '/accueil',
  failureRedirect: '/signinprof',
  failureFlash: true
}), function(req, res, info){
  res.render('siginprof.ejs',{'loginError' :req.flash('error')});
})
.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
})
.get('/quizz/:quizznum', function(req, res) {
  var numQuizz = req.params.quizznum;
  res.render('quizz.ejs', {'quizz': numQuizz});
})


// dernière route !!
.get('*', function(req, res){
  res.render('404.ejs',{'error': '404'});
});

function isAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  req.flash('error','You must be logged in to access this page');
  res.redirect('/signin');

}

function isEnseignant(req, res, next) {
  if (req.isAuthenticated() && req.user.isProf) {
    return next();
  }
  req.flash('error','You must be a teacher to access this page');
  res.redirect('/accueil');

}

function isEtudiant(req, res, next) {
  if (req.isAuthenticated() && !req.user.isProf) {
    return next();
  }
  req.flash('error','You must be a student to access this page');
  res.redirect('/accueil');

}

module.exports = router;
