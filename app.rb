require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'aes'

set :database, "sqlite3:message.db"

class Message < ActiveRecord::Base

end

get '/' do
  @messages = Message.all
  erb :new
end

post '/message/create' do
  message = Message.new(text: params['text'], urlsafe: SecureRandom.urlsafe_base64)
  if params['destruction_option'] == 'link_visit'
    message.visits_remaining = 1
  end
  message.save
  redirect to("/message/#{message.urlsafe}")
end

get '/message/:urlsafe' do
  @message = Message.where(urlsafe: params['urlsafe']).last
  erb :show
end