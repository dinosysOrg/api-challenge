# General

* This website is built based on Ruby on Rails framework (Ruby 2.3.4p301 and Rails 5.1.5)
* Describe about soccer tournament purpose

## Prepare running website
Make sure you have installed Ruby and Postgresql
## Build website
1. Cloning source from https://github.com/nhoxtien2010/api-challenge.git
2. Install depended gems by run: bundle install
3. Config connect database on config/database.yml (some thing similar database.sample.yml)
4. Init database:
    1. Manual build:
        Run these commands by orders: rake db:create, rake db:migrate, rake db:seed
    2. Auto build:
        Run command: rake tournament:setup


If you want to import from simple sample CSV file run: rake db:import_from_csv

## Usages
| method | url                    | param                        | description                                                                                                                                                                                            |
|--------|------------------------|------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| post   | /import_csv            | upload_file                  | Import one tournament by upload CSV file, you can view sample: tournament 9 ball.csv ,tournament 10 ball.csv                                                                                           |
| GET    | /players/statistic     | player_name, tournament_name | Get statistic of 1 player (number of won matches, lost matches, drawn matches by player name, loose, total_points)                                                                                     |
| GET    | /tournaments/statistic | tournament_name              | Get statistic of all player                                                                                                                                                                            |
| GET    | /filter_matches        | player_name, tournament_name | query matches, filter by player name or tournament name. If you wan to query by player just send only player_name , query by only tournament just send only tournament_name, or query by both 2 params |

### A couple special things.
This app build on postgresql, all foreign key was indexed for performance purpose
Some column query more often (exp: name...) are indexed too
When we create a match record on table matches, database will auto insert to table match_records by trigger
This app was built in short time so maybe the performance is not good, we can optimize query be create one more table to save 
the statistic of each player. If we do that, we have a couple triggers to auto update this table when insert or update match. The performance will be increase because we just need query from the statistic table instead join and calculate from match_records. 






