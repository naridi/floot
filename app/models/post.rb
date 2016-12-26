class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140,
  too_long: "%{count} characters is the maximum allowed" } # posts capped at 140
  default_scope -> { order(created_at: :desc) } # newests posts first
end
