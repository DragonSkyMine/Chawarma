var mysql = require('mysql');
var connection = mysql.createConnection({
  supportBigNumbers: true,
  bigNumberStrings: true,
  host     : "localhost",
  user     : "chawarma",
  password : "chawarma",
  database : "chawarma"
});
connection.connect(function(err) {
  if (err) {
    console.log(err);
  } else {
    console.log("connection réussie");
  }
});
module.exports = connection;
