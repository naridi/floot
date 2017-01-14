class PagesController < ApplicationController
  
  def index
  end
  
  def home
    @posts = Post.where('created_at >= :one_days_ago', one_days_ago: Time.now - 16.hours)
    @newPost = Post.new
  end

  def explore
    @posts = Post.where('created_at >= :one_days_ago', one_days_ago: Time.now - 16.hours).last(30)
  end

  def privacy
  end 
  
  def profile
    if (User.find_by_username(params[:id]))
      @username = params[:id]
      @users = User.all.where("id = ?", User.find_by_username(params[:id]).id)
      @posts = Post.where(user_id: User.find_by_username(params[:id]).id).where('created_at > ?', 16.hours.ago)
     else
      redirect_to root_path, notice: 'User not found.'
    end
      @newPost = Post.new
  end
  
end