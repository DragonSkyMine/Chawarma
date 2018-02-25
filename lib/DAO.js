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

  getAllClasses(callback) {
    this.query("select * from Classe order by cla_nom", callback);
  }

  getSondageInfoBySonId(sonId, callback) {
    var data = {};
    dao.getQuestionsBySonId(sonId, function(rows) {
      var nbQuestions = rows.length;
      var counter = 0;
      data.questions = rows;
      for (var i = 0; i < rows.length; i++) {
        var question = rows[i];
        dao.getReponsesByQueId(question.que_id, function(rows) {
          question.reponses = rows;
          counter++;
          if (counter == nbQuestions) {
            callback(data);
          }
        });
      }
    });
  }

  getSondagesInfoByEtuId(etuId, callback) {
    var data = {};
    dao.getSondagesByEtuId(etuId, function(rows) {
      var nbSondages = rows.length;
      var counter = 0;
      data.sondages = rows;
      for (var i = 0; i < rows.length; i++) {
        var sondage = rows[i];
        dao.getSondageInfoBySonId(sondage.son_id, function(infos) {
          sondage.infos = infos;
          counter++;
          if (counter == nbSondages) {
            callback(data);
          }
        });
      }
    });
  }

  getSondagesInfoByEnsId(ensId, callback) {
    var data = {};
    dao.getSondagesByEnsId(ensId, function(rows) {
      var nbSondages = rows.length;
      var counter = 0;
      data.sondages = rows;
      for (var i = 0; i < rows.length; i++) {
        var sondage = rows[i];
        dao.getSondageInfoBySonId(sondage.son_id, function(infos) {
          sondage.infos = infos;
          counter++;
          if (counter == nbSondages) {
            callback(data);
          }
        });
      }
    });
  }

  getSondagesByEtuId(etuId, callback) {
    this.query("select son.* from Sondage son, Etudiant etu where son.cla_id = etu.cla_id and etu.etu_id = " + etuId + " order by 1 desc", callback);
  }

  getSondagesByEnsId(ensId, callback) {
    this.query("select * from Sondage where ens_id = " + ensId + " order by 1 desc", callback);
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
