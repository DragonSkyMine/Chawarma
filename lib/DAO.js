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

  queryParams(query, params, callback) {
    connection.query(query, params, function (err, rows){
      if (err) {
        console.log(err);
      }
      callback(rows);
    });
  }

  getAllClasses(callback) {
    this.query("select * from Classe order by cla_nom", callback);
  }

  reponseSondage(sonId, etuId, data, callback) {
    for (var p in data) {
      this.queryParams("insert into ReponseEtu(rep_id, etu_id) values (?, ?)", [p.split("_")[1], etuId], function(bool) {
        if (bool) {
          console.log("enregistré");
        }
      });
    }
    callback(true);
  }

  getSondageInfoBySonId(sonId, callback) {
    var self = this;
    var data = {};
    self.getQuestionsBySonId(sonId, function(rows) {
      var nbQuestions = rows.length;
      var counter = 0;
      data.questions = rows;
      for (var i = 0; i < rows.length; i++) {
        var question = rows[i];
        self.getReponsesByQueId(question.que_id, function(rows2) {
          question.reponses = rows2;
          counter++;
          if (counter == nbQuestions) {
            callback(data);
          }
        });
      }
    });
  }

  getSondagesInfoByEtuId(etuId, callback) {
    var self = this;
    var data = {};
    self.getSondagesByEtuId(etuId, function(rows) {
      var nbSondages = rows.length;
      var counter = 0;
      data.sondages = rows;
      for (var i = 0; i < rows.length; i++) {
        var sondage = rows[i];
        self.getSondageInfoBySonId(sondage.son_id, function(infos) {
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
    var self = this;
    var data = {};
    self.getSondagesByEnsId(ensId, function(rows) {
      var nbSondages = rows.length;
      var counter = 0;
      data.sondages = rows;
      for (var i = 0; i < rows.length; i++) {
        var sondage = rows[i];
        self.getSondageInfoBySonId(sondage.son_id, function(infos) {
          sondage.infos = infos;
          counter++;
          if (counter == nbSondages) {
            callback(data);
          }
        });
      }
    });
  }

  insertSondageFull(sondage, callback) {
    var self = this;
    self.insertSondage(sondage.son_refe, sondage.ens_id, sondage.cla_id, function(data) {
      var son_id = data.insertId;
      var questions = sondage.questions;
      var nbQuestions = questions.length;
      var counterQuestions = 0;
      for (var i = 0; i < questions.length; i++) {
        var question = questions[i];
        self.insertQuestionFull(son_id, question, function() {
          counterQuestions++;
          if (counterQuestions == nbQuestions) {
            callback(true);
          }
        });
      }
    });
  }

  insertQuestionFull(son_id, question, callback) {
    var self = this;
    var reponses = question.reponses;
    self.insertQuestion(son_id, question.que_question, function(data2) {
      var que_id = data2.insertId;
      var nbReponses = reponses.length;
      var counterReponses = 0;
      for (var j = 0; j < reponses.length; j++) {
        var reponse = reponses[j];
        self.insertReponse(que_id, reponse.rep_label, reponse.rep_vrai, function(data3) {
          counterReponses++;
          if (counterReponses == nbReponses) {
            callback();
          }
        });
      }
    });
  }

  getSondagesByEtuId(etuId, callback) {
    this.query("select son.* from Sondage son, Etudiant etu where son.cla_id = etu.cla_id and etu.etu_id = " + etuId + " and son_flag <> 'N' order by 1 desc", callback);
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

  insertSondage(son_refe, ens_id, cla_id, callback) {
    this.queryParams("insert into Sondage(son_refe, ens_id, cla_id) values (?, ?, ?)", [son_refe, ens_id, cla_id], callback);
  }

  insertQuestion(son_id, que_question, callback) {
    this.queryParams("insert into Question(son_id, que_question) values (?, ?)", [son_id, que_question], callback);
  }

  insertReponse(que_id, rep_label, rep_vrai, callback) {
    this.queryParams("insert into Reponse(que_id, rep_label, rep_vrai) values (?, ?, ?)", [que_id, rep_label, rep_vrai], callback);
  }

  changeState(sId, etat, callback){
    this.queryParams("UPDATE Sondage SET cla_flag = ? WHERE son_id = ?", [etat, sId], callback);
  }
}
var connection = require('./dbconn.js');
var dao = new DAO(connection);
module.exports = dao;
