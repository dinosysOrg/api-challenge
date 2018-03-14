# API Challenge

## How to setup

You have to `docker` and `docker-compose` to setup. Please follow steps:

- Run `docker-compose`: `$ docker-compose up`
- Run seeders for test: `$ docker-compose exec api yarn seq db:seed:all` 
- Run all tests: `$ docker-compose exec api yarn test` 

## Thing to be proud of

I dockerized my app. It'll make my app easy to deploy or scale. Whenever you want to scale, just create a new docker container and use nginx to load balancer.

One more thing, when you upload csv file, I decided not to calculate the points at this time. Once you upload the large file, process is slow. So, I move it to the query of statistics. Just create statistics on the first request for it if it is not created