require 'pry'
class UsersController < ApplicationController
 
   def show
     @user = User.friendly.find(params[:id])     
     render json: {
      status: {code: 200, message: 'Logged in sucessfully.'},
      data: UserSerializer.new(@user).serializable_hash[:data][:attributes]
    }, status: :ok
   end

   def create
    @user = User.new(user_params)
      @user.password_confirmation = params[:confirm_password]
      @user.password = params[:password]
    if @user.save
      render json: @user, status: :created  
    else
      render json: @user.errors, status: :unprocessable_entity
    end
   end 

   def set_user
    @user = User.friendly.find(params[:id])
    redirect_to @user, :status => :moved_permanently if params[:id] != @user.slug
  end

   def get_invited_user
    invited_by_id = current_user[:id]
    user = User.where(invited_by_id: invited_by_id)
    if user
      response.headers['Authorization'] = nil
      render json: user, status: :ok,message: :""
    else
      render json: { error: 'User not found' }, status: :not_found
    end
   end 

    def user_params      
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    


end
