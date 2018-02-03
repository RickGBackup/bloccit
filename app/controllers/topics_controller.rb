class TopicsController < ApplicationController
  #require that actions other than index & show can only be performed by a signed in, authorized user - i.e. admin.
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]
  
  def index
    @topics = Topic.all
  end
  
  def show
    @topic = Topic.find(params[:id]) #params hash contains the ID,because it is passed via GET request to the controller.
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(topic_params)
    
    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "Error creating topic. Please try again"
      render :new
    end
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)
     
    if @topic.save
        flash[:notice] = "Topic was updated successfully."
       redirect_to @topic
    else
       flash.now[:alert] = "Error saving topic. Please try again."
       render :edit
    end
  end
  
  def destroy
     @topic = Topic.find(params[:id])
 
     if @topic.destroy
       flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
       redirect_to action: :index  #equivalent to redirect_to topics_path
     else
       flash.now[:alert] = "There was an error deleting the topic."
       render :show
     end
  end
  
  private
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end
  
  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to topics_path
    end
  end
end
