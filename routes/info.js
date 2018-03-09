var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/player', function(req, res, next) {
	const mysql = req.app.get("mysql");
	let returnObj = {
		win: 0,
		loss: 0,
		draw: 0,
		totalScore: 0
	}
	if(!req.query.name) {
		next("No player Name")
	} else {
		mysql.query("SELECT score,Player1 FROM Matches WHERE Player1 = ? OR Player2 = ?",[req.query.name,req.query.name],(err, result) => {
 			if(err) {
 				next(err)
 			} else {
 				result.map(k => {
  				switch(matchResult(k.Player1, req.query.name, k.score)) {
  					case 0:{
  						returnObj.draw += 1;
  						returnObj.totalScore += 1;
  						break;
  					}
  					case 1: {
  						returnObj.loss +=1;
  						break;
  					}
  					case 3: {
  						returnObj.win +=1;
  						returnObj.totalScore += 3;
  						break;
  					}
  				}
 				})
 				res.json(returnObj)
 			}
		})
	}
});

router.get('/matches', (req,res,next) => {
	const mysql = req.app.get("mysql");
	mysql.query("SELECT * from matches WHERE Player1 = ? OR Player2 = ?",[req.query.name,req.query.name], (err, result) => {
		res.json(result);
	})
})

function matchResult(player1, playerName, score) {
	if(score.includes("gave up")) {
		score = score.trim().split(' ').slice(0,-2).join(" ");
		if (playerName == score) return 0
		return 3
	} else {
		score = eval(score);
		score = (player1 == playerName) ? score : -score;
		if(score >0) {
			return 3
		} else if (score == 0) {
			return 1
		}
		return 0
	}
}
module.exports = router;
