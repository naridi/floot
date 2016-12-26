class PagesController < ApplicationController
  
  def index
  end
  
  def home
    @posts = Post.where('created_at >= :one_days_ago', one_days_ago: Time.now - 1.day)
    @newPost = Post.new
  end
  
  def profile
    # grab the username from the URL as :id
    if (User.find_by_username(params[:id]))
      @username = params[:id]
      @users = User.all.where("id = ?", User.find_by_username(params[:id]).id)
      @posts = Post.where(user_id: User.find_by_username(params[:id]).id).where('created_at > ?', 1.days.ago)
      #@posts = Post.all.where(:user_id => User.where(:username => params[:id]))
      #                 .where('created_at >= :seven_days_ago', seven_days_ago: Time.now - 1.days)
    else
      # redirect to 404 (root for now)
      redirect_to root_path, :notice=> "User not found"
    end
      @newPost = Post.new
  end
  
  def explore
    # @posts = Post.all  OLD POST ALL
    @posts = Post.where('created_at >= :one_days_ago', one_days_ago: Time.now - 1.day)
  end
  
end