### Contents

- [Requirements](#requirements)
- [Setup](#setup)
- [API Docs](#api-docs)
- [Achievements](#achievements)
- [Improvements](#improvements)

## Requirements
- Ruby 2.5.0
- Rails 5.1.6
- PostgreSQL 9.6
 -Rspec-rails 3.5


## Setup

### Setting up the development environment

#### Clone and pull source code:
    ```bash
    git@github.com:bathien/api-challenge.git
    cd api-challenge
    git pull origin master
    ```

#### Prepare database.yml
    ```bash
    cp config/database.example.yml config/database.yml
    ```

Config database.yml with your database configuration in your development enviroment

#### Create and migrate database.yml
    ```bash
    bundle exec rake db:create
    bundle exec rake db:migrate
    ```
#### Re-generate secret key if needed
    ```bash
    bundle exec rake secret
    ```
####  Start the development server:
    ```bash
    bundle exec rails s
    ```

Done

### API Docs

#### Import CSV[Post /api/v1/tournaments/import]

+ Attributes
    + file (file, required) - required, csv file

+ Response 200 (application/json)

```
{
    "message": "Your CSV file has been succesfully imported"
}
```
+ Response 400 (application/json)

```
{
    "message": "Please import a CSV file"
}
```

#### Get matches by tournament name[GET /api/v1/tournaments/matches?{tournament_name}]

+ Attributes
    + tournament_name (required) - tournament_name, tournament's name

+ Response 200 (application/json)

```
{
    "items": [
        {
            "id": 34,
            "tournament_id": 2,
            "group_id": 9,
            "code": "A1-1-2",
            "date": "2017-02-16",
            "time": "21:00:00",
            "venue": "Legend"
        },
        {
            "id": 72,
            "tournament_id": 2,
            "group_id": 12,
            "code": "A4-3-5",
            "date": "2017-02-15",
            "time": "21:00:00",
            "venue": "Twins"
        },
        {
            "id": 73,
            "tournament_id": 2,
            "group_id": 12,
            "code": "A4-4-5",
            "date": "2017-02-14",
            "time": "20:00:00",
            "venue": "Twins"
        },
        {
            "id": 74,
            "tournament_id": 2,
            "group_id": 13,
            "code": "B1-1-2",
            "date": "2017-02-13",
            "time": "16:00:00",
            "venue": "Carmen"
        },
        {
            "id": 75,
            "tournament_id": 2,
            "group_id": 13,
            "code": "B1-1-3",
            "date": "2017-02-16",
            "time": "14:00:00",
            "venue": "Professional"
        },
        {
            "id": 76,
            "tournament_id": 2,
            "group_id": 13,
            "code": "B1-1-4",
            "date": "2017-02-16",
            "time": "19:00:00",
            "venue": "Legend"
        },
        {
            "id": 77,
            "tournament_id": 2,
            "group_id": 13,
            "code": "B1-1-5",
            "date": "2017-02-16",
            "time": "13:00:00",
            "venue": "Professional"
        },
        {
            "id": 78,
            "tournament_id": 2,
            "group_id": 13,
            "code": "B1-2-3",
            "date": "2017-02-16",
            "time": "15:00:00",
            "venue": "Professional"
        }
    ]
}
```
+ Response 400 (application/json)

```
{
    "message": "Your request params is wrong"
}
```

#### Get matches by player name[GET /api/v1/tournaments/matches?{player_name}]

+ Attributes
    + player_name (required) - required, player's name

+ Response 200 (application/json)

```
{
    "items": [
        {
            "id": 4,
            "tournament_id": 1,
            "group_id": 2,
            "code": "C2-1-2",
            "date": "2017-02-16",
            "time": "18:00:00",
            "venue": "Carmen"
        },
        {
            "id": 5,
            "tournament_id": 1,
            "group_id": 2,
            "code": "C2-1-3",
            "date": "2017-02-16",
            "time": "12:00:00",
            "venue": "Twins"
        },
        {
            "id": 36,
            "tournament_id": 2,
            "group_id": 9,
            "code": "A1-1-4",
            "date": "2017-02-12",
            "time": "14:00:00",
            "venue": "Carmen"
        },
        {
            "id": 39,
            "tournament_id": 2,
            "group_id": 9,
            "code": "A1-2-4",
            "date": "2017-02-14",
            "time": "14:00:00",
            "venue": "Carmen"
        },
        {
            "id": 41,
            "tournament_id": 2,
            "group_id": 9,
            "code": "A1-3-4",
            "date": "2017-02-12",
            "time": "13:00:00",
            "venue": "Carmen"
        },
        {
            "id": 43,
            "tournament_id": 2,
            "group_id": 9,
            "code": "A1-4-5",
            "date": "2017-02-12",
            "time": "16:00:00",
            "venue": "Carmen"
        }
    ]
}
```
+ Response 400 (application/json)

```
{
    "message": "Your request params is wrong"
}
```

#### Get result by player name[GET /api/v1/tournaments/statistical?{player_name}]

+ Attributes
    + player_name (required) - required, player's name

+ Response 200 (application/json)

```
    {
        "item": {
            "won_matches": 2,
            "lost_matches": 1,
            "drawn_matches": 3,
            "point": 9
        }
    }
```
+ Response 400 (application/json)

```
{
    "message": "Please check your request params"
}
```

+ Response 200 (application/json)

```
{
    "message": "No result found for player: Elon Musk1"
}
```

### Running tests with Postman
This is Rails API-only project so I use Postman to testing development source code based on the api docs above
Install Postman:
https://www.getpostman.com/

1.  Import CSV post request:
    ```bash
    http://localhost:3000/api/v1/tournaments/imports
    ```
1.  Query matches by player name:

    ```bash
    http://localhost:3000/api/v1/tournaments/matches?player_name=Elon%20Musk
    ```

1.  Query matches by tournament name:

    ```bash
    http://localhost:3000/api/v1/tournaments/matches?tournament_name=Tournament%209%20ball
    ```

    **Note:** The tournament name has been capitalized

1.  Query points and number of won matches, lost matches, drawn matches by player name:

    ```bash
    http://localhost:3000/api/v1/tournaments/statistical?player_name=Elon%20Musk
    ```


#### Unit testing code with Rspec


1.  Move project directory

1.  Initialize your test database:

    ```bash
    bundle exec rake test:prepare
    ```

    This needs to be rerun whenever you make changes to your database schema.

1.  To run unit tests, open another terminal and run:

    ```bash
    bundle exec rspec spec --format documentation
    ```

## Achievements

- Build DB structual
- Finish feature challenge
- Tested with Rspec
- Add rack-attack and rack-cors to protect api-server
- Using rubocop to check coding convention

## Improvements
I think it a challenge project but if it develop more i think DB structure will need to change like match with team, tournament yearly seasonly
- Source code is hard code in counting point
- Add more test case to rspec
- Add sidekiq to implement backgroud-job when import csv
- Decrease DB hit when import csv
- API authentication

