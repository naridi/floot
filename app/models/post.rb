class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 320,
  too_long: "%{count} characters is the maximum allowed" } # posts capped at 320
  default_scope -> { order(created_at: :desc) } # newests posts first
  
  acts_as_votable
  
  def score
    get_upvotes.size - get_downvotes.size
  end
  
end
