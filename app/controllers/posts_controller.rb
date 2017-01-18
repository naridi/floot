class PostsController < ApplicationController
    
    def index
    @posts = Post.allow
    end
  
    def new 
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id # Assign post to the user who created it.
        respond_to do |f|
            if (@post.save) 
                f.html { redirect_to :back, :flash => { :success => "Posted! Your floot will disappear in 24 hours." } }
            else
                f.html { redirect_to :back, :flash => { :error => "Error: Post not saved." } }
            end
        end
    end
    
    def destroy # Allow post owner to delete post.
        @post = Post.find(params[:id])
        if current_user == @post.user
            @post.destroy
        end
            redirect_to :back, alert: 'Floot has been deleted.'
    end
    
    def upvote
      @post = Post.find(params[:id])
      @post.upvote_by current_user
        respond_to do |format|
            format.html { redirect_to :back }
            format.js 
        end
    end

    def downvote
      @post = Post.find(params[:id])
      @post.downvote_by current_user
        respond_to do |format|
            format.html { redirect_to :back }
            format.js 
        end
    end
    
    private
    def post_params # Allow certain data to be passed through form.
        params.require(:post).permit(:user_id, :content)
        
    end
    
end