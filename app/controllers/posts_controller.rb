class PostsController < ApplicationController
  before_action :require_sign_in, except: :show #all actions only execute if there's a signed in user, according to require_sign_in which is defined in ApplicationController
  before_action :load_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_mod, only: [:edit, :update]
  before_action :authorize_user, only: [:destroy]
  
  def show
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end
  
  def create
    #refactor the individual assignments below - replace with one mass assignment:
    # @post = Post.new
    # @post.title = params[:post][:title]
    # @post.body = params[:post][:body]
    # @post.topic = @topic
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    
    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
      flash[:notice] = "Post was saved successfully."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post.  Please try again."
      render :new
    end
  end
    
  def edit
  end
  
  def update
    # @post.title = params[:post][:title]
    # @post.body = params[:post][:body]
    @post.assign_attributes(post_params)
    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
      flash[:notice] = "Post was updated successfully."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again"
      render :edit
    end
  end
  
  def destroy
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
  
  private
  def load_post
     @post = Post.find(params[:id])
  end
  
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
  def authorize_user
    unless current_user == @post.user || current_user.admin?  #only allow the user to perform action on the post if they own it or are admin.
      flash[:alert] = "You must be an admin to do that."
    redirect_to [@post.topic, @post]
    end
  end
  
  def authorize_mod
    unless current_user == @post.user ||  ( current_user.admin? || current_user.moderator?) #only allow the user to perform action on the post if they own it or are admin/mod.
      flash[:alert] = "You must be an admin or mod to do that."
      redirect_to [@post.topic, @post]
    end
  end
end
