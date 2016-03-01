class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    @posts = current_user.favorite_posts
  end

  def create
    @post = Post.find params[:post_id]

    if is_author_of? @post
      return redirect_to @post, notice: "Access Denied"
    end

    favorite = Favorite.new(post: @post, user: current_user)

    respond_to do |format|
      if favorite.save
        format.html{ redirect_to @post, notice: "Added Favorite" }
        format.js { render :success_favorite }
      else
        format.html { redirect_to @post, alert: "Error, Can't Favorite" }
        format.js { render :unsuccess_favorite }
      end
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    favorite = current_user.favorites.find params[:id]
    favorite.destroy

    respond_to do |format|
      format.html {redirect_to post_path(@post), notice: "Un-favorited"}
      format.js { render } # this will render favorites/destroy.js.erb
    end
  end


end
