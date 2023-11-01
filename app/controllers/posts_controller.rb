class PostsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  # GET /posts or /posts.json
  def index
    @posts = current_user.post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    if request.headers['X-Request-Source']==="Client"
      @post = Post.with_rich_text_content_and_embeds.includes(:user, :post_tags, :tags, :comments).friendly.find(params[:id])

  
        if @post.nil?
          render json: { error: "Post not found" }, status: :not_found     
        else            
          render json: {
            status: {code: 200, message: 'Logged in sucessfully.'},
            data:PostSerializer.new(@post)                
          }, status: :ok
        end 
      end 
    
  end

  # GET /posts/new
  def new
    @post = current_user.post.new
  end
  
  def all_post
    if request.headers['X-Request-Source']==="Client"
      @post = Post.includes(:user, :post_tags, :tags, :comments).with_rich_text_content_and_embeds.all
        if @post.nil?
          render json: { error: "Post not found" }, status: :not_found     
        else            
          render json: {
            status: {code: 200, message: 'ok.'},
            data:PostSerializer.new(@post)                
          }, status: :ok
        end 
      end     
  end 

  def featured
    if request.headers['X-Request-Source']==="Client"      
      @post = Post.includes(:user, :post_tags, :tags, :comments,user: { member_detail: :avatar_attachment }).joins(:post_tags).where(post_tags: { tag_id: 1 })
          if @post.nil?
            render json: { error: "Post not found" }, status: :not_found     
          else            
            render json: {
              status: {code: 200, message: 'ok.'},
              data:PostSerializer.new(@post)                
            }, status: :ok
          end 
        end     
    end 

    def tech
      if request.headers['X-Request-Source']==="Client"      
        @post = Post.includes(:user, :post_tags, :tags, :comments,user: { member_detail: :avatar_attachment }).joins(:post_tags).where(post_tags: { tag_id: 5 })
            if @post.nil?
              render json: { error: "Post not found" }, status: :not_found     
            else            
              render json: {
                status: {code: 200, message: 'ok.'},
                data:PostSerializer.new(@post)                
              }, status: :ok
            end 
          end     
      end 
  
    def trending
      if request.headers['X-Request-Source']==="Client"      
        @post = Post.includes(:user, :post_tags, :tags, :comments,user: { member_detail: :avatar_attachment }).joins(:post_tags).where(post_tags: { tag_id: 2 })
            if @post.nil?
              render json: { error: "Post not found" }, status: :not_found     
            else            
              render json: {
                status: {code: 200, message: 'ok.'},
                data:PostSerializer.new(@post)                
              }, status: :ok
            end 
          end     
      end 

      def news
        if request.headers['X-Request-Source']==="Client"      
          @post = Post.includes(:user, :post_tags, :tags, :comments,user: { member_detail: :avatar_attachment }).joins(:post_tags).where(post_tags: { tag_id: 3 })
              if @post.nil?
                render json: { error: "Post not found" }, status: :not_found     
              else            
                render json: {
                  status: {code: 200, message: 'ok.'},
                  data:PostSerializer.new(@post)                
                }, status: :ok
              end 
            end     
        end   

        def events
          if request.headers['X-Request-Source']==="Client"      
            @post = Post.includes(:user, :post_tags, :tags, :comments,user: { member_detail: :avatar_attachment }).joins(:post_tags).where(post_tags: { tag_id: 4 })
                if @post.nil?
                  render json: { error: "Post not found" }, status: :not_found     
                else            
                  render json: {
                    status: {code: 200, message: 'ok.'},
                    data:PostSerializer.new(@post)                
                  }, status: :ok
                end 
              end     
          end    

          def latest
            if request.headers['X-Request-Source']==="Client"      
              @post = Post.includes(:user, :post_tags, :tags, :comments,user: { member_detail: :avatar_attachment }).joins(:post_tags).where(post_tags: { tag_id: 6 })
                  if @post.nil?
                    render json: { error: "Post not found" }, status: :not_found     
                  else            
                    render json: {
                      status: {code: 200, message: 'ok.'},
                      data:PostSerializer.new(@post)                
                    }, status: :ok
                  end 
                end     
            end    


  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.post.new(post_params)
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.friendly.find(params[:id])
        redirect_to @post, :status => :moved_permanently if params[:id] != @post.slug
      end

    # Only allow a list of trusted parameters through.x
    def post_params
      params.require(:post).permit(:title, :content,:summary, :photos, :heroimage, tag_ids:[])
    end


  
end
