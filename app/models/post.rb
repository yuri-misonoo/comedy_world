class Post < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true
  validates :body, presence: true

  def post_time
    created_at.strftime("%Y/%m/%d")
  end
end
