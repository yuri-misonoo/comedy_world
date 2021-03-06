module SessionsHelper
  # 渡されたユーザーでサインインする
  def sign_in(user)
    # sessionメソッドはRailsに元から定義されている。一時cookiesが作成される
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的にする
  # permanentメソッドは20年で期限切れになるcookiesの設定の専用メソッド
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # ログイン中のユーザーを返す
  def current_user
    # session[:user_id]が存在すれば一時セッションからユーザーを取得
    if (user_id = session[:user_id])
      # ユーザーが存在しない場合、findメソッドだと例外が発生するが、find_byだとnilが返る
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def signed_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをサインアウトする
  def sign_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # サインイン前にurl直打ち→強制的にサインイン画面へ
  # →直打ちしたurlを記憶してサインイン後にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
  def store_location
    session[:forwarding_url] = request.original_url if request.get
  end
end
