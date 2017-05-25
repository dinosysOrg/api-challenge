
## Project Description

We need an internal system for our employees to report their business expenses. This will also be used by our accountants for monthly accounting.

### What your API must do:

- Allow submitting expenses in batch. A sample JSON input named `expenses.json` is included in this repo.
- Store the expenses in a relational database.
- Allow querying total expenses amount by categories.

### Documentation:

- Instructions on how to build/run your application.
After checkout source code and make sure you have run 'bunlde install' and then 
'rake db:migrate'
'rails s'

- API Provide:
1. API to import data
URL : 		http://localhost:3000/api/v1/expenses/import_data
HTTP Verb: 	POST
Example using curl to post reuqest:
curl -vX POST http://localhost:3000/api/v1/expenses/import_data -d @../expenses.json --header "Content-Type: application/json"
2. API to calculate expenses by categories
URL : 		http://localhost:3000/api/v1/expenses/expenses_by_category
HTTP Verb: 	GET
Parameter: category
Example: http://localhost:3000/api/v1/expenses/expenses_by_category?category=Computer%20-%20Software

- About implementation:
This is the first time I implement API using Ruby Rails. I need time to practice more and more to familiar with ruby syntax. 
