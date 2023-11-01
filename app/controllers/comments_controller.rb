require 'pry'
class CommentsController < ApplicationController

    
    def create                            
        @comment = Comment.new(comment_params)        
        if !@comment.save
            flash[:notice] = @comment.errors.full_messages.to_sentence
        else
          render json: {
            status: {code: 200, message: 'ok.'},                    
            data:CommentSerializer.new(@comment)      
          }, status: :ok
        end 
    end 

    def destroy                            
       @comment = Comment.find(params[:id])     
       if @comment.destroy
        render json: {
          status: { code: 200, message: 'Comment deleted successfully' }
        }, status: :ok
      else
        render json: { error: 'Failed to delete comment' }, status: :unprocessable_entity
      end
      
    end 
    
    def show        
        if request.headers['X-Request-Source']==="Client"   
            @comments = Post.friendly.find(params["post_id"]).comments.includes(user: { member_detail: :avatar_attachment })
                if @comments.nil?
                  render json: { error: "Post not found" }, status: :not_found     
                else            
                  render json: {
                    status: {code: 200, message: 'ok.'},                    
                    data:CommentSerializer.new(@comments)      
                  }, status: :ok
            end 
        end             
    end 

    def update        
      if request.headers['X-Request-Source']==="Client"   
        @edited_comments = Comment.find(params[:id]) 
        @edited_comments["content"] = params["content"]   
         
              if @edited_comments.save
                render json: {
                  status: {code: 200, message: 'ok.'},                    
                  data:CommentSerializer.new(@edited_comments)      
                }, status: :ok
              else            
                render json: { error: "Post not found" }, status: :not_found     
               
          end 
      end             
  end 
    
    

    def comment_params  
     
        params
        .require(:comment)
        .permit(:content,:user_id)
        .merge(post_id: Post.friendly.find(params["post_id"])["id"])     
       
    end  
    
    
  
end
