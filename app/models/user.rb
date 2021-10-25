class User < ApplicationRecord
  # オブジェクトを作成。migrationでt.string :remember_tokenとするのとほぼ同義。型は動的に決まる。
  attr_accessor :remember_token

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 新しい記憶トークンを作成
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 渡された文字列のハッシュ値を返す
  # cost（コストパラメータ）→ハッシュを算出するための計算コストを指定
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    # パスワードの作成
    BCrypt::Password.create(string, cost: cost)
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    # 記憶トークンを作成
    self.remember_token = User.new_token
    # 記憶ダイジェストの更新
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  # 引数のremember_tokenは1行目のものとは別物
  def authenticated?(remember_token)
    # 記憶ダイジェストがnilの時はfalseを返す。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのサインイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  attachment :profile_image
  has_many :posts, dependent: :destroy
end
