#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "blogg.db"}

class Post < ActiveRecord::Base
  validates :author, presence: true
  validates :content, presence: true
end

class Comment < ActiveRecord::Base
  validates :author, presence: true
  validates :content, presence: true
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
    @error = @post.errors.full_messages.first
    erb :new
  end

end

get '/details/:post_id' do
  @comment = Comment.new
  @details = Post.find params[:post_id]
  @comments = Comment.where post_id: params[:post_id]
  erb :details
end

post '/details/:post_id' do

  post_id = params[:post_id]
  @comment = Comment.new params[:comment]
  @comment.post_id = params[:post_id]

  if @comment.save
    redirect to('/details/' + post_id)
  else
    @error = @comment.errors.full_messages.first
    @details = Post.find params[:post_id]
    @comments = Comment.where post_id: params[:post_id]

    erb :details
  end

end