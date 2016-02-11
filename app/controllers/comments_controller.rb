class CommentsController < ApplicationController


  def create
    @post = Post.find params[:post_id]
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.post = @post

    if @comment.save
      redirect_to post_path(@post), notice: "Comment created!"
    else
      render "/posts/show"
    end
  end


  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to post_path(params[:post_id]), notice: "Comment deleted!"
  end


  # before_action :find_comment, only: [:show, :edit, :update, :destroy]
  #
  # def new
  #   @comment = Comment.new
  # end
  #
  # def create
  #   @comment = Comment.create comment_params
  #
  #   if @comment.valid?
  #     redirect_to comment_path(@comment), notice: "Comment Created"
  #   else
  #     flash[:alert] = "Comment not created"
  #     render :new
  #   end
  # end
  #
  # def index
  #   @comments = Comment.order("id DESC")
  # end
  #
  # def show
  # end
  #
  # def edit
  # end
  #
  # def update
  #   if @comment.update comment_params
  #     redirect_to comment_path(@comment), notice: "Comment Updated"
  #   else
  #     flash[:alert] = "Comment not updated"
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @comment.destroy
  #   redirect_to comments_path, alert: "Comment deleted"
  # end
  #
  # private
  #
  # def comment_params
  #   params.require(:comment).permit(:body)
  # end
  #
  # def find_comment
  #   @comment = Comment.find params[:id]
  # end
end
