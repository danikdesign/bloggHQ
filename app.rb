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
  @posts = Post.order 'created_at DESC'
end

get '/' do
  erb :index
end

get '/new' do
  @post = Post.new

  erb :new
end

post '/new' do
  @post = Post.new params[:post]

  if @post.save
    erb :index
  else
    @error = @c.errors.full_messages.first
    erb :new
  end

end

get '/details/:id' do

  @details = Post.find params[:id]
  #@comments = @db.execute 'select * from Comments where post_id = ? order by id', [post_id]

  erb :details
end