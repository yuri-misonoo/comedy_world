class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user_path(user)
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user_path(user)
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to signin_path
      end
    end
end
