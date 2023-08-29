const sqlite3 = require('sqlite3').verbose();
let dbPath = 'C:/ProgramData/inventory/ois.db';

var DBHelper = {

  executeCommand: function (sql, params, callback) {
    var stmtFailed = true;
    var message = "";
    let db = new sqlite3.Database(dbPath, sqlite3.OPEN_READWRITE, (err) => {
      if (err) {
        //console.error(err.message);
        callback({ Status: false, Message: err.message, lastId: 0 });
      }
    });
    db.serialize(function () {
      db.run("begin transaction");
      db.run(sql, params, function (err) {
        // if (err) {
        //   callback({ Status: false, Message:err.message, lastId: 0});
        // }
        if (err) {
          //callback({ Status: false, Message:err.message, lastId: 0});
          stmtFailed = false;
          message = err.message;
        }
      });

      // db.run("commit", function(err) {
      //   if (err) {
      //     callback({ Status: false, Message:err.message, lastId: 0});
      //   }
      //   else{
      //   callback({ Status: true, Message:'', lastId: this.lastID})
      //   }
      // });

      // db.close();

      if (stmtFailed) {
        db.run("commit", function (err) {
          if (err) {
            callback({ Status: false, Message: err.message, lastId: 0 });
          }
          else {
            callback({ Status: true, Message: 'Successfully saved Data', lastId: this.lastID })
          }
        });
      }
      else {
        db.run("rollback", function (err) {
          callback({ Status: false, Message: message, lastId: 0 });

        });
      }
      db.close();
    });
  },

  executeSelectCommand: function (sql, params, callback) {
    let db = new sqlite3.Database(dbPath, sqlite3.OPEN_READWRITE, (err) => {
      if (err) {
        //console.error(err.message);
        callback({ Status: false, Message: err.Message, Data: [] });
      }
    });
    db.all(sql, params, (err, rows) => {
      if (err) {
        //throw err;
        callback({ Status: false, Message: err.message, Data: [] });

      }
      else {
        callback({ Status: true, Message: '', Data: rows });
      }
      //fCallBack(rows);

    });
    db.close();
  },

  executeBatchCommand: function (sql, data, callback) {
    var isStmtFailed = false;
    var callBackSent = false;
    var rowCount = 0;
    var message = "";
    let db = new sqlite3.Database(dbPath, sqlite3.OPEN_READWRITE, (err) => {
      if (err) {
        callback({ Status: false, Message: err.message, lastId: 0 });
      }
    });
    db.serialize(function () {
      db.run("begin transaction");

      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          stmt = db.prepare(sql);
          var objData = data[i];

          stmt.run(objData, function (err) {
            var orgData = data[rowCount];
            rowCount++;
            if (err) {
              isStmtFailed = true;
              message = err.message;
            }
            if (isStmtFailed && !callBackSent) {
              callBackSent = true;
              db.run("rollback", function (error) {
                callback({ Status: false, Message: err.message, lastId: 0, ErrData: orgData });

              });
            }
            else {
              if (rowCount == data.length) {
                db.run("commit", function (err) {
                  if (err && !callBackSent) {
                    callback({ Status: false, Message: err.message, lastId: 0, data: orgData });
                  }
                  else if (!callBackSent) {
                    callback({ Status: true, Message: 'Successfully Uploaded Data', lastId: this.lastID });
                  }
                });
              }
            }
          });
          stmt.finalize();
        }
      }
      else {
        callback({ Status: false, Message: "Batch insert failed. Data is not found", lastId: 0, data: data });

      }
    });
  }
}

module["exports"] = DBHelper;