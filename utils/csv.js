const path = require('path');
const fs = require('fs')
const csv = require('fast-csv')
const readFromCsv = (filename) => {
	return new Promise((resolve, reject) => {
		var stream = fs.createReadStream(__dirname + '/../uploads/' + filename);
		let returnArr = []
		let keyArr = []
		var csvStream = csv()
    .on("data", function(data){
  		if(isNaN(data[0]) && data[0] !== "") {
    		keyArr = data
    	}
    	if(!isNaN(data[0]) && data[0] !== "") {
    		let temp = {};
    		for(let i=0; i < keyArr.length ; i++) {
    			temp[keyArr[i]] = data[i]
    		}
    		returnArr.push(temp)
    	}
    })
    .on("end", function(result){
			resolve(returnArr)
    });
		stream.pipe(csvStream);
	})	
}
	


module.exports = readFromCsv
