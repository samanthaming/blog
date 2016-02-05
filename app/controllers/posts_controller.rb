class PostsController < ApplicationController

  # ******* Create

  def new
    @post = Post.new
  end

  def create
    post_params = params.require(:post).permit(:title,:body)
    @post = Post.new post_params

    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  # ******* Read

  def index
    @posts = Post.order("created_at DESC")
  end

  def show
    @post = Post.find params[:id]
  end

  # ******* Update

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    post_params = params.require(:post).permit(:title, :body)

    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  # ******* Destroy

  def destroy
    @post = Post.find params[:id]
    @post.destroy

    redirect_to posts_path
  end
end
