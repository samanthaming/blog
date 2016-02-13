class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :destroy, :update]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :destroy, :update]
  # ******* Create

  def new
    @post = Post.new
  end

  def create

    @post = Post.new post_params
    @post.user = current_user

    if @post.save
      redirect_to post_path(@post), notice: "Post Created"
    else
      flash[:alert] = "Post failed to create"
      render :new
    end
  end

  # ******* Read

  def index
    @posts = Post.order("created_at DESC").page(params[:page])
  end

  def show
    # @post = Post.find params[:id]
    @comment = Comment.new
  end

  # ******* Update

  def edit
  end

  def update
    if @post.update post_params
      redirect_to post_path(@post), notice: "Post Updated"
    else
      flash[:alert] = "Post Failed to update"
      render :edit
    end
  end

  # ******* Destroy

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post Deleted"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize_user
    unless can? :manage, @post
      redirect_to root_path, alert: "Access Denied"
    end
  end




end
