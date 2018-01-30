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
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
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
  
end
