# API Challenge

## Project Description

We need an internal system for our employees to report their business expenses. This will also be used by our accountants for monthly accounting.

### How to run the application:

- Merge this branch into master
- Install need gems:
  - `bundle install`
- Run migrations to create the databases:
  - modify database.yml config corresponding to current pc
  - `bundle exec rake db:create`
  - `bundle exec rake db:migrate`
- The endpoints (need to start web server before these actions)
  - API Endpoint for submitting specific json file: 
    `curl -X POST -H "Content-Type: application/json" -d @expenses.json http://localhost:3000/api/v1/expenses/import`
  - URL to check the total expense by categories: 
    http://localhost:3000/api/v1/expenses/total_expense_by_category

### How to verify the correctness of this application.
run rspec 
  `bundle exec rspec spec/controllers/api/v1/expenses_controller_spec.rb`

### What I am particularly proud of in your implementation
 - Implemented the endpoint that meet the basic requirement, because it's the target of this, of course.
 - Implemented the rspec file for Expense Controller, because I think that, testing is one of the important parts to any application.
 - My implementation is easy to check (for reviewer).
