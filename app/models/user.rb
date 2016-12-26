class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         has_many :posts, dependent: :destroy # remove user's posts if account is deleted
         
        validates_uniqueness_of :username
        validates_presence_of :username
        validates_presence_of :name
        has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
        validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
