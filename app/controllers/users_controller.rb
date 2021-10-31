class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to user_path(@user)
      flash[:success] = "Comedy World へようこそ"
    else
      render :new
    end
  end

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  def following
    @title = "フォロー中"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :profile_image)
    end

    # サインイン済みユーザーかどうか確認。サインイン前のurl直打ち禁止。
    def signed_in_user
      unless signed_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to signin_path
      end
    end

    # 正しいユーザーかどうか確認。他ユーザーの編集、url直打ち禁止。
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
