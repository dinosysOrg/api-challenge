# API Challenge

We kindly ask you to spend no more than a few hours on this exercise, as we value your time and are happy to leave things open to discussion in the final round of interview.

Please use whatever programming language and framework you feel the most comfortable with.

Feel free to email us if you have any questions.

## Project description

We are building a football tournament management system for our client. Our client has been managing their data in CSV files. We need to provide a system for them to upload their existing data.

### What your API must do:

Features:

- User can upload a list of matches for a tournament. Sample CSV input named `tournament 9 ball.csv` and `tournament 10 ball.csv` are included in this repo.
- Structure the data in a relational database.
- Calculate points for each player. A player gets 3 points by winning, 0 point by losing and 1 point with a draw match. If a player gives up, the opponent gets 3 points.
- User can query matches, filter by player name or tournament name.
- User can query points and number of won matches, lost matches, drawn matches by player name.
- The actual API endpoint names and request & response format are up to you.

Your application should be easy to set up, and should not require any non open-source software.

### Documentation:

  #### How to run application

  Step 1: Checkout source code and make sure you installed `ruby`, `rails` and `postgresql`

  Step 2: Run

     ```
      rails db:create
      rails db:migrate
      rails server
     ```

 Step 3: We have 2 API:

  1. API import json data to database
   - URL PATH: http://localhost:3000/api/v1/expenses
   - HTTP Verb: POST
   - Example by `curl` send POST request to API:

    ```
    curl -vX POST http://localhost:3000/api/v1/expenses -d @expenses.json --header "Content-Type: application/json"
     #note: expenses.json: path to your json file
    ```
  2. API calculator expenses amount by categories
    - URL PATH: http://localhost:3000/api/v1/calc_expenses
    - HTTP Verb: GET
    - Parameter require: category_name, year, month
    - Example by `curl` send GET request to API:

    ```
      curl http://localhost:3000/api/v1/calc_expenses?category_name=travel&year=2013&month=10
    ```
  #### How to verify the correctness of application
  Please input smail json file and calculate manual.

  I provided 2 API others
  - API calculate tax by category:  http://localhost:3000/api/v1/calc_tax
  - API calculate pre tax by category: http://localhost:3000/api/v1/calc_pre_tax

  You can use that to check expenses.
  - Example by `curl`:

  ```
  curl http://localhost:3000/api/v1/calc_tax?category_name=travel&year=2013&month=10
  curl http://localhost:3000/api/v1/calc_pre_tax?category_name=travel&year=2013&month=10
  ```

  #### One point particularly proud
  The first time I implement API


### Submission Instructions

1. Fork this project on GitHub. You will need to create an account if you don't already have one.
1. Complete the project as described below within your fork.
1. Push all of your changes to your fork on github and submit a pull request.
1. Please also send an email to let us know that you have submitted a solution. Make sure to include your github username in your email (so we can match applicants with pull requests.)

Alternatively, if you don't want to submit your assignment publicly, you can email a patch file to us.

### Evaluation

Evaluation of your submission will be based on the following criteria:

1. Did you follow the instructions for submission?
1. Did you document your build/deploy instructions and your explanation of what you did well?
1. Does your API work correctly?
1. Was your code easy to understand to the reviewer?
1. What design decisions did you make when designing your models/entities? Why (i.e. were they explained?)
1. Was your app tested?
