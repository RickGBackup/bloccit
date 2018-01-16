class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each { |post| post.censor_spam }
  end

  def show
  end

  def new
  end

  def edit
  end
end
