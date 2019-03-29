require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'aes'

set :database, "sqlite3:message.db"

  get '/' do
    erb :new
  end

  post "message/create" do

  end