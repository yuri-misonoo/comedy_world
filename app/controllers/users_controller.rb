class UsersController < ApplicationController
  before_action :sign_in_user, only: [:index, :edit, :update]
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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction)
    end

    # サインイン済みユーザーかどうか確認。サインイン前のurl直打ち禁止。
    def sign_in_user
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
