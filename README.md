# iCourse

## What's iCourse

iCourse is a course selection system for all NCCU students. iCourse tries to improve UI & UX and also reduces the inconvenience between the selecting action.   


## Environment

* Ruby version : 2.4.2

* Rails version : 5.1.6


## Getting Started

1. Set Database Parameter in config/database.yml and secret key in config/secrets.yml:

Example of database.yml:
```yml
development:
  <<: *default
  adapter: <YOUR ADAPTER>
  encoding: utf8mb4
  host: <YOUR HOST>
  database: <YOUR SCHEMA>
  username: <YOUR USERNAME>
  password: <YOUR PASSWORD>
```

2. Install dependent package:
```console
$ bundle install
```

3. Run the server:
```console
$ rails server
```
