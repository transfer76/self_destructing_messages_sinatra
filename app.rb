require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'aes'
require_relative 'lib/message'

#set :database, 'sqlite3:message.db'

#class App < Sinatra::Base

  get '/' do
    @messages = Message.all
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/message/create' do
    message = Message.new(urlsafe: SecureRandom.urlsafe_base64)
    message.encryption_key = AES.key
    message.text = AES.encrypt(params['text'], message.encryption_key)
    if params['destruction_option'] == 'link_visits'
      message.visits_remaining = params['destruction_option_value'].to_i
    else
      Thread.new do
        sleep params['destruction_option_value'].to_i
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
    elsif @message.destroyed_via_link_visits? && @message.visits_remaining.zero?
      @message.visits_remaining -= 1
      @message.save
    end

    erb :show
  end
#end
