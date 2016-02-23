class CommentsController < ApplicationController
  # before_action :authorize_user, only: [:create, :update, :destory]
  authorize_resource
  # load_and_authorize_resource :only => [:destroy]

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Comment created!"
    else
      render "/posts/show"
    end
  end


  def destroy
    @comment = Comment.find params[:id]
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to post_path(params[:post_id]), notice: "Comment deleted!"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    unless can? :manage, @comment
      redirect_to root_path, alert: "Access Denied"
    end
  end

end
