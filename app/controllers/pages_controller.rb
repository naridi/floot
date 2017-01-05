class PagesController < ApplicationController
  
  def index
  end
  
  def home
    @posts = Post.where('created_at >= :one_days_ago', one_days_ago: Time.now - 1.day)
    @newPost = Post.new
  end

  def explore
    @posts = Post.where('created_at >= :one_days_ago', one_days_ago: Time.now - 1.day)
  end

  def privacy
  end 
  
  def profile
    if (User.find_by_username(params[:id]))
      @username = params[:id]
      @users = User.all.where("id = ?", User.find_by_username(params[:id]).id)
      @posts = Post.where(user_id: User.find_by_username(params[:id]).id).where('created_at > ?', 1.days.ago)
     else
      redirect_to root_path, notice: 'User not found.'
    end
      @newPost = Post.new
  end
  
end