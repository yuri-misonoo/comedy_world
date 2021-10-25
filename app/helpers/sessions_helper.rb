module SessionsHelper
  # 渡されたユーザーでサインインする
  def sign_in(user)
    # sessionメソッドはRailsに元から定義されている。一時cookiesが作成される
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      # ユーザーが存在しない場合、findメソッドだと例外が発生するが、find_byだとnilが返る
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def signed_in?
    !current_user.nil?
  end
end
