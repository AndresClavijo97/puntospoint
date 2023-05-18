# README

* Configure and start the server

``mv config/database.yml.example config/database.yml``

``rails db:create && rails db:migrate && rails db:seed``

``bundle exec whenever --update-crontab --set environment='development'``

``bin/dev``

* Ruby version
  3.2.0
* Rails version
  7.0.4

