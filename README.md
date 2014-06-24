# About P-003

This website is created to verify that the visitor is **selected friend** of website's owner.

It will use Facebook to verify that the visitor is a friend of website's owner and visitor's name is already registered on database.

Sorry, no test unit implemented yet. I'll implement it later when I have learnt more about RSpec.

Here is list of library that I've used:

- figaro for all environment variables :
	- FACEBOOK\_APP\_ID
	- FACEBOOK\_APP\_SECRET
	- FACEBOOK\_OWNER\_ID (Facebook Owner's app specific user ID)
	- FACEBOOK\_OWNER\_LINK (Facebook Owner's user profile link to contact if user is not registered)
- koala for Facebook Open Graph API wrapper
- bower-rails
- bootstrap for CSS layout
- font-awesome (bower component)
- bootstrap-social for Facebook button (bower component)
- github-markup to show about page this readme document

Installation step by step :

- git clone ...
- bundle install
- input seeds.rb with list of your registered friend (_FacebookFriend.create(name: 'Werner Heisenberg')_)
- rake db:migrate
- rake db:seed
- rake bower:install
- rake bower:resolve
- rails g figaro:install
- input all required environment variables