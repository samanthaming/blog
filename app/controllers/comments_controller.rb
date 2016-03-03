class CommentsController < ApplicationController
  # before_action :authorize_user, only: [:create, :update, :destory]
  authorize_resource except: [:index]
  # load_and_authorize_resource :only => [:destroy]

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html {redirect_to post_path(@post), notice: "Comment created!"}
        format.js { render :create_success }
      else
        format.html {render "/posts/show"}
        format.js { render :create_failure }
      end
    end
  end

  def index
    @post = Post.find params[:post_id]
    render json: @post.comments
  end

  def destroy
    @comment = Comment.find params[:id]
    authorize! :destroy, @comment
    @comment.destroy

    respond_to do |format|
      format.html {redirect_to post_path(params[:post_id]), notice: "Comment deleted!"}
      format.js { render } # this renders /views/comments/destroy.js.erb
    end
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
