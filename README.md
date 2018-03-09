Get Start:
-Config mysql server in config.js
-Create table in Sql 
	CREATE TABLE Matches (   ID int NOT NULL AUTO_INCREMENT,   GroupCode varchar(3) NOT NULL,   MatchCode varchar(10) NOT NULL,   Player1 varchar(50) NOT NULL,   Player2 varchar(50) NOT NULL,   Time time NOT NULL,   Date date NOT NULL,   Venue varchar(50) NOT NULL,   Score varchar(50) NOT NULL,   PRIMARY KEY (ID) );
-Npm install
-Npm start

Route:
 POST /upload: upload csv files and insert into database
 GET /info/player?name="Bill Gates": Query points and number of matches
 GET /info/matches?name="Bill Gates": Query match by player's name

Improvement:
	- Create Player table
	- Keep track of uploading csv files
	- Error handling