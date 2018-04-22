### Contents

- [Requirements](#requirements)
- [Setup](#setup)
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

####  Start the development server:

    ```bash
    bundle exec rails s
    ```

Done

### API Docs

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
    http://localhost:3000/api/v1/tournaments/matches?tournament_name=Tournament%2010%20ball
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

When working on this project, I have a chance to solving some of the many-to-many relationships which make us have to deal with before going to code.

Also, Rspec is currently applied to create units test for the app that helps us to create lots of scenarios to make sure the app works correctly.

And the last one I proud of in this implementation is my coding styles. I have tried my best to write readable code that makes more sense for the reviewer or co-workers when working in a team.

## Improvements

I have thought that the import function needs to run in the background because when we import a huge file that will take a long time for the user to wait for a response. But it does not worth to implement at the moment because we are focusing on the correctness of the application. [Let me know](mailto:khaile.to@gmail.com) what do you think?
