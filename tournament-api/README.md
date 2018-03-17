### Contents

- [Technology stack](#technology-stack)
- [Installation](#installation)
- [Achievements](#achievements)
- [Improvements](#improvements)

## Technology stack

- Ruby 2.3
- Ruby on Rails 5.0.1
- PostgreSQL 9.6
- RSpec 3.7

## Installation

### Requirements

Before you get started, the following needs to be installed:
  * **Ruby**. Version 2.3.1 is currently used and we don't guarantee everything works with other versions. If you need multiple versions of Ruby, [RVM](https://rvm.io//) or [rbenv](https://github.com/rbenv/rbenv) is recommended.
  * [**RubyGems**](http://rubygems.org/)
  * **Bundler**: `gem install bundler`
  * [**Git**](http://help.github.com/git-installation-redirect)
  * **A database**. PostgreSQL version 9.6.6 is currently used. You can download and install [PostgreSQL from here.](https://www.postgresql.org/download/)

### Setting up the development environment

1.  Get the code. Clone this git repository and check out the latest release:

    ```bash
    git clone git@github.com:khaile/api-challenge.git
    cd api-challenge/tournament-api
    git checkout latest
    ```

1.  Create a `database.yml` file by copying the example database configuration:

    ```bash
    cp config/database.example.yml config/database.yml
    ```

1.  Add your database configuration details to `config/database.yml`. You will probably only need to fill in the password for the database(s).

1.  Create a `config.yml` file by copying the example configuration file:

    ```bash
    cp config/secrets.example.yml config/secrets.yml
    ```

1.  Run `bundle exec rake secret` to get a secrect key and fill the secret_key_base in the `config/secrects.yml` file by this key.

1.  Create and initialize the database:

    ```bash
    bundle exec rake db:create
    ```

    ```bash
    bundle exec rake db:migrate
    ```

1.  Start the development server:

    ```bash
    bundle exec rails s
    ```


Congratulations! The app should now be up and running for development purposes. Open a browser and go to the server URL (e.g. http://localhost:3000).You should be now able to import the existing data by choose a CSV file (e.g. `tournament 10 ball.csv`) and click the **Import CSV** button.


### Running tests

#### Test on browser
Once imported the existing data into the database. You should be now able to test the API though. Here are some examples:
1.  Query matches by player name:

    ```bash
    http://localhost:3000/api/v1/matches?player=Elon%20Musk
    ```

1.  Query matches by tournament name:

    ```bash
    http://localhost:3000/api/v1/matches?tournament=Tournament%2010%20ball
    ```

    **Note:** The tournament name has been capitalized

1.  Query points and number of won matches, lost matches, drawn matches by player name:

    ```bash
    http://localhost:3000/api/v1/statistical?player=Elon%20Musk
    ```

To make sure our API work correctly, you can open the CSV file and filter for a properly value.

#### Unit tests

Also, [RSpec](http://rspec.info/) is currently used for unit tests.

1.  Navigate to the root directory of the project

1.  Initialize your test database:

    ```bash
    bundle exec rake test:prepare
    ```

    This needs to be rerun whenever you make changes to your database schema.

1.  To run unit tests, open another terminal and run:

    ```bash
    bundle exec rspec spec --format documentation
    ```

1. Or to only run test for a controller (e.g. tournaments_controller)
    ```bash
    bundle exec rspec spec/controllers/tournaments_controller_spec.rb --format documentation
    ```

1. Or only for API (e.g. api_spec)
    ```bash
    bundle exec rspec spec/requests/api_spec.rb --format documentation
    ```

## Achievements

When working on this project, I have a chance to solving some of the many-to-many relationships which make us have to deal with before going to code.

Also, Rspec is currently applied to create units test for the app that helps us to create lots of scenarios to make sure the app works correctly.

And the last one I proud of in this implementation is my coding styles. I have tried my best to write readable code that makes more sense for the reviewer or co-workers when working in a team.

## Improvements

I have thought that the import function needs to run in the background because when we import a huge file that will take a long time for the user to wait for a response. But it does not worth to implement at the moment because we are focusing on the correctness of the application. [Let me know](mailto:khaile.to@gmail.com) what do you think?