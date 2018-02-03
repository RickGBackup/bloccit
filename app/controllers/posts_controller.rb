class PostsController < ApplicationController
  before_action :require_sign_in, except: :show #all actions only execute if there's a signed in user, according to require_sign_in which is defined in ApplicationController
  before_action :authorize_user, except: [:show, :new, :create]
  
  def show
    @post = Post.find(params[:id])
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
      flash[:notice] = "Post was saved successfully."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post.  Please try again."
      render :new
    end
  end
    
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    # @post.title = params[:post][:title]
    # @post.body = params[:post][:body]
    @post.assign_attributes(post_params)
    if @post.save
      flash[:notice] = "Post was updated successfully."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again"
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
  def authorize_user
    post = Post.find(params[:id])
    
    unless current_user == post.user || current_user.admin?  #only allow the user to perform action on the post if they own it or are admin.
    flash[:alert] = "You must be an admin to do that."
    redirect_to [post.topic, post]
    end
  end
end
