var express = require('express');
var router = express.Router();

const dest = require("../config.js").dest
const multer  = require('multer')
const csv = require('../utils/csv.js');
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, dest)
  },
  filename: function (req, file, cb) {
    cb(null, file.fieldname + '-' + Date.now())
  }
})
const upload = multer({storage}).array('tournaments')
const match = require('../models/match')
const player = require('../models/player')

router.post('/tournaments', function (req, res, next) {
	const mysql = req.app.get("mysql");
  upload(req, res, function (err) {
    if (err) {
      // An error occurred when uploading
      return
    }
    let listFile = req.files.map(k => csv(k.filename));
  	let listPlayer = new Set([]);
  	let queryPlayer = "SELECT id FROM player WHERE "
		Promise.all(listFile).then(result => {
			query = "INSERT INTO matches (GroupCode, MatchCode, Player1, Player2, Time, Date, Venue, score) VALUES "
			listValue = []
   		result.map(file => {
   			file.map(m => {
   				m.player1 = m["player 1"]
   				m.player2 = m["player 2"]
   				m.matchCode = m["match code"]
   				let newMatch =  new match(m)
   				query += "(?, ?, ? ,? ,? ,?, ?, ?),"
   				listValue = [...listValue, ...newMatch.addValue()]
   				listPlayer.add([m.player1,m.player2]);
   			})
   		})
   		
   		query = query.slice(0,-1)
   		mysql.query(query, listValue, ((err,result, fields) => {
   			if(err) {
   				next(err)
   			} else {
    			res.json(result)
   			}
   		}))
		})
  })
})

module.exports = router;
