class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      render :new
      flash.now[:danger] = 'メールアドレスとパスワードのいずれかが有効ではありません。'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
