class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    @posts = current_user.favorite_posts
  end

  def create
    po = Post.find params[:post_id]
    favorite = Favorite.new(post: po, user: current_user)

    if favorite.save
      redirect_to po, notice: "Added Favorite"
    else
      redirect_to po, alert: "Error, Can't Favorite"
    end
  end

  def destroy
    po = Post.find params[:post_id]
    favorite = current_user.favorites.find params[:id]
    favorite.destroy
    redirect_to post_path(po), notice: "Post deleted from favorites"
  end
end
