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
                f.html { redirect_to :back, :flash => { :success => "Posted! Your floot will disappear in 24 hours" } }
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
    
    private
    def post_params # Allow certain data to be passed through form.
        params.require(:post).permit(:user_id, :content)
        
    end
    
end