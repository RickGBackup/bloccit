class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new
    #set user attributes according to attributes in params hash
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
  
    if @user.save
      flash[:notice] = "Welcome to Bloccit #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)  # the :visible_to scope is defined in the Post.rb model.
    @favorite_posts = get_favorite_posts(@user)
  end
  
  def confirm
    #as with create action, @user is set to User.new with attributes provided by params. 
    #Since this confirm action is an intermediate step between new and create.
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
  end
  
  private
  
  def get_favorite_posts(user)
    # grab posts with favorites that have same user ID as user
    posts = Post.all
    favorite_posts = posts.select{ |post| post.favorites.find_by_user_id(user.id) }
  end
end


