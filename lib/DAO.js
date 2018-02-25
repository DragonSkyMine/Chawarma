class DAO {
  constructor(connection) {
    this.connection = connection;
  }

  query(query, callback) {
    connection.query(query, function (err, rows){
      if (err) {
        console.log(err);
      }
      callback(rows);
    });
  }

  getSondageInfoBySonId(sonId, callback) {
    var infos = {};
    dao.getQuestionsBySonId(sonId, function(rows) {
      infos.questions = rows;
      for (var i = 0; i < rows.length; i++) {
        var question = rows[i];
        dao.getReponsesByQueId(question.que_id, function(rows) {
          question.reponses = rows;
          console.log(question);
        });
      }
      //callback(infos);
    });
  }

  getSondagesByEnsId(ensId, callback) {
    this.query("select * from Sondage where ens_id = " + ensId, callback);
  }

  getQuestionsBySonId(sonId, callback) {
    this.query("select * from Question where son_id = " + sonId, callback);
  }

  getReponsesByQueId(queId, callback) {
    this.query("select * from Reponse where que_id = " + queId, callback);
  }
}
var connection = require('./dbconn.js');
var dao = new DAO(connection);
module.exports = dao;
