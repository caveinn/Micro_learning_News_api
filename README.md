[![Build Status](https://travis-ci.org/caveinn/Micro_learning_News_api.svg?branch=develop)](https://travis-ci.org/caveinn/Micro_learning_News_api)  
# Micro_learning_News_api
  This is a responsive web application written in ruby and sinatra that
  allows a user to choose areas of interest and get access to information
  regarding those areas on a daily basis. The information is provided by 
  [NewsApi](https://newsapi.org/)  

**Installation**
 
- clone this repo `git clone https://github.com/caveinn/Micro_learning_News_api.git`
- cd into the Micro_Learning-New_api directory with `cd Micro_learning_News_api`
- install the dependencies with `bundle`
- Run `rake db:create` to create the relevant databases
- Run `rake db:migrate` to perform migrations and create the relevant tables
- Run `rake db:seed` to populate the db with categories
- start server by running `bundle exec rackup`

**Running tests**

- make migrations to the test_db by running `rake db:migrate RACK_ENV="test"`
- run the tests by running `rspec`

**Installed gems**
 - sinatra - A DSL for easy development of web apps in ruby
 - pg - a gem that allows ruby to interact with the postgreSQL engine 
 - activerecord - an ORM that helps interuct with SQL using the familiar ruby objects
 - sinatra-activerecord - An extension of sinatra that allows the use of active-records ORM
 - shotgun - a version of rackup that allows hot reloadimg
 - bcrypt - a gem that allows for encryption of passwords
 - news-api - a gem that offers a simple way to interuct with the News API 
