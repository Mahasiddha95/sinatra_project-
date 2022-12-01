Music library database app

GitHub top language
  Sinatra    Rspec  Rspec

This is a Makers' exercise from week 4 Web applications. In this module I learned to:

Explain how HTTP requests and responses work at a high level
Write integration tests for a web application
Implement web routes using a lightweight web framework (Sinatra)
Follow a debugging process for a web application
TechBit

Technologies used:

Ruby(3.0.0)
RVM
Sinatra(2.2)
Rspec(Testing)
Rack-test (2.0)
Simplecov(Test Coverage)
Clone the repository and run bundle install to install the dependencies within the folder:

git clone https://github.com/Mahasiddha95/music_library_database_app.git

cd music-library-database-app
bundle install
To run the tests:

createdb music_library_test
rspec
To run the app and see individudal routes:

createdb music_library
psql -h 127.0.0.1 music_library < spec/seeds/music_library.sql
rackup

Go to http://localhost:9292/:route to explore the routes.



