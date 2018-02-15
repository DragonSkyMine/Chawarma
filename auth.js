var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
var connection = require('./lib/dbconn.js');
var crypto = require('crypto');

passport.serializeUser(function(user, done){
  done(null, user.per_id);
});
passport.deserializeUser(function(id, done){
  connection.query("select * from Personne where per_id = "+ id, function (err, rows){
    if (err) {
      console.log(err);
    }
    done(err, rows[0]);
  });
});

passport.use('local-etu', new LocalStrategy({
  usernameField: 'per_mail',
  passwordField: 'per_mdp',
  passReqToCallback: true //passback entire req to call back
} , function (req, username, password, done){
  if(!username || !password ) { return done(null, false, {'message': 'All fields are required.'}); }
  var salt = '7fa73b47df808d36c5fe328546ddef8b9011b2c6';
  connection.query("select * from v_etudiant where per_mail = ?", [username], function(err, rows){
    if (err) {
      console.log(err);
    }
    if (err) return done({'message': err});
    if(!rows.length){ return done(null, false,{'message': 'Invalid username or password.'}); }
    salt = salt+''+password;
    var encPassword = crypto.createHash('sha1').update(salt).digest('hex');
    var dbPassword  = rows[0].per_mdp;
    if(dbPassword != encPassword){
      return done(null, false, {'message':'Invalid username or password.'});
    }
    return done(null, rows[0]);
  });
}
));

passport.use('local-ens', new LocalStrategy({
  usernameField: 'per_mail',
  passwordField: 'per_mdp',
  passReqToCallback: true //passback entire req to call back
} , function (req, username, password, done){
  if(!username || !password ) { return done(null, false, {'message': 'All fields are required.'}); }
  var salt = '7fa73b47df808d36c5fe328546ddef8b9011b2c6';
  connection.query("select * from v_enseignant where per_mail = ?", [username], function(err, rows){
    if (err) {
      console.log(err);
    }
    if (err) return done({'message': err});
    if(!rows.length){ return done(null, false,{'message': 'Invalid username or password.'}); }
    salt = salt+''+password;
    var encPassword = crypto.createHash('sha1').update(salt).digest('hex');
    var dbPassword  = rows[0].per_mdp;
    if(dbPassword != encPassword){
      return done(null, false, {'message':'Adresse email ou Mot de passe incorrect.'}); 
    }
    return done(null, rows[0]);
  });
}
));

module.exports = passport;
