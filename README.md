# API Challenge
### Requirement
 - User can upload a list of matches for a tournament. Sample CSV input named tournament 9 ball.csv and tournament 10 ball.csv are included in this repo.
 - Structure the data in a relational database.
 - Calculate points for each player. A player gets 3 points by winning, 0 point by losing and 1 point with a draw match. If a player gives up, the opponent gets 3 points.
 - User can query matches, filter by player name or tournament name.
 - User can query points and number of won matches, lost matches, drawn matches by player name.

### Tech
- Ruby version 2.5.1
- Rails version 5.2.1
- Gems: active_model_serializers, rspec-rails, database_cleaner, factory_bot_rails, oj

### **API descriptions**
#### 1. Import CSV:
- **Requirement:** User can upload a list of matches for a tournament. Sample CSV input named tournament 9 ball.csv and tournament 10 ball.csv are included in this repo.
- **Method:** POST
- **API:** /api/v1/csv/import
- **Params input:**
    ```ruby
    {csv: {file: <File mutilpart>}}
    ```
- **Output:**
    - Standard HTTP status code
    ```ruby
        {
            msg: <messages>,
            is_success: <true/false>,
            data: {}
        }
    ```

#### 2. Get matches list based on the player name or tournament name:
- **Requirement:** User can query matches, filter by player name or tournament name.
- **Method:** GET
- **API:** /api/v1/match/get_list
- **Params input:**
    ```ruby
    {search_string: <player name or tournament name>}
    ```
- **Output:**
    - Standard HTTP status code
    ```ruby
        {
            msg: <messages>,
            is_success: <true/false>,
            data: [
                {
                    "id": 33,
                    "group": "D4",
                    "match_code": "D4-2-3",
                    "player_1": "Joe Zadeh",
                    "player_2": "Chip Conley",
                    "score": "8-2",
                    "time": "2000-01-01T17:00:00.000Z",
                    "date": "2017-02-14",
                    "venue": "Carmen"
                }
            ]
        }
    ```
#### 3. Return the result all matches of player based on username:
- **Requirement:**
    - Calculate points for each player. A player gets 3 points by winning, 0 point by losing and 1 point with a draw match. If a player gives up, the opponent gets 3 points.
    - User can query points and number of won matches, lost matches, drawn matches by player name.
- **Method:** GET
- **API:** /api/v1/user/player_results
- **Params input:**
    ```ruby
    {username: <username>}
    ```
- **Output:**
    - Standard HTTP status code
    ```ruby
        {
            msg: <messages>,
            is_success: <true/false>,
            data: [
                points: 4,
                match_result: {
                    won: 1,
                    lost: 1,
                    drawn: 1
                }
            ]
        }
    ```
### **Deployment instructions**
```sh
$ git clonehttps://github.com/leanhthang/api-challenge.git
$ cd api-challenge
$ bundle install
$ rails db:setup
```
### **Test methods**
- **Postman**
    > rails server
- **Rspec test**


