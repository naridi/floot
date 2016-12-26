class PostsController < ApplicationController
    
    def index
    @posts = Post.allow
    end
  
    def new 
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id # assign the post to the user who created it.
        respond_to do |f|
            if (@post.save) 
                f.html { redirect_to "", notice: "Post created!" }
            else
                f.html { redirect_to "", notice: "Error: Post Not Saved." }
            end
        end
    end
    
    def destroy # delete post but its not working
        @post = Post.find(params[:id])
        if current_user == @post.user
            @post.destroy
        end
            redirect_to root_path
    end
    
    private
    def post_params # allows certain data to be passed via form.
        params.require(:post).permit(:user_id, :content)
        
    end
    
end