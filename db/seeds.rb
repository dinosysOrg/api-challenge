Venue.create(name: "American Express Community Stadium")
Venue.create(name: "Anfield")
Venue.create(name: "Ayresome Park")
Venue.create(name: "Bet365 Stadium")
Venue.create(name: "Boleyn Ground")
Venue.create(name: "The Dell")
Venue.create(name: "Emirates Stadium")
Venue.create(name: "Etihad Stadium")
Venue.create(name: "Filbert Street")
Venue.create(name: "Goodison Park")
Venue.create(name: "Stamford Bridge")
Venue.create(name: "Old Traffold")
Venue.create(name: "Villa Park")
Venue.create(name: "White Hart Lane")
Venue.create(name: "Wembpley")

Tournament.create(id: 1, name: "Premier League")
Tournament.create(id: 2, name: "La Liga")
Tournament.create(id: 3, name: "Seria A")
Tournament.create(id: 4, name: "Ligue 1")

Group.create(id: 1, tournament_id: 1, name: "Eng 2017-2018")
Group.create(id: 2, tournament_id: 1, name: "Eng 2018-2019")
Group.create(id: 3, tournament_id: 1, name: "Eng 2019-2020")
Group.create(id: 4, tournament_id: 2, name: "Esp 2017-2018")
Group.create(id: 5, tournament_id: 2, name: "Esp 2018-2019")
Group.create(id: 6, tournament_id: 2, name: "Esp 2019-2020")
Group.create(id: 7, tournament_id: 3, name: "Ita 2017-2018")
Group.create(id: 8, tournament_id: 3, name: "Ita 2018-2019")
Group.create(id: 9, tournament_id: 3, name: "Ita 2019-2020")
Group.create(id: 10, tournament_id: 4, name: "Fra 2017-2018")
Group.create(id: 11, tournament_id: 4, name: "Fra 2018-2019")
Group.create(id: 12, tournament_id: 4, name: "Fra 2019-2020")

Player.create(name: "Arsenal", group_id: 1)
Player.create(name: "Bournemouth", group_id: 1)
Player.create(name: "Brighton & Hove Albion", group_id: 1)
Player.create(name: "Burnley", group_id: 1)
Player.create(name: "Chelsea", group_id: 1)
Player.create(name: "Crystal Palace", group_id: 1)
Player.create(name: "Everton", group_id: 1)
Player.create(name: "Huddersfield Town", group_id: 1)
Player.create(name: "Leicester City", group_id: 1)
Player.create(name: "Liverpool", group_id: 1)
Player.create(name: "Manchester City", group_id: 1)
Player.create(name: "Manchester United", group_id: 1)
Player.create(name: "Newcastle United", group_id: 1)
Player.create(name: "Southampton", group_id: 1)
Player.create(name: "Stoke City", group_id: 1)
Player.create(name: "Swansea City	", group_id: 1)
Player.create(name: "Tottenham Hotspur", group_id: 1)
Player.create(name: "Watford", group_id: 1)
