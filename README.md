## Self destructing messages

### Ruby test task Spring 2019

a web application, which creates text self-destructing
messages.
A user opens the website and creates a message. The application generates a safe link to this saved message (such as: http://yourapp.com/message/ftr45e32fgv56d2 ).
The user should be able to choose a destruction option:
● destroy message after the first link visit
● destroy after 1 hour
All the messages stored on the server side should be encrypted using
The AES algorithm (you can use any library for text encryption).
Cover your application with the unit and integration tests using
rspec.

Language: Ruby

Web-framework: Sinatra.

Database development: Sqlite3

Database production: PostgreSQL

### To start app

1 Clone the "self_destructing_messages_sinatra" repository

2 Get your terminal window into "self_destructing_messages_sinatra" derictory

3 Bundle
```
$ Bundle install
```

4 Start
```
$ ruby app.rb
```

5 Open any browser and write URL
```
localhost:4567
```

Heroku Link: https://my-first-task.herokuapp.com/
