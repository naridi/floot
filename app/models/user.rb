class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
        has_many :posts, dependent: :destroy # remove user's posts if account is deleted
         
        validates_uniqueness_of :username, :case_sensitive => false
        validates_presence_of :username
        validates_presence_of :name
        
        attr_accessor :current_password # check current pasword only if user is trying to change new password in edit.html.erb
        
        has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/default_0.png"
        validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
