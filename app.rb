#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "blogg.db"}

class Post < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
end

before do
  @results = Post.order 'created_at DESC'
end

get '/' do
  erb :index
end

get '/posts' do
  erb :index
end
get '/new' do
  erb :index
end