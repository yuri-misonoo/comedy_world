class FavoritesController < ApplicationController
  before_action :signed_in_user

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new(post_id: @post.id)
    @favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @favorite.destroy
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to signin_path
    end
  end

end
