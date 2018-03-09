module.exports  = class Match{
	constructor(match){
		this.group = match.group
		this.matchCode = match.matchCode
		this.player1 = match.player1
		this.player2 = match.player2
		this.time = match.time
		this.venue = match.venue
		this.score = match.score


		this.date = getDate(match.date)
	}

	addValue() {
		return [this.group, this.matchCode, this.player1, this.player2, this.time, this. date, this.venue, this.score]
	}
} 

function getDate(date) {
	date = date.split("/")
	date = new Date(date[2], date[1] -1, date[0]).toISOString();
	let index = date.indexOf('T')
	date = date.slice(0, index);
	return date
}