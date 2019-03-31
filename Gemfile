source "http://rubygems.org"

gem 'rake'
gem 'sinatra'
gem "activerecord"
gem 'sinatra-activerecord'
gem "sinatra-contrib"
gem 'aes'

group :production do
  gem 'pg'
end

group :development, :test do
  gem "sqlite3", '~> 1.3.6'
  gem 'tux'
  gem 'rspec'
  gem 'capybara'
  gem 'timecop'
end