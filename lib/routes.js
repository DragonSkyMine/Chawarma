var express = require('express');
var router = express.Router();
var passport = require('./auth.js');
var dao = require('./DAO.js');

router
.get('/', function(req, res){
  res.redirect('/signin');
})
.get('/accueil', isAuthenticated, function(req, res) {
  if (req.user.isProf) {
    dao.getSondagesInfoByEnsId(req.user.ens_id, function(sondages) {
      render(req, res, 'accueil.ejs',{'user': req.user, 'sondages': sondages});
    });
  } else {
    dao.getSondagesInfoByEtuId(req.user.etu_id, function(sondages) {
      render(req, res, 'accueil.ejs',{'user': req.user, 'sondages': sondages});
    });
  }
})
.get('/signin', function(req, res){
  render(req, res, 'sigin.ejs');
})
.get('/signinprof', function(req, res){
  render(req, res, 'siginprof.ejs');
})
.post("/signin", passport.authenticate('local-etu', {
  successRedirect: '/accueil',
  failureRedirect: '/signin',
  failureFlash: true
}), function(req, res, info){
  render(req, res, 'sigin.ejs');
})
.post("/signinprof", passport.authenticate('local-ens', {
  successRedirect: '/accueil',
  failureRedirect: '/signinprof',
  failureFlash: true
}), function(req, res, info){
  render(req, res, 'siginprof.ejs');
})
.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
})
.get('/quiz/:quizznum', isEtudiant, function(req, res) {
  var numQuizz = req.params.quizznum;
  console.log(numQuizz);
  dao.getSondageInfoBySonId(numQuizz, function(data) {
    if (data == undefined) {
      res.redirect('/error');
    } else {
      data.id = numQuizz;
      render(req, res, 'quizz.ejs', {'user': req.user, 'sondage': data});
    }
  });
})
.get('/etat/:sondageId/:etat', isEnseignant, function(req, res){
  var sId = req.params.sondageId;
  var etat = req.params.etat;

  dao.changeState(sId, etat, function(req,res){
    
  });
  res.redirect('/accueil');
})
.get('/creerSondage', isEnseignant, function(req, res) {
  dao.getAllClasses(function(data) {
    var classes = data;
    render(req, res, 'creerSondage.ejs', {'classes': classes});
  });
})
.post('/creerSondage', isEnseignant, function(req, res) {
  var data = JSON.parse(req.body.sondageData);
  var sondage = data.sondage;
  sondage.ens_id = req.user.ens_id;
  dao.insertSondageFull(sondage, function(valid) {
    console.log("teststst");
    res.send(valid);
  });
})


// dernière route !!
.get('*', function(req, res){
  res.render('404.ejs',{'errorNum': '404'});
});


function render(req, res, page, params) {
  if (params === undefined) {
    params = {};
  }
  params.user = req.user;
  params.error = req.flash('error');
  res.render(page, params);
}

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
