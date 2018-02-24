class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :load_commentable_and_path
  before_action :authorize_user, only: [:destroy]
  
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @new_comment  = @commentable.comments.new
    
    if @comment.save
      flash[:notice] = "Comment saved successfully."
    else
      flash[:alert] = "Comment failed to save."
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def destroy
    @comment = @commentable.comments.find(params[:id])
    
    if @comment.destroy
      flash[:notice] = "Commented was deleted successfully."
    else 
      flash[:alert] = "Comment couldn't be deleted."
    end
    
    respond_to do |format|
      format.html
      format.js 
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to @commentable_path
    end
  end
  
  def load_commentable_and_path
    if params[:post_id]
      @commentable = Post.find(params[:post_id])
      @commentable_path = [@commentable.topic, @commentable]
    elsif params[:topic_id]
      @commentable = Topic.find(params[:topic_id])
      @commentable_path = @commentable
    end
  end
end
