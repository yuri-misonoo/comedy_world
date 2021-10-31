class Post < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true
  validates :body, presence: true
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def post_time
    created_at.strftime("%Y/%m/%d")
  end
end
