require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'aes'
require 'message'

set :database, "sqlite3:message.db"

get '/' do
  @messages = Message.all
  erb :new
end

post '/message/create' do
  message = Message.new(text: params['text'], urlsafe: SecureRandom.urlsafe_base64)
  if params['destruction_option'] == 'link_visit'
    message.visits_remaining = 1 + 1
  else
    Thread.new do
      sleep 1.hour
      message.delete
    end
  end
  message.save
  redirect to("/message/#{message.urlsafe}")
end

get '/message/:urlsafe' do
  @message = Message.where(urlsafe: params['urlsafe']).last
  if @message.nil?
    redirect to('/')
  else
    if @message.destroyed_via_link_visits?
      @message.visits_remaining -= 1
      @message.save
      if @message.visits_remaining == 0
        @message.delete
      end
    end
  end
  erb :show
end