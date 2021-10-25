class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      remember user
      redirect_to user_path(user)
    else
      render :new
      flash.now[danger] = 'メールアドレスとパスワードのいずれかが有効ではありません。'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
